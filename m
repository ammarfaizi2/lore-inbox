Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261323AbVBRJ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVBRJ3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 04:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVBRJ3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 04:29:03 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:14483 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261317AbVBRJ26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 04:28:58 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Fri, 18 Feb 2005 10:28:42 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] bksend example script fix
Message-ID: <20050218092842.GA12309@kiste>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "bksend" example script doesn't work if PAGER (used by "bk changes")
is set to something which doesn't fallback to plain stdout if its output
isn't a tty.

Fixed by forcing PAGER to be /bin/cat.

Signed-Off-By: Matthias Urlichs <smurf@debian.org>

diff -Nru a/Documentation/BK-usage/bksend b/Documentation/BK-usage/bksend
--- a/Documentation/BK-usage/bksend	2005-02-18 10:06:04 +01:00
+++ b/Documentation/BK-usage/bksend	2005-02-18 10:06:04 +01:00
@@ -27,7 +27,7 @@
=20
 SEP=3D"\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n\n"
 echo -e $SEP
-bk changes -r$REV
+env PAGER=3D/bin/cat bk changes -r$REV
 echo
 bk export -tpatch -du -h -r$REV | diffstat
 echo; echo

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCFbVK8+hUANcKr/kRAoYZAJ9f4F4y8raJwEZFrYCr0iZ/bIZ96gCfUH1g
7Pumy0favm3k8nTZOa2j7v0=
=CRE/
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
