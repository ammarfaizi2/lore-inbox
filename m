Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTEDTY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 15:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbTEDTY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 15:24:29 -0400
Received: from cpt-dial-196-30-179-171.mweb.co.za ([196.30.179.171]:18305 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S261605AbTEDTY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 15:24:27 -0400
Subject: Re: [2.5] Update sk98lin driver
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030504185716.GI24892@mea-ext.zmailer.org>
References: <1052073847.4478.18.camel@nosferatu.lan>
	 <20030504185716.GI24892@mea-ext.zmailer.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U8mUJ7tBQSqimidahwdp"
Organization: 
Message-Id: <1052076918.4478.23.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 04 May 2003 21:35:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U8mUJ7tBQSqimidahwdp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-05-04 at 20:57, Matti Aarnio wrote:

> > Now the problem is that if I try to load it, I get this:
> > -----------------------------------------
> > sk98lin: Unknown symbol __udivdi3
> > -----------------------------------------
> > Meaning it linked with libgcc_s.so.  Any ideas why ?
>=20
>   It wanted to.    That is signature of  64 bit value
>   being divided by an abitrary non-power-of-two divider.
>=20
>   If there is a non-fast-path use for the division,
>   using   do_div()  macro.   Originally for   lib/vsprintf.c
>   from which you can deduce the usage.
>=20
>   If it is in fast-path,   then the code needs serious
>   re-thought.
>=20

Bleh, never easy hey =3D)

And I am guessing just adding a __udivdi3 implementation like
some of the other archs is out of the question ?


--=20

Martin Schlemmer




--=-U8mUJ7tBQSqimidahwdp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+tWt2qburzKaJYLYRAkb4AJ4sj0m/vgJQv3l9sE5Yfryow8K1CwCglB4i
Q0b8C29WLnGsDxzLLcHnsUI=
=jcI7
-----END PGP SIGNATURE-----

--=-U8mUJ7tBQSqimidahwdp--

