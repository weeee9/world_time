import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; // time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      // make the request
      Response resp = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(resp.body);
      // print(data);

      // get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // print('$datetime - $offset');

      // create a datetime object
      DateTime now =
          DateTime.parse(datetime).add(Duration(hours: int.parse(offset)));

      // set the time property
      time = DateFormat.jm().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
