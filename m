Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVAXAyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVAXAyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 19:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVAXAyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 19:54:09 -0500
Received: from mail.telester.ee ([194.204.18.108]:60357 "EHLO mail.telester.ee")
	by vger.kernel.org with ESMTP id S261399AbVAXAyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 19:54:02 -0500
Subject: Re: Trying to fix radeonfb suspending on IBM Thinkpad T41
From: Antti Andreimann <Antti.Andreimann@mail.ee>
To: Volker Braun <vbraun@physics.upenn.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1106517245.10964.3.camel@carrot.hep.upenn.edu>
References: <1106450704.10594.52.camel@localhost.localdomain>
	 <1106517245.10964.3.camel@carrot.hep.upenn.edu>
Content-Type: multipart/mixed; boundary="=-G/sGYy5JIh9nxijyBZ5z"
Date: Mon, 24 Jan 2005 02:54:00 +0200
Message-Id: <1106528040.17621.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G/sGYy5JIh9nxijyBZ5z
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=C3=9Chel kenal p=C3=A4eval (p=C3=BChap=C3=A4ev, 23. jaanuar 2005, 16:54-05=
00), kirjutas
Volker Braun:
> Update: I compiled a kernel with the radeonfb-massive-update-of-pm-
> code.patch. Now I can successfully resume from acpi S3 again. The power
> drain issue remains, it still uses about 5W in the suspend state.

radeonfb power management is not enabled on PC platform.
I cooked up some code to turn D2 sleep mode on for selected PC-s and
managed to get my ThinkPad to work.
Try this patch on top of radeonfb-massive.
NB! The patch has a model specific triger, so You MUST add Your laptop
model number to the top of the drivers/video/aty/radeon_pm.c.

--=20
 Antti Andreimann - Security Expert
      Using Linux since 1993
  Member of ELUG since 29.01.2000

--=-G/sGYy5JIh9nxijyBZ5z
Content-Disposition: attachment; filename=radeonfb-thinkpad-pm.patch
Content-Type: text/x-patch; name=radeonfb-thinkpad-pm.patch; charset=utf-8
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xMS1yYzItdGFuay9kcml2ZXJzL3ZpZGVvL2F0eS9yYWRlb25fcG0uYy5v
cmlnCTIwMDUtMDEtMjMgMTQ6NTU6NTcuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjEx
LXJjMi10YW5rL2RyaXZlcnMvdmlkZW8vYXR5L3JhZGVvbl9wbS5jCTIwMDUtMDEtMjMgMjE6NTM6
NDcuMDAwMDAwMDAwICswMjAwDQpAQCAtMjUsOCArMjUsMzEgQEANCiAjaW5jbHVkZSA8YXNtL3Bt
YWNfZmVhdHVyZS5oPg0KICNlbmRpZg0KIA0KKy8qIEZvciBkZXRlY3Rpbmcgc3VwcG9ydGVkIFBD
IGxhcHRvcHMgKi8NCisjaWZkZWYgQ09ORklHX1g4Ng0KKyNpbmNsdWRlIDxsaW51eC9kbWkuaD4N
CisjZW5kaWYNCisNCiAjaW5jbHVkZSAiYXRpX2lkcy5oIg0KIA0KKyNpZmRlZiBDT05GSUdfWDg2
DQorLyogVGhpcyBhcnJheSBob2xkcyBhIGxpc3Qgb2Ygc3VwcG9ydGVkIFBDIGxhcHRvcHMuDQor
ICogQ3VycmVudGx5IG9ubHkgZmV3IElCTSBtb2RlbHMgYXJlIHRlc3RlZC4NCisgKiBJZiB5b3Ug
d2FudCB0byBleHBlcmltZW50LCB1c2UgZG1pZGVjb2RlIHRvIGZpbmQgb3V0DQorICogdmVuZG9y
IGFuZCBwcm9kdWN0IGNvZGVzIGZvciBZb3VyIGxhcHRvcC4NCisgKi8NCitzdGF0aWMgc3RydWN0
IGRtaV9zeXN0ZW1faWQgX19kZXZpbml0ZGF0YSByYWRlb25mYl9kbWlfdGFibGVbXSA9IHsNCisJ
ew0KKwkJLmlkZW50ID0gIklCTSBUaGlua1BhZCBUNDEgKDIzNzMtMkZHKSIsDQorCQkubWF0Y2hl
cyA9IHsNCisJCQlETUlfTUFUQ0goRE1JX1NZU19WRU5ET1IsICJJQk0iKSwNCisJCQlETUlfTUFU
Q0goRE1JX1BST0RVQ1RfTkFNRSwgIjIzNzMyRkciKSwNCisJCX0sDQorCX0sDQorCXsgfSwNCit9
Ow0KKyNlbmRpZg0KKw0KIHZvaWQgcmFkZW9uX3BtX2Rpc2FibGVfZHluYW1pY19tb2RlKHN0cnVj
dCByYWRlb25mYl9pbmZvICpyaW5mbykNCiB7DQogCXUzMiB0bXA7DQpAQCAtMjc0OCw2ICsyNzcx
LDI0IEBADQogCQlPVVRSRUcoVFZfREFDX0NOVEwsIElOUkVHKFRWX0RBQ19DTlRMKSB8IDB4MDcw
MDAwMDApOw0KIAl9DQogI2VuZGlmIC8qIGRlZmluZWQoQ09ORklHX1BNKSAmJiBkZWZpbmVkKENP
TkZJR19QUENfT0YpICovDQorDQorLyogVGhlIFBNIGNvZGUgYWxzbyB3b3JrcyBvbiBzb21lIFBD
IGxhcHRvcHMuDQorICogT25seSBhIGZldyBtb2RlbHMgYXJlIGFjdHVhbGx5IHRlc3RlZCBzbyBZ
b3VyIG1pbGVhZ2UgbWF5IHZhcnkuDQorICogV2UgY2FuIGRvIEQyIG9uIGF0IGxlYXN0IE03IGFu
ZCBNOSBvbiBzb21lIElCTSBUaGlua1BhZCBUNDEgbW9kZWxzLg0KKyAqLw0KKyNpZiBkZWZpbmVk
KENPTkZJR19QTSkgJiYgZGVmaW5lZChDT05GSUdfWDg2KQ0KKwlpZiAoZG1pX2NoZWNrX3N5c3Rl
bShyYWRlb25mYl9kbWlfdGFibGUpKSB7DQorCQlpZiAocmluZm8tPmlzX21vYmlsaXR5ICYmIHJp
bmZvLT5wbV9yZWcgJiYNCisJCSAgICByaW5mby0+ZmFtaWx5IDw9IENISVBfRkFNSUxZX1JWMjUw
KQ0KKwkJCXJpbmZvLT5wbV9tb2RlIHw9IHJhZGVvbl9wbV9kMjsNCisNCisJCS8qIFBvd2VyIGRv
d24gVFYgREFDLCB0aGF0IHNhdmVzIGEgc2lnbmlmaWNhbnQgYW1vdW50IG9mIHBvd2VyLA0KKwkJ
ICogd2UnbGwgaGF2ZSBzb21ldGhpbmcgYmV0dGVyIG9uY2Ugd2UgYWN0dWFsbHkgaGF2ZSBzb21l
IFRWT3V0DQorCQkgKiBzdXBwb3J0DQorCQkgKi8NCisJCU9VVFJFRyhUVl9EQUNfQ05UTCwgSU5S
RUcoVFZfREFDX0NOVEwpIHwgMHgwNzAwMDAwMCk7DQorCX0NCisjZW5kaWYgLyogZGVmaW5lZChD
T05GSUdfUE0pICYmIGRlZmluZWQoQ09ORklHX1g4NikgKi8NCiB9DQogDQogdm9pZCByYWRlb25m
Yl9wbV9leGl0KHN0cnVjdCByYWRlb25mYl9pbmZvICpyaW5mbykNCg==


--=-G/sGYy5JIh9nxijyBZ5z--
