Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267034AbUBMR5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 12:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267079AbUBMR5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 12:57:23 -0500
Received: from nan-smtp-13.noos.net ([212.198.2.121]:15415 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id S267034AbUBMR5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 12:57:20 -0500
Subject: Re: JFS default behavior (was: UTF-8 in file systems?
	xfs/extfs/etc.)
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: chris.siebenmann@utoronto.ca
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <04Feb13.024659est.41760@gpu.utcc.utoronto.ca>
References: <04Feb13.024659est.41760@gpu.utcc.utoronto.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Yrmvq+8dfRWQNA/FE5g0"
Organization: Adresse personelle
Message-Id: <1076695037.23795.13.camel@m222.net81-64-248.noos.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Fri, 13 Feb 2004 18:57:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Yrmvq+8dfRWQNA/FE5g0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le ven, 13/02/2004 =E0 02:46 -0500, Chris Siebenmann a =E9crit :
> You write:
> | Please put valid encoding info somewhere  [...]
>=20
>  There is no place for encoding information in the Unix API;

Big surprise;)

>  you would
> have to implement a new one. Even if the kernel is informed of process
> locale when a process creates files, a new API that returns filename
> encoding alongside the file name itself is necessary. And relying on
> process locale on creation leads to undesirable results in some cases.
>=20
> | [...] or declare filenames are utf-8 od utf-16 only - changing user
> | locale should not corrupt old data.
>=20
>  Since not all byte sequences are valid UTF-8, this immediately means
> that some old files are inaccessible since their filenames are now
> illegal[*]. This also screws everyone who has no desire to work in
> UTF-8, and it screws everyone completely if ever UTF-8 is decided to not
> be the solution to the world's problems.

So what ?
Do you think an app that expects utf-8 filenames won't crash today when
served a byte sequence that's invalid UTF-8 ? (or an app that expects
ascii when served utf-8 oddities)

The problem exists now - putting encoding info somewhere of agreeing on
a common convention won't solve the legacy mess. What it will do is
avoid we get stuck the same way in a decade.

As long as an FS is shared by multiple apps/users agreeing on what the
filenames mean exactly should not be revolutionary. And btw I don't care
if it's UTF-8, UCS or something else. I just want a common ground so
peple and apps can communicate sanely.

Cheers,

--=20
Nicolas Mailhot

--=-Yrmvq+8dfRWQNA/FE5g0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALQ/8I2bVKDsp8g0RAopPAJ9uCEqjK2xyMZH6OklruGx3ZIlIjQCcCRI5
O3CX+9TS6fJuuzYQEldWqS8=
=Nq2j
-----END PGP SIGNATURE-----

--=-Yrmvq+8dfRWQNA/FE5g0--

