Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWHIQJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWHIQJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHIQJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:09:00 -0400
Received: from static-ip-62-75-163-132.inaddr.intergenia.de ([62.75.163.132]:16812
	"EHLO vs163132.vserver.de") by vger.kernel.org with ESMTP
	id S1751096AbWHIQI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:08:58 -0400
From: Alexander Hans <alex@ahans.de>
To: bzolnier@gmail.com
Subject: [PATCH 2.6.18_rc4 1/1] via82cxxx: Add support for 8237A ISA bridge
Date: Wed, 9 Aug 2006 18:05:51 +0200
User-Agent: KMail/1.9.3
Cc: vojtech@ucw.cz, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200608091805.52945.alex@ahans.de>
Content-Type: multipart/signed;
  boundary="nextPart1956684.EmtyKidt4V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1956684.EmtyKidt4V
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Some mainboards (e.g. Asrock 775Dual-VSTA) come with a
PCI_DEVICE_ID_VIA_82C586_1 IDE controller together with a VIA VT8237A
southbridge.

While the corresponding PCI ID is already present in pci_ids.h, the via82cxxx
driver doesn't know about it yet and disables DMA.

Signed-off-by: Alexander Hans <alex@ahans.de>

--

--- a/drivers/ide/pci/via82cxxx.c	2006-08-09 17:49:38.000000000 +0200
+++ b/drivers/ide/pci/via82cxxx.c	2006-08-09 17:53:38.578053677 +0200
@@ -6,7 +6,7 @@
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
  *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a,
- *   vt8235, vt8237
+ *   vt8235, vt8237, vt8237a
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
  *
@@ -81,6 +81,7 @@
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },

--nextPart1956684.EmtyKidt4V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBE2gfgqFtLGM/cY+MRAkSdAKCtzSxXR3W4t0ptJPTY17j9JxzBJACdEes4
WEHe1lI5UzuSc/zd3j6X/Is=
=D0cU
-----END PGP SIGNATURE-----

--nextPart1956684.EmtyKidt4V--
