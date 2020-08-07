import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarAlpha = 0;
  final ACCESP_CHANGE_HEIGTH = 100;

  void _onscroll(double pixels) {
    double alpha = pixels / ACCESP_CHANGE_HEIGTH;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    print('$alpha<-----alpha');
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    const _imageUrls = [
      "https://www.cume.cc/img/small_banner_1.jpg",
      "https://www.cume.cc/img/small_banner_2.jpg",
      "https://www.cume.cc/img/small_banner_3.jpg",
      "https://www.cume.cc/img/small_banner_4.jpg",
    ];
    return Scaffold(
        body: Stack(
      children: [
//        顶部padding移除
        MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification) {
//                找到第0 个元素也就是listView才让他处理这个滚动监听 否则会监听到swiper的滚动 is 是滚动的时候才监听回调
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onscroll(scrollNotification.metrics.pixels);
                }
                return null;
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                        itemCount: _imageUrls.length,
                        autoplay: true,
                        pagination: SwiperPagination(),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill,
                          );
                        }),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(
                      title: Text('哈哈'),
                    ),
                  )
                ],
              ),
            )),
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('首页'),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
