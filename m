Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAZNaQ>; Fri, 26 Jan 2001 08:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbRAZNaG>; Fri, 26 Jan 2001 08:30:06 -0500
Received: from wg.redhat.de ([193.103.254.4]:12360 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S129562AbRAZNaB>;
	Fri, 26 Jan 2001 08:30:01 -0500
Date: Fri, 26 Jan 2001 14:29:59 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@redhat.com>
Subject: [PATCH] MatroxFB support can't be compiled into kernel in 2.4.0-ac11
Message-ID: <Pine.LNX.4.30.0101261421550.29870-200000@bochum.redhat.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279710978-395707962-980515771=:29870"
Content-ID: <Pine.LNX.4.30.0101261429420.30041@bochum.redhat.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279710978-395707962-980515771=:29870
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.30.0101261429421.30041@bochum.redhat.de>

Subject says it all - works as a module, but can't be compiled into the
kernel because of duplicate definitions, caused by several files including
matroxfb_base.h which in turn defines global_disp.

Patch attached.

LLaP
bero


--279710978-395707962-980515771=:29870
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="matroxfb-compile.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0101261429310.29870@bochum.redhat.de>
Content-Description: matroxfb patch
Content-Disposition: ATTACHMENT; FILENAME="matroxfb-compile.patch"

LS0tIGxpbnV4L2RyaXZlcnMvdmlkZW8vbWF0cm94L21hdHJveGZiX2Jhc2Uu
aC5iZXJvCUZyaSBKYW4gMjYgMTM6Mzk6NTQgMjAwMQ0KKysrIGxpbnV4L2Ry
aXZlcnMvdmlkZW8vbWF0cm94L21hdHJveGZiX2Jhc2UuaAlGcmkgSmFuIDI2
IDEzOjQwOjIyIDIwMDENCkBAIC01ODksNyArNTg5LDExIEBADQogI2Vsc2UN
CiANCiBleHRlcm4gc3RydWN0IG1hdHJveF9mYl9pbmZvIG1hdHJveGZiX2ds
b2JhbF9teGluZm87DQorI2lmZGVmIE1PRFVMRQ0KIHN0cnVjdCBkaXNwbGF5
IGdsb2JhbF9kaXNwOw0KKyNlbHNlDQorZXh0ZXJuIHN0cnVjdCBkaXNwbGF5
IGdsb2JhbF9kaXNwOw0KKyNlbmRpZg0KIA0KICNkZWZpbmUgQUNDRVNTX0ZC
SU5GTyh4KSAobWF0cm94ZmJfZ2xvYmFsX214aW5mby54KQ0KICNkZWZpbmUg
QUNDRVNTX0ZCSU5GTzIoaW5mbywgeCkgKG1hdHJveGZiX2dsb2JhbF9teGlu
Zm8ueCkNCi0tLSBsaW51eC9kcml2ZXJzL3ZpZGVvL21hdHJveC9tYXRyb3hm
Yl9iYXNlLmMuYmVybwlGcmkgSmFuIDI2IDEzOjQwOjQwIDIwMDENCisrKyBs
aW51eC9kcml2ZXJzL3ZpZGVvL21hdHJveC9tYXRyb3hmYl9iYXNlLmMJRnJp
IEphbiAyNiAxMzo0MToyOSAyMDAxDQpAQCAtOTgsNiArOTgsMTAgQEANCiAj
aW5jbHVkZSA8bGludXgvbWF0cm94ZmIuaD4NCiAjaW5jbHVkZSA8YXNtL3Vh
Y2Nlc3MuaD4NCiANCisjaWZuZGVmIE1PRFVMRQ0KK3N0cnVjdCBkaXNwbGF5
IGdsb2JhbF9kaXNwOw0KKyNlbmRpZg0KKyANCiAjaWZkZWYgQ09ORklHX1BQ
Qw0KIHVuc2lnbmVkIGNoYXIgbnZyYW1fcmVhZF9ieXRlKGludCk7DQogc3Rh
dGljIGludCBkZWZhdWx0X3Ztb2RlID0gVk1PREVfTlZSQU07DQo=
--279710978-395707962-980515771=:29870--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
