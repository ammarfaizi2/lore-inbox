Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261337AbSKSNN7>; Tue, 19 Nov 2002 08:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbSKSNN7>; Tue, 19 Nov 2002 08:13:59 -0500
Received: from 251-120-ADSL.red.retevision.es ([80.224.120.251]:10948 "EHLO
	marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S261337AbSKSNN6>; Tue, 19 Nov 2002 08:13:58 -0500
Date: Tue, 19 Nov 2002 14:21:06 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: kraxel@bytesex.org, Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH] bttv & 2.5.48
Message-ID: <20021119132106.GA14615@jerry.marcet.dyndns.org>
References: <20021118141328.GA10815@vana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <20021118141328.GA10815@vana>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Petr Vandrovec <vandrove@vc.cvut.cz> [021118 16:12]:

>   I did not saw this patch posted... PCI now does not have its own name,
>and it uses dev's name. Please apply.


>diff -urdN linux/drivers/media/video/bttv-cards.c linux/drivers/media/vide=
o/bttv-cards.c
>--- linux/drivers/media/video/bttv-cards.c	2002-11-18 13:50:42.000000000 +=
0000
>+++ linux/drivers/media/video/bttv-cards.c	2002-11-18 13:55:51.000000000 +=
0000
>@@ -2990,7 +2990,7 @@
>=20
> 	/* print which chipset we have */
> 	while ((dev =3D pci_find_class(PCI_CLASS_BRIDGE_HOST << 8,dev)))
>-		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->name);
>+		printk(KERN_INFO "bttv: Host bridge is %s\n",dev->dev.name);
>=20
> 	/* print warnings about any quirks found */
> 	if (triton1)

This fixes the second of the errors, but not the missing
AUDC_CONFIG_PINNACLE I get first:

make -f scripts/Makefile.build obj=3Ddrivers/media/radio
make -f scripts/Makefile.build obj=3Ddrivers/media/video
  gcc -Wp,-MD,drivers/media/video/.bttv-cards.o.d -D__KERNEL__ -Iinclude -W=
all -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict=
-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon-=
xp -Iarch/i386/mach-generic -nostdinc -iwithprefix include -DMODULE   -DKBU=
ILD_BASENAME=3Dbttv_cards -DKBUILD_MODNAME=3Dbttv   -c -o drivers/media/vid=
eo/bttv-cards.o drivers/media/video/bttv-cards.c
drivers/media/video/bttv-cards.c: In function AUDC_CONFIG_PINNACLE' undecla=
red (first use in this function)
drivers/media/video/bttv-cards.c:1742: (Each undeclared identifier is repor=
ted only once
drivers/media/video/bttv-cards.c:1742: for each function it appears in.)
drivers/media/video/bttv-cards.c: In function name'
make[4]: *** [drivers/media/video/bttv-cards.o] Error 1
make[3]: *** [drivers/media/video] Error 2
make[2]: *** [drivers/media] Error 2
make[1]: *** [drivers] Error 2
make: *** [modules] Error 2

I know this has not changed since 2.5.47, nor couldn't spot any
difference within the /media tree, yet it fails on 2.5.48 while it
compiled fine on 2.5.47

Any idea where the error might be?


--=20
Javier Marcet <jmarcet@pobox.com>

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3aOsIACgkQx/ptJkB7frxbygCeJT9u8JWMp4tyiSjPm4zBQezY
2N4Anidmb5lXSEW5jDqqpaSH1hwehz1j
=DJxB
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
