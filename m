Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbULFNIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbULFNIw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 08:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbULFNIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 08:08:52 -0500
Received: from mail.donpac.ru ([80.254.111.2]:25533 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261508AbULFNIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 08:08:48 -0500
Date: Mon, 6 Dec 2004 16:08:44 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386 mpparse.c: make MP_processor_info static
Message-ID: <20041206130844.GC30348@pazke>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20041206004133.GJ2953@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20041206004133.GJ2953@stusta.de>
X-Uname: Linux 2.6.6 i686
User-Agent: Mutt/1.5.6+20040907i
X-SMTP-Authenticated: pazke@donpac.ru (ntlm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 341, 12 06, 2004 at 01:41:33AM +0100, Adrian Bunk wrote:
> The patch below makes a needlessly global function static.

Looks good.

> diffstat output:
>  arch/i386/kernel/mpparse.c     |    2 +-
>  arch/i386/mach-visws/mpparse.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> --- linux-2.6.10-rc2-mm4-full/arch/i386/mach-visws/mpparse.c.old	2004-12-=
06 01:19:45.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/i386/mach-visws/mpparse.c	2004-12-06 0=
1:19:54.000000000 +0100
> @@ -36,7 +36,7 @@
>   * No problem for Linux.
>   */
> =20
> -void __init MP_processor_info (struct mpc_config_processor *m)
> +static void __init MP_processor_info (struct mpc_config_processor *m)
>  {
>   	int ver, logical_apicid;
>  	physid_mask_t apic_cpus;
> --- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/mpparse.c.old	2004-12-06 0=
1:20:02.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/mpparse.c	2004-12-06 01:20=
:07.000000000 +0100
> @@ -119,7 +119,7 @@
>  }
>  #endif
> =20
> -void __init MP_processor_info (struct mpc_config_processor *m)
> +static void __init MP_processor_info (struct mpc_config_processor *m)
>  {
>   	int ver, apicid;
>  	physid_mask_t tmp;
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtFncby9O0+A2ZecRAj3WAJwJ+vb3Oi1Uz8qN6/TiI/EBDF9SkACdHYqO
aKyBG1F3FuiHVRuqoEwLAkI=
=FhXf
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
