Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbTJDOTS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 10:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTJDOTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 10:19:18 -0400
Received: from 82-68-84-59.dsl.in-addr.zen.co.uk ([82.68.84.59]:11648 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S262053AbTJDOTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 10:19:15 -0400
Date: Sat, 4 Oct 2003 15:15:35 +0100
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: patch for 2.4.23pre6aa2 thinkpad compile errors
Message-ID: <20031004141535.GA12876@tor.trudheim.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When building the 2.4.23pre6aa2 kernel, there was some compile breaks
in the new thinkpad support. All that was missing was an include line
in some files, see attached patch.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Ltd. - Linux System Administrator

PGP Usage Strongly Advised!!      My Key ID =3D 4B20601A
Fingerprint =3D 1B11 2F8C CBD6 7E53 E246  B23B 2D8C B0AA 4B20 601A

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.23pre6aa2.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.23pre6aa2/drivers/char/thinkpad/rtcmosram.c.orig	2003-10-04 1=
5:08:23.000000000 +0100
+++ linux-2.4.23pre6aa2/drivers/char/thinkpad/rtcmosram.c	2003-10-04 15:08:=
36.000000000 +0100
@@ -30,6 +30,7 @@
 #include "thinkpad_driver.h"
=20
 #include <linux/kernel.h>
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
--- linux-2.4.23pre6aa2/drivers/char/thinkpad/smapi_core.c.orig	2003-10-04 =
15:07:11.000000000 +0100
+++ linux-2.4.23pre6aa2/drivers/char/thinkpad/smapi_core.c	2003-10-04 15:07=
:25.000000000 +0100
@@ -30,6 +30,7 @@
 #include "thinkpad_driver.h"
=20
 #include <linux/kernel.h>
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
--- linux-2.4.23pre6aa2/drivers/char/thinkpad/superio.c.orig	2003-10-04 15:=
07:48.000000000 +0100
+++ linux-2.4.23pre6aa2/drivers/char/thinkpad/superio.c	2003-10-04 15:08:01=
.000000000 +0100
@@ -31,6 +31,7 @@
 #include "thinkpad_driver.h"
=20
 #include <linux/kernel.h>
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
--- linux-2.4.23pre6aa2/drivers/char/thinkpad/thinkpad.c.orig	2003-10-04 14=
:53:37.000000000 +0100
+++ linux-2.4.23pre6aa2/drivers/char/thinkpad/thinkpad.c	2003-10-04 15:06:2=
6.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/kmod.h>
 #include <linux/kernel.h>
+#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
--- linux-2.4.23pre6aa2/drivers/char/thinkpad/thinkpadpm.c.orig	2003-10-04 =
15:09:05.000000000 +0100
+++ linux-2.4.23pre6aa2/drivers/char/thinkpad/thinkpadpm.c	2003-10-04 15:09=
:18.000000000 +0100
@@ -31,6 +31,7 @@
 #include "thinkpad_driver.h"
=20
 #include <linux/kernel.h>
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>

--bg08WKrSYDhXBjb5--

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ftYHLYywqksgYBoRAqGzAJ4hHVe1zEBoom7tTT6ceBviN7iPXACfZWNw
EqtH+pW2dloE9WywzLKeDtw=
=SSrH
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
