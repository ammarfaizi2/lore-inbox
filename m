Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUATRft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 12:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265611AbUATRft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 12:35:49 -0500
Received: from [199.45.143.209] ([199.45.143.209]:29704 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S265602AbUATRfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 12:35:45 -0500
Subject: Re: Compiling C++ kernel module + Makefile
From: Zan Lynx <zlynx@acm.org>
To: root@chaos.analogic.com
Cc: Bart Samwel <bart@samwel.tk>, Ashish sddf <buff_boulder@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401201000490.11497@chaos>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
	 <Pine.LNX.4.53.0401161659470.31455@chaos>
	 <200401171359.20381.bart@samwel.tk>
	 <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk>
	 <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk>
	 <Pine.LNX.4.53.0401191521400.8389@chaos> <400C4B17.3000003@samwel.tk>
	 <Pine.LNX.4.53.0401201000490.11497@chaos>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ND8Tp7FBKEwXA6pUrD6K"
Message-Id: <1074620079.22023.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 20 Jan 2004 10:34:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ND8Tp7FBKEwXA6pUrD6K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-01-20 at 08:20, Richard B. Johnson wrote:
> Nevertheless, I provide three programs, one written in
> C, the other in C++ and the third in assembly. A tar.gz
> file is attached for those interested.
>=20
> -rwxr-xr-x   1 root     root        57800 Jan 20 10:16 hello+
> -rwxr-xr-x   1 root     root          460 Jan 20 10:16 helloa
> -rwxr-xr-x   1 root     root         2948 Jan 20 10:16 helloc
>=20
> The code size, generated from assembly is 460 bytes.
> The code size, generated from C is 2,948 bytes.
> The code size, generated from C++ is 57,800 bytes.
>=20
> Clearly, C++ is not the optimum language for writing
> a "Hello World" program.

I like C++ and hate to see it so unfairly maligned.  Here's a much
better example:

Makefile:
helloc: hello.c
        gcc -Os -s -o helloc hello.c
=20
hellocpp: hello.cpp
        g++ -Os -fno-rtti -fno-exceptions -s -o hellocpp hello.cpp

Both programs contain exactly the same code: one main() function using
puts("Hello world!").

# ls -l
-rwxrwxr-x    1 jbriggs  jbriggs      2840 Jan 20 10:02 helloc
-rwxrwxr-x    1 jbriggs  jbriggs      2948 Jan 20 10:06 hellocpp

108 extra bytes is hardly the end of the world.
--=20
Zan Lynx <zlynx@acm.org>

--=-ND8Tp7FBKEwXA6pUrD6K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBADWavG8fHaOLTWwgRAst9AKCmv/9V0S1JFozysCau/gbglvaUvQCfUeY9
u+a+hwpbHbwSxEWFLyH8er4=
=dXfv
-----END PGP SIGNATURE-----

--=-ND8Tp7FBKEwXA6pUrD6K--

