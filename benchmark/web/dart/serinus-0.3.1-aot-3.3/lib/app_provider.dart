import 'dart:convert';
import 'dart:io';

import 'package:serinus/serinus.dart';

class AppProvider extends Provider {

  final elementUrl = Uri.http('web-data-source', '/element.json');
  final shellsUrl = Uri.http('web-data-source', '/shells.json');
  final httpClient = HttpClient();

  AppProvider();

  Future<Map<String, dynamic>> getElement(String symbol) async {
    final tmpReq = await httpClient.getUrl(elementUrl);
    final tmpRes = await tmpReq.close();
    final json = jsonDecode(await tmpRes.transform(utf8.decoder).join());
    final entry = Map<String, dynamic>.from(json[symbol]);
    return {
      'name': entry['name'],
      'number': entry['number'],
      'group': entry['group'],
    };
  }

  Future<Map<String, dynamic>> getShells(String symbol) async {
    final tmpReq = await httpClient.getUrl(shellsUrl);
    final tmpRes = await tmpReq.close();
    final json = Map<String, dynamic>.from(jsonDecode(await tmpRes.transform(utf8.decoder).join()));
    return {
      'shells': json[symbol],
    };
  }

}