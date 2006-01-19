Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030436AbWASQqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWASQqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWASQqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:46:52 -0500
Received: from remus.commandcorp.com ([130.205.32.4]:26779 "EHLO
	remus.wittsend.com") by vger.kernel.org with ESMTP id S1030436AbWASQqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:46:51 -0500
Subject: Re: [RFC: 2.6 patch] move ip2.c and ip2main.c to drivers/char/ip2/
From: "Michael H. Warfield" <mhw@WittsEnd.com>
Reply-To: mhw@WittsEnd.com
To: Adrian Bunk <bunk@stusta.de>
Cc: mhw@WittsEnd.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060119163500.GR19398@stusta.de>
References: <20060119163500.GR19398@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xeS+TWf3JkCOahi16G2n"
Organization: Thaumaturgy & Speculums Technology
Date: Thu, 19 Jan 2006 11:43:50 -0500
Message-Id: <1137689030.17699.2.camel@canyon.wittsend.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 (2.4.2.1-1.1.fc4.nr) 
X-WittsEnd-MailScanner-Information: Please contact the ISP for more information
X-WittsEnd-MailScanner: Found to be clean
X-WittsEnd-MailScanner-From: mhw@wittsend.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-xeS+TWf3JkCOahi16G2n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey Adrian,

On Thu, 2006-01-19 at 17:35 +0100, Adrian Bunk wrote:
> Hi Michael,

> I plan to do some cleanups for the ip2 driver including replacing the=20
> #include'ing of .c files with building them separately and linking them=
=20
> together.

> As a preparation, this patch contains the following:
> - move ip2.c and ip2main.c to drivers/char/ip2/
> - rename ip2.c to ip2base.c (the module is still called ip2)
> - adjust some #include's in the moved file to the new location

> Is this patch OK for you?

	Yeah, go for it...  Sounds good.

	I've had some other patches in the queue but I've been sitting on them
until I can carve out some time to fix a spinlock problem.  I'll rework
those based on what your doing.

	Thanks!

	Regards,
	Mike

> Due to it's size (due to moving the files around) the patch is attached=
=20
> gzip'ed.
>=20
> diffstat output:
>=20
>  drivers/char/Makefile      |    2=20
>  drivers/char/ip2.c         |  109 -
>  drivers/char/ip2/Makefile  |    8=20
>  drivers/char/ip2/ip2base.c |  109 +
>  drivers/char/ip2/ip2main.c | 3260 +++++++++++++++++++++++++++++++++++++
>  drivers/char/ip2main.c     | 3260 -------------------------------------
>  6 files changed, 3378 insertions(+), 3370 deletions(-)
>=20
>=20
>=20
> cu
> Adrian
>=20
> --=20
>=20
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
>=20
>=20
--=20
Michael H. Warfield (AI4NB) | (770) 985-6132 |  mhw@WittsEnd.com
   /\/\|=3Dmhw=3D|\/\/          | (678) 463-0932 |  http://www.wittsend.com=
/mhw/
   NIC whois: MHW9          | An optimist believes we live in the best of a=
ll
 PGP Key: 0xDF1DD471        | possible worlds.  A pessimist is sure of it!


--=-xeS+TWf3JkCOahi16G2n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQCVAwUAQ8/BxuHJS0bfHdRxAQL4kwQAs+pC8wq6T3PnZfWPhldyYA4Gn6Dy+LQq
5y4XLarDHw+UY2IgRWHEYOolPjdvCPw1v6hjMyhre1ozOO9GX86gex10VXW8OrMv
G5Hq5zXD9+3NiAjp6FESh6+/WKU8TqQUxt5Fk1CYCvBvB9IyITmOTcMRcZgxeYSj
/P9wm8b++jg=
=AuAN
-----END PGP SIGNATURE-----

--=-xeS+TWf3JkCOahi16G2n--

-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
