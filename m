Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268194AbUGXAOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268194AbUGXAOZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 20:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268195AbUGXAOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 20:14:25 -0400
Received: from smtp09.auna.com ([62.81.186.19]:11653 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S268194AbUGXAOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 20:14:23 -0400
Date: Sat, 24 Jul 2004 02:14:21 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>
Subject: 2.4.27+stdarg+gcc-3.4.1
Message-ID: <20040724001421.GC8560@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
X-Mailer: Balsa 2.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

With gcc-3.4.1 I get the following error when building 2.4.27-rc3.
Any suggestion ?

gcc -D__KERNEL__ -nostdinc -iwithprefix include -I/usr/src/linux-2.4.27-rc3=
-jam1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-alia=
sing -fno-common -fomit-frame-pointer -mpreferred-stack-boundary=3D2 -msoft=
-float -march=3Dpentium3 -fno-unit-at-a-time   -DKBUILD_BASENAME=3Ddo_mount=
s -c -o init/do_mounts.o init/do_mounts.c
init/do_mounts.c: In function `change_floppy':
init/do_mounts.c:424: error: `va_list' undeclared (first use in this functi=
on)
init/do_mounts.c:424: error: (Each undeclared identifier is reported only o=
nce
init/do_mounts.c:424: error: for each function it appears in.)
init/do_mounts.c:424: error: syntax error before "args"
init/do_mounts.c:425: warning: implicit declaration of function `va_start'
init/do_mounts.c:425: error: `args' undeclared (first use in this function)
init/do_mounts.c:426: warning: implicit declaration of function `vsprintf'
init/do_mounts.c:427: warning: implicit declaration of function `va_end'
make: *** [init/do_mounts.o] Error 1


As a side note:

=2E/include/acpi/platform/aclinux.h:

#define ACPI_USE_SYSTEM_CLIBRARY

??=20


--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandrakelinux release 10.1 (Alpha 1) for i586
Linux 2.6.8-rc1-jam1 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-1mdk)) #1

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBAandRlIHNEGnKMMRAnAeAJ48D+IXdNzL8/qOT4zPz6fevr4bHwCfVkMO
jVQapgTT3QxVRzcGKzVCNW4=
=3INY
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
