Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVCYF1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVCYF1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 00:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVCYF1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 00:27:12 -0500
Received: from dea.vocord.ru ([217.67.177.50]:56294 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261294AbVCYF1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 00:27:02 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <42439839.7060702@pobox.com>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	 <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>
	 <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda>
	 <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>
	 <42439839.7060702@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Cf/0LQfSfTnM3/Qyc+Hu"
Organization: MIPT
Date: Fri, 25 Mar 2005 08:33:24 +0300
Message-Id: <1111728804.23532.137.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 08:26:13 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Cf/0LQfSfTnM3/Qyc+Hu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-24 at 23:48 -0500, Jeff Garzik wrote:

> > And how HIFN driver can contribute entropy?
>=20
> Use the current chrdev->rngd method.

Why HIFN must be chardev?

> > You may say, that hardware can be broken and thus produces=20
> > wrong data, but if user want, it can turn it on or off.
>=20
> The user cannot know the data is bad unless it is constantly being=20
> validated.

The user can not use HW crypto processors, since he does not
know if HW is broken or not, and thus must validate each crypto
operation, i.e. reencrypt data in SW.

Not the point.

Validation can be performed in other HW=20
(like Xilinx which routes HW requests to the real devices),
or in driver (if it is not FIPS validation).

So I still insist on creating ability to contribute entropy directly,
without userspace validation.
It will be turned off by default.

> 	Jeff

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-Cf/0LQfSfTnM3/Qyc+Hu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ6KkIKTPhE+8wY0RAtDYAKCFnCDI/8Dnnctbh6B6Pwci1WLTYwCfSGwq
JDY0Xe3vJsXbb+TSo1NgMD4=
=7Xal
-----END PGP SIGNATURE-----

--=-Cf/0LQfSfTnM3/Qyc+Hu--

