Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271582AbRIBHBi>; Sun, 2 Sep 2001 03:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271586AbRIBHB2>; Sun, 2 Sep 2001 03:01:28 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:4622 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S271582AbRIBHBX>; Sun, 2 Sep 2001 03:01:23 -0400
Date: Sun, 2 Sep 2001 00:01:39 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
        Kernel Developer List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        USB Storage List <usb-storage@one-eyed-alien.net>
Subject: PATCH: usb-storage: 2 of 3
Message-ID: <20010902000139.H4415@one-eyed-alien.net>
Mail-Followup-To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Kernel Developer List <linux-kernel@vger.redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	USB Storage List <usb-storage@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cDtQGJ/EJIRf/Cpq
Content-Type: multipart/mixed; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached is a patch to usb-storage.  Linus, please apply.

This patch adds 3 configuration sub-options to the usb-storage driver.  One
is _very_ well tested -- that's CONFIG_USB_STOR_ISD200.  The other two are
still experimental, but there are many people using it, so I think it's
time it's on the menu (at least as EXPERIMENTAL).

Matt Dharm

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.patch"

--- drivers/usb/Config.in.old	Sat Sep  1 22:21:48 2001
+++ drivers/usb/Config.in	Sat Sep  1 22:25:07 2001
@@ -32,7 +32,12 @@
    if [ "$CONFIG_USB_STORAGE" != "n" ]; then
       bool '    USB Mass Storage verbose debug' CONFIG_USB_STORAGE_DEBUG
       bool '    Freecom USB/ATAPI Bridge support' CONFIG_USB_STORAGE_FREECOM
-      bool '    Microtech CompactFlash/SmartMedia reader' CONFIG_USB_STORAGE_DPCM
+      bool '    ISD-200 USB/ATA Bridge support' CONFIG_USB_STORAGE_ISD200
+      bool '    Microtech CompactFlash/SmartMedia support' CONFIG_USB_STORAGE_DPCM
+      if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+         bool '    HP CD-Writer 82xx support' CONFIG_USB_STORAGE_HP8200e
+         bool '    SanDisk SDDR-09 (and other SmartMedia) support' CONFIG_USB_STORAGE_SDDR09
+      fi
    fi
    dep_tristate '  USB Modem (CDC ACM) support' CONFIG_USB_ACM $CONFIG_USB
    dep_tristate '  USB Printer support' CONFIG_USB_PRINTER $CONFIG_USB

--CNK/L7dwKXQ4Ub8J--

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7kdlTz64nssGU+ykRAq3WAJ4kkEtMCrHaQe/k7ZP+KHd556nVVQCbBCWF
5jAPLfjQVseB9Z3H9/zEo/s=
=SB5I
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
