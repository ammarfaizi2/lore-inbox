Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbQKKWkH>; Sat, 11 Nov 2000 17:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKKWj5>; Sat, 11 Nov 2000 17:39:57 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:21522 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S129178AbQKKWjp>; Sat, 11 Nov 2000 17:39:45 -0500
Date: Sat, 11 Nov 2000 23:39:58 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] mpu401 bugfix
Message-ID: <Pine.LNX.4.21.0011112337100.11176-200000@tricky>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2039088291-973982398=:11176"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-2039088291-973982398=:11176
Content-Type: TEXT/PLAIN; charset=US-ASCII


Some mpu401 functions are used in many sound drivers thus they can't be
marked __init. This patch should allow using these drivers as modules...
 
--
Bartlomiej Zolnierkiewicz
<bkz@linux-ide.org>

--8323328-2039088291-973982398=:11176
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="240t11p2-mpu401_init.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0011112339580.11176@tricky>
Content-Description: 
Content-Disposition: attachment; filename="240t11p2-mpu401_init.diff"

LS0tIGxpbnV4LTI0MHQxMXAyL2RyaXZlcnMvc291bmQvbXB1NDAxLmMJVHVl
IE9jdCAgMyAwMDoxNzo0OCAyMDAwDQorKysgbGludXgvZHJpdmVycy9zb3Vu
ZC9tcHU0MDEuYwlGcmkgTm92IDEwIDIxOjM0OjI4IDIwMDANCkBAIC0xMyw2
ICsxMyw3IEBADQogICoNCiAgKiBUaG9tYXMgU2FpbGVyCWlvY3RsIGNvZGUg
cmV3b3JrZWQgKHZtYWxsb2MvdmZyZWUgcmVtb3ZlZCkNCiAgKiBBbGFuIENv
eAkJbW9kdWxhcmlzYXRpb24sIHVzZSBub3JtYWwgcmVxdWVzdF9pcnEsIHVz
ZSBkZXZfaWQNCisgKiBCYXJ0bG9taWVqIFpvbG5pZXJraWV3aWN6CXJlbW92
ZWQgc29tZSBfX2luaXQgdG8gYWxsb3cgdXNpbmcgbWFueSBkcml2ZXJzDQog
ICovDQogDQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KQEAgLTkwOCw3
ICs5MDksNyBAQA0KIA0KIHN0YXRpYyBzdHJ1Y3QgbWlkaV9vcGVyYXRpb25z
IG1wdTQwMV9taWRpX29wZXJhdGlvbnNbTUFYX01JRElfREVWXTsNCiANCi1z
dGF0aWMgdm9pZCBfX2luaXQgbXB1NDAxX2Noa192ZXJzaW9uKGludCBuLCBz
dHJ1Y3QgbXB1X2NvbmZpZyAqZGV2YykNCitzdGF0aWMgdm9pZCBtcHU0MDFf
Y2hrX3ZlcnNpb24oaW50IG4sIHN0cnVjdCBtcHVfY29uZmlnICpkZXZjKQ0K
IHsNCiAJaW50IHRtcDsNCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCkBAIC05
MzksNyArOTQwLDcgQEANCiAJcmVzdG9yZV9mbGFncyhmbGFncyk7DQogfQ0K
IA0KLXZvaWQgX19pbml0IGF0dGFjaF9tcHU0MDEoc3RydWN0IGFkZHJlc3Nf
aW5mbyAqaHdfY29uZmlnLCBzdHJ1Y3QgbW9kdWxlICpvd25lcikNCit2b2lk
IGF0dGFjaF9tcHU0MDEoc3RydWN0IGFkZHJlc3NfaW5mbyAqaHdfY29uZmln
LCBzdHJ1Y3QgbW9kdWxlICpvd25lcikNCiB7DQogCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7DQogCWNoYXIgcmV2aXNpb25fY2hhcjsNCkBAIC0xMTY2LDcgKzEx
NjcsNyBAQA0KIA0KIH0NCiANCi1pbnQgX19pbml0IHByb2JlX21wdTQwMShz
dHJ1Y3QgYWRkcmVzc19pbmZvICpod19jb25maWcpDQoraW50IHByb2JlX21w
dTQwMShzdHJ1Y3QgYWRkcmVzc19pbmZvICpod19jb25maWcpDQogew0KIAlp
bnQgb2sgPSAwOw0KIAlzdHJ1Y3QgbXB1X2NvbmZpZyB0bXBfZGV2YzsNCkBA
IC0xNjYyLDcgKzE2NjMsNyBAQA0KIAl9DQogfQ0KIA0KLXN0YXRpYyBpbnQg
X19pbml0IG1wdV90aW1lcl9pbml0KGludCBtaWRpX2RldikNCitzdGF0aWMg
aW50IG1wdV90aW1lcl9pbml0KGludCBtaWRpX2RldikNCiB7DQogCXN0cnVj
dCBtcHVfY29uZmlnICpkZXZjOw0KIAlpbnQgbjsNCkBAIC0xNzI0LDcgKzE3
MjUsNyBAQA0KIE1PRFVMRV9QQVJNKGlycSwgImkiKTsNCiBNT0RVTEVfUEFS
TShpbywgImkiKTsNCiANCi1pbnQgaW5pdF9tcHU0MDEodm9pZCkNCitpbnQg
X19pbml0IGluaXRfbXB1NDAxKHZvaWQpDQogew0KIAkvKiBDYW4gYmUgbG9h
ZGVkIGVpdGhlciBmb3IgbW9kdWxlIHVzZSBvciB0byBwcm92aWRlIGZ1bmN0
aW9ucw0KIAkgICB0byBvdGhlcnMgKi8NCkBAIC0xNzM5LDcgKzE3NDAsNyBA
QA0KIAlyZXR1cm4gMDsNCiB9DQogDQotdm9pZCBjbGVhbnVwX21wdTQwMSh2
b2lkKQ0KK3ZvaWQgX19leGl0IGNsZWFudXBfbXB1NDAxKHZvaWQpDQogew0K
IAlpZiAoaW8gIT0gLTEgJiYgaXJxICE9IC0xKSB7DQogCQkvKiBDaGVjayBm
b3IgdXNlIGJ5LCBmb3IgZXhhbXBsZSwgc3NjYXBlIGRyaXZlciAqLw0K
--8323328-2039088291-973982398=:11176--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
