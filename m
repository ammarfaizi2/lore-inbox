Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbULFMXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbULFMXt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 07:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbULFMXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 07:23:48 -0500
Received: from mail.donpac.ru ([80.254.111.2]:34724 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S261515AbULFMXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 07:23:24 -0500
Date: Mon, 6 Dec 2004 15:23:20 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: reboot.c cleanups
Message-ID: <20041206122320.GB30348@pazke>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20041206004127.GH2953@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline
In-Reply-To: <20041206004127.GH2953@stusta.de>
X-Uname: Linux 2.6.6 i686
User-Agent: Mutt/1.5.6+20040907i
X-SMTP-Authenticated: pazke@donpac.ru (ntlm)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 341, 12 06, 2004 at 01:41:27AM +0100, Adrian Bunk wrote:
> The partch below includes the following changes:
> - arch/i386/kernel/reboot.c: make reboot_thru_bios static
> - arch/i386/mach-visws/reboot.c: remove the unused reboot_thru_bios and
>                                  reboot_smp
> - arch/i386/mach-voyager/voyager_basic.c: remove the unused reboot_thru_b=
ios
> - arch/i386/mach-voyager/voyager_smp.c: remove the unused reboot_smp

Look like "i386/x86_64/parisc process.c: make hlt_counter static" patch
attached instead of promised :)


> diffstat output:
>  arch/i386/kernel/reboot.c              |    2 +-
>  arch/i386/mach-visws/reboot.c          |    3 ---
>  arch/i386/mach-voyager/voyager_basic.c |    2 --
>  arch/i386/mach-voyager/voyager_smp.c   |    2 --
>  4 files changed, 1 insertion(+), 8 deletions(-)
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> --- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c.old	2004-12-06 0=
1:25:27.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/process.c	2004-12-06 01:25=
:38.000000000 +0100
> @@ -60,7 +60,7 @@
> =20
>  asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
> =20
> -int hlt_counter;
> +static int hlt_counter;
> =20
>  unsigned long boot_option_idle_override =3D 0;
>  EXPORT_SYMBOL(boot_option_idle_override);
> --- linux-2.6.10-rc2-mm4-full/arch/parisc/kernel/process.c.old	2004-12-06=
 01:25:55.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/parisc/kernel/process.c	2004-12-06 01:=
26:01.000000000 +0100
> @@ -54,7 +54,7 @@
>  #include <asm/uaccess.h>
>  #include <asm/unwind.h>
> =20
> -int hlt_counter;
> +static int hlt_counter;
> =20
>  /*
>   * Power off function, if any
> --- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c.old	2004-12-06=
 01:26:17.000000000 +0100
> +++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/process.c	2004-12-06 01:=
26:28.000000000 +0100
> @@ -53,7 +53,7 @@
> =20
>  unsigned long kernel_thread_flags =3D CLONE_VM | CLONE_UNTRACED;
> =20
> -atomic_t hlt_counter =3D ATOMIC_INIT(0);
> +static atomic_t hlt_counter =3D ATOMIC_INIT(0);
> =20
>  unsigned long boot_option_idle_override =3D 0;
>  EXPORT_SYMBOL(boot_option_idle_override);
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

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBtE84by9O0+A2ZecRAt4vAKCDsW4pW8jqqPpvBlpOQn+9uj1P1ACg0TSY
vdjDFIdcXJb2+Zasvz3LqJA=
=xPrX
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
