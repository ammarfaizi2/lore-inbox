Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbTDCXfB (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbTDCXfA (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:35:00 -0500
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:16608
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S263595AbTDCXez (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 18:34:55 -0500
Date: Thu, 3 Apr 2003 15:46:23 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com
Subject: [PATCH] Kconfig fixes
Message-ID: <20030403234623.GA1002@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I came across some ambiguity and some obvious typos in a few of the
Kconfig files, and a patch is attached. There's more to come, as I
stumble upon a few I will correct them.

Also, I corrected occurences of '.o' by removing the suffix. It
shouldn't matter to users who use modprobe -- people using insmod will
know that modules end in .ko in 2.5 kernels. (I suppose this is
debateable. Comments?)

The patch against 2.5.66 is attached.

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clarify_kconfig.diff"
Content-Transfer-Encoding: quoted-printable

--- a/drivers/net/wireless/Kconfig	2003-03-17 13:43:49.000000000 -0800
+++ b/drivers/net/wireless/Kconfig	2003-04-03 15:19:52.000000000 -0800
@@ -134,7 +134,7 @@
 	depends on NET_RADIO && PCMCIA
=20
 config PCMCIA_RAYCS
-	tristate "Aviator/Raytheon 2.4MHz wireless support"
+	tristate "Aviator/Raytheon 2.4GHz wireless support"
 	depends on NET_RADIO && PCMCIA
 	---help---
 	  Say Y here if you intend to attach an Aviator/Raytheon PCMCIA
@@ -189,6 +189,8 @@
 	  configure your card and that /etc/pcmcia/wireless.opts works :
 	  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>
=20
+	  If you compile this as a module, it will be called "hermes".
+
 config APPLE_AIRPORT
 	tristate "Apple Airport support (built-in)"
 	depends on ALL_PPC && HERMES
@@ -196,7 +198,9 @@
 	  Say Y here to support the Airport 802.11b wireless Ethernet hardware
 	  built into the Macintosh iBook and other recent PowerPC-based
 	  Macintosh machines. This is essentially a Lucent Orinoco card with=20
-	  a non-standard interface
+	  a non-standard interface.
+
+	  If you compile this as a module, it will be called "airport".
=20
 config PLX_HERMES
 	tristate "Hermes in PLX9052 based PCI adaptor support (Netgear MA301 etc.=
) (EXPERIMENTAL)"
@@ -212,6 +216,8 @@
 	  Support for these adaptors is so far still incomplete and buggy.
 	  You have been warned.
=20
+	  If you compile this as a module, it will be called "orinoco_plx".
+
 config PCI_HERMES
 	tristate "Prism 2.5 PCI 802.11b adaptor support (EXPERIMENTAL)"
 	depends on PCI && HERMES && EXPERIMENTAL
@@ -222,6 +228,8 @@
 	  common.  Some of the built-in wireless adaptors in laptops are of
 	  this variety.
=20
+	  If you compile this as a module, it will be called "orinoco_pci."
+
 # If Pcmcia is compiled in, offer Pcmcia cards...
 comment "Wireless 802.11b Pcmcia/Cardbus cards support"
 	depends on NET_RADIO && PCMCIA
@@ -246,6 +254,8 @@
 	  configure your card and that /etc/pcmcia/wireless.opts works:
 	  <http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Tools.html>.
=20
+	  If you compile this as a module, it will be called "orinoco_cs".
+
 config AIRO_CS
 	tristate "Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards"
 	depends on NET_RADIO && PCMCIA
@@ -259,7 +269,7 @@
 	  supports OEM of Cisco such as the DELL TrueMobile 4800 and Xircom
 	  802.11b cards.
=20
-	  This driver support both the standard Linux Wireless Extensions
+	  This driver supports both the standard Linux Wireless Extensions
 	  and Cisco proprietary API, so both the Linux Wireless Tools and the
 	  Cisco Linux utilities can be used to configure the card.
=20
@@ -268,6 +278,8 @@
 	  for location).  You also want to check out the PCMCIA-HOWTO,
 	  available from <http://www.linuxdoc.org/docs.html#howto>.
=20
+	  If you compile this as a module, it will be called "airo_cs".
+
 # yes, this works even when no drivers are selected
 config NET_WIRELESS
 	bool
--- a/drivers/serial/Kconfig	2003-04-01 21:58:50.000000000 -0800
+++ b/drivers/serial/Kconfig	2003-04-03 15:23:04.000000000 -0800
@@ -73,7 +73,7 @@
=20
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called serial_cs.  If you want to compile it as
+	  The module will be called 8250_cs.  If you want to compile it as
 	  a module, say M here and read <file:Documentation/modules.txt>.
 	  If unsure, say N.
=20
--- a/drivers/char/watchdog/Kconfig	2003-03-17 13:44:19.000000000 -0800
+++ /tmp/diffwOjj2c	2003-04-03 15:37:03.000000000 -0800
@@ -364,8 +364,7 @@
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want).
 	  If you want to compile it as a module, say M here and read
-	  Documentation/modules.txt. The module will be called
-	  wafer5823wdt.o
+	  Documentation/modules.txt. The module will be called "wafer5823wdt".
=20
 config CPU5_WDT
 	tristate "SMA CPU5 Watchdog"
@@ -374,7 +373,7 @@
 	  TBD.
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module is called cpu5wdt.o.  If you want to compile it as a
+	  The module is called "cpu5wdt".  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
=20
 endmenu
--- a/drivers/s390/net/Kconfig	2003-03-17 13:44:43.000000000 -0800
+++ /tmp/diffpyWjrd	2003-04-03 15:37:55.000000000 -0800
@@ -9,7 +9,7 @@
   	   or zSeries. This device driver supports Token Ring (IEEE 802.5),
   	   FDDI (IEEE 802.7) and Ethernet.=20
 	   This option is also available as a module which will be
-	   called lcs.o . If you do not know what it is, it's safe to say "Y".
+	   called "lcs". If you do not know what it is, it's safe to say "Y".
=20
 config CTC
 	tristate "CTC device support"
@@ -20,7 +20,7 @@
 	  coupling using ESCON. It also supports virtual CTCs when running
 	  under VM. It will use the channel device configuration if this is
 	  available.  This option is also available as a module which will be
-	  called ctc.o.  If you do not know what it is, it's safe to say "Y".
+	  called "ctc".  If you do not know what it is, it's safe to say "Y".
=20
 config IUCV
 	tristate "IUCV device support (VM only)"
@@ -28,7 +28,7 @@
 	help
 	  Select this option if you want to use inter-user communication
 	  vehicle networking under VM or VIF.  This option is also available
-	  as a module which will be called iucv.o. If unsure, say "Y".
+	  as a module which will be called "iucv". If unsure, say "Y".
=20
 config CCWGROUP
  	tristate
--- a/drivers/net/Kconfig	2003-04-01 21:58:49.000000000 -0800
+++ /tmp/diffXVXENg	2003-04-03 15:38:21.000000000 -0800
@@ -762,7 +762,7 @@
=20
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called typhoon.o.  If you want to compile it as a
+	  The module will be called "typhoon".  If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt> as well
 	  as <file:Documentation/networking/net-modules.txt>.
=20
--- a/drivers/input/keyboard/Kconfig	2003-04-01 21:57:10.000000000 -0800
+++ /tmp/diffYpoxzU	2003-04-03 15:38:42.000000000 -0800
@@ -99,6 +99,6 @@
=20
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called xtkbd.o. If you want to compile it as a
+	  The module will be called xtkbd. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
=20
--- a/drivers/input/serio/Kconfig	2003-04-01 21:57:10.000000000 -0800
+++ /tmp/difffKNbAi	2003-04-03 15:39:39.000000000 -0800
@@ -116,6 +116,6 @@
=20
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called rpckbd.o. If you want to compile it as a
+	  The module will be called rpckbd. If you want to compile it as a
 	  module, say M here and read <file:Documentation/modules.txt>.
=20
--- a/drivers/input/mouse/Kconfig	2003-04-01 21:57:10.000000000 -0800
+++ /tmp/diff4fp5UN	2003-04-03 15:39:52.000000000 -0800
@@ -130,6 +130,6 @@
=20
 	  This driver is also available as a module ( =3D code which can be
 	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called logibm.o. If you want to compile it as a
+	  The module will be called logibm. If you want to compile it as a
 	  module, say M here and read <file.:Documentation/modules.txt>.
=20
--- a/drivers/bluetooth/Kconfig	2003-03-17 13:44:04.000000000 -0800
+++ /tmp/diffTHnAud	2003-04-03 15:40:23.000000000 -0800
@@ -105,7 +105,7 @@
 	     Anycom Bluetooth CF Card
=20
 	  Say Y here to compile support for HCI BlueCard devices into the
-	  kernel or say M to compile it as module (bluecard_cs.o).
+	  kernel or say M to compile it as module (bluecard_cs).
=20
 config BT_HCIBTUART
 	tristate "HCI UART (PC Card) device driver"

--AhhlLboLdkugWU4S--

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+jMfOT2bz5yevw+4RAvgxAKCno5Ep7iF6X/8SxGMpezEALeb9wQCgwHhW
SquODGzxvudVSK+kP31ocok=
=YMog
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
