Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSAPVVt>; Wed, 16 Jan 2002 16:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSAPVUZ>; Wed, 16 Jan 2002 16:20:25 -0500
Received: from UX3.SP.CS.CMU.EDU ([128.2.198.103]:38260 "HELO
	ux3.sp.cs.cmu.edu") by vger.kernel.org with SMTP id <S287874AbSAPVT3>;
	Wed, 16 Jan 2002 16:19:29 -0500
Subject: Re: [PATCH] I3 sched tweaks...
From: Justin Carlson <justincarlson@cmu.edu>
To: Robert Love <rml@tech9.net>
Cc: mingo@elte.hu, Rusty Russell <rusty@rustcorp.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1011215440.814.82.camel@phantasy>
In-Reply-To: <Pine.LNX.4.33.0201162343290.18971-100000@localhost.localdomain> 
	<1011215440.814.82.camel@phantasy>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-vP/TQ6GOqKKDDhDdkzHT"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 16 Jan 2002 16:19:05 -0500
Message-Id: <1011215946.314.14.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vP/TQ6GOqKKDDhDdkzHT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-01-16 at 16:10, Robert Love wrote:
> On Wed, 2002-01-16 at 17:46, Ingo Molnar wrote:
>=20
> > we pass pointers across functions regularly, even if the pointer could =
be
> > calculated within the function. We do this in the timer code too. It's
> > slightly cheaper to pass an already existing (calculated) 'current'
> > pointer over to another function, instead of calculating it once more i=
n
> > that function. This will be especially true once we make 'current' a ti=
ny
> > bit more expensive (Alan's kernel stack coloring rewrite will do that i
> > think, it will be one more instruction to get 'current'.)
>=20
> Maybe we should benchmark it?  It is very easy to calculate current.
>=20
> Certainly I see the benefit if we start coloring the pointer (it adds 2
> instructions I believe) but let's make sure it is worth passing another
> 32-bit argument.  It could very well be, schedule_tick is called
> enough...

Don't forget that, in non-x86 land, current tends to be just kept in a=20
register.  No computations required.  Certainly passing it around on,
e.g. mips is a clear loss.

-Justin


--=-vP/TQ6GOqKKDDhDdkzHT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8Re5J47Lg4cGgb74RAkitAKDFhR51z42UJEtDYiZ/IMpQMLfajwCgtptp
YTfsmlvv+N6o+KzWjYA9qzo=
=bFaK
-----END PGP SIGNATURE-----

--=-vP/TQ6GOqKKDDhDdkzHT--

