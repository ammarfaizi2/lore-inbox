Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268455AbUIQFNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268455AbUIQFNO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUIQFNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:13:14 -0400
Received: from dhcp160178161.columbus.rr.com ([24.160.178.161]:11782 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S268455AbUIQFM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:12:57 -0400
Date: Fri, 17 Sep 2004 01:12:45 -0400
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: DRM regression in Linux 2.6.9-rc1-bk12
Message-ID: <20040917051244.GA2725@samarkand.rivenstone.net>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>,
	dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040916025942.GA27261@samarkand.rivenstone.net> <9e47339104091522176fa8ffbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <9e47339104091522176fa8ffbd@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040818i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 16, 2004 at 01:17:02AM -0400, Jon Smirl wrote:
> This should fix the problem
>=20
> =3D=3D=3D=3D=3D linux/drm_scatter.h 1.6 vs edited =3D=3D=3D=3D=3D
> +++ edited/linux/drm_scatter.h  Thu Sep 16 01:11:13 2004
> @@ -73,7 +73,7 @@
>  =20
>         DRM_DEBUG( "%s\n", __FUNCTION__ );
>  =20
> -       if (drm_core_check_feature(dev, DRIVER_SG))
> +       if (!drm_core_check_feature(dev, DRIVER_SG))
>                 return -EINVAL;
>  =20
>         if ( dev->sg )
>=20
>=20

    Yes, it does (tested with this change in 2.6.9-rc2-mm1).

    Thanks again!
--=20
Joseph Fannin
jhf@rivenstone.net

"That's all I have to say about that." -- Forrest Gump.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBSnJMWv4KsgKfSVgRAjRiAKCUk8PSzXaFvutmgqNL8XsB2awVzQCeMrTO
VVXCF4mGuv5sTo4XOkFnH8c=
=gkua
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
