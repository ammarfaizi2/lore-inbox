Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSHWN14>; Fri, 23 Aug 2002 09:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318799AbSHWN14>; Fri, 23 Aug 2002 09:27:56 -0400
Received: from host82-101.pool80116.interbusiness.it ([80.116.101.82]:28801
	"EHLO momo.initd.org") by vger.kernel.org with ESMTP
	id <S318798AbSHWN1z>; Fri, 23 Aug 2002 09:27:55 -0400
Subject: [PATCH] Intel 830m backport (2.5 -> 2.4)
From: Federico Di Gregorio <fog@initd.org>
To: faith@valinux.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-27XKiMlM1U8UJCeHNvoU"
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Aug 2002 15:32:28 +0200
Message-Id: <1030109549.1120.86.camel@momo>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-27XKiMlM1U8UJCeHNvoU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi,

this is my first try at a kernel patch, i hope i am doing everything
right; if not, please just tell me. (i sent this patch to both the drm
maintainer and the linux-kernel ML. should i send 2.4 patches directly
to marcelo? mm..)=20

anyway, this is just a backport of the 2.5 DRM driver for Intel 830M to
the 2.4 series. It is against 2.4.19 but, consisting only of added files
it should work clean on later kernels (tested on 2.4.20pre). The patch
is quite big (67252 bytes) and can be downloaded from:

        http://people.initd.org/fog/linux-2.4.19-i830.diff

* Added files:=20
    linux-2.4.19/drivers/char/drm/i830_dma.c
    linux-2.4.19/drivers/char/drm/i830_drm.h
    linux-2.4.19/drivers/char/drm/i830_drv.c
    linux-2.4.19/drivers/char/drm/i830_drv.h
    linux-2.4.19/drivers/char/drm/i830.h

* Modified files:
    linux-2.4.19/Documentation/Configure.help
    linux-2.4.19/drivers/char/drm/Config.in
    linux-2.4.19/drivers/char/drm/Makefile

The only noteworthy change is the removal of some 2.5 specific code from
i830_free_page (file i830_dma.c) and the replacement of unlock_page by
UnlockPage.

I am not subscribed to the kernel ML, so please keep me in cc:.

ciao,
federico

--=20
Federico Di Gregorio
Debian GNU/Linux Developer                                fog@debian.org
INIT.D Developer                                           fog@initd.org
                   I came like Water, and like Wind I go. -- Omar Khayam

--=-27XKiMlM1U8UJCeHNvoU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9ZjlsvcCgrgZGjesRAlIMAKDEAI05IqubJCkTbulT7VsBqNhYpwCgsHQd
S+NSVLDRiNTp8JRDnBxREdU=
=ol/H
-----END PGP SIGNATURE-----

--=-27XKiMlM1U8UJCeHNvoU--

