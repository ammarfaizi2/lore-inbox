Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbSIZVeP>; Thu, 26 Sep 2002 17:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261546AbSIZVeP>; Thu, 26 Sep 2002 17:34:15 -0400
Received: from B52dc.pppool.de ([213.7.82.220]:50565 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S261545AbSIZVeM>; Thu, 26 Sep 2002 17:34:12 -0400
Subject: Re: Serious Problems with diskless clients
From: Daniel Egger <degger@fhm.edu>
To: Wakko Warner <wakko@animx.eu.org>
Cc: Marco Schwarz <marco.schwarz@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20020926071847.A12878@animx.eu.org>
References: <20020926095957.GC42048@niksula.cs.hut.fi>
	<3489.1033036000@www51.gmx.net>  <20020926071847.A12878@animx.eu.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-HT02xNdZAU8KVzYEmk6I"
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Sep 2002 22:58:00 +0200
Message-Id: <1033073881.23327.8.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HT02xNdZAU8KVzYEmk6I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2002-09-26 um 13.18 schrieb Wakko Warner:

> --- net/ipv4/ipconfig-orig.c	2001-11-19 20:48:35.000000000 -0500
> +++ net/ipv4/ipconfig.c	2001-11-19 20:56:21.000000000 -0500
> @@ -1105,7 +1105,11 @@
>         proc_net_create("pnp", 0, pnp_get_info);
>  #endif /* CONFIG_PROC_FS */
> =20
> -	if (!ic_enable)
> +	if (!ic_enable
> +#if defined(IPCONFIG_DYNAMIC) && defined(CONFIG_ROOT_NFS)
> +	    && ROOT_DEV !=3D MKDEV(UNNAMED_MAJOR, 255)
> +#endif
> +	   )
> 		return 0;

This together with the nfs-root-path-patch would be a nice addition to
the kernels I think, I find myself forgetting to add a few options every
now and then which is really nasty time-wise.
=20
--=20
Servus,
       Daniel

--=-HT02xNdZAU8KVzYEmk6I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9k3TYchlzsq9KoIYRAoUHAJ9+lHwF51rEjrZc5T6bqvSJdWVCXgCg1vA/
HZPVk8GzqYsZmhPJC+xoLaY=
=4mfC
-----END PGP SIGNATURE-----

--=-HT02xNdZAU8KVzYEmk6I--

