Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbVBCOQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVBCOQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbVBCOQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:16:32 -0500
Received: from steffenspage.de ([213.9.79.102]:52888 "EHLO
	mail.steffenspage.de") by vger.kernel.org with ESMTP
	id S263632AbVBCOQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:16:05 -0500
From: Steffen Zieger <lkml@steffenspage.de>
Subject: [Patch] eth1394: Change KERN_ERR to KERN_INFO
Date: Thu, 3 Feb 2005 15:28:41 +0100
User-Agent: KMail/1.7.91
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed;
  boundary="nextPart2099968.6OKGB1MNR3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502031528.51523.lkml@steffenspage.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2099968.6OKGB1MNR3
Content-Type: multipart/mixed;
  boundary="Boundary-01=_eUjAC0ZMda58bXz"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_eUjAC0ZMda58bXz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello list,

on boot eth1394 prints the following message to KERN_ERR, but I think it is=
=20
better printing to KERN_INFO, because it _is_ an informational message only=
=20
(or: I think so).
This is the message I mean:
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)

The patch should apply against kernel 2.6.11-rc2 cleanly

HAND,
Steffen
=2D-=20
=46reiheit ist die Freiheit zu sagen, dass zwei und zwei gleich vier ist.
Sobald das gew=E4hrleistet ist, ergibt sich alles andere von selbst.
1984 - George Orwell

--Boundary-01=_eUjAC0ZMda58bXz
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="eth1394_KERN_ERR-2.6.11-rc2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="eth1394_KERN_ERR-2.6.11-rc2.patch"

=2D-- drivers/ieee1394/eth1394.c.orig	2005-02-03 08:48:34.884410376 +0100
+++ drivers/ieee1394/eth1394.c	2005-02-03 08:48:58.948752040 +0100
@@ -626,7 +626,7 @@
 		goto out;
 	}
=20
=2D	ETH1394_PRINT (KERN_ERR, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet =
(fw-host%d)\n",
+	ETH1394_PRINT (KERN_INFO, dev->name, "IEEE-1394 IPv4 over 1394 Ethernet (=
fw-host%d)\n",
 		       host->id);
=20
 	hi->host =3D host;

--Boundary-01=_eUjAC0ZMda58bXz--

--nextPart2099968.6OKGB1MNR3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAjUjY5//oRiEYMIRAlQXAJ9/0ZdrTOmwBlkvUfAMBOq5mGVnDgCgo+F1
2rKI+qGoW0A/jOteGcJ4HFY=
=jir1
-----END PGP SIGNATURE-----

--nextPart2099968.6OKGB1MNR3--
