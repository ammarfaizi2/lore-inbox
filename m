Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265604AbUBAVXU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265598AbUBAVWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:22:51 -0500
Received: from mhub-w6.tc.umn.edu ([160.94.160.36]:2295 "EHLO
	mhub-w6.tc.umn.edu") by vger.kernel.org with ESMTP id S265596AbUBAVUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:20:20 -0500
Subject: Re: Uptime counter
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Ludootje <ludootje@linux.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1075673274.4047.8.camel@gax.mynet>
References: <Pine.LNX.4.44.0402012239010.6206-100000@midi>
	 <20040201205115.GS2259@mea-ext.zmailer.org>
	 <1075673274.4047.8.camel@gax.mynet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kvHIFpLNELnU9P/1CMWp"
Message-Id: <1075670417.14322.9.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 01 Feb 2004 15:20:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kvHIFpLNELnU9P/1CMWp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-02-01 at 16:07, Ludootje wrote:
> On Sun, 2004-02-01 at 20:51, Matti Aarnio wrote:
> > On Sun, Feb 01, 2004 at 10:41:41PM +0200, Markus H=C3=A4stbacka wrote:
> > > Hi list,
> > > I wonder does any kernel branch have a uptime counter that doesn't st=
op
> > > counting at 497 days? Or is a patch needed for the job to
> > > 2.{0,2,4,6} kernel?
> >=20
> > Any 64 bit machine since day 1,  but also 2.6 at i386 does work.
> >=20
> > > 	Markus
> >=20
> > /Matti Aarnio
>=20
> It's the first time I hear about the uptime being resetted after 497 days=
,
> why is this? Is this a mistake or are their reasons for it?

On 32-bit architectures, the uptime counter is only 32 bits wide. Each
"tick" of the counter is worth 1/HZ seconds (IIRC). So, you can get the
number of seconds this will hold with simple math (2^32 * 1/HZ, HZ
being 100 on i386). This is about 497.1 days.

Of course, on 64-bit architectures, the counter will hold 4 billion
times that, which is about as long as the Earth has existed. Apparently
2.6 has come up with a way to deal with this on 32-bit architectures.

Matt

--=-kvHIFpLNELnU9P/1CMWp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAHW2QA9ZcCXfrOTMRAi5qAKCSpdzFyUv/aa58/6Tv07TuoqgMFACgxJWJ
3jZ3HjUZ5opCd9UqhEQxx9E=
=dEMO
-----END PGP SIGNATURE-----

--=-kvHIFpLNELnU9P/1CMWp--

