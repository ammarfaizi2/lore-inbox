Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVBGTr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVBGTr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbVBGTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:47:10 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:11218 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261282AbVBGTfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:35:00 -0500
Subject: Re: [PATCH] Filesystem linking protections
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Valdis.Kletnieks@vt.edu
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
In-Reply-To: <200502071914.j17JEbjQ018534@turing-police.cc.vt.edu>
References: <1107802626.3754.224.camel@localhost.localdomain>
	 <200502071914.j17JEbjQ018534@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M9H8skLzSSpCWpBMExiR"
Date: Mon, 07 Feb 2005 20:34:33 +0100
Message-Id: <1107804873.3754.232.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M9H8skLzSSpCWpBMExiR
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 07-02-2005 a las 14:14 -0500, Valdis.Kletnieks@vt.edu escribi=F3:
> On Mon, 07 Feb 2005 19:57:06 +0100, Lorenzo =3D?ISO-8859-1?Q?Hern=3DE1nde=
z_?=3D =3D?ISO-8859-1?Q?Garc=3DEDa-Hierro?=3D said:
>=20
> > This patch adds two checks to do_follow_link() and sys_link(), for
> > prevent users to follow (untrusted) symlinks owned by other users in
> > world-writable +t directories (i.e. /tmp), unless the owner of the
> > symlink is the owner of the directory, users will also not be able to
> > hardlink to files they do not own.
>=20
> This should be done using the LSM framework.  That's what it's *THERE* fo=
r.
> I've previously posted an LSM that does these checks (and a few others), =
it
> should be in the archives.

vSecurity also implements this and many other "ported" features from
OpenWall and grSecurity.

But It's better to give users a "secure-by-default" status, at least on
those parts that don't affect negatively the stability or the
performance itself.

The LSM hook call is before the check, so, LSM framework still has the
control over it, until it releases the operation giving control back to
the standard function.

If users must rely on LSM or other external solutions for applying basic
security checks (as the framework itself only provides the way to apply
them, the checks need to be implemented in a module), then we are making
them unable to be protected using the "default" configuration.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-M9H8skLzSSpCWpBMExiR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB8LJDcEopW8rLewRAqmnAJ9esqo2Ff9RGwHKJDhn9wlhlnzdxACfaz/F
M8BuhTYB9vhDJ9KVKMkTI98=
=DSMt
-----END PGP SIGNATURE-----

--=-M9H8skLzSSpCWpBMExiR--

