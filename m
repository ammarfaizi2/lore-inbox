Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265665AbSKAIhR>; Fri, 1 Nov 2002 03:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSKAIhR>; Fri, 1 Nov 2002 03:37:17 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:53227 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265665AbSKAIhP>; Fri, 1 Nov 2002 03:37:15 -0500
Date: Fri, 1 Nov 2002 09:43:20 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [2.5. PATCH] cpufreq: update Documentation
Message-ID: <20021101094320.A2500@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Update/Add description of longhaul module parameters. (David Kimdon)
Also update status of ARM drivers, and add cpufreq to the list in
00-INDEX.

	Dominik

diff -ruN linux-2545original/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-2545original/arch/i386/Kconfig	Thu Oct 31 12:00:00 2002
+++ linux/arch/i386/Kconfig	Thu Oct 31 21:00:00 2002
@@ -525,6 +525,13 @@
 	  VIA Cyrix Samuel/C3, VIA Cyrix Ezra and VIA Cyrix Ezra-T=20
 	  processors.
=20
+	  If you do not want to scale the Front Side Bus or voltage,
+	  pass the module parameter "dont_scale_fsb=3D1" or
+	  "dont_scale_voltage=3D1". Additionally, it is advised that
+	  you pass the current Front Side Bus speed (in MHz) to=20
+	  this module as module parameter "current_fsb", e.g.=20
+	  "current_fsb=3D133" for a Front Side Bus speed of 133 MHz.
+
 	  For details, take a look at linux/Documentation/cpufreq.=20
=20
 	  If in doubt, say N.
diff -ruN linux-2545original/Documentation/00-INDEX linux/Documentation/00-=
INDEX
--- linux-2545original/Documentation/00-INDEX	Thu Oct 31 12:00:00 2002
+++ linux/Documentation/00-INDEX	Thu Oct 31 21:00:00 2002
@@ -58,6 +58,8 @@
 	- info on Computone Intelliport II/Plus Multiport Serial Driver
 cpqarray.txt
 	- info on using Compaq's SMART2 Intelligent Disk Array Controllers.
+cpufreq
+	- describes the CPU frequency and voltage scaling support=20
 cris/
 	- directory with info about Linux on CRIS architecture.
 devices.txt
diff -ruN linux-2544original/Documentation/cpufreq linux/Documentation/cpuf=
req
--- linux-2544original/Documentation/cpufreq	Thu Oct 31 12:00:00 2002
+++ linux/Documentation/cpufreq	Thu Oct 31 21:00:00 2002
@@ -37,8 +37,7 @@
 ARM:
     ARM Integrator, SA 1100, SA1110
 --------------------------------
-    This driver will be ported to new CPUFreq core soon, so
-    far it will not work.
+    No known issues.   =20
=20
=20
 AMD Elan:
@@ -56,19 +55,19 @@
     VIA Cyrix Ezra, VIA Cyrix Ezra-T
 --------------------------------
     If you do not want to scale the Front Side Bus or voltage,
-    pass the module parameter "dont_scale_fsb 1" or
-    "dont_scale_voltage 1". Additionally, it is advised that
+    pass the module parameter "dont_scale_fsb=3D1" or
+    "dont_scale_voltage=3D1". Additionally, it is advised that
     you pass the current Front Side Bus speed (in MHz) to=20
     this module as module parameter "current_fsb", e.g.=20
-    "current_fsb 133" for a Front Side Bus speed of 133 MHz.
+    "current_fsb=3D133" for a Front Side Bus speed of 133 MHz.
=20
=20
 Intel SpeedStep:
     certain mobile Intel Pentium III (Coppermine), and all mobile
     Intel Pentium III-M (Tualatin) and mobile Intel Pentium 4 P4-Ms.
 --------------------------------
-    Unfortunately only modern Intel ICH2-M and ICH3-M chipsets are=20
-    supported.
+    Unfortunately, only modern Intel ICH2-M and ICH3-M chipsets are=20
+    supported yet.
=20
=20
 P4 CPU Clock Modulation:

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9wj6nZ8MDCHJbN8YRAiqNAJ9YdHyZyhy77HzZmH2kHQGCz7sOqgCfdWC8
lagrbz3PbcPGZF3R5QIAlJ0=
=vGXc
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
