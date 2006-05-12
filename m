Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWELPVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWELPVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWELPVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:21:09 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:5602 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S932124AbWELPVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:21:08 -0400
Subject: Re: [patch 9/9] Add bcm43xx HW RNG support
From: Johannes Berg <johannes@sipsolutions.net>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Michael Buesch <mb@bu3sch.de>, akpm@osdl.org,
       Deepak Saxena <dsaxena@plexity.net>, bcm43xx-dev@lists.berlios.de,
       linux-kernel@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <200605121816.55025.vda@ilport.com.ua>
References: <20060512103522.898597000@bu3sch.de>
	 <20060512103649.060196000@bu3sch.de> <200605121816.55025.vda@ilport.com.ua>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A6WlIrzwPHZDZUGfLlwO"
Date: Fri, 12 May 2006 17:20:24 +0200
Message-Id: <1147447224.7404.43.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A6WlIrzwPHZDZUGfLlwO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-12 at 18:16 +0300, Denis Vlasenko wrote:

> Didn't you mean
>=20
> 	*(u16*)data =3D bcm43xx_read16(bcm, BCM43xx_MMIO_RNG); ?
>=20
> > +	bcm43xx_unlock(bcm, flags);
> > +
> > +	return (sizeof(u16));
> > +}

I'm not the expert, but looking at patch 2 I'd say no, because one byte
is copied out and then the value is right-shifted, so it is always
treated as a u32 where only 'size' bytes are valid starting with the
lower bytes.

johannes

--=-A6WlIrzwPHZDZUGfLlwO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGSntaVg1VMiehFYAQKLqRAAnApvULQA5iaOd2+1YLHiB8iCsXjrn0Lt
pnfoA3PKsG0bQg39SzDFg1BIazFII1tJ7fFfwhc5EcQlQ4/UhRr6pMV1akQZfq8y
xfTx6O/yUvcSZ+1SgHiqrHvSxqqHDVx4vKJMfZou0r7TKn/TROgL4Yod9YVPJZ1c
uZWmOIRAOjN2jBVj7PIQFGG6x5gG9tiUqa04LJtidlwtKFS0eIS/vWUFD7e3CNRP
q8OSI2o5WP5s6lg+qNeEB8mstxrfSS1X029dXnsZJhmAB6OxOguPbNxAt+5gLe0q
e2NUXEVFrK9Pf3z2Ju+FzJXUT88LJQh2GfQ4Qh6zeMcc1f2UTGEozlKT+usdSWJu
VBCEaBX1FBdBU8rGQiq/4ZBCHVDmEiQ60K1qxMwcQN8FpArNyMXArs73qpqkQhlX
CUxnv2wht5Cn57+4ldOYtonOM4k/JvITCUhfaGWOSiyiAS9N00CEpJUA1RckAWDU
I8Klym8tE/Y2te68+XrJF1Lq4q8rvCwb0vT6JsOXjUlDANFymJK38y0aQGSbQ7nW
kbJ3KbpEDskupPMtxuHf4UcwaNJKhIofazuSp8Jl564pIJm5NQiHv7mSLgEWXWO7
KJgu//4PRIU8Wz0WaflocA0norhtNvNwXGbe7o49oQhsPBy7jLdwKnChVjXNWWs/
ssXmqHcegrw=
=pKWa
-----END PGP SIGNATURE-----

--=-A6WlIrzwPHZDZUGfLlwO--

