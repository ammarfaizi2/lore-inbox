Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVAaRYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVAaRYT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVAaRYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:24:19 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:27593 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261268AbVAaRYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:24:11 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com,
       Hank Leininger <hlein@progressive-comp.com>
In-Reply-To: <20050131165025.GN18316@stusta.de>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	 <1106937110.3864.5.camel@localhost.localdomain>
	 <20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
	 <1106944492.3864.30.camel@localhost.localdomain>
	 <1106945266.7776.41.camel@laptopd505.fenrus.org>
	 <200501290915.j0T9FkVY012948@turing-police.cc.vt.edu>
	 <20050131165025.GN18316@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sVRmgpnA8TFRirAc9KXF"
Date: Mon, 31 Jan 2005 18:23:38 +0100
Message-Id: <1107192218.3754.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sVRmgpnA8TFRirAc9KXF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El lun, 31-01-2005 a las 17:50 +0100, Adrian Bunk escribi=F3:
> On Sat, Jan 29, 2005 at 04:15:43AM -0500, Valdis.Kletnieks@vt.edu wrote:
> > On Fri, 28 Jan 2005 21:47:45 +0100, Arjan van de Ven said:
> >=20
> > > as for obsd_get_random_long().. would it be possible to use the
> > > get_random_int() function from the patches I posted the other day? Th=
ey
> > > use the existing random.c infrastructure instead of making a copy...
> > >=20
> > > I still don't understand why you need a obsd_rand.c and can't use the
> > > normal random.c
> >=20
> > Note that obsd_rand.c started off life as a BSD-licensed file - I was t=
old
> > that was a show-stopper when I submitted basically the same patch a whi=
le back.
> >...
>=20
> At least the three clause BSD license is GPL compatible.
>=20

Yes, AFAIK :)

I will try to follow Arjan's recommendations on using his functions
instead of obsd ones, even if I think it should be alone in the current
file.
Also I will split up the patch.

I will do it as soon as I get time for it, I need first to work out a
cleaner vsec (no more code in headers and such) and also a sys_chroot()
hook that I requested yesterday on the bugzilla, among the SELinux 2.4
backport which needs several fixes due to last 2.6 bk-commits reports.

Thanks for the comments,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-sVRmgpnA8TFRirAc9KXF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB/mmZDcEopW8rLewRAlqbAJwNTBNH7ugNu10emnGg6YxKw0q/SQCeOpLj
Z4J7CgJ7BoxQu4HwPGcAmkM=
=7prp
-----END PGP SIGNATURE-----

--=-sVRmgpnA8TFRirAc9KXF--

