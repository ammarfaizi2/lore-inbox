Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTIHQjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTIHQjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:39:51 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:2711 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S262771AbTIHQjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:39:48 -0400
Date: Mon, 8 Sep 2003 12:36:39 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Vagn Scott <vagn@ranok.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: [PATCH] BINFMT_ZFLAT (was [2.6.0-test4] boolean symbol BINFMT_ZFLAT
 tested for 'm'? test forced to 'n')
In-Reply-To: <E19vpC0-0000BJ-00@Maya.ny.ranok.com>
Message-ID: <Pine.GSO.4.33.0309081230160.13584-200000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1271212614-1063038999=:13584"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1271212614-1063038999=:13584
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sat, 6 Sep 2003, Vagn Scott wrote:
>scripts/kconfig/conf -s arch/i386/Kconfig
>boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'

Hear ya go...

# This is a BitKeeper patch.  What follows are the unified diffs for the
# set of deltas contained in the patch.  The rest of the patch, the part
# that BitKeeper cares about, is below these diffs. (actually, attached)
# User:	jfbeam
# Host:	troz.com
# Root:	/usr/src/linux-2.6-bk

--- 1.5/lib/Kconfig	Thu Jun 19 13:06:56 2003
+++ 1.6/lib/Kconfig	Sun Sep  7 04:33:24 2003
@@ -18,7 +18,7 @@
 config ZLIB_INFLATE
 	tristate
 	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || BINFMT_ZFLAT=y || CRYPTO_DEFLATE=y
-	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || BINFMT_ZFLAT=m || CRYPTO_DEFLATE=m
+	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || CRYPTO_DEFLATE=m

 config ZLIB_DEFLATE
 	tristate

--Ricky


---559023410-1271212614-1063038999=:13584
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="zflat.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0309081236390.13584@sweetums.bluetronic.net>
Content-Description: BK send patch
Content-Disposition: attachment; filename="zflat.patch"

VGhpcyBCaXRLZWVwZXIgcGF0Y2ggY29udGFpbnMgdGhlIGZvbGxvd2luZyBj
aGFuZ2VzZXRzOg0KMS4xMTY2DQoNCiMgVGhpcyBpcyBhIEJpdEtlZXBlciBw
YXRjaC4gIFdoYXQgZm9sbG93cyBhcmUgdGhlIHVuaWZpZWQgZGlmZnMgZm9y
IHRoZQ0KIyBzZXQgb2YgZGVsdGFzIGNvbnRhaW5lZCBpbiB0aGUgcGF0Y2gu
ICBUaGUgcmVzdCBvZiB0aGUgcGF0Y2gsIHRoZSBwYXJ0DQojIHRoYXQgQml0
S2VlcGVyIGNhcmVzIGFib3V0LCBpcyBiZWxvdyB0aGVzZSBkaWZmcy4NCiMg
VXNlcjoJamZiZWFtDQojIEhvc3Q6CXRyb3ouY29tDQojIFJvb3Q6CS91c3Iv
c3JjL2xpbnV4LTIuNi1iaw0KDQojDQojLS0tIDEuNS9saWIvS2NvbmZpZwlU
aHUgSnVuIDE5IDEzOjA2OjU2IDIwMDMNCiMrKysgMS42L2xpYi9LY29uZmln
CVN1biBTZXAgIDcgMDQ6MzM6MjQgMjAwMw0KI0BAIC0xOCw3ICsxOCw3IEBA
DQojIGNvbmZpZyBaTElCX0lORkxBVEUNCiMgCXRyaXN0YXRlDQojIAlkZWZh
dWx0IHkgaWYgQ1JBTUZTPXkgfHwgUFBQX0RFRkxBVEU9eSB8fCBKRkZTMl9G
Uz15IHx8IFpJU09GU19GUz15IHx8IEJJTkZNVF9aRkxBVD15IHx8IENSWVBU
T19ERUZMQVRFPXkNCiMtCWRlZmF1bHQgbSBpZiBDUkFNRlM9bSB8fCBQUFBf
REVGTEFURT1tIHx8IEpGRlMyX0ZTPW0gfHwgWklTT0ZTX0ZTPW0gfHwgQklO
Rk1UX1pGTEFUPW0gfHwgQ1JZUFRPX0RFRkxBVEU9bQ0KIysJZGVmYXVsdCBt
IGlmIENSQU1GUz1tIHx8IFBQUF9ERUZMQVRFPW0gfHwgSkZGUzJfRlM9bSB8
fCBaSVNPRlNfRlM9bSB8fCBDUllQVE9fREVGTEFURT1tDQojIA0KIyBjb25m
aWcgWkxJQl9ERUZMQVRFDQojIAl0cmlzdGF0ZQ0KIw0KDQojIERpZmYgY2hl
Y2tzdW09NjA5YzhkMTANCg0KDQojIFBhdGNoIHZlcnM6CTEuMw0KIyBQYXRj
aCB0eXBlOglSRUdVTEFSDQoNCj09IENoYW5nZVNldCA9PQ0KdG9ydmFsZHNA
YXRobG9uLnRyYW5zbWV0YS5jb218Q2hhbmdlU2V0fDIwMDIwMjA1MTczMDU2
fDE2MDQ3fGMxZDExYTQxZWQwMjQ4NjQNCmpmYmVhbUB0cm96LmNvbXxDaGFu
Z2VTZXR8MjAwMzA5MDYwMjI1NTZ8MDk4MzQNCkQgMS4xMTY2IDAzLzA5LzA3
IDA0OjMzOjQzLTA0OjAwIGpmYmVhbUB0cm96LmNvbSArMSAtMA0KQiB0b3J2
YWxkc0BhdGhsb24udHJhbnNtZXRhLmNvbXxDaGFuZ2VTZXR8MjAwMjAyMDUx
NzMwNTZ8MTYwNDd8YzFkMTFhNDFlZDAyNDg2NA0KQw0KYyBbUEFUQ0hdIEJJ
TkZNVF9aRkxBVCBjYW5ub3QgYmUgJ20nDQpLIDk5NjENClAgQ2hhbmdlU2V0
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCg0KMGEwDQo+IHppcHBlbEBsaW51eC1tNjhrLm9yZ1t0b3J2YWxk
c118bGliL0tjb25maWd8MjAwMjEwMzAwNDMyMzh8MzI0NDl8NzI1YjE2MTEy
OTgyYTJlZSBqZmJlYW1AdHJvei5jb218bGliL0tjb25maWd8MjAwMzA5MDcw
ODMzMjR8NjU0NTENCg0KPT0gbGliL0tjb25maWcgPT0NCnppcHBlbEBsaW51
eC1tNjhrLm9yZ1t0b3J2YWxkc118bGliL0tjb25maWd8MjAwMjEwMzAwNDMy
Mzh8MzI0NDl8NzI1YjE2MTEyOTgyYTJlZQ0KZ3JlZ0Brcm9haC5jb218bGli
L0tjb25maWd8MjAwMzA2MTkxNzA2NTZ8MDEzMjUNCkQgMS42IDAzLzA5LzA3
IDA0OjMzOjI0LTA0OjAwIGpmYmVhbUB0cm96LmNvbSArMSAtMQ0KQiB0b3J2
YWxkc0BhdGhsb24udHJhbnNtZXRhLmNvbXxDaGFuZ2VTZXR8MjAwMjAyMDUx
NzMwNTZ8MTYwNDd8YzFkMTFhNDFlZDAyNDg2NA0KQw0KYyBCSU5GTVRfWkZM
QVQgaXMgYm9vbA0KSyA2NTQ1MQ0KTyAtcnctcnctci0tDQpQIGxpYi9LY29u
ZmlnDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCg0KRDIxIDENCkkyMSAxDQoJZGVmYXVsdCBtIGlmIENSQU1G
Uz1tIHx8IFBQUF9ERUZMQVRFPW0gfHwgSkZGUzJfRlM9bSB8fCBaSVNPRlNf
RlM9bSB8fCBDUllQVE9fREVGTEFURT1tDQoNCiMgUGF0Y2ggY2hlY2tzdW09
OThhMzJjOGINCg==
---559023410-1271212614-1063038999=:13584--
