Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTGTJIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 05:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTGTJIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 05:08:51 -0400
Received: from [61.95.53.28] ([61.95.53.28]:33298 "EHLO dreamcraft.com.au")
	by vger.kernel.org with ESMTP id S263597AbTGTJIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 05:08:50 -0400
Date: Sun, 20 Jul 2003 19:23:14 +1000
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.com, pavel@ucw.cz
Subject: [PATCH] Compile fix for suspend.c
Message-ID: <20030720092314.GA11395@himi.org>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@osdl.com,
	pavel@ucw.cz
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: simon@himi.org (Simon Fowler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

kernel/suspend.c fails to build as of a bk pull at about 08:00 UTC,
with redefinitions of _text.

The attached patch fixes the build.

Simon

=3D=3D=3D=3D=3D kernel/suspend.c 1.42 vs edited =3D=3D=3D=3D=3D
--- 1.42/kernel/suspend.c       Sat May  3 04:16:11 2003
+++ edited/kernel/suspend.c     Sun Jul 20 19:14:48 2003
@@ -83,7 +83,6 @@
 #define ADDRESS2(x) __ADDRESS(__pa(x))         /* Needed for x86-64 where =
some pages are in m
emory twice */
=20
 /* References to section boundaries */
-extern char _text, _etext, _edata, __bss_start, _end;
 extern char __nosave_begin, __nosave_end;
=20
 extern int is_head_of_free_region(struct page *);

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/Gl+BQPlfmRRKmRwRAgEIAKCTFPwimVxSpuH3XQAww6RPTDZAHACgsTRO
Z9IJU1VyTwgPLmI4zfBUMmg=
=0omz
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
