Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132735AbRDQP7M>; Tue, 17 Apr 2001 11:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDQP7D>; Tue, 17 Apr 2001 11:59:03 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:39182 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132735AbRDQP6y>; Tue, 17 Apr 2001 11:58:54 -0400
Date: Tue, 17 Apr 2001 16:58:49 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: linux-kernel@vger.kernel.org, becker@scyld.com
cc: maurizio.quadrio@polimi.it, harry@navaho.co.uk
Subject: Fix for Donald Becker's DP83815 network driver (v1.07)
Message-ID: <Pine.LNX.4.21.0104171653110.4446-200000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="665600-674573692-987523128=:4446"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--665600-674573692-987523128=:4446
Content-Type: TEXT/PLAIN; charset=US-ASCII


The attached patch fixes the following problems with the DP83815 driver
(natsemi.c):

1. When compiled into the kernel, the cards would be registered multiple
times.
2. Autonegotiation code was buggy, causing the card to stop working after
autonegotiation.

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


--665600-674573692-987523128=:4446
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.2.18-natsemi-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0104171658480.4446@sorbus.navaho>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.2.18-natsemi-fix.patch"

ZGlmZiAtdXJOIGxpbnV4Lm5hdHNlbWkvZHJpdmVycy9uZXQvbmF0c2VtaS5j
IGxpbnV4L2RyaXZlcnMvbmV0L25hdHNlbWkuYw0KLS0tIGxpbnV4Lm5hdHNl
bWkvZHJpdmVycy9uZXQvbmF0c2VtaS5jCVR1ZSBBcHIgMTcgMTM6MTI6MjYg
MjAwMQ0KKysrIGxpbnV4L2RyaXZlcnMvbmV0L25hdHNlbWkuYwlUdWUgQXBy
IDE3IDEzOjIwOjA0IDIwMDENCkBAIC0xOSw2ICsxOSwxNiBAQA0KIAlodHRw
Oi8vd3d3LnNjeWxkLmNvbS9uZXR3b3JrL25ldHNlbWkuaHRtbA0KICovDQog
DQorLyoNCisJMTEgQXByaWwgMjAwMSAgICAgU3RldmUgSGlsbCA8c3RldmVA
bmF2YWhvLmNvLnVrPg0KKwlCdWdmaXg6IFdoZW4gY29tcGlsZWQgaW50byB0
aGUga2VybmVsIGluc3RlYWQgb2YgYXMgYSBtb2R1bGUgdGhlIGRyaXZlcg0K
KwlpbmNvcnJlY3RseSByZWdpc3RlcmVkIG11bHRpcGxlIG5ldHdvcmsgY2Fy
ZHMuDQorCQ0KKwkxNyBBcHJpbCAyMDAxICAgICBTdGV2ZSBIaWxsIDxzdGV2
ZUBuYXZhaG8uY28udWs+DQorCUJ1Z2ZpeDogQXV0b25lZ290aWF0aW9uIGNv
ZGUgd2FzIHVzaW5nIHdyaXRldygpIGluc3RlYWQgb2Ygd3JpdGVsKCkgLSB0
aGlzDQorCXJlc3VsdGVkIGluIHRoZSBjYXJkIGZhaWxpbmcgYWZ0ZXIgYXV0
b25lZ290aWF0aW9uLg0KKyovDQorCQ0KIC8qIFRoZXNlIGlkZW50aWZ5IHRo
ZSBkcml2ZXIgYmFzZSB2ZXJzaW9uIGFuZCBtYXkgbm90IGJlIHJlbW92ZWQu
ICovDQogc3RhdGljIGNvbnN0IGNoYXIgdmVyc2lvbjFbXSA9DQogIm5hdHNl
bWkuYzp2MS4wNyAxLzkvMjAwMSAgV3JpdHRlbiBieSBEb25hbGQgQmVja2Vy
IDxiZWNrZXJAc2N5bGQuY29tPlxuIjsNCkBAIC0zNjMsOCArMzczLDEyIEBA
DQogI2lmbmRlZiBNT0RVTEUNCiBpbnQgbmF0c2VtaV9wcm9iZShzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2KQ0KIHsNCisJc3RhdGljIGludCBkb25lID0gMDsN
CisNCisJaWYgKGRvbmUpIHJldHVybiAtRU5PREVWOw0KIAlpZiAocGNpX2Ry
dl9yZWdpc3RlcigmbmF0c2VtaV9kcnZfaWQsIGRldikgPCAwKQ0KIAkJcmV0
dXJuIC1FTk9ERVY7DQorCWRvbmUgPSAxOw0KIAlwcmludGsoS0VSTl9JTkZP
ICIlcyIgS0VSTl9JTkZPICIlcyIsIHZlcnNpb24xLCB2ZXJzaW9uMik7DQog
CXJldHVybiAwOw0KIH0NCkBAIC02MzcsOCArNjUxLDggQEANCiAJCQlucC0+
cnhfY29uZmlnICY9IH4weDEwMDAwMDAwOw0KIAkJCW5wLT50eF9jb25maWcg
Jj0gfjB4QzAwMDAwMDA7DQogCQl9DQotCQl3cml0ZXcobnAtPnR4X2NvbmZp
ZywgaW9hZGRyICsgVHhDb25maWcpOw0KLQkJd3JpdGV3KG5wLT5yeF9jb25m
aWcsIGlvYWRkciArIFJ4Q29uZmlnKTsNCisJCXdyaXRlbChucC0+dHhfY29u
ZmlnLCBpb2FkZHIgKyBUeENvbmZpZyk7DQorCQl3cml0ZWwobnAtPnJ4X2Nv
bmZpZywgaW9hZGRyICsgUnhDb25maWcpOw0KIAl9DQogfQ0KIA0K
--665600-674573692-987523128=:4446--
