Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSEVJME>; Wed, 22 May 2002 05:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316904AbSEVJMD>; Wed, 22 May 2002 05:12:03 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:46860 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S316903AbSEVJMA>;
	Wed, 22 May 2002 05:12:00 -0400
Date: Wed, 22 May 2002 13:16:48 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] SLC82C105 IDE driver: missing __init
Message-ID: <20020522091648.GB312@pazke.ipt>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.15 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zbGR4y+acU1DwHSi
Content-Type: multipart/mixed; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

slc82c105_bridge_revision() functions lacks __init modifier.
Attached patch (against 2.5.17) fixes it.
Compiles, but untested. Please consider applying.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-slc82c105

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/sl82c105.c linux/drivers/ide/sl82c105.c
--- linux.vanilla/drivers/ide/sl82c105.c	Tue May 21 01:56:18 2002
+++ linux/drivers/ide/sl82c105.c	Wed May 22 03:10:09 2002
@@ -185,7 +185,7 @@
  * Return the revision of the Winbond bridge
  * which this function is part of.
  */
-static unsigned int sl82c105_bridge_revision(struct pci_dev *dev)
+static unsigned int __init sl82c105_bridge_revision(struct pci_dev *dev)
 {
 	struct pci_dev *bridge;
 	unsigned char rev;

--TYecfFk8j8mZq+dy--

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE862IABm4rlNOo3YgRAoiGAKCDnJZLQBg9pThQzczUAJv0XBzmBACfZJBy
R0yRpTaWRU5hcF/xgIN6Pmg=
=ZO6i
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
