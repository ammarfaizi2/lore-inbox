Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbSJGK6c>; Mon, 7 Oct 2002 06:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262984AbSJGK6c>; Mon, 7 Oct 2002 06:58:32 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:25582 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262983AbSJGK6b>; Mon, 7 Oct 2002 06:58:31 -0400
Subject: Re: [PATCH] Use __attribute__((malloc)) for gcc 3.2
From: Arjan van de Ven <arjanv@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, rth@twiddle.net, jakub@redhat.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20021007105622.GA24530@averell>
References: <20020929152731.GA10631@averell>
	<20020929160113.K5659@devserv.devel.redhat.com>
	<20021007030541.A3910@twiddle.net>
	<20021007.032900.51704978.davem@redhat.com> 
	<20021007105622.GA24530@averell>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Byoz0Zr7jA+C2LIDgevX"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 13:07:48 +0200
Message-Id: <1033988869.2815.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Byoz0Zr7jA+C2LIDgevX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-10-07 at 12:56, Andi Kleen wrote:
> On Mon, Oct 07, 2002 at 12:29:00PM +0200, David S. Miller wrote:
> >    From: Richard Henderson <rth@twiddle.net>
> >    Date: Mon, 7 Oct 2002 03:05:41 -0700
> >=20
> >    On Sun, Sep 29, 2002 at 04:01:13PM -0400, Jakub Jelinek wrote:
> >    > Does this matter when the kernel is compiled with -fno-strict-alia=
sing?
> >   =20
> >    Yes.  The malloc attribute uses REG_NOALIAS, not alias sets.
> >   =20
> > Great, I'm all for Andi's patch in that case.
>=20
> I retested it on gcc 3.2 and it unfortunately doesn't make any difference
> (resulting kernel is byte-for-byte identical). So it looks like with
> current gcc it isn't worth the effort.

I'm still in favor of doing it, even if it's just to break the
chick-and-egg deadlock that such issues can have.

Greetings,
  Arjan van de Ven

--=-Byoz0Zr7jA+C2LIDgevX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9oWsExULwo51rQBIRAu9eAKCDOu7p70UpxrOD0ByGJNO0n+28ywCgjAbS
loEWKIOcDOYdZm1kRaURGls=
=gUfP
-----END PGP SIGNATURE-----

--=-Byoz0Zr7jA+C2LIDgevX--

