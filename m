Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVCYETw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVCYETw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 23:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVCYETw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 23:19:52 -0500
Received: from dea.vocord.ru ([217.67.177.50]:37346 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261217AbVCYETq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 23:19:46 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, jmorris@redhat.com,
       herbert@gondor.apana.org.au
In-Reply-To: <42432596.2090709@pobox.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	 <20050323203856.17d650ec.akpm@osdl.org> <1111666903.23532.95.camel@uganda>
	 <42432596.2090709@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I28O0JuNKZqUYJxHu3Tq"
Organization: MIPT
Date: Fri, 25 Mar 2005 07:25:59 +0300
Message-Id: <1111724759.23532.121.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 07:18:50 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I28O0JuNKZqUYJxHu3Tq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-24 at 15:39 -0500, Jeff Garzik wrote:
> Evgeniy Polyakov wrote:
> > hw_random.c already does it using userspace daemons,
> > which is bad idea for very fast HW - like VIA xstore/xcrypt=20
> > instructions.
>=20
> This is incorrect, because it implies that a user would want to use the=20
> 'xstore' feature at full speed -- which would dominate the CPU,=20
> drastically slowing down the applications that are actually doing work.

If user want to get RNG data at full speed we do not want to allow it?
Something changed in the world...

User actually do not want to use xstore, but only read from /dev/random.

If kernelspace can assist and driver _knows_ in advance that data
produced is cryptographically strong, why not allow it directly
access pools?

> As I mentioned in another message, VIA xstore support should be removed=20
> from hw_random.c and moved completely to userspace rngd.
>=20
> 	Jeff
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-I28O0JuNKZqUYJxHu3Tq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ5LXIKTPhE+8wY0RAmzxAKCCKsvQpWG6HbrDxkedaVMS3L46cQCfWrOS
6i7LqmhxjF6afKvxKc+KhTs=
=Gzm6
-----END PGP SIGNATURE-----

--=-I28O0JuNKZqUYJxHu3Tq--

