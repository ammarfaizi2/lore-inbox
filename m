Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314609AbSEGWQQ>; Tue, 7 May 2002 18:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314753AbSEGWQP>; Tue, 7 May 2002 18:16:15 -0400
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]:55206 "HELO
	gs256.sp.cs.cmu.edu") by vger.kernel.org with SMTP
	id <S314609AbSEGWQN>; Tue, 7 May 2002 18:16:13 -0400
Subject: Re: Memory Barrier Definitions
From: justincarlson@cmu.edu
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Engebretsen <engebret@vnet.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E175BY8-0008S4-00@the-village.bc.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-DVwoIHhZOh96fRnw5VE2"
X-Mailer: Ximian Evolution 1.0.4.99 
Date: 07 May 2002 18:15:50 -0400
Message-Id: <1020809750.13627.24.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Source-Info: Sender is really justinca+@gs256.sp.cs.cmu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DVwoIHhZOh96fRnw5VE2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-05-07 at 16:27, Alan Cox wrote:
> and our current heirarchy is a little bit more squashed than that. I'd=20
> agree. We actually hit a corner case of this on the IDT winchip x86 where
> we run relaxed store ordering and have to define wmb() as a locked add of
> zero to the top of stack - which does have a penalty that isnt needed
> for CPU ordering.
>=20
> How much of this impacts Mips64 ?

In terms of the MIPS{32|64} ISA, the current primitives seem fine;
there's only 1 option defined in the ISA:  'sync'.  Order for all
off-cache accesses is guaranteed around a sync.

It gets a bit more complicated when you talk about what particular
implementations do, and ordering rules for uncached vs cached accesses,
but to the best of my knowledge there aren't any fundamental problems as
described for the PPC.

-Justin


--=-DVwoIHhZOh96fRnw5VE2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA82FIV47Lg4cGgb74RAnDlAKDHoFrOfxYmSy+knzQjz8zz31JecwCggr6Q
YferDGlpy6aHA6IvI4DrD4w=
=jLhA
-----END PGP SIGNATURE-----

--=-DVwoIHhZOh96fRnw5VE2--
