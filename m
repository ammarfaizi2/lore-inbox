Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbTKGWEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTKGWEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:04:47 -0500
Received: from DaVinci.coe.neu.edu ([129.10.32.95]:54919 "EHLO
	DaVinci.coe.neu.edu") by vger.kernel.org with ESMTP id S264369AbTKGOil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 09:38:41 -0500
Date: Fri, 7 Nov 2003 09:38:36 -0500 (EST)
From: Mauricio Martinez <mauricio@coe.neu.edu>
To: <linux-kernel@vger.kernel.org>
cc: Corey Minyard <minyard@acm.org>
Subject: [PATCH] 2.4.22 drivers/cdrom/cdu31a.c
Message-ID: <Pine.GSO.4.33.0311070918350.27679-200000@Amps.coe.neu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1068215916=:27679"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1068215916=:27679
Content-Type: TEXT/PLAIN; charset=US-ASCII


This patch fixes a problem (multiple reads of the same data) while reading
from a CDU31 SONY CD-ROM drive.

The hack was originally suggested by Corey Minyard a few months ago (and
working well for months in my old P5/200), but for some reason it didn't
appear in the current stable release of the kernel - Patch submitted just
for the sake of code cleanliness.

-Mauricio Martinez
 mauricio@coe.neu.edu

---559023410-851401618-1068215916=:27679
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cdu31a.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0311070938360.27679@Amps.coe.neu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cdu31a.patch"

LS0tIGRyaXZlcnMvY2Ryb20vY2R1MzFhLmMub3JpZwlGcmkgSnVuIDEzIDA5
OjUxOjMyIDIwMDMNCisrKyBkcml2ZXJzL2Nkcm9tL2NkdTMxYS5jCVdlZCBP
Y3QgMjkgMjM6MDM6MTAgMjAwMw0KQEAgLTEzNDEsNyArMTM0MSw3IEBADQog
I2VuZGlmDQogfQ0KIA0KLS8qIHJlYWQgZGF0YSBmcm9tIHRoZSBkcml2ZS4g
IE5vdGUgdGhlIG5zZWN0IG11c3QgYmUgPD0gNC4gKi8NCisvKiByZWFkIGRh
dGEgZnJvbSB0aGUgZHJpdmUuICBOb3RlIHRoZSBuYmxvY2tzIG11c3QgYmUg
PD0gNC4gKi8NCiBzdGF0aWMgdm9pZA0KIHJlYWRfZGF0YV9ibG9jayhjaGFy
ICpidWZmZXIsDQogCQl1bnNpZ25lZCBpbnQgYmxvY2ssDQpAQCAtMTM2MSwx
MiArMTM2MSwxMCBAQA0KIAlyZXNfcmVnWzBdID0gMDsNCiAJcmVzX3JlZ1sx
XSA9IDA7DQogCSpyZXNfc2l6ZSA9IDA7DQotCS8qIE1ha2Ugc3VyZSB0aGF0
IGJ5dGVzbGVmdCBkb2Vzbid0IGV4Y2VlZCB0aGUgYnVmZmVyIHNpemUgKi8N
Ci0JaWYgKG5ibG9ja3MgPiA0KSBuYmxvY2tzID0gNDsNCiAJYnl0ZXNsZWZ0
ID0gbmJsb2NrcyAqIDUxMjsNCiAJb2Zmc2V0ID0gMDsNCiANCi0JLyogSWYg
dGhlIGRhdGEgaW4gdGhlIHJlYWQtYWhlYWQgZG9lcyBub3QgbWF0Y2ggdGhl
IGJsb2NrIG9mZnNldCwNCisJLyogSWYgdGhlIGRhdGEgaW4gdGhlIHJlYWQg
YWhlYWQgZG9lcyBub3QgbWF0Y2ggdGhlIGJsb2NrIG9mZnNldCwNCiAJICAg
dGhlbiBmaXggdGhpbmdzIHVwLiAqLw0KIAlpZiAoKChibG9jayAlIDQpICog
NTEyKSAhPSAoKDIwNDggLSByZWFkYWhlYWRfZGF0YWxlZnQpICUgMjA0OCkp
IHsNCiAJCXNvbnlfbmV4dF9ibG9jayArPSBibG9jayAlIDQ7DQpAQCAtMTUz
NSw3ICsxNTMzLDcgQEANCiANCiAvKg0KICAqIFRoZSBPUyBjYWxscyB0aGlz
IHRvIHBlcmZvcm0gYSByZWFkIG9yIHdyaXRlIG9wZXJhdGlvbiB0byB0aGUg
ZHJpdmUuDQotICogV3JpdGUgb2J2aW91c2x5IGZhaWwuICBSZWFkcyB0byBh
IHJlYWQgYWhlYWQgb2Ygc29ueV9idWZmZXJfc2l6ZQ0KKyAqIFdyaXRlcyBv
YnZpb3VzbHkgZmFpbC4gIFJlYWRzIHRvIGEgcmVhZCBhaGVhZCBvZiBzb255
X2J1ZmZlcl9zaXplDQogICogYnl0ZXMgdG8gaGVscCBzcGVlZCBvcGVyYXRp
b25zLiAgVGhpcyBlc3BlY2lhbGx5IGhlbHBzIHNpbmNlIHRoZSBPUw0KICAq
IHVzZXMgMTAyNCBieXRlIGJsb2NrcyBhbmQgdGhlIGRyaXZlIHVzZXMgMjA0
OCBieXRlIGJsb2Nrcy4gIFNpbmNlIG1vc3QNCiAgKiBkYXRhIGFjY2VzcyBv
biBhIENEIGlzIGRvbmUgc2VxdWVudGlhbGx5LCB0aGlzIHNhdmVzIGEgbG90
IG9mIG9wZXJhdGlvbnMuDQpAQCAtMTU0OCw2ICsxNTQ2LDcgQEANCiAJdW5z
aWduZWQgaW50IHJlc19zaXplOw0KIAlpbnQgbnVtX3JldHJpZXM7DQogCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7DQorCWNoYXIgKmJ1ZmZlcjsNCiANCiANCiAj
aWYgREVCVUcNCkBAIC0xNjE4LDYgKzE2MTcsNyBAQA0KIA0KIAkJYmxvY2sg
PSBDVVJSRU5ULT5zZWN0b3I7DQogCQluYmxvY2sgPSBDVVJSRU5ULT5ucl9z
ZWN0b3JzOw0KKwkJYnVmZmVyID0gQ1VSUkVOVC0+YnVmZmVyOw0KIA0KIAkJ
aWYgKCFzb255X3RvY19yZWFkKSB7DQogCQkJcHJpbnRrKCJDRFUzMUE6IFRP
QyBub3QgcmVhZFxuIik7DQpAQCAtMTY5Nyw4ICsxNjk3LDE3IEBADQogCQkJ
CX0NCiAJCQl9DQogDQotCQkJcmVhZF9kYXRhX2Jsb2NrKENVUlJFTlQtPmJ1
ZmZlciwgYmxvY2ssIG5ibG9jaywNCi0JCQkJCXJlc19yZWcsICZyZXNfc2l6
ZSk7DQorCQkJaWYgKG5ibG9jayA+PSA0KSB7DQorCQkJCXJlYWRfZGF0YV9i
bG9jayhidWZmZXIsIGJsb2NrLCA0LA0KKwkJCQkJCXJlc19yZWcsICZyZXNf
c2l6ZSk7DQorCQkJCW5ibG9jayAtPSA0Ow0KKwkJCQlibG9jayArPSA0Ow0K
KwkJCQlidWZmZXIgKz0gNCAqIDUxMjsNCisJCQl9IGVsc2Ugew0KKwkJCQly
ZWFkX2RhdGFfYmxvY2soYnVmZmVyLCBibG9jaywgbmJsb2NrLA0KKwkJCQkJ
CXJlc19yZWcsICZyZXNfc2l6ZSk7DQorCQkJCW5ibG9jayA9IDA7DQorCQkJ
fQ0KIAkJCWlmIChyZXNfcmVnWzBdID09IDB4MjApIHsNCiAJCQkJaWYgKG51
bV9yZXRyaWVzID4gTUFYX0NEVTMxQV9SRVRSSUVTKSB7DQogCQkJCQllbmRf
cmVxdWVzdCgwKTsNCkBAIC0xNzE3LDYgKzE3MjYsMTAgQEANCiAJCQkJCSAg
ICAgYmxvY2ssIG5ibG9jayk7DQogCQkJCX0NCiAJCQkJZ290byB0cnlfcmVh
ZF9hZ2FpbjsNCisvKgkJCX0gZWxzZSBpZiAobmJsb2NrID4gMCkgew0KKwkJ
CQlwcmludGsoIk51bWJlciBvZiBibG9ja3MgbGVmdDogJWRcbiIsIG5ibG9j
ayk7DQorCQkJCWVuZF9yZXF1ZXN0KDEpOw0KKyovDQogCQkJfSBlbHNlIHsN
CiAJCQkJZW5kX3JlcXVlc3QoMSk7DQogCQkJfQ0K
---559023410-851401618-1068215916=:27679--
