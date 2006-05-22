Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWEVG5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWEVG5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 02:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWEVG5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 02:57:21 -0400
Received: from ozlabs.org ([203.10.76.45]:62593 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932519AbWEVG5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 02:57:21 -0400
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <p73y7wz30a1.fsf@bragg.suse.de>
References: <20060518091410.CC527679F4@ozlabs.org>
	 <p73y7wz30a1.fsf@bragg.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kYuyyCaLr3kuUPtuIXca"
Date: Mon, 22 May 2006 16:57:23 +1000
Message-Id: <1148281043.24345.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kYuyyCaLr3kuUPtuIXca
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 15:55 +0200, Andi Kleen wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
>=20
> > Currently printk is no use for early debugging because it refuses to ac=
tually
> > print anything to the console unless cpu_online(smp_processor_id()) is =
true.
>=20
> On x86-64 this is simply solved by setting the boot processor online very=
 early.

I had a closer look at this, and we could actually fudge it so that
cpu_online() is true in our early boot code, even though we don't know
what cpu we're on.

But that kind of begs the question, what does "cpu_online(x)" actually
mean? If it doesn't mean percpu data is allocated, what does it mean?

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-kYuyyCaLr3kuUPtuIXca
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEcWDTdSjSd0sB4dIRAgpKAJ9HUXsG57lE6PGzs82FVaLHQADRRQCgrN8N
GYXBlTCAbLoubF6hbG9GuBc=
=rtHC
-----END PGP SIGNATURE-----

--=-kYuyyCaLr3kuUPtuIXca--

