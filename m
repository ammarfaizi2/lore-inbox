Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVCYG3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVCYG3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 01:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCYG3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 01:29:07 -0500
Received: from dea.vocord.ru ([217.67.177.50]:34793 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261425AbVCYG2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 01:28:41 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20050325061311.GA22959@gondor.apana.org.au>
References: <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>
	 <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda>
	 <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>
	 <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
	 <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i/3SG/BtmYAoK03n8zSr"
Organization: MIPT
Date: Fri, 25 Mar 2005 09:34:19 +0300
Message-Id: <1111732459.20797.16.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 09:28:00 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-i/3SG/BtmYAoK03n8zSr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-25 at 17:13 +1100, Herbert Xu wrote:
> On Fri, Mar 25, 2005 at 09:16:01AM +0300, Evgeniy Polyakov wrote:
> > On Fri, 2005-03-25 at 00:58 -0500, Jeff Garzik wrote:
> >
> > > If its disabled by default, then you and 2-3 other people will use th=
is=20
> > > feature.  Not enough justification for a kernel API at that point.
> >=20
> > It is only because there are only couple of HW crypto devices
> > in the tree, with one crypto framework inclusion there will be
> > at least redouble.
>=20
> You missed the point.  This has nothing to do with the crypto API.
> Jeff is saying that if this is disabled by default, then only a few
> users will enable it and therefore use this API.
>=20
> Since we can't afford to enable it by default as hardware RNG may
> fail which can lead to catastrophic consequences, there is no point
> for this API at all.

Currently implemented in-tree drivers(hw_random.c, do not have spec
about=20
VIA) do not perform any kind of validation, drivers created for
OCF/acrypto
have HW validated RNG.
Such hardware is used mostly in embedded world where SW crypto
processing
is too expensive, so users of such HW likely want to trust to=20
theirs hardware and likely will turn in on.
That would be even be a good idea to have two way of turning it on -=20
kernel config option and ioctl() one - to allow embedded systems
with too limited userspace not change it's applications.
Of course with big fat warning about possible dramatical consequences.

> Cheers,
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-i/3SG/BtmYAoK03n8zSr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ7DrIKTPhE+8wY0RAs7KAJ4vT9KhqiNEa1lF1/AKmUnFxsgmzACeKzqq
ls+Zt6oZRiDEakuZyeC+eWs=
=A/Sj
-----END PGP SIGNATURE-----

--=-i/3SG/BtmYAoK03n8zSr--

