Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314671AbSEUOwD>; Tue, 21 May 2002 10:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314674AbSEUOwC>; Tue, 21 May 2002 10:52:02 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:21726 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S314671AbSEUOwC>;
	Tue, 21 May 2002 10:52:02 -0400
Date: Tue, 21 May 2002 16:48:35 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: linux-usb-users@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Oops report USB-OHCI
Message-ID: <Pine.LNX.4.44.0205211644080.12674-200000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-708705538-1797410247-1021992515=:12674"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---708705538-1797410247-1021992515=:12674
Content-Type: TEXT/PLAIN; charset=US-ASCII

The Oops from ksymoops is attached. There is one warning
but the System.map was correct (I tested twice).
The problem is repetable - I tested on 3 computers. It occured
with two types of phillips camera and with modem.
On UHCI it works, with OHCO - Opti chipset is fails.
Kernel 2.4.18, no patches. Tested on Pentium and PII computers.
There is
kernel BUG at usb-ohci.h:464!
always before Oops. It seems definitely to be bug in kernel.
Probably TD/ED memory is freed twice ..

devik

---708705538-1797410247-1021992515=:12674
Content-Type: TEXT/plain; name="oops.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0205211648350.12674@luxik.cdi.cz>
Content-Description: report
Content-Disposition: attachment; filename="oops.txt"

a3N5bW9vcHMgMi40LjUgb24gaTU4NiAyLjQuMTguICBPcHRpb25zIHVzZWQN
CiAgICAgLVYgKGRlZmF1bHQpDQogICAgIC1rIC9wcm9jL2tzeW1zIChkZWZh
dWx0KQ0KICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQ0KICAgICAt
byAvbGliL21vZHVsZXMvMi40LjE4LyAoZGVmYXVsdCkNCiAgICAgLW0gL2Jv
b3QvU3lzdGVtLm1hcC0yLjQuMTggKHNwZWNpZmllZCkNCg0KV2FybmluZyAo
Y29tcGFyZV9tYXBzKTogbWlzbWF0Y2ggb24gc3ltYm9sIHBhcnRpdGlvbl9u
YW1lICAsIGtzeW1zX2Jhc2Ugc2F5cyBjMDIwYzFlMCwgU3lzdGVtLm1hcCBz
YXlzIGMwMTQ5OGYwLiAgSWdub3Jpbmcga3N5bXNfYmFzZSBlbnRyeQ0Ka2Vy
bmVsIEJVRyBhdCB1c2Itb2hjaS5oOjQ2NCENCmludmFsaWQgb3BlcmFuZDog
MDAwMA0KQ1BVOiAgICAwDQpFSVA6ICAgIDAwMTA6WzxjMDIwODExZj5dICAg
IE5vdCB0YWludGVkDQpVc2luZyBkZWZhdWx0cyBmcm9tIGtzeW1vb3BzIC10
IGVsZjMyLWkzODYgLWEgaTM4Ng0KRUZMQUdTOiAwMDAxMDA4Mg0KZWF4OiAw
MDAwMDAxZSAgIGVieDogMDAwMDAwMDAgICBlY3g6IGMwMmIwMjY4ICAgZWR4
OiAwMDAwMjM2Nw0KZXNpOiBjMDA1NDdmOCAgIGVkaTogYzE4MDIwMDAgICBl
YnA6IGMwMDU0N2YwICAgZXNwOiBjMDYzMWYyOA0KZHM6IDAwMTggICBlczog
MDAxOCAgIHNzOiAwMDE4DQpQcm9jZXNzIHNzaGQgKHBpZDogMTMzMzMsIHN0
YWNrcGFnZT1jMDYzMTAwMCkNClN0YWNrOiBjMDI5ODBjMSAwMDAwMDFkMCBj
MDA4NDgwMCAwMDAwMDAwMCBjMTgwMjAwMCBjMDA4NDhiNCBjMDA4NmM2MCBj
MDJkOTkwMCANCiAgICAgICAwMDAwMDAwMCAwMDAwMDAwMCBjMDA1NDdmOCAw
MjUwZDI4MiAwMDAwMDI4MiBjMDIwOTM0ZiBjMDA4NDgwMCAwMDAwMDAwMSAN
CiAgICAgICBjMDA0Nzk2MCAwNDAwMDAwMSAwMDAwMDAwYiBjMDYzMWZjNCAw
MDAwMDAwNCBjMDEwN2RlZiAwMDAwMDAwYiBjMDA4NDgwMCANCkNhbGwgVHJh
Y2U6IFs8YzAyMDkzNGY+XSBbPGMwMTA3ZGVmPl0gWzxjMDEwN2Y1ZT5dIA0K
Q29kZTogMGYgMGIgODMgYzQgMDggOGIgMWIgODkgNWMgMjQgMTQgOGIgNTUg
MDggOGIgNGMgMjQgMzAgODMgZTIgDQoNCg0KPj5FSVA7IGMwMjA4MTFmIDxk
bF9kZWxfbGlzdCs3Yi81YTQ+ICAgPD09PT09DQoNCj4+ZWN4OyBjMDJiMDI2
OCA8Y29uc29sZV9zZW0rMC8xND4NCj4+ZWR4OyAwMDAwMjM2NyBCZWZvcmUg
Zmlyc3Qgc3ltYm9sDQo+PmVzaTsgYzAwNTQ3ZjggQmVmb3JlIGZpcnN0IHN5
bWJvbA0KPj5lZGk7IGMxODAyMDAwIDxfZW5kKzE0Y2VhMjgvMTRkZmEyOD4N
Cj4+ZWJwOyBjMDA1NDdmMCBCZWZvcmUgZmlyc3Qgc3ltYm9sDQo+PmVzcDsg
YzA2MzFmMjggPF9lbmQrMmZlOTUwLzE0ZGZhMjg+DQoNClRyYWNlOyBjMDIw
OTM0ZiA8aGNfaW50ZXJydXB0K2VmLzEzND4NClRyYWNlOyBjMDEwN2RlZiA8
aGFuZGxlX0lSUV9ldmVudCsyZi81OD4NClRyYWNlOyBjMDEwN2Y1ZSA8ZG9f
SVJRKzcyL2I0Pg0KDQpDb2RlOyAgYzAyMDgxMWYgPGRsX2RlbF9saXN0Kzdi
LzVhND4NCjAwMDAwMDAwIDxfRUlQPjoNCkNvZGU7ICBjMDIwODExZiA8ZGxf
ZGVsX2xpc3QrN2IvNWE0PiAgIDw9PT09PQ0KICAgMDogICAwZiAwYiAgICAg
ICAgICAgICAgICAgICAgIHVkMmEgICAgICA8PT09PT0NCkNvZGU7ICBjMDIw
ODEyMSA8ZGxfZGVsX2xpc3QrN2QvNWE0Pg0KICAgMjogICA4MyBjNCAwOCAg
ICAgICAgICAgICAgICAgIGFkZCAgICAkMHg4LCVlc3ANCkNvZGU7ICBjMDIw
ODEyNCA8ZGxfZGVsX2xpc3QrODAvNWE0Pg0KICAgNTogICA4YiAxYiAgICAg
ICAgICAgICAgICAgICAgIG1vdiAgICAoJWVieCksJWVieA0KQ29kZTsgIGMw
MjA4MTI2IDxkbF9kZWxfbGlzdCs4Mi81YTQ+DQogICA3OiAgIDg5IDVjIDI0
IDE0ICAgICAgICAgICAgICAgbW92ICAgICVlYngsMHgxNCglZXNwLDEpDQpD
b2RlOyAgYzAyMDgxMmEgPGRsX2RlbF9saXN0Kzg2LzVhND4NCiAgIGI6ICAg
OGIgNTUgMDggICAgICAgICAgICAgICAgICBtb3YgICAgMHg4KCVlYnApLCVl
ZHgNCkNvZGU7ICBjMDIwODEyZCA8ZGxfZGVsX2xpc3QrODkvNWE0Pg0KICAg
ZTogICA4YiA0YyAyNCAzMCAgICAgICAgICAgICAgIG1vdiAgICAweDMwKCVl
c3AsMSksJWVjeA0KQ29kZTsgIGMwMjA4MTMxIDxkbF9kZWxfbGlzdCs4ZC81
YTQ+DQogIDEyOiAgIDgzIGUyIDAwICAgICAgICAgICAgICAgICAgYW5kICAg
ICQweDAsJWVkeA0KDQogPDA+S2VybmVsIHBhbmljOiBBaWVlLCBraWxsaW5n
IGludGVycnVwdCBoYW5kbGVyIQ0KDQoxIHdhcm5pbmcgaXNzdWVkLiAgUmVz
dWx0cyBtYXkgbm90IGJlIHJlbGlhYmxlLg0K
---708705538-1797410247-1021992515=:12674--
