Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVBGTxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVBGTxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVBGTwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:52:31 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:33498 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261279AbVBGTlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:41:13 -0500
Subject: Re: [PATCH] Filesystem linking protections
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Chris Wright <chrisw@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050207111235.Y24171@build.pdx.osdl.net>
References: <1107802626.3754.224.camel@localhost.localdomain>
	 <20050207111235.Y24171@build.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AyL+hmaAQJJAkpDVZG/n"
Date: Mon, 07 Feb 2005 20:40:43 +0100
Message-Id: <1107805243.3754.240.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AyL+hmaAQJJAkpDVZG/n
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 07-02-2005 a las 11:12 -0800, Chris Wright escribi=F3:
> * Lorenzo Hern=E1ndez Garc=EDa-Hierro (lorenzo@gnu.org) wrote:
> > This patch adds two checks to do_follow_link() and sys_link(), for
> > prevent users to follow (untrusted) symlinks owned by other users in
> > world-writable +t directories (i.e. /tmp), unless the owner of the
> > symlink is the owner of the directory, users will also not be able to
> > hardlink to files they do not own.
> >=20
> > The direct advantage of this pretty simple patch is that /tmp races wil=
l
> > be prevented.
>=20
> The disadvantage is that it can break things and places policy in the
> kernel.

It's just like DAC then, because it never applies any policy than a
simple check relying on kernel's DAC, and standard capabilities &
permissions.DAC-related checks are placed all over the place, but maybe
the place is lacking of some ones that may be important.

About what things it can break, I haven't noticed any issue on it (at
least regarding grSecurity or OpenWall), but of course I would
appreciate a lot any information on them, so, I could report to the
developers that are currently using this in their own solutions.

Thanks in advance,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-AyL+hmaAQJJAkpDVZG/n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCB8Q7DcEopW8rLewRAks2AJ0Xr2Y+b3nGVg6/jAosSKXPbSL2+QCff62h
SIR3wPkCLoY/YYSVWGVhC5k=
=IijR
-----END PGP SIGNATURE-----

--=-AyL+hmaAQJJAkpDVZG/n--

