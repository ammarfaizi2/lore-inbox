Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161415AbWI2ItS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161415AbWI2ItS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161414AbWI2ItS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:49:18 -0400
Received: from ozlabs.org ([203.10.76.45]:56530 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161416AbWI2ItQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:49:16 -0400
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <451CDC31.6060407@goop.org>
References: <20060928225444.439520197@goop.org> >
	 <20060928225452.229936605@goop.org> >
	 <1159506427.25820.20.camel@localhost.localdomain>
	 <451CDC31.6060407@goop.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qLX14O92Ht35+EQNdpJR"
Date: Fri, 29 Sep 2006 18:49:14 +1000
Message-Id: <1159519754.15896.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qLX14O92Ht35+EQNdpJR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-09-29 at 01:41 -0700, Jeremy Fitzhardinge wrote:
> Michael Ellerman wrote:
> >> +       printk(KERN_EMERG "------------[ cut here ]------------\n");
> >>    =20
> >
> > I'm not sure I'm big on the cut here marker.
> >  =20
>=20
> x86 has it.  I figured its more important to not change x86 output than=20
> powerpc.

Yeah, you don't want to go messing up legacy architectures.

> >> i386 implements CONFIG_DEBUG_BUGVERBOSE, but x86-64 and powerpc do
> >> not.  This should probably be made more consistent.
> >>    =20
> >
> > It looks like if you do this you _might_ be able to share struct
> > bug_entry, or at least have consistent members for each arch. Which
> > would eliminate some of the inlines you have for accessing the bug
> > struct.
> >  =20
> Yeah, its a bit of a toss-up.  powerpc wants to hide the warn flag=20
> somewhere, which either means having a different structure, or using the=20
> fields differently.  CONFIG_DEBUG_BUGVERBOSE supporters (ie, i386) want=20
> to make the structure completely empty in the !DEBUG_BUGVERBOSE case=20
> (which doesn't currently happen).
> > It needed a bit of work to get going on powerpc:
> >  =20
>=20
> Thanks.  I'll try to fold all this together into a new patch when things=20
> settle down.

Yeah ok there's a few competing concerns there, it's a good start
though.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-qLX14O92Ht35+EQNdpJR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFHN4KdSjSd0sB4dIRAnogAJsEQENYYFLGsaOGbBIntmV0OKV2JwCfe3rD
GWWOMC2U8sfLLskqeBxtMpM=
=1kwg
-----END PGP SIGNATURE-----

--=-qLX14O92Ht35+EQNdpJR--

