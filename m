Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162266AbWLAXax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162266AbWLAXax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162243AbWLAXaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:30:12 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:37862 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1162387AbWLAXaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:30:02 -0500
Subject: Re: [Cluster-devel] Re: [GFS2] Change argument of gfs2_dinode_out
	[17/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061201210849.GF3078@ftp.linux.org.uk>
References: <1164888933.3752.338.camel@quoit.chygwyn.com>
	 <1165000744.1194.89.camel@xenon.msp.redhat.com>
	 <20061201192555.GD3078@ftp.linux.org.uk>
	 <1165006331.1194.96.camel@xenon.msp.redhat.com>
	 <20061201210849.GF3078@ftp.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5r2xqbpwY23b5qJkuoa2"
Date: Fri, 01 Dec 2006 17:29:46 -0600
Message-Id: <1165015786.1194.133.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5r2xqbpwY23b5qJkuoa2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-12-01 at 21:08 +0000, Al Viro wrote:
> On Fri, Dec 01, 2006 at 02:52:11PM -0600, Russell Cattelan wrote:
> > code clean up are not without risk and with no regression test suite to
> > verify
> > that a "cleanup" has not broken something. Cleanups are very much a
> > hindrance to stabilization. With no know working points in a code
> > history it becomes difficult
> > to bisect changes and figure out when bugs were introduced
> > Especially when cleanups are mixed in with bug fixes.
> >=20
> > Pretty code does not equal correct code.
>=20
> No, but convoluted and unreadable code ends up being crappier due
> to lack of review.  And that's aside of the memory footprint,
> likeliness of bugs introduced by code modifications (having in-core
> and on-disk data structures with different contents and the same C
> type =3D> trouble that won't be caught by compiler), etc.

Nothing makes up for the complete lack of GFS2 testing.
reviewed code does not equal correct code either.

Honestly tell me what test suite do you run on GFS2?

Sure is it possible to make an educated guess that some
cleanups will not destabilize the code. Indeed the stuff
you have done is quite useful to ensure that endian bugs are
being caught by the compiler/sparse.
But no amount of "it shouldn't break anything" assertions
can replace testing.


But there is a large quantity of the 70 or so patches that were
sent out were to enable "future" cleanup's. Putting in partial cleanups
do nothing core code readability and I many cases is more confusing.
Unless you meticulously keep up with the partial cleanups looking
at the code is now a jumbled mess of inconsistencies.

gfs2 is supposed to be stabilized and use-able for the up coming rhel5
release, not pretty up for somebody to print out and hang on their wall.


--=20
Russell Cattelan <cattelan@thebarn.com>

--=-5r2xqbpwY23b5qJkuoa2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcLrpNRmM+OaGhBgRAlzwAJ9AqX8R7F2U2/4cAqKFNaqqiKSa1gCbBeCR
aU76OypxpaVPg/Ntj/k0z18=
=EoGN
-----END PGP SIGNATURE-----

--=-5r2xqbpwY23b5qJkuoa2--

