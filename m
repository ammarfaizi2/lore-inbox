Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTKFSmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 13:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTKFSmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 13:42:10 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:40587 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263513AbTKFSmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 13:42:06 -0500
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "David S. Miller" <davem@redhat.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <1068143563.12287.264.camel@nosferatu.lan>
References: <1068140199.12287.246.camel@nosferatu.lan>
	 <20031106093746.5cc8066e.davem@redhat.com>
	 <1068143563.12287.264.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-noDgJ2m4jR74ByLKDWOB"
Message-Id: <1068144179.12287.283.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 20:42:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-noDgJ2m4jR74ByLKDWOB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 20:32, Martin Schlemmer wrote:
> On Thu, 2003-11-06 at 19:37, David S. Miller wrote:
> > On Thu, 06 Nov 2003 19:36:39 +0200
> > Martin Schlemmer <azarah@gentoo.org> wrote:
> >=20
> > > On Tue, 2003-05-06 at 04:19, David S. Miller wrote:
> > > > On Tue, 2003-05-06 at 02:16, Thomas Horsten wrote:=20
> > > > > The following patch fixes the problem:
> > > >
> > > > Making the u64 swabbing functions unavailable is not an=20
> > > > acceptable solution.=20
> > > >
> > >=20
> > > Sorry to dig this up again, but wont __STRICT_ANSI__ assume
> > > that the program will not use u64 functions (as the program/compiler
> > > is supposed to adhere to ansi standards)?
> >=20
> > It may make indirect use of inline functions in the kernel headers
> > in question, which themselves need to use the u64 type.
>=20
> Right, thanks.

Actually, so what ?

If we use -ansi, it means we in theory only use u16 and u32 as
data types, and if the library that was compiled with u64 support
wish to convert the u32 array/buffer pointer we pass to it to
u64, it should make sure it setup things correctly.

Ok, so maybe above is not a case to work on, but if I write an
app that use only 32bit data types, and it links to a library that
also handles 64bit, it does not matter, as I do not call the functions
that handle 64bit data types, no ?


Thanks,

--=20

Martin Schlemmer




--=-noDgJ2m4jR74ByLKDWOB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qpYzqburzKaJYLYRAmxWAJwKgb7OlIB/A3BCcaB6Lcl76U3xCwCeKCeF
2LBvTTbEVg/d/mQaP79ziIU=
=eZ5F
-----END PGP SIGNATURE-----

--=-noDgJ2m4jR74ByLKDWOB--

