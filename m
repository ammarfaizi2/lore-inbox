Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUGYSCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUGYSCy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 14:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUGYSCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 14:02:54 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:40197 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S264251AbUGYSCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 14:02:50 -0400
Subject: Re: [PATCH] Delete cryptoloop
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4103ED18.FF2BC217@users.sourceforge.net>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
	<1090672906.8587.66.camel@ghanima>
	<41039CAC.965AB0AA@users.sourceforge.net>
	<1090761870.10988.71.camel@ghanima>
	<4103ED18.FF2BC217@users.sourceforge.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-S6s76eSXhUl1sdjb+wP1"
Message-Id: <1090778567.10988.375.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 25 Jul 2004 20:02:47 +0200
From: Fruhwirth Clemens <clemens-dated-1091642568.f246@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S6s76eSXhUl1sdjb+wP1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-25 at 19:25, Jari Ruusu wrote:
> Fruhwirth Clemens wrote:
> > On Sun, 2004-07-25 at 13:42, Jari Ruusu wrote:
> > > Fruhwirth Clemens wrote:
> > There is no use in running your code. It does not decipher any block
> > without the proper key.
>=20
> So you never ran that. That explains a lot.

Probably just, that I like to save life time.

> > Where is the exploit?
>=20
> wget -O cryptoloop-exploit.tar.bz2 "http://marc.theaimsgroup.com/?l=3Dlin=
ux-kernel&m=3D107719798631935&q=3Dp3"

That's no exploit. Where is the exploit?
http://www.google.com/search?q=3Djargon%20exploit=20
When you're there, you can look up the term ``backdoor'' as well.=20

> > Further the link you provide in the posting above is broken (as you
> > already noticed). I tried at google cache, citeseer and the rest of
> > Saarien's homepage. No success.
>=20
> In short: exploit encodes watermark patterns as sequences of identical
> ciphertexts.

Probably I'm missing the point, but at the moment this looks like a
chosen plain text attack. As you know for sure, this is trivial. For
instance, AES asserts to be secure against this kind of attack. (See the
author's definition of K-secure..).

> > > Can you name implementation that your "key-truncated" version is comp=
atible
> > > with that existed _before_ your version appeared?. To my knowledge, t=
hat
> > > key-truncated version is only compatible with itself, and there is no=
 other
> > > version that does the same.
> >=20
> > Actually there is a version: util-linux 2.12 official. But
> > unfortunately, the official version truncates binary keys (at 0x00, 0x0=
a
> > values), that's what my patch is for. cryptsetup handles keys the same
> > way. So migration is easy, something which does not hold true for your
> > strange util-linux patches.
>=20
> Actually loop-AES' util-linux patch can used in mainline util-linux-2.12
> compatible mode. Just specify passphrase hash type as unhashed2

The default mode of loop-AES' isn't compatible with anything out there.

> But I was talking about your rmd160 compatibity with ancient mount versio=
ns
> that used 160 bits of hash output + 96 zero bits. Last time I looked at y=
our
> compatibility code it used 128 bits of hash and 128 bits of zeroes.

I'm not aware of any ``ancient'' mount versions. util-linux 2.12 is not
designed to be compatible with anything. It's merely a low-level
interface, since the maintainer decided to omit hashing completely. My
patch enables the user to utilize external hash programs like hashalot.=20

The compatibility code you're referring to is probably my patch for
hashalot. As you know, this has nothing to do with util-linux. If you're
not happy with hashalot, write your own external hasher, you can do that
thanks to my patch.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-S6s76eSXhUl1sdjb+wP1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBA/XGW7sr9DEJLk4RAg18AJwOtzB2GcuhRGPhCGVbb8lUNW4syACcCuGb
V0Dish2Hx3pAvI73hqmO58M=
=TcgW
-----END PGP SIGNATURE-----

--=-S6s76eSXhUl1sdjb+wP1--
