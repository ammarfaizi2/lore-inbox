Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030711AbWKORJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030711AbWKORJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030716AbWKORJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:09:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:22219 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030711AbWKORJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:09:00 -0500
X-Authenticated: #5108953
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
To: isdn4linux@listserv.isdn4linux.de
Subject: [PATCH]  fix build error for HISAX_NETJET
Date: Wed, 15 Nov 2006 18:08:54 +0100
User-Agent: KMail/1.9.5
Cc: info@formula-n.de, kkeil@suse.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1300889.GCndtVfbFA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611151808.56562.toralf.foerster@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1300889.GCndtVfbFA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The following patch fixes a build error for the  enter:now PCI card.

Signed-off-by: Toralf F=F6rster <toralf.foerster@gmx.de>

diff --git a/drivers/isdn/hisax/Kconfig b/drivers/isdn/hisax/Kconfig
index eb57a98..cfd2718 100644
=2D-- a/drivers/isdn/hisax/Kconfig
+++ b/drivers/isdn/hisax/Kconfig
@@ -344,7 +344,7 @@ config HISAX_HFC_SX

 config HISAX_ENTERNOW_PCI
        bool "Formula-n enter:now PCI card"
=2D       depends on PCI && (BROKEN || !(SPARC || PPC || PARISC || M68K || =
=46RV))
+       depends on HISAX_NETJET && PCI && (BROKEN || !(SPARC || PPC || PARI=
SC || M68K || FRV))
        help
          This enables HiSax support for the Formula-n enter:now PCI
          ISDN card.

--nextPart1300889.GCndtVfbFA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFW0mohyrlCH22naMRAu+9AJ9BKBQjQTdzdCdwP6jI9jvVJQOmdQCgprjH
P8mkznMv9aMb1z7ZioQrwik=
=qou8
-----END PGP SIGNATURE-----

--nextPart1300889.GCndtVfbFA--
