Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132517AbRDKIIb>; Wed, 11 Apr 2001 04:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDKIIV>; Wed, 11 Apr 2001 04:08:21 -0400
Received: from [194.8.76.131] ([194.8.76.131]:11279 "HELO imap.camline.com")
	by vger.kernel.org with SMTP id <S132517AbRDKIIK>;
	Wed, 11 Apr 2001 04:08:10 -0400
Date: Wed, 11 Apr 2001 10:09:46 +0200 (CEST)
From: Matthias Hanisch <matze@camline.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] some new __init functions in aha1542.c
Message-ID: <Pine.LNX.4.10.10104111002550.21412-200000@homer.camline.com>
Organization: camLine Datensysteme fuer die Mikroelektronik
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463781119-1494034063-986976586=:21412"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463781119-1494034063-986976586=:21412
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi!

The attached patch puts the following functions into the .text.init
section.

aha1542_in
        called by aha1542_getconfig, aha1542_query (all initfuncs)

aha1542_mbenable
        called by aha1542_query (initfunc)

aha1542_in1
        called in aha1542_mbenable (now also an initfunc)

Patch is against 2.4.4pre1.

Regards,

	Matze

-- 
Matthias Hanisch    mailto:matze@camline.com    phone: +49 8137 935-219

---1463781119-1494034063-986976586=:21412
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=init-aha1542
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.10.10104111009460.21412@homer.camline.com>
Content-Description: 
Content-Disposition: attachment; filename=init-aha1542

ZGlmZiAtcnUgbGludXgtdmFuaWxsYS9kcml2ZXJzL3Njc2kvYWhhMTU0Mi5j
IGxpbnV4L2RyaXZlcnMvc2NzaS9haGExNTQyLmMNCi0tLSBsaW51eC12YW5p
bGxhL2RyaXZlcnMvc2NzaS9haGExNTQyLmMJTW9uIEFwciAgOSAyMjoxMzo1
OCAyMDAxDQorKysgbGludXgvZHJpdmVycy9zY3NpL2FoYTE1NDIuYwlNb24g
QXByICA5IDIyOjI2OjA0IDIwMDENCkBAIC0yNTQsNyArMjU0LDcgQEANCiAv
KiBPbmx5IHVzZWQgYXQgYm9vdCB0aW1lLCBzbyB3ZSBkbyBub3QgbmVlZCB0
byB3b3JyeSBhYm91dCBsYXRlbmN5IGFzIG11Y2gNCiAgICBoZXJlICovDQog
DQotc3RhdGljIGludCBhaGExNTQyX2luKHVuc2lnbmVkIGludCBiYXNlLCB1
bmNoYXIgKiBjbWRwLCBpbnQgbGVuKQ0KK3N0YXRpYyBpbnQgX19pbml0IGFo
YTE1NDJfaW4odW5zaWduZWQgaW50IGJhc2UsIHVuY2hhciAqIGNtZHAsIGlu
dCBsZW4pDQogew0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIA0KQEAgLTI3
Niw3ICsyNzYsNyBAQA0KIC8qIFNpbWlsYXIgdG8gYWhhMTU0Ml9pbiwgZXhj
ZXB0IHRoYXQgd2Ugd2FpdCBhIHZlcnkgc2hvcnQgcGVyaW9kIG9mIHRpbWUu
DQogICAgV2UgdXNlIHRoaXMgaWYgd2Uga25vdyB0aGUgYm9hcmQgaXMgYWxp
dmUgYW5kIGF3YWtlLCBidXQgd2UgYXJlIG5vdCBzdXJlDQogICAgaWYgdGhl
IGJvYXJkIHdpbGwgcmVzcG9uZCB0byB0aGUgY29tbWFuZCB3ZSBhcmUgYWJv
dXQgdG8gc2VuZCBvciBub3QgKi8NCi1zdGF0aWMgaW50IGFoYTE1NDJfaW4x
KHVuc2lnbmVkIGludCBiYXNlLCB1bmNoYXIgKiBjbWRwLCBpbnQgbGVuKQ0K
K3N0YXRpYyBpbnQgX19pbml0IGFoYTE1NDJfaW4xKHVuc2lnbmVkIGludCBi
YXNlLCB1bmNoYXIgKiBjbWRwLCBpbnQgbGVuKQ0KIHsNCiAJdW5zaWduZWQg
bG9uZyBmbGFnczsNCiANCkBAIC04ODYsNyArODg2LDcgQEANCiAvKiBUaGlz
IGZ1bmN0aW9uIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBmb3IgMTU0MkMgYm9h
cmRzIC0gd2UgY2FuIGRldGVjdA0KICAgIHRoZSBzcGVjaWFsIGZpcm13YXJl
IHNldHRpbmdzIGFuZCB1bmxvY2sgdGhlIGJvYXJkICovDQogDQotc3RhdGlj
IGludCBhaGExNTQyX21iZW5hYmxlKGludCBiYXNlKQ0KK3N0YXRpYyBpbnQg
X19pbml0IGFoYTE1NDJfbWJlbmFibGUoaW50IGJhc2UpDQogew0KIAlzdGF0
aWMgdW5jaGFyIG1iZW5hYmxlX2NtZFszXTsNCiAJc3RhdGljIHVuY2hhciBt
YmVuYWJsZV9yZXN1bHRbMl07DQo=
---1463781119-1494034063-986976586=:21412--
