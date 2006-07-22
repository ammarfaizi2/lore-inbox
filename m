Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWGVMBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWGVMBE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 08:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWGVMBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 08:01:04 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:15085 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751169AbWGVMBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 08:01:02 -0400
Message-Id: <1153569662.17307.266622961@webmail.messagingengine.com>
X-Sasl-Enc: tXh+z5RXHJzteEMoP3u3Gt0y/uDF/IwZVFGsMhI2V/Cm 1153569662
From: "Komal Shah" <komal_shah802003@yahoo.com>
To: juha.yrjola@solidboot.com, tony@atomide.com, dsaxena@plexity.net,
       mb@bu3sch.de
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: multipart/mixed; boundary="_----------=_1153569662173070"; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Subject: [PATCH] OMAP: Fix RNG driver build
Date: Sat, 22 Jul 2006 05:01:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--_----------=_1153569662173070
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Sat, 22 Jul 2006 12:01:02 UT

Michael/Deepak/Juha,

Attached patch fixes the following RNG driver build warnings and errors:

drivers/char/hw_random/omap-rng.c:33:32: asm/hardware/clock.h: No such file or directory
drivers/char/hw_random/omap-rng.c: In function `omap_rng_probe':
drivers/char/hw_random/omap-rng.c:88: warning: implicit declaration of function `to_platform_device'
drivers/char/hw_random/omap-rng.c:88: warning: initialization makes pointer from integer without a cast
drivers/char/hw_random/omap-rng.c:99: warning: implicit declaration of function `clk_get'
drivers/char/hw_random/omap-rng.c:99: warning: assignment makes pointer from integer without a cast
drivers/char/hw_random/omap-rng.c:106: warning: implicit declaration of function `clk_use'
drivers/char/hw_random/omap-rng.c:110: warning: implicit declaration of function `platform_get_resource'
drivers/char/hw_random/omap-rng.c:110: warning: assignment makes pointer from integer without a cast
drivers/char/hw_random/omap-rng.c:115: error: dereferencing pointer to incomplete type
drivers/char/hw_random/omap-rng.c: In function `omap_rng_remove':
drivers/char/hw_random/omap-rng.c:148: warning: implicit declaration of function `clk_unuse'
drivers/char/hw_random/omap-rng.c:149: warning: implicit declaration of function `clk_put'
drivers/char/hw_random/omap-rng.c: At top level:
drivers/char/hw_random/omap-rng.c:184: error: `platform_bus_type' undeclared here (not in a function)
drivers/char/hw_random/omap-rng.c:184: error: initializer element is not constant
drivers/char/hw_random/omap-rng.c:184: error: (near initialization for `omap_rng_driver.bus')

Please give your Signed-off-by: line if it is OK.

---Komal Shah
http://komalshah.blogspot.com

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow


--_----------=_1153569662173070
Content-Disposition: attachment; filename="0001-OMAP-Fix-RNG-build.patch"
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="0001-OMAP-Fix-RNG-build.patch"
MIME-Version: 1.0
X-Mailer: MessagingEngine.com Webmail Interface
Date: Sat, 22 Jul 2006 12:01:02 UT

RnJvbSBub2JvZHkgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEtv
bWFsIFNoYWggPGtvbWFsX3NoYWg4MDIwMDNAeWFob28uY29tPgpEYXRlOiBT
YXQsIDIyIEp1bCAyMDA2IDIyOjU0OjMwICswNTMwClN1YmplY3Q6IFtQQVRD
SF0gT01BUDogRml4IFJORyBkcml2ZXIgYnVpbGQuCgpGaXhlcyBmb2xsb3dp
bmcgd2FybmluZ3MgYW5kIGVycm9yczoKCmRyaXZlcnMvY2hhci9od19yYW5k
b20vb21hcC1ybmcuYzozMzozMjogYXNtL2hhcmR3YXJlL2Nsb2NrLmg6IE5v
IHN1Y2ggZmlsZSBvcgpkaXJlY3RvcnkKZHJpdmVycy9jaGFyL2h3X3JhbmRv
bS9vbWFwLXJuZy5jOiBJbiBmdW5jdGlvbiBgb21hcF9ybmdfcHJvYmUnOgpk
cml2ZXJzL2NoYXIvaHdfcmFuZG9tL29tYXAtcm5nLmM6ODg6IHdhcm5pbmc6
IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCmB0b19wbGF0Zm9y
bV9kZXZpY2UnCmRyaXZlcnMvY2hhci9od19yYW5kb20vb21hcC1ybmcuYzo4
ODogd2FybmluZzogaW5pdGlhbGl6YXRpb24gbWFrZXMgcG9pbnRlciBmcm9t
CmludGVnZXIgd2l0aG91dCBhIGNhc3QKZHJpdmVycy9jaGFyL2h3X3JhbmRv
bS9vbWFwLXJuZy5jOjk5OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbgpgY2xrX2dldCcKZHJpdmVycy9jaGFyL2h3X3JhbmRv
bS9vbWFwLXJuZy5jOjk5OiB3YXJuaW5nOiBhc3NpZ25tZW50IG1ha2VzIHBv
aW50ZXIgZnJvbQppbnRlZ2VyIHdpdGhvdXQgYSBjYXN0CmRyaXZlcnMvY2hh
ci9od19yYW5kb20vb21hcC1ybmcuYzoxMDY6IHdhcm5pbmc6IGltcGxpY2l0
IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCmBjbGtfdXNlJwpkcml2ZXJzL2No
YXIvaHdfcmFuZG9tL29tYXAtcm5nLmM6MTEwOiB3YXJuaW5nOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbgpgcGxhdGZvcm1fZ2V0X3Jlc291
cmNlJwpkcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29tYXAtcm5nLmM6MTEwOiB3
YXJuaW5nOiBhc3NpZ25tZW50IG1ha2VzIHBvaW50ZXIgZnJvbQppbnRlZ2Vy
IHdpdGhvdXQgYSBjYXN0CmRyaXZlcnMvY2hhci9od19yYW5kb20vb21hcC1y
bmcuYzoxMTU6IGVycm9yOiBkZXJlZmVyZW5jaW5nIHBvaW50ZXIgdG8KaW5j
b21wbGV0ZSB0eXBlCmRyaXZlcnMvY2hhci9od19yYW5kb20vb21hcC1ybmcu
YzogSW4gZnVuY3Rpb24gYG9tYXBfcm5nX3JlbW92ZSc6CmRyaXZlcnMvY2hh
ci9od19yYW5kb20vb21hcC1ybmcuYzoxNDg6IHdhcm5pbmc6IGltcGxpY2l0
IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCmBjbGtfdW51c2UnCmRyaXZlcnMv
Y2hhci9od19yYW5kb20vb21hcC1ybmcuYzoxNDk6IHdhcm5pbmc6IGltcGxp
Y2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCmBjbGtfcHV0Jwpkcml2ZXJz
L2NoYXIvaHdfcmFuZG9tL29tYXAtcm5nLmM6IEF0IHRvcCBsZXZlbDoKZHJp
dmVycy9jaGFyL2h3X3JhbmRvbS9vbWFwLXJuZy5jOjE4NDogZXJyb3I6IGBw
bGF0Zm9ybV9idXNfdHlwZScgdW5kZWNsYXJlZApoZXJlIChub3QgaW4gYSBm
dW5jdGlvbikKZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9vbWFwLXJuZy5jOjE4
NDogZXJyb3I6IGluaXRpYWxpemVyIGVsZW1lbnQgaXMgbm90CmNvbnN0YW50
CmRyaXZlcnMvY2hhci9od19yYW5kb20vb21hcC1ybmcuYzoxODQ6IGVycm9y
OiAobmVhciBpbml0aWFsaXphdGlvbiBmb3IKCQkJCQkgICAgICAgYG9tYXBf
cm5nX2RyaXZlci5idXMnKQoKU2lnbmVkLW9mZi1ieTogS29tYWwgU2hhaCA8
a29tYWxfc2hhaDgwMjAwM0B5YWhvby5jb20+CgotLS0KCiBkcml2ZXJzL2No
YXIvaHdfcmFuZG9tL29tYXAtcm5nLmMgfCAgICA5ICsrKystLS0tLQogMSBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CgowMWJjMTY1MmU2ODIyOTg5NjdlZmQyNTgyOTJhYTc3ZDJiOTVhMmE2CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29tYXAtcm5nLmMg
Yi9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL29tYXAtcm5nLmMKaW5kZXggODE5
NTE2Yi4uNjgxMWRhNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9jaGFyL2h3X3Jh
bmRvbS9vbWFwLXJuZy5jCisrKyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20v
b21hcC1ybmcuYwpAQCAtMjgsOSArMjgsMTAgQEAgI2luY2x1ZGUgPGxpbnV4
L3JhbmRvbS5oPgogI2luY2x1ZGUgPGxpbnV4L2Vyci5oPgogI2luY2x1ZGUg
PGxpbnV4L2RldmljZS5oPgogI2luY2x1ZGUgPGxpbnV4L2h3X3JhbmRvbS5o
PgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1
ZGUgPGxpbnV4L2Nsay5oPgogCiAjaW5jbHVkZSA8YXNtL2lvLmg+Ci0jaW5j
bHVkZSA8YXNtL2hhcmR3YXJlL2Nsb2NrLmg+CiAKICNkZWZpbmUgUk5HX09V
VF9SRUcJCTB4MDAJCS8qIE91dHB1dCByZWdpc3RlciAqLwogI2RlZmluZSBS
TkdfU1RBVF9SRUcJCTB4MDQJCS8qIFN0YXR1cyByZWdpc3RlcgpAQCAtMTAy
LDkgKzEwMyw3IEBAIHN0YXRpYyBpbnQgX19pbml0IG9tYXBfcm5nX3Byb2Jl
KHN0cnVjdCAKIAkJCXJldCA9IFBUUl9FUlIocm5nX2ljayk7CiAJCQlyZXR1
cm4gcmV0OwogCQl9Ci0JCWVsc2UgewotCQkJY2xrX3VzZShybmdfaWNrKTsK
LQkJfQorCQljbGtfZW5hYmxlKHJuZ19pY2spOwogCX0KIAogCXJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7
CkBAIC0xNDUsNyArMTQ0LDcgQEAgc3RhdGljIGludCBfX2V4aXQgb21hcF9y
bmdfcmVtb3ZlKHN0cnVjdAogCW9tYXBfcm5nX3dyaXRlX3JlZyhSTkdfTUFT
S19SRUcsIDB4MCk7CiAKIAlpZiAoY3B1X2lzX29tYXAyNHh4KCkpIHsKLQkJ
Y2xrX3VudXNlKHJuZ19pY2spOworCQljbGtfZGlzYWJsZShybmdfaWNrKTsK
IAkJY2xrX3B1dChybmdfaWNrKTsKIAl9CiAKLS0gCjEuMy4zCgo=

--_----------=_1153569662173070--

