Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbUKVQzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUKVQzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbUKVQoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:44:25 -0500
Received: from dea.vocord.ru ([217.67.177.50]:15327 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262132AbUKVQWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:22:55 -0500
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041122133344.GA19419@stusta.de>
References: <20041121220251.GE13254@stusta.de>
	 <1101108672.2843.55.camel@uganda>  <20041122133344.GA19419@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WpoNA6IRBvXGmkFmRn9I"
Organization: MIPT
Date: Mon, 22 Nov 2004 19:25:45 +0300
Message-Id: <1101140745.9784.7.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 22 Nov 2004 16:21:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WpoNA6IRBvXGmkFmRn9I
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-22 at 14:33 +0100, Adrian Bunk wrote:
> On Mon, Nov 22, 2004 at 10:31:12AM +0300, Evgeniy Polyakov wrote:
> > On Mon, 2004-11-22 at 01:02, Adrian Bunk wrote:
> > > Hi Evgeniy,
> >=20
> > Hello, Adrian.
>=20
> Hi Evgeniy,
>=20
> > > drivers/w1/Makefile in recent 2.6 kernels contains:
> > >   obj-$(CONFIG_W1_DS9490)         +=3D ds9490r.o=20
> > >   ds9490r-objs    :=3D dscore.o
> > >=20
> > > Is there a reason, why dscore.c isn't simply named ds9490r.c ?
> >=20
> > dscore.c is a core function set to work with ds2490 chip.
> > ds9490* is built on top of it.
> > Any vendor can create it's own w1 bus master using this chip,=20
> > not ds9490.
>=20
> if it was built on top of it, I'd have expected ds9490r.o to contain=20
> additional object files.

DS9490 does not have anything except this chip and simple 64bit memory
chip,
so it is not needed to have any additional code.

> How would a different w1 bus master chip look like in=20
> drivers/w1/Makefile?

obj-m: proprietary_module.o
proprietary_module-objs: dscore.o proprietary_module_init.o

Actually it will live outside the kernel tree, but will require ds2490
driver.
It could be called ds2490.c but I think dscore is better name.

> > 	Evgeniy Polyakov
>=20
> cu
> Adrian
>=20
--=20

--=-WpoNA6IRBvXGmkFmRn9I
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBohMJIKTPhE+8wY0RAjdFAJ4tMfeL5jtKsQS7+8Xmj6wwytnuOACgg2r/
ly13rxU3zlmD7EAUTQJFeCE=
=Scs6
-----END PGP SIGNATURE-----

--=-WpoNA6IRBvXGmkFmRn9I--

