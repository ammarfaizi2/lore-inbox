Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWESEPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWESEPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 00:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWESEPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 00:15:46 -0400
Received: from ozlabs.org ([203.10.76.45]:29330 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932222AbWESEPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 00:15:46 -0400
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <200605181800.21829.ak@suse.de>
References: <20060518091410.CC527679F4@ozlabs.org>
	 <p73y7wz30a1.fsf@bragg.suse.de>
	 <1147966886.8469.4.camel@localhost.localdomain>
	 <200605181800.21829.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ArSm8HUt+1BXJWalsCtU"
Date: Fri, 19 May 2006 14:15:33 +1000
Message-Id: <1148012134.8515.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ArSm8HUt+1BXJWalsCtU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 18:00 +0200, Andi Kleen wrote:
> On Thursday 18 May 2006 17:41, Michael Ellerman wrote:
> > On Thu, 2006-05-18 at 15:55 +0200, Andi Kleen wrote:
> > > Michael Ellerman <michael@ellerman.id.au> writes:
> > >=20
> > > > Currently printk is no use for early debugging because it refuses t=
o actually
> > > > print anything to the console unless cpu_online(smp_processor_id())=
 is true.
> > >=20
> > > On x86-64 this is simply solved by setting the boot processor online =
very early.
> >=20
> > Yeah, someone suggested that. Unfortunately it doesn't work, we actuall=
y
> > want to call printk before we even know which cpu we're on :D
>=20
> You mean smp_processor_id() returns a random value?
>=20
> Then your patch is broken too because iirc it tested smp_processor_id()
> before that other flag

No it returns 0, but that seems to be the result of good luck rather
than good management. I think I owe you a beer :)

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ArSm8HUt+1BXJWalsCtU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEbUZldSjSd0sB4dIRAj7/AJ9YA75HofsrOZH2stoQelVaHZpkfQCgjlXR
faH523DCxqqBKWOtkrJ0VR8=
=buwq
-----END PGP SIGNATURE-----

--=-ArSm8HUt+1BXJWalsCtU--

