Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSFJAPe>; Sun, 9 Jun 2002 20:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315445AbSFJAPd>; Sun, 9 Jun 2002 20:15:33 -0400
Received: from dc-mx14.cluster1.charter.net ([209.225.8.24]:6312 "EHLO
	dc-mx14.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S315438AbSFJAPc>; Sun, 9 Jun 2002 20:15:32 -0400
From: Cory Watson <gphat@cafes.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] emu10k1, 2.5.21
Date: Sun, 9 Jun 2002 19:16:07 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_VERGCADQNG0IT1ULMXVR"
Message-ID: <auto-000057796559@dc-mx14.cluster1.charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_VERGCADQNG0IT1ULMXVR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

emu10k1 wouldn't compile for me, this patch fixes it via #including
linux/init.h.  Perhaps this is the wrong way, but it works for me.

Attached, and below:

iff -urN a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
--- a/sound/pci/emu10k1/emufx.c	Sun May  5 22:37:52 2002
+++ b/sound/pci/emu10k1/emufx.c	Sun Jun  9 15:04:01 2002
@@ -29,6 +29,7 @@
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>

diff -urN a/sound/pci/emu10k1/emumixer.c b/sound/pci/emu10k1/emumixer.c
--- a/sound/pci/emu10k1/emumixer.c	Sun May  5 22:37:58 2002
+++ b/sound/pci/emu10k1/emumixer.c	Sun Jun  9 15:03:36 2002
@@ -29,6 +29,7 @@
 #define __NO_VERSION__
 #include <sound/driver.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>

diff -urN a/sound/pci/emu10k1/emumpu401.c b/sound/pci/emu10k1/emumpu401.c
--- a/sound/pci/emu10k1/emumpu401.c	Sun May  5 22:37:55 2002
+++ b/sound/pci/emu10k1/emumpu401.c	Sun Jun  9 15:01:36 2002
@@ -22,6 +22,7 @@
 #define __NO_VERSION__
 #include <sound/driver.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>

diff -urN a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
--- a/sound/pci/emu10k1/emupcm.c	Sun May  5 22:37:53 2002
+++ b/sound/pci/emu10k1/emupcm.c	Sun Jun  9 15:02:52 2002
@@ -29,6 +29,7 @@
 #include <sound/driver.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>

diff -urN -X dontdiff a/sound/pci/emu10k1/emuproc.c
b/sound/pci/emu10k1/emuproc.c
--- a/sound/pci/emu10k1/emuproc.c	Sun May  5 22:37:59 2002
+++ b/sound/pci/emu10k1/emuproc.c	Sun Jun  9 15:03:15 2002
@@ -28,6 +28,7 @@
 #define __NO_VERSION__
 #include <sound/driver.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/emu10k1.h>

--
Cory 'G' Watson

"You know the old saying -- any technology sufficiently advanced is
indistinguishable from a Perl script."
     - "Programming Perl", page 301

-------------------------------------------------------



-- 
Cory 'G' Watson

"You know the old saying -- any technology sufficiently advanced is 
indistinguishable from a Perl script."
     - "Programming Perl", page 301
--------------Boundary-00=_VERGCADQNG0IT1ULMXVR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="make-emu10k1-compile.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="make-emu10k1-compile.patch"

ZGlmZiAtdXJOIGEvc291bmQvcGNpL2VtdTEwazEvZW11ZnguYyBiL3NvdW5kL3BjaS9lbXUxMGsx
L2VtdWZ4LmMKLS0tIGEvc291bmQvcGNpL2VtdTEwazEvZW11ZnguYwlTdW4gTWF5ICA1IDIyOjM3
OjUyIDIwMDIKKysrIGIvc291bmQvcGNpL2VtdTEwazEvZW11ZnguYwlTdW4gSnVuICA5IDE1OjA0
OjAxIDIwMDIKQEAgLTI5LDYgKzI5LDcgQEAKICNpbmNsdWRlIDxzb3VuZC9kcml2ZXIuaD4KICNp
bmNsdWRlIDxsaW51eC9kZWxheS5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRl
IDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8c291bmQvY29yZS5oPgogI2luY2x1ZGUgPHNvdW5k
L2VtdTEwazEuaD4KIApkaWZmIC11ck4gYS9zb3VuZC9wY2kvZW11MTBrMS9lbXVtaXhlci5jIGIv
c291bmQvcGNpL2VtdTEwazEvZW11bWl4ZXIuYwotLS0gYS9zb3VuZC9wY2kvZW11MTBrMS9lbXVt
aXhlci5jCVN1biBNYXkgIDUgMjI6Mzc6NTggMjAwMgorKysgYi9zb3VuZC9wY2kvZW11MTBrMS9l
bXVtaXhlci5jCVN1biBKdW4gIDkgMTU6MDM6MzYgMjAwMgpAQCAtMjksNiArMjksNyBAQAogI2Rl
ZmluZSBfX05PX1ZFUlNJT05fXwogI2luY2x1ZGUgPHNvdW5kL2RyaXZlci5oPgogI2luY2x1ZGUg
PGxpbnV4L3RpbWUuaD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8c291bmQv
Y29yZS5oPgogI2luY2x1ZGUgPHNvdW5kL2VtdTEwazEuaD4KIApkaWZmIC11ck4gYS9zb3VuZC9w
Y2kvZW11MTBrMS9lbXVtcHU0MDEuYyBiL3NvdW5kL3BjaS9lbXUxMGsxL2VtdW1wdTQwMS5jCi0t
LSBhL3NvdW5kL3BjaS9lbXUxMGsxL2VtdW1wdTQwMS5jCVN1biBNYXkgIDUgMjI6Mzc6NTUgMjAw
MgorKysgYi9zb3VuZC9wY2kvZW11MTBrMS9lbXVtcHU0MDEuYwlTdW4gSnVuICA5IDE1OjAxOjM2
IDIwMDIKQEAgLTIyLDYgKzIyLDcgQEAKICNkZWZpbmUgX19OT19WRVJTSU9OX18KICNpbmNsdWRl
IDxzb3VuZC9kcml2ZXIuaD4KICNpbmNsdWRlIDxsaW51eC90aW1lLmg+CisjaW5jbHVkZSA8bGlu
dXgvaW5pdC5oPgogI2luY2x1ZGUgPHNvdW5kL2NvcmUuaD4KICNpbmNsdWRlIDxzb3VuZC9lbXUx
MGsxLmg+CiAKZGlmZiAtdXJOIGEvc291bmQvcGNpL2VtdTEwazEvZW11cGNtLmMgYi9zb3VuZC9w
Y2kvZW11MTBrMS9lbXVwY20uYwotLS0gYS9zb3VuZC9wY2kvZW11MTBrMS9lbXVwY20uYwlTdW4g
TWF5ICA1IDIyOjM3OjUzIDIwMDIKKysrIGIvc291bmQvcGNpL2VtdTEwazEvZW11cGNtLmMJU3Vu
IEp1biAgOSAxNTowMjo1MiAyMDAyCkBAIC0yOSw2ICsyOSw3IEBACiAjaW5jbHVkZSA8c291bmQv
ZHJpdmVyLmg+CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L3RpbWUu
aD4KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiAjaW5jbHVkZSA8c291bmQvY29yZS5oPgogI2lu
Y2x1ZGUgPHNvdW5kL2VtdTEwazEuaD4KIApkaWZmIC11ck4gLVggZG9udGRpZmYgYS9zb3VuZC9w
Y2kvZW11MTBrMS9lbXVwcm9jLmMgYi9zb3VuZC9wY2kvZW11MTBrMS9lbXVwcm9jLmMKLS0tIGEv
c291bmQvcGNpL2VtdTEwazEvZW11cHJvYy5jCVN1biBNYXkgIDUgMjI6Mzc6NTkgMjAwMgorKysg
Yi9zb3VuZC9wY2kvZW11MTBrMS9lbXVwcm9jLmMJU3VuIEp1biAgOSAxNTowMzoxNSAyMDAyCkBA
IC0yOCw2ICsyOCw3IEBACiAjZGVmaW5lIF9fTk9fVkVSU0lPTl9fCiAjaW5jbHVkZSA8c291bmQv
ZHJpdmVyLmg+CiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgorI2luY2x1ZGUgPGxpbnV4L2luaXQu
aD4KICNpbmNsdWRlIDxzb3VuZC9jb3JlLmg+CiAjaW5jbHVkZSA8c291bmQvZW11MTBrMS5oPgog
Cg==

--------------Boundary-00=_VERGCADQNG0IT1ULMXVR
Content-Type: text/plain;
  charset="iso-8859-1";
  name="README"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="README"

QWRkcyBsaW51eC9pbml0LmggdG8gZW11ZnguYywgZW11bWl4ZXIuYywgZW11bXB1NDAxLmMsIGVt
dXBjbS5jLCBlbXVwcm8uYwoKQ29yeSBXYXRzb24gKGdwaGF0QGNhZmVzLm5ldCkK

--------------Boundary-00=_VERGCADQNG0IT1ULMXVR--
