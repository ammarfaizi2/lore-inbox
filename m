Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSJQG66>; Thu, 17 Oct 2002 02:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSJQG66>; Thu, 17 Oct 2002 02:58:58 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:6152 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S261839AbSJQG65>;
	Thu, 17 Oct 2002 02:58:57 -0400
Date: Thu, 17 Oct 2002 11:03:32 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] de2104x.c missing __devexit_p in 2.5.43
Message-ID: <20021017070332.GB304@pazke.ipt>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.2.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


IMHO subject and patch are self explainning :)

--=20
Andrey Panin            | Embedded systems software developer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-de2104x-devexit

diff -urN -X /usr/share/dontdiff linux-vanilla/drivers/net/tulip/de2104x.c linux/drivers/net/tulip/de2104x.c
--- linux-vanilla/drivers/net/tulip/de2104x.c	Sun Sep  1 02:04:53 2002
+++ linux/drivers/net/tulip/de2104x.c	Thu Oct 17 04:10:19 2002
@@ -2216,7 +2216,7 @@
 	.name		= DRV_NAME,
 	.id_table	= de_pci_tbl,
 	.probe		= de_init_one,
-	.remove		= de_remove_one,
+	.remove		= __devexit_p(de_remove_one),
 #ifdef CONFIG_PM
 	.suspend	= de_suspend,
 	.resume		= de_resume,

--c3bfwLpm8qysLVxt--

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9rmDEBm4rlNOo3YgRAgTyAJ42JYqWYCcGUxlwtSronEtNrq++/wCgkBWu
HzbKfGDJ6qS/L5hosmjKKVY=
=jZjU
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
