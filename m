Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTEWU1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264180AbTEWU1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:27:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21438 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264178AbTEWU1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:27:10 -0400
Date: Fri, 23 May 2003 17:39:14 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: SteveW@ACM.org
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Fix multiline string on dn_table.c (decnet)
Message-ID: <20030523203914.GU2939@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqSMaTz1cCSspCQ4"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tqSMaTz1cCSspCQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Detected when using gcc 3.3.

--=20
Eduardo


diff -purN linux-2.4.orig/net/decnet/dn_table.c linux-2.4/net/decnet/dn_tab=
le.c
--- linux-2.4.orig/net/decnet/dn_table.c	2003-05-22 20:13:13.000000000 -0300
+++ linux-2.4/net/decnet/dn_table.c	2003-05-22 20:13:13.000000000 -0300
@@ -836,8 +836,7 @@ struct dn_fib_table *dn_fib_get_table(in
                 return NULL;
=20
         if (in_interrupt() && net_ratelimit()) {
-                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing =
table=20
-from interrupt\n");=20
+                printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing =
table from interrupt\n");=20
                 return NULL;
         }
         if ((t =3D kmalloc(sizeof(struct dn_fib_table), GFP_KERNEL)) =3D=
=3D NULL)

--tqSMaTz1cCSspCQ4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+zobycaRJ66w1lWgRAoqtAJ0RbEe/n2SETX2bA4sG6S6RGUIm1QCfWN7F
7R6L10ILrd0rYHb1e2k2HfY=
=BX0t
-----END PGP SIGNATURE-----

--tqSMaTz1cCSspCQ4--
