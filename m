Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271302AbTGWUgX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTGWUgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:36:23 -0400
Received: from dsl027-161-083.atl1.dsl.speakeasy.net ([216.27.161.83]:12041
	"EHLO hoist") by vger.kernel.org with ESMTP id S271302AbTGWUgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:36:21 -0400
Date: Wed, 23 Jul 2003 16:51:21 -0400
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] 2.4.22-pre7 configure help incorrect (i810_rng)
Message-ID: <20030723205120.GA6898@suburbanjihad.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: nick black <dank@suburbanjihad.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

i went looking for how the i810 rng exported data to the entropy pool
after reading the 2.4 help text, and was confused when i found no code.
this note was in Documentation/i810_rng.txt:

Version 0.9.5:
* Rip out entropy injection via timer.  It never ever
* worked, and a better solution (rngd) is now available.

so the following updates Configure.help to the 2.6 entry:

diff -ur linux-2.4.22-pre7-pristine/Documentation/Configure.help linux-2.4.=
21/Documentation/Configure.help
--- linux-2.4.22-pre7-pristine/Documentation/Configure.help	2003-07-23 16:4=
0:27.000000000 -0400
+++ linux-2.4.21/Documentation/Configure.help	2003-07-23 16:44:45.000000000=
 -0400
@@ -18725,9 +18725,7 @@
   This driver provides kernel-side support for the Random Number
   Generator hardware found on Intel i8xx-based motherboards.
=20
-  Both a character driver, used to read() entropy data, and a timer
-  function which automatically adds entropy directly into the
-  kernel pool, are exported by this driver.
+  Provides a character driver, used to read() entropy data.
=20
   To compile this driver as a module ( =3D code which can be inserted in
   and removed from the running kernel whenever you want), say M here

--=20
nick black <dank@reflexsecurity.com>
"np:  nondeterministic polynomial-time
the class of dashed hopes and idle dreams." - the complexity zoo

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/HvVIzjCRTpolKGsRAuEkAJ9LI4t722oppnkk1ozEQKwtei0vgACfWfVX
4bXnP1IgwmVe5emndDPnBkg=
=0LwT
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
