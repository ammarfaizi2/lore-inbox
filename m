Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVBJR3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVBJR3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVBJR3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 12:29:08 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:48653 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262167AbVBJR3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 12:29:02 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, davem@davemloft.net, adam@yggdrasil.com
In-Reply-To: <Xine.LNX.4.44.0502101159450.9016-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502101159450.9016-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gQ9qzqeesmU/+z5+/Yk8"
Date: Thu, 10 Feb 2005 18:29:00 +0100
Message-Id: <1108056540.14335.80.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gQ9qzqeesmU/+z5+/Yk8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-10 at 12:02 -0500, James Morris wrote:
> On Thu, 10 Feb 2005, Fruhwirth Clemens wrote:
>=20
> > Hm, alright. So I'm going take the internal of kmap_atomic into
> > scatterwalk.c. to test if the page is in highmem, with PageHighMem. If
> > it is, I'm going to kmap_atomic and mark the fixmap as used. If it's
> > not, I do the "mapping" on my own with page_address.
>=20
> No, you do not need to do any of this.
>=20
> Per previous email, all you need is the existing two kmaps, pass the twea=
k=20
> in as a linear buffer.

Why should I pass the first thing of size X as scatterlist, and the
second thing of size X as linear buffer?=20

I could do that. It would be reasonable, because tweaks are more likely
to be generated than transmitted, read or whatever. But what for shall I
narrow the interface? I could also pass a linear mapped buffer as
scatterlist. This doesn't cause any overhead.

And switching to a more specific interface would just delay a solution
of the inherent limitations of kmap's. I guess it will take another half
year until the next guy stumbles across this (totally undocumented!)
problem. Why are you pushing to ignore this problem?

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-gQ9qzqeesmU/+z5+/Yk8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCC5ncbjN8iSMYtrsRAjykAJ9fFhALzUIKtuvfxq9d6+g2dZjKtQCfQc3B
D3mSsagoI3JtaJw/jeU2FnI=
=FSuc
-----END PGP SIGNATURE-----

--=-gQ9qzqeesmU/+z5+/Yk8--
