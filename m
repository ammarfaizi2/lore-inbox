Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVBJBi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVBJBi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 20:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVBJBi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 20:38:26 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:48037 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S262006AbVBJBhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 20:37:46 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Christophe Saout <christophe@saout.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Fruhwirth Clemens <clemens@endorphin.org>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org, michal@logix.cz, davem@davemloft.net,
       adam@yggdrasil.com
In-Reply-To: <20050209171943.05e9816e.akpm@osdl.org>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
	 <1107997358.7645.24.camel@ghanima>  <20050209171943.05e9816e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-snR+X6xpFnYgfRsHGL+v"
Date: Thu, 10 Feb 2005 02:37:36 +0100
Message-Id: <1107999456.12483.18.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-snR+X6xpFnYgfRsHGL+v
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 09.02.2005, 17:19 -0800 schrieb Andrew Morton:

> > It must be
> >  possible to process more than 2 mappings in softirq context.
>=20
> Adding a few more fixmap slots wouldn't hurt anyone.  But if you want an
> arbitrarily large number of them then no, we cannot do that.
>=20
> Possibly one could arrange for the pages to not be in highmem at all.

In the case of the LRW use in dm-crypt only plain- and ciphertext need
to be accessible through struct page (both are addressed through BIO
vectors). The LRW tweaks could simply be kmalloced. So instead of
passing "struct scatterlist *tweaksg" we could just pass a "void
*tweaksg".

Some of the hard work on the generic scatterlist walker would be for
nothing then. :(


--=-snR+X6xpFnYgfRsHGL+v
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCCrrgZCYBcts5dM0RAtCoAKCJt2BoWNfmBjHB2CPh1pNraCjkrQCeOuPQ
AU7v6YudUXM9r4/HKoJyqJ4=
=nCBL
-----END PGP SIGNATURE-----

--=-snR+X6xpFnYgfRsHGL+v--

