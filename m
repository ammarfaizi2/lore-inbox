Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSKTRWc>; Wed, 20 Nov 2002 12:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSKTRWc>; Wed, 20 Nov 2002 12:22:32 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53934 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261448AbSKTRWb>;
	Wed, 20 Nov 2002 12:22:31 -0500
Subject: Re: writing to sysfs appears to hang
From: Paul Larson <plars@linuxtestproject.org>
To: Jens Axboe <axboe@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, davej@codemonkey.org.uk
In-Reply-To: <20021119170205.GC11884@suse.de>
References: <1037401217.11295.145.camel@plars>
	<20021116004723.GB3153@beaverton.ibm.com>  <20021119170205.GC11884@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-MWtVgRkHHwCjTCOFmRUU"
X-Mailer: Ximian Evolution 1.0.5 
Date: 20 Nov 2002 11:24:22 -0600
Message-Id: <1037813063.24031.32.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MWtVgRkHHwCjTCOFmRUU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-11-19 at 11:02, Jens Axboe wrote:
> This has been in the deadline-rbtree patches for some time (uses writes
> to sysfs, too).
>=20
> =3D=3D=3D=3D=3D fs/sysfs/inode.c 1.59 vs edited =3D=3D=3D=3D=3D
> --- 1.59/fs/sysfs/inode.c	Wed Oct 30 21:27:35 2002
> +++ edited/fs/sysfs/inode.c	Fri Nov  8 14:33:59 2002
> @@ -243,7 +243,7 @@
>  	if (kobj && kobj->subsys)
>  		ops =3D kobj->subsys->sysfs_ops;
>  	if (!ops || !ops->store)
> -		return 0;
> +		return -EINVAL;
> =20
>  	page =3D (char *)__get_free_page(GFP_KERNEL);
>  	if (!page)

No effect, the behaviour is still the same for me.

-Paul Larson

--=-MWtVgRkHHwCjTCOFmRUU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3bxUYACgkQbkpggQiFDqfRoACfURPk2llxquDXRMj3rnAxYjeY
QQoAn1aOObkIv600h677cR0Zc5x9Px4u
=ODc2
-----END PGP SIGNATURE-----

--=-MWtVgRkHHwCjTCOFmRUU--

