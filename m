Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWERPla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWERPla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWERPla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:41:30 -0400
Received: from ozlabs.org ([203.10.76.45]:7129 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750939AbWERPl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:41:29 -0400
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <p73y7wz30a1.fsf@bragg.suse.de>
References: <20060518091410.CC527679F4@ozlabs.org>
	 <p73y7wz30a1.fsf@bragg.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CRU89BgDb8w2A+yF/d7d"
Date: Fri, 19 May 2006 01:41:26 +1000
Message-Id: <1147966886.8469.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CRU89BgDb8w2A+yF/d7d
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

Yeah, someone suggested that. Unfortunately it doesn't work, we actually
want to call printk before we even know which cpu we're on :D

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-CRU89BgDb8w2A+yF/d7d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEbJWmdSjSd0sB4dIRAmokAJsEBg3xT4JXZiiQlkddEVHWaSNOiwCfZkCj
5W5AN5mPNFGbsfE9vtToU90=
=BvwF
-----END PGP SIGNATURE-----

--=-CRU89BgDb8w2A+yF/d7d--

