Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbUKHGLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbUKHGLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 01:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUKHGLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 01:11:50 -0500
Received: from ylpvm25-ext.prodigy.net ([207.115.57.56]:13971 "EHLO
	ylpvm25.prodigy.net") by vger.kernel.org with ESMTP id S261746AbUKHGLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 01:11:44 -0500
Subject: Re: makeing a loadable module
From: Eric Gaumer <gaumerel@ecs.fullerton.edu>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200411072328.48785.gene.heskett@verizon.net>
References: <200411072328.48785.gene.heskett@verizon.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jv35bQi6E7DItqfzt8fc"
Date: Sun, 07 Nov 2004 22:08:55 -0800
Message-Id: <1099894136.18456.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jv35bQi6E7DItqfzt8fc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-11-07 at 23:28 -0500, Gene Heskett wrote:
> Greetings;
>=20
> I found some code I can play with/hack/etc, in the form of a loadable=20
> module and some testing driver programs, in 'dpci8255.tar.gz'.
>=20
> Unforch its for a slightly different card than the one I have, and=20
> once I've hacked the code to suit, I need to rebuild it.
>=20
> So whats the gcc command line to make just a bare, loadable module for=20
> say a 2.4.25 kernel?   Obviously I'm missing something when it=20
> complains and quits, claiming there is no 'main' defined, which I=20
> don't think modules actually have one of those?
>=20
> What I'm trying to do (hey, no big dummy jokes please :)
>=20
> [root@coyote dist]# cc -o dpci8255.o dpci8255lib.c
> /usr/lib/gcc-lib/i386-redhat-linux/3.3.3/../../../crt1.o(.text+0x18):=20
> In function `_start':
> : undefined reference to `main'
> collect2: ld returned 1 exit status
>=20
> The gcc manpage isn't that helpfull and I've now read thru it twice.

This should work for a single source file=20

]$ gcc -O2 -D__KERNEL__ -DMODULE -DHAVE_CONFIG_H -I/usr/src/linux/include -=
c dcpi8255.c

If your using SMP then you'll need to define that as well.

--=20
Eric Gaumer <gaumerel@ecs.fullerton.edu>

--=-jv35bQi6E7DItqfzt8fc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBjw13ZWL8hfFdQekRAibTAKC39aJHIqqttb3KNCoAnpR6T1CuXwCgx6ON
21QQJ+qToNoy7hdeNRctV4o=
=vF3V
-----END PGP SIGNATURE-----

--=-jv35bQi6E7DItqfzt8fc--

