Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131883AbQKQKuP>; Fri, 17 Nov 2000 05:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131882AbQKQKtz>; Fri, 17 Nov 2000 05:49:55 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:4515 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S131795AbQKQKtx>; Fri, 17 Nov 2000 05:49:53 -0500
Date: Fri, 17 Nov 2000 10:19:52 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: PATCH: 2.4.0-test11-pre6 NTFS: new_inode namespace clash fix
Message-ID: <Pine.SOL.3.96.1001117101847.16389A-200000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-974456312=:15796"
Content-ID: <Pine.SOL.3.96.1001117101847.16389B@virgo.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-974456312=:15796
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.SOL.3.96.1001117101847.16389C@virgo.cus.cam.ac.uk>

This patch fixes the namespace collision in NTFS new_inode that appeared
with pre6 (have submitted it to Linus).

Thanks go to Albert Cranford <ac9410@bellsouth.net> for being the first
one to spot this.

Regards,

Anton

-- 

Anton Altaparmakov       Phone: +44-(0)1223-333541 (lab)
Christ's College         eMail: AntonA@bigfoot.com
Cambridge CB2 3BU          WWW: http://www-stu.christs.cam.ac.uk/~aia21/
United Kingdom             ICQ: 8561279

---559023410-851401618-974456312=:15796
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ntfs_new_inode.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.96.1001117101832.15796B@virgo.cus.cam.ac.uk>
Content-Description: 

ZGlmZiAtdXIgbGludXgtMi40LjAtdGVzdDExLXByZTYvZnMvbnRmcy9mcy5j
IGxpbnV4L2ZzL250ZnMvZnMuYw0KLS0tIGxpbnV4LTIuNC4wLXRlc3QxMS1w
cmU2L2ZzL250ZnMvZnMuYwlGcmkgTm92IDE3IDExOjA1OjExIDIwMDANCisr
KyBsaW51eC9mcy9udGZzL2ZzLmMJRnJpIE5vdiAxNyAxMTowODowMiAyMDAw
DQpAQCAtNDI4LDcgKzQyOCw3IEBADQogCWludCBlcnJvcj0wOw0KIAludGZz
X2F0dHJpYnV0ZSAqc2k7DQogDQotCXI9bmV3X2lub2RlKGRpci0+aV9zYik7
DQorCXI9bnRmc19uZXdfaW5vZGUoZGlyLT5pX3NiKTsNCiAJaWYoIXIpew0K
IAkJZXJyb3I9RU5PTUVNOw0KIAkJZ290byBmYWlsOw0KQEAgLTUwMCw3ICs1
MDAsNyBAQA0KIAkJZ290byBvdXQ7DQogDQogCWVycm9yID0gRUlPOw0KLQly
ID0gbmV3X2lub2RlKGRpci0+aV9zYik7DQorCXIgPSBudGZzX25ld19pbm9k
ZShkaXItPmlfc2IpOw0KIAlpZiAoIXIpDQogCQlnb3RvIG91dDsNCiAJDQpk
aWZmIC11ciBsaW51eC0yLjQuMC10ZXN0MTEtcHJlNi9mcy9udGZzL2lub2Rl
LmMgbGludXgvZnMvbnRmcy9pbm9kZS5jDQotLS0gbGludXgtMi40LjAtdGVz
dDExLXByZTYvZnMvbnRmcy9pbm9kZS5jCVdlZCBKdW4gMjEgMTg6MTA6MDIg
MjAwMA0KKysrIGxpbnV4L2ZzL250ZnMvaW5vZGUuYwlGcmkgTm92IDE3IDEx
OjA4OjMyIDIwMDANCkBAIC0xMDUwLDcgKzEwNTAsNyBAQA0KIA0KIC8qIFdl
IGhhdmUgdG8gc2tpcCB0aGUgMTYgbWV0YWZpbGVzIGFuZCB0aGUgOCByZXNl
cnZlZCBlbnRyaWVzICovDQogc3RhdGljIGludCANCi1uZXdfaW5vZGUgKG50
ZnNfdm9sdW1lKiB2b2wsaW50KiByZXN1bHQpDQorbnRmc19uZXdfaW5vZGUg
KG50ZnNfdm9sdW1lKiB2b2wsaW50KiByZXN1bHQpDQogew0KIAlpbnQgYnl0
ZSxlcnJvcjsNCiAJaW50IGJpdDsNCkBAIC0xMjM2LDExICsxMjM2LDExIEBA
DQogCW50ZnNfdm9sdW1lKiB2b2w9ZGlyLT52b2w7DQogCWludCBieXRlLGJp
dDsNCiANCi0JZXJyb3I9bmV3X2lub2RlICh2b2wsJihyZXN1bHQtPmlfbnVt
YmVyKSk7DQorCWVycm9yPW50ZnNfbmV3X2lub2RlICh2b2wsJihyZXN1bHQt
PmlfbnVtYmVyKSk7DQogCWlmKGVycm9yPT1FTk9TUEMpew0KIAkJZXJyb3I9
bnRmc19leHRlbmRfbWZ0KHZvbCk7DQogCQlpZihlcnJvcilyZXR1cm4gZXJy
b3I7DQotCQllcnJvcj1uZXdfaW5vZGUodm9sLCYocmVzdWx0LT5pX251bWJl
cikpOw0KKwkJZXJyb3I9bnRmc19uZXdfaW5vZGUodm9sLCYocmVzdWx0LT5p
X251bWJlcikpOw0KIAl9DQogCWlmKGVycm9yKXsNCiAJCW50ZnNfZXJyb3Ig
KCJudGZzX2dldF9lbXB0eV9pbm9kZTogbm8gZnJlZSBpbm9kZXNcbiIpOw0K

---559023410-851401618-974456312=:15796--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
