Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316902AbSEVJQb>; Wed, 22 May 2002 05:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316909AbSEVJQa>; Wed, 22 May 2002 05:16:30 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:60684 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S316902AbSEVJQ2>;
	Wed, 22 May 2002 05:16:28 -0400
Date: Wed, 22 May 2002 13:21:21 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VIA IDE driver: missing __initdata
Message-ID: <20020522092121.GC312@pazke.ipt>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.15 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--l+goss899txtYvYf
Content-Type: multipart/mixed; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


via_isa_bridges array lacks __initdata. Patch attached.
This one is tested on my machine.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-via82cxxx

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux.vanilla/drivers/ide/via82cxxx.c	Tue May 21 01:55:59 2002
+++ linux/drivers/ide/via82cxxx.c	Wed May 22 03:22:11 2002
@@ -105,7 +105,7 @@
 	unsigned char rev_min;
 	unsigned char rev_max;
 	unsigned short flags;
-} via_isa_bridges[] = {
+} via_isa_bridges[] __initdata = {
 #ifdef FUTURE_BRIDGES
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },

--imjhCm/Pyz7Rq5F2--

--l+goss899txtYvYf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE862MRBm4rlNOo3YgRAsBOAJ9l7VHwhlJ85Pmx5pT8dnxcrENdIgCffOnT
vGumpzx1U5Ugo8EYDNhOz4A=
=YcCP
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--
