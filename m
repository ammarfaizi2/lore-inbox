Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbULBFue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbULBFue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 00:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbULBFue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 00:50:34 -0500
Received: from mail.donpac.ru ([80.254.111.2]:5046 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261556AbULBFuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 00:50:23 -0500
Date: Thu, 2 Dec 2004 08:50:20 +0300
From: Andrey Panin <pazke@donpac.ru>
To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VISWS: prevent APM
Message-ID: <20041202055020.GC20380@pazke>
Mail-Followup-To: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
References: <20041201115758.294585c3.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20041201115758.294585c3.rddunlap@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-SMTP-Authenticated: pazke@donpac.ru (ntlm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 336, 12 01, 2004 at 11:57:58AM -0800, Randy.Dunlap wrote:
> (resend)
>=20
> Prevent X86_VISWS config from building APM support.
> APM isn't supported and it won't build if attempted.
> Also disable P4THERMAL for VISWS.
>=20
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

Look good. Please apply.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

> diffstat:=3D
>  arch/i386/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff -Naurp ./arch/i386/Kconfig~visws_noapm ./arch/i386/Kconfig
> --- ./arch/i386/Kconfig~visws_noapm	2004-10-11 10:54:31.019559744 -0700
> +++ ./arch/i386/Kconfig	2004-10-14 09:52:24.131743344 -0700
> @@ -584,7 +584,7 @@ config X86_MCE_NONFATAL
> =20
>  config X86_MCE_P4THERMAL
>  	bool "check for P4 thermal throttling interrupt."
> -	depends on X86_MCE && (X86_UP_APIC || SMP)
> +	depends on X86_MCE && (X86_UP_APIC || SMP) && !X86_VISWS
>  	help
>  	  Enabling this feature will cause a message to be printed when the P4
>  	  enters thermal throttling.
> @@ -879,7 +879,7 @@ source kernel/power/Kconfig
>  source "drivers/acpi/Kconfig"
> =20
>  menu "APM (Advanced Power Management) BIOS Support"
> -depends on PM
> +depends on PM && !X86_VISWS
> =20
>  config APM
>  	tristate "APM (Advanced Power Management) BIOS support"

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBrq0cby9O0+A2ZecRAsE/AJ419XjXpjLEUh63C9G5Jczc0Z+kbgCdElci
nuAI4T9O9ToXoZwxzhsSRno=
=r5/Z
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
