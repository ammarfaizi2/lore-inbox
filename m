Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262298AbVC2OeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbVC2OeR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 09:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVC2OeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 09:34:17 -0500
Received: from dea.vocord.ru ([217.67.177.50]:15588 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262298AbVC2OeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 09:34:05 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, cryptoapi@lists.logix.cz,
       Jeff Garzik <jgarzik@pobox.com>, David McCullough <davidm@snapgear.com>
In-Reply-To: <1112101875.5243.111.camel@uganda>
References: <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda>
	 <20050325061311.GA22959@gondor.apana.org.au>
	 <20050329102104.GB6496@elf.ucw.cz>
	 <20050329103049.GB19541@gondor.apana.org.au>
	 <1112093428.5243.88.camel@uganda>
	 <20050329104627.GD19468@gondor.apana.org.au>
	 <1112096525.5243.98.camel@uganda>
	 <20050329113921.GA20174@gondor.apana.org.au>
	 <1112098517.5243.102.camel@uganda>
	 <20050329124322.GA20543@gondor.apana.org.au>
	 <1112101875.5243.111.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/wB1rvPlWGVRqRVZcwlj"
Organization: MIPT
Date: Tue, 29 Mar 2005 18:38:59 +0400
Message-Id: <1112107139.5243.116.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 29 Mar 2005 18:32:28 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/wB1rvPlWGVRqRVZcwlj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-29 at 17:11 +0400, Evgeniy Polyakov wrote:
> On Tue, 2005-03-29 at 22:43 +1000, Herbert Xu wrote:
> > On Tue, Mar 29, 2005 at 04:15:17PM +0400, Evgeniy Polyakov wrote:
> > > > > On Tue, 2005-03-29 at 20:46 +1000, Herbert Xu wrote:
> > > >=20
> > > > > > Well if you can demonstrate that you're getting a higher rate o=
f
> > > > > > throughput from your RNG by doing this in kernel space vs. doin=
g
> > > > > > it in user space please let me know.
> > >
> > > > Well when you get 55mb/s from /dev/random please get back to me.
> > >=20
> > > I cant, noone writes 55mbit into it, but HW RNG drivers could. :)
> >=20
> > Are you intending to feed that into /dev/random at 55mb/s?
> >
> > If not then how is this an argument against doing it in userspace
> > through rngd?
>=20
> Yes.
> Untill pool is filled and then sleep there.
> When someone wants to draw from the pool - awake and fill it again.
>=20
> I clearly see your point here and I agree that it must be

I mean userspace validating and load balancing must be
default method for entropy producing.

> default method for entropy producing, but if there are=20
> possibility to speed that up, such techniques should be=20
> allowed to be used.
>=20
> It is really faster to fill pool from the kernelspace
> without copying/validating it in userspace.
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-/wB1rvPlWGVRqRVZcwlj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCSWiDIKTPhE+8wY0RAjbPAJ43T1GJgYFyB4uDer7c4XkdbogdGgCfSKhB
qvTvdbz+zNbAgQQ/xDbPG+M=
=xQ4i
-----END PGP SIGNATURE-----

--=-/wB1rvPlWGVRqRVZcwlj--

