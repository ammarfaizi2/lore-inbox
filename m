Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272118AbRIVUvc>; Sat, 22 Sep 2001 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272137AbRIVUvM>; Sat, 22 Sep 2001 16:51:12 -0400
Received: from femail22.sdc1.sfba.home.com ([24.0.95.147]:49342 "EHLO
	femail22.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272118AbRIVUvL>; Sat, 22 Sep 2001 16:51:11 -0400
Date: Sat, 22 Sep 2001 16:50:48 -0400 (EDT)
From: Leonid Igolnik <lim@igolnik.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.2.19 - semadj overflow in ipc/sem.c
Message-ID: <Pine.LNX.4.33.0109221647060.9877-200000@home.igolnik.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1400189789-1001191764=:9877"
Content-ID: <Pine.LNX.4.33.0109221650080.9877@home.igolnik.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1400189789-1001191764=:9877
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0109221650081.9877@home.igolnik.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Allan's patch for 2.4.9-ac14 plus some minor modifications.

- -- 

Leonid Igolnik.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7rPmqRrKFtN3cJpMRAsaMAJ94PZIZv9BLnLlOXQaq16Egrdb28ACfZyTL
7pK0jf1rJ/FBUCyeYfwuZF4=
=/pbV
-----END PGP SIGNATURE-----

--8323328-1400189789-1001191764=:9877
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="linux-2.2.19-SEM_UNDO.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109221649240.9877@home.igolnik.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="linux-2.2.19-SEM_UNDO.patch"

ZGlmZiAtdWJyIGxpbnV4LTIuMi4xOS9pcGMvc2VtLmMgbGludXgtMi4yLjE5
LmxpbS9pcGMvc2VtLmMNCi0tLSBsaW51eC0yLjIuMTkvaXBjL3NlbS5jCVN1
biBNYXIgMjUgMTE6MzE6MTUgMjAwMQ0KKysrIGxpbnV4LTIuMi4xOS5saW0v
aXBjL3NlbS5jCVNhdCBTZXAgMjIgMTY6Mzg6NDAgMjAwMQ0KQEAgLTIyOSw3
ICsyMjksMTkgQEANCiAJCWN1cnItPnNlbXBpZCA9IChjdXJyLT5zZW1waWQg
PDwgMTYpIHwgcGlkOw0KIAkJY3Vyci0+c2VtdmFsICs9IHNlbV9vcDsNCiAJ
CWlmIChzb3AtPnNlbV9mbGcgJiBTRU1fVU5ETykNCi0JCQl1bi0+c2VtYWRq
W3NvcC0+c2VtX251bV0gLT0gc2VtX29wOw0KKwkJew0KKwkJCWludCB1bmRv
ID0gdW4tPnNlbWFkaltzb3AtPnNlbV9udW1dIC0gc2VtX29wOw0KKwkJCS8q
DQorCQkJKiAgICAgIEV4Y2VlZGluZyB0aGUgdW5kbyByYW5nZSBpcyBhbiBl
cnJvci4NCisJCQkqLw0KKwkJCWlmKHVuZG8gPCAoLVNFTUFFTSAtIDEpIHx8
IHVuZG8gPiBTRU1BRU0pDQorCQkJew0KKwkJCQkvKiBEb24ndCB1bmRvIHRo
ZSB1bmRvICovDQorCQkJCXNvcC0+c2VtX2ZsZyAmPSB+U0VNX1VORE87DQor
CQkJCWdvdG8gb3V0X29mX3JhbmdlOw0KKwkJCX0NCisJCQl1bi0+c2VtYWRq
W3NvcC0+c2VtX251bV0gPSB1bmRvOw0KKwkJfQ0KIA0KIAkJaWYgKGN1cnIt
PnNlbXZhbCA8IDApDQogCQkJZ290byB3b3VsZF9ibG9jazsNCmRpZmYgLXVi
ciBsaW51eC0yLjIuMTkvaW5jbHVkZS9saW51eC9zZW0uaCBsaW51eC0yLjIu
MTkubGltL2luY2x1ZGUvbGludXgvc2VtLmgNCi0tLSBsaW51eC0yLjIuMTkv
aW5jbHVkZS9saW51eC9zZW0uaAlTdW4gTWFyIDI1IDExOjMxOjAzIDIwMDEN
CisrKyBsaW51eC0yLjIuMTkubGltL2luY2x1ZGUvbGludXgvc2VtLmgJU2F0
IFNlcCAyMiAxNjozOToyMiAyMDAxDQpAQCAtNjUsMTEgKzY1LDExIEBADQog
I2RlZmluZSBTRU1NTlMgIChTRU1NTkkqU0VNTVNMKSAvKiA/IG1heCAjIG9m
IHNlbWFwaG9yZXMgaW4gc3lzdGVtICovDQogI2RlZmluZSBTRU1PUE0gIDMy
CSAgICAgICAgLyogfiAxMDAgbWF4IG51bSBvZiBvcHMgcGVyIHNlbW9wIGNh
bGwgKi8NCiAjZGVmaW5lIFNFTVZNWCAgMzI3NjcgICAgICAgICAgIC8qIHNl
bWFwaG9yZSBtYXhpbXVtIHZhbHVlICovDQorI2RlZmluZSBTRU1BRU0gIFNF
TVZNWCAgICAgICAgICAvKiBhZGp1c3Qgb24gZXhpdCBtYXggdmFsdWUgKi8N
CiANCiAvKiB1bnVzZWQgKi8NCiAjZGVmaW5lIFNFTVVNRSAgU0VNT1BNICAg
ICAgICAgIC8qIG1heCBudW0gb2YgdW5kbyBlbnRyaWVzIHBlciBwcm9jZXNz
ICovDQogI2RlZmluZSBTRU1NTlUgIFNFTU1OUyAgICAgICAgICAvKiBudW0g
b2YgdW5kbyBzdHJ1Y3R1cmVzIHN5c3RlbSB3aWRlICovDQotI2RlZmluZSBT
RU1BRU0gIChTRU1WTVggPj4gMSkgICAvKiBhZGp1c3Qgb24gZXhpdCBtYXgg
dmFsdWUgKi8NCiAjZGVmaW5lIFNFTU1BUCAgU0VNTU5TICAgICAgICAgIC8q
ICMgb2YgZW50cmllcyBpbiBzZW1hcGhvcmUgbWFwICovDQogI2RlZmluZSBT
RU1VU1ogIDIwCQkvKiBzaXplb2Ygc3RydWN0IHNlbV91bmRvICovDQogDQo=
--8323328-1400189789-1001191764=:9877--
