Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVC2Ks5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVC2Ks5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVC2Ks4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:48:56 -0500
Received: from dea.vocord.ru ([217.67.177.50]:2202 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262331AbVC2KqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:46:14 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, cryptoapi@lists.logix.cz,
       Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>
In-Reply-To: <20050329103049.GB19541@gondor.apana.org.au>
References: <20050324132342.GD7115@beast>
	 <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com>
	 <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com>
	 <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com>
	 <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <20050329102104.GB6496@elf.ucw.cz>
	 <20050329103049.GB19541@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CRd5hRzaKEJcBXJ1q7xX"
Organization: MIPT
Date: Tue, 29 Mar 2005 14:50:28 +0400
Message-Id: <1112093428.5243.88.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 29 Mar 2005 14:43:53 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CRd5hRzaKEJcBXJ1q7xX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-29 at 20:30 +1000, Herbert Xu wrote:
> On Tue, Mar 29, 2005 at 12:21:04PM +0200, Pavel Machek wrote:
> >=20
> > What catastrophic consequences? Noone is likely to even *notice*, and
> > it does not help practical attack at all. Unless hardware RNGs are
> > *very* flakey (like, more flakey than harddrives), this is not a proble=
m.
>=20
> The reason some people use hardware RNGs in the first place is because
> they don't trust the software RNGs.  When the hardware RNG fails but
> continues to send data to /dev/random, /dev/random essentially degenerate=
s
> into a software RNG.  Now granted /dev/random is a pretty good software
> RNG, however, for some purposes it just isn't good enough.

I think the most people use hardware accelerated devices to
speed up theirs calculations - embedded world is the best example -=20
applications that are written to use /dev/random
will work just too slow, so hardware vendors
place HW assistant chips to unload that very cpu-intencive work
from main CPU.
Without ability speed this up in kernel, we completely [ok, almost]=20
loose all RNG advantages.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-CRd5hRzaKEJcBXJ1q7xX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCSTL0IKTPhE+8wY0RAh9pAJ9x6YxVOEjezl97ddhZpJniMWo3SgCgkaEy
JeuclHM1PxxWpfztRYyuutc=
=kG/8
-----END PGP SIGNATURE-----

--=-CRd5hRzaKEJcBXJ1q7xX--

