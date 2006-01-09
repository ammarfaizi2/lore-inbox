Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWAIOQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWAIOQa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWAIOQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:16:30 -0500
Received: from master.altlinux.org ([62.118.250.235]:11268 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1750934AbWAIOQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:16:29 -0500
Date: Mon, 9 Jan 2006 17:15:50 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15 cfq oops
Message-Id: <20060109171550.6e59c30c.vsu@altlinux.ru>
In-Reply-To: <20060109105800.GT3389@suse.de>
References: <20060106201928.GI4595@redhat.com>
	<20060109105800.GT3389@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__9_Jan_2006_17_15_50_+0300_veic5Lnyqcmy4Peu"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__9_Jan_2006_17_15_50_+0300_veic5Lnyqcmy4Peu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jan 2006 11:58:01 +0100 Jens Axboe wrote:

[skip]
> I've merged this up for 2.6.16-rc inclusion, probably should go to
> stabel as well.
>=20
> ---
>=20
> [PATCH] Kill blk_attempt_remerge()
>=20
> It's a bad interface, and it's always done too late. Remove it.
>=20
> Signed-off-by: Jens Axboe <axboe@suse.de>
>=20
[skip]
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 1539603..2e44d81 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -426,7 +426,7 @@ int register_cdrom(struct cdrom_device_i
>  		cdi->exit =3D cdrom_mrw_exit;
> =20
>  	if (cdi->disk)
> -		cdi->cdda_method =3D CDDA_BPC_FULL;
> +		cdi->cdda_method =3D CDDA_BPC_SINGLE;
>  	else
>  		cdi->cdda_method =3D CDDA_OLD;

Does not seem to be related to the rest of patch...

[skip]

--Signature=_Mon__9_Jan_2006_17_15_50_+0300_veic5Lnyqcmy4Peu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.17 (GNU/Linux)

iD8DBQFDwnAZW82GfkQfsqIRAua7AJ4pRy/QQ0s/lS4hHMdeR/a0EXc/awCfSL+L
VonDncVwNjd6ILdDxSaJgFw=
=9jri
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Jan_2006_17_15_50_+0300_veic5Lnyqcmy4Peu--
