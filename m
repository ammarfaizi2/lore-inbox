Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262807AbVCXMPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262807AbVCXMPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 07:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVCXMPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 07:15:52 -0500
Received: from dea.vocord.ru ([217.67.177.50]:18658 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262807AbVCXMPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 07:15:41 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       jmorris@redhat.com, herbert@gondor.apana.org.au
In-Reply-To: <20050323203856.17d650ec.akpm@osdl.org>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	 <20050323203856.17d650ec.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1iEeZs3btkOotNtHZyol"
Organization: MIPT
Date: Thu, 24 Mar 2005 15:21:43 +0300
Message-Id: <1111666903.23532.95.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 24 Mar 2005 15:14:31 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1iEeZs3btkOotNtHZyol
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-03-23 at 20:38 -0800, Andrew Morton wrote:
> David McCullough <davidm@snapgear.com> wrote:
> >
> > Here is a small patch for 2.6.11 that adds a routine:
> >=20
> >  	add_true_randomness(__u32 *buf, int nwords);
>=20
> It neither applies correctly nor compiles in current kernels.  2.6.11 is
> very old in kernel time.
>=20
> Are we likely to see any in-kernel users of this?

Any external crtypto framework can add entropy using that routing.
Currently it can be
 - OCF
 - acrypto
 - hw_random.c

hw_random.c already does it using userspace daemons,
which is bad idea for very fast HW - like VIA xstore/xcrypt=20
instructions.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-1iEeZs3btkOotNtHZyol
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQrDXIKTPhE+8wY0RAjCvAJ9nODOPN7hEwF1wSd4sa0Xa/Jp5cQCeNstY
fuYLs7Uv9bdLpSojBQ0IQ/c=
=cAhP
-----END PGP SIGNATURE-----

--=-1iEeZs3btkOotNtHZyol--

