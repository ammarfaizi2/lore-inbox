Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSLJXtj>; Tue, 10 Dec 2002 18:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266865AbSLJXtj>; Tue, 10 Dec 2002 18:49:39 -0500
Received: from attila.bofh.it ([213.92.8.2]:11472 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S266771AbSLJXti>;
	Tue, 10 Dec 2002 18:49:38 -0500
Date: Wed, 11 Dec 2002 00:57:14 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: 2.5.51 nanosleep fails
Message-ID: <20021210235714.GA6537@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

nanosleep fails after being interrupted:

[...]
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D5444, ...}) =3D 0
gettimeofday({1039564416, 703895}, NULL) =3D 0
nanosleep({1, 0}, NULL)                 =3D 0
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D5444, ...}) =3D 0
gettimeofday({1039564417, 777452}, NULL) =3D 0
nanosleep({1, 0},=20
[1]+  Stopped                 strace tail -f /var/log/uucp/Log
md@wonderland:~$ fg
strace tail -f /var/log/uucp/Log
 <unfinished ...>
--- SIGCONT (Continued) ---
<... nanosleep resumed> 0)              =3D -1 ENOSYS (Function not impleme=
nted)


This can be reliably reproduced.


Linux wonderland 2.5.51 #13 Tue Dec 10 14:15:49 CET 2002 i686 unknown unkno=
wn GNU/Linux

--=20
ciao,
Marco

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE99n9aFGfw2OHuP7ERAkTyAJ42rS21yrdjUQ6zQ7Acv2y6kngNiwCgpmfa
m7mIrMVPea8pLiVbL5CHqTo=
=xUWa
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
