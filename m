Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbVCYHOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbVCYHOL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 02:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVCYHOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 02:14:11 -0500
Received: from dea.vocord.ru ([217.67.177.50]:129 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261464AbVCYHOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 02:14:00 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>,
       cryptoapi@lists.logix.cz, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20050325065622.GA31127@gondor.apana.org.au>
References: <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda>
	 <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda>
	 <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <1111732459.20797.16.camel@uganda>
	 <20050325063333.GA27939@gondor.apana.org.au>
	 <1111733958.20797.30.camel@uganda>
	 <20050325065622.GA31127@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RiP/IKZFL+8Gwvpu3e3E"
Organization: MIPT
Date: Fri, 25 Mar 2005 10:19:55 +0300
Message-Id: <1111735195.20797.42.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 25 Mar 2005 10:13:28 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RiP/IKZFL+8Gwvpu3e3E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-03-25 at 17:56 +1100, Herbert Xu wrote:
> On Fri, Mar 25, 2005 at 09:59:18AM +0300, Evgeniy Polyakov wrote:
> >=20
> > It is not only about userspace/kernelspace system calls and data
> > copying,
> > but about whole revalidation process, which can and is quite expensive,
> > due to system calls, copying and validating itself,
>=20
> What I meant is if you don't need the revalidation then don't do it.
> That's the advantage of having it in user-space, *you* get to decide,
> not us.

One can not add entropy data directly to the pool from kernelspace now.
But now noone may do it, since all presented data is not validated.
So when there will be validated HW RNG they still need to pass
it's data through userspace validation daemon
(which btw makes tens to hundreds operations per bit according to FIPS).

> > And what about initial bootup? When system needs to create randoom
> > IP/dhcp/any ids? What about small router?
>=20
> Let's not reinvent the wheel, this is exactly what initramfs is for.

It is not panacea and even not always working solution.

If user turn that feature on - he is on his own.
Noone will complain on Linux if NIC is broken and produces wrong
checksum
and HW checksum offloading is enabled using ethtools.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-RiP/IKZFL+8Gwvpu3e3E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQ7ubIKTPhE+8wY0RAr49AJ92Xyas+eA5epxqK0zicxZRhUWmEQCeNPnn
9VaiCRY1JPG4JoKpmPUiPuQ=
=8s5J
-----END PGP SIGNATURE-----

--=-RiP/IKZFL+8Gwvpu3e3E--

