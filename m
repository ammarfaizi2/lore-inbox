Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTLNNou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 08:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTLNNou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 08:44:50 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:53410
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S261877AbTLNNot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 08:44:49 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: Jamie Lokier <jamie@shareable.org>, forming@charter.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200312142311.10650.ross@datscreative.com.au>
References: <200312140407.28580.ross@datscreative.com.au>
	 <20031214042714.GB21241@mail.shareable.org>
	 <200312142124.45966.ross@datscreative.com.au>
	 <200312142311.10650.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+3U4+7k+vCbcQg9Ak1nt"
Message-Id: <1071409484.3309.16.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 14 Dec 2003 14:44:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+3U4+7k+vCbcQg9Ak1nt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Resend due to no CC...

On Sun, 2003-12-14 at 14:11, Ross Dickson wrote:
> I had a lockup on a boot so I am trying a bit more conservative with
>=20
> 1000UL and ndelay(400)=20
>=20
> I don't think anyone should try any less than this but hey?
>=20
> This gives my system a safety margin of 16 apic counts.
> The v1 patch on my system typically gave a safety delay of 13 counts.
>=20
> The performance hit with the v2 is still less than with the v1.
> With v2 additional delay would only have been present on 2 out of 10
> instead of 10 out of 10 with v1.

13h 18min here now, with 800UL 100ns

Works like a charm. It seems like we are just avoiding a timer race with
some values...  ie more delay might not solve the problem.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-+3U4+7k+vCbcQg9Ak1nt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/3GlL7F3Euyc51N8RAhjmAJ9jKI/sZGuuV2kO2xHl97+47fEPAgCghUqL
pc7SzZ51guRO0TYKMLnFF5A=
=xQtX
-----END PGP SIGNATURE-----

--=-+3U4+7k+vCbcQg9Ak1nt--

