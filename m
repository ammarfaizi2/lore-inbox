Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262773AbSI1KOf>; Sat, 28 Sep 2002 06:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262774AbSI1KOf>; Sat, 28 Sep 2002 06:14:35 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:23022 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262773AbSI1KOe>; Sat, 28 Sep 2002 06:14:34 -0400
Subject: Re: [patch] 'virtual => physical page mapping cache',
	vcache-2.5.38-B8
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@zip.com.au>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209270922340.2013-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0209270922340.2013-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-xolLIeQgCcWtsNOWFRFk"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Sep 2002 12:22:09 +0200
Message-Id: <1033208530.1695.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xolLIeQgCcWtsNOWFRFk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-09-27 at 18:26, Linus Torvalds wrote:
>=20
> On Fri, 27 Sep 2002, Ingo Molnar wrote:
> >=20
> > the attached patch implements the virtual =3D> physical cache. Right no=
w
> > only the COW code calls the invalidation function, because futexes do n=
ot
> > need notification on unmap.
>=20
> Ok, looks good. Except you make get_user_page() do a write fault on the=20
> page, and one of the points of this approach was that that shouldn't even=
=20
> be needed. Or did I miss some case that does need it?

get_user_page() cannot/should not ever do a pagefault via the pagefault
code otherwise the coredump code will take the mmap semaphore
recursively and deadlock.

--=-xolLIeQgCcWtsNOWFRFk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9lYLRxULwo51rQBIRAgMuAJoCoE7DaLDsnMh6fh9UayeIrmL5PQCgidBZ
HG+Ka3rfwoUrwDHCNZ6JspQ=
=0Vzx
-----END PGP SIGNATURE-----

--=-xolLIeQgCcWtsNOWFRFk--

