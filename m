Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUCBGDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 01:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCBGDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 01:03:34 -0500
Received: from [196.25.168.8] ([196.25.168.8]:15758 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S261478AbUCBGDa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 01:03:30 -0500
Date: Tue, 2 Mar 2004 08:02:51 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
Message-ID: <20040302060251.GG21950@lbsd.net>
References: <4043938C.9090504@lbsd.net> <40439B03.4000505@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <40439B03.4000505@backtobasicsmgmt.com>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Nothing said solves the problem, the problem has got nothing to do with
devfs (only for compat reasons), the problem is that "net/tun" breaks
sysfs.
                                                                           =
                                                                           =
               =20
-Nigel


On Mon, Mar 01, 2004 at 01:20:19PM -0700, Kevin P. Fleming wrote:
> Nigel Kukard wrote:
>=20
> >--- drivers/net/tun.c.old   2004-02-27 18:18:55.000000000 +0200
> >+++ drivers/net/tun.c       2004-02-27 18:19:02.000000000 +0200
> >@@ -605,7 +605,7 @@
> >
> > static struct miscdevice tun_miscdev =3D {
> >        .minor =3D TUN_MINOR,
> >-       .name =3D "net/tun",
> >+       .name =3D "tun",
> >        .fops =3D &tun_fops
> > };
>=20
> This changed back and forth since the tun driver was added to the=20
> kernel; making this change will cause the devfs path to the tun node to=
=20
> change, and userspace applications expect it to be at /dev/misc/net/tun,=
=20
> whether that's right or wrong.


--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFARCOKKoUGSidwLE4RAjypAKCmJLht6EWLi9SvNe/b8g1LC4pdIACfY+mF
WAY2+h3OWRW2bTnwxzXAv1Y=
=V2Xv
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
