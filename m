Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbUKVRMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUKVRMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbUKVRHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:07:23 -0500
Received: from dea.vocord.ru ([217.67.177.50]:53478 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262227AbUKVRCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:02:01 -0500
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041122165145.GH19419@stusta.de>
References: <20041121220251.GE13254@stusta.de>
	 <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de>
	 <1101140745.9784.7.camel@uganda>  <20041122165145.GH19419@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vEhrdAqQa7QupHTQX4uB"
Organization: MIPT
Date: Mon, 22 Nov 2004 20:05:09 +0300
Message-Id: <1101143109.9784.9.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 22 Nov 2004 17:00:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vEhrdAqQa7QupHTQX4uB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-22 at 17:51 +0100, Adrian Bunk wrote:
> On Mon, Nov 22, 2004 at 07:25:45PM +0300, Evgeniy Polyakov wrote:
> > On Mon, 2004-11-22 at 14:33 +0100, Adrian Bunk wrote:
> > > On Mon, Nov 22, 2004 at 10:31:12AM +0300, Evgeniy Polyakov wrote:
> > > > On Mon, 2004-11-22 at 01:02, Adrian Bunk wrote:
> > > > > Hi Evgeniy,
> > > >=20
> > > > Hello, Adrian.
> > >=20
> > > Hi Evgeniy,
> > >=20
> > > > > drivers/w1/Makefile in recent 2.6 kernels contains:
> > > > >   obj-$(CONFIG_W1_DS9490)         +=3D ds9490r.o=20
> > > > >   ds9490r-objs    :=3D dscore.o
> > > > >=20
> > > > > Is there a reason, why dscore.c isn't simply named ds9490r.c ?
> > > >=20
> > > > dscore.c is a core function set to work with ds2490 chip.
> > > > ds9490* is built on top of it.
> > > > Any vendor can create it's own w1 bus master using this chip,=20
> > > > not ds9490.
> > >=20
> > > if it was built on top of it, I'd have expected ds9490r.o to contain=20
> > > additional object files.
> >=20
> > DS9490 does not have anything except this chip and simple 64bit memory
> > chip,
> > so it is not needed to have any additional code.
> >=20
> > > How would a different w1 bus master chip look like in=20
> > > drivers/w1/Makefile?
> >=20
> > obj-m: proprietary_module.o
> > proprietary_module-objs: dscore.o proprietary_module_init.o
> >=20
> > Actually it will live outside the kernel tree, but will require ds2490
> > driver.
> > It could be called ds2490.c but I think dscore is better name.
>=20
> Why are you talking about proprietary modules living outside the kernel=20
> tree?
>=20
> The only interesting case is the one of modules shipped with the kernel.
> And for them, this will break at link time if two such modules are=20
> included statically into the kernel.

If we _currently_ do not have any open hw/module that depends on ds2490
core then it does not
mean that tomorrow noone will add it.

> cu
> Adrian
>=20
--=20

--=-vEhrdAqQa7QupHTQX4uB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBohxEIKTPhE+8wY0RAlYuAJ0ZfkXI8YIzl4HEW7Hv7HCB1Abe4wCdH1Z4
yzZaJmatBLZ8TkGilyflimk=
=PsHK
-----END PGP SIGNATURE-----

--=-vEhrdAqQa7QupHTQX4uB--

