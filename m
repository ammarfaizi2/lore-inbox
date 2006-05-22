Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWEVGkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWEVGkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWEVGkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:40:31 -0400
Received: from ozlabs.org ([203.10.76.45]:58349 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932364AbWEVGka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:40:30 -0400
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <20060518030719.14995317.akpm@osdl.org>
References: <20060518091410.CC527679F4@ozlabs.org>
	 <20060518023449.4e697b96.akpm@osdl.org>
	 <1147946150.7360.29.camel@localhost.localdomain>
	 <20060518030719.14995317.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ud2tsB3rr1F9pSlxC/Xz"
Date: Mon, 22 May 2006 16:40:32 +1000
Message-Id: <1148280032.24345.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ud2tsB3rr1F9pSlxC/Xz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 03:07 -0700, Andrew Morton wrote:
> Michael Ellerman <michael@ellerman.id.au> wrote:
> >
> >  I'll trawl through the console drivers tomorrow and see if I can guess
> >  what percentage look like they will/won't work, then we can decide whi=
ch
> >  way to flip it.
>=20
> Yes, that's probably safer and saner, thanks.  Don't bust a gut over
> it though - it's not your problem and if someone's hurting from it
> then they can write and test the patch.

I had a quick gander at some of the consoles registered under arch. A
lot of them look like they'd be ok running with CON_ANYTIME, ie. they
just write to a fixed address or uart or something simple.

Having said that I still think we should leave this patch as is, and
leave it up to arch people to decide whether they want to add
CON_ANYTIME to their particular console driver.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-Ud2tsB3rr1F9pSlxC/Xz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEcVzgdSjSd0sB4dIRAt1LAJwJcBsK2DgqIb6FoVqDlq7fY3n6ogCfd84T
wGnUCy9dKayc3gUvJIWvH3k=
=0pEI
-----END PGP SIGNATURE-----

--=-Ud2tsB3rr1F9pSlxC/Xz--

