Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUAJShv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 13:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265309AbUAJShv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 13:37:51 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:58247 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265298AbUAJShm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 13:37:42 -0500
Subject: Re: Q re /proc/bus/i2c
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: "J. Ryan Earl" <heretic@clanhk.org>
Cc: gene.heskett@verizon.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FFFE8E4.8080004@clanhk.org>
References: <200401100117.42252.gene.heskett@verizon.net>
	 <3FFF59A0.2080503@clanhk.org> <200401100754.47752.gene.heskett@verizon.net>
	 <3FFFE8E4.8080004@clanhk.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yIzmcJ8wBhv4o4pPMrBO"
Message-Id: <1073760037.9096.16.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 20:40:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yIzmcJ8wBhv4o4pPMrBO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-10 at 13:58, J. Ryan Earl wrote:
> Gene Heskett wrote:
>=20
> >On Friday 09 January 2004 20:47, J. Ryan Earl wrote:
> > =20
> >
> >I've also got a bttv card, whose init seems to be done quite early in=20
> >the bootup, and that requires I have i2c-dev in the kernel.  So I=20
> >might as well put it all in, the current situation.  All in, or all=20
> >out, it doesn't work.  A run of sensors right now, returns this:
> > =20
> >
>=20
> A couple questions:
>=20
> 1) Have you installed the lm-sensors package?
> 2) What kernel version?
>=20
> Even with 2.6, you need to install the lm-sensors package, but not the=20
> i2c package as the kernel already has everything needed in it.  The=20
> lm-sensors packages contains drivers for all the sensor chips.  After=20
> you get lm-sensors installed on your current kernel, run sensors-detect=20
> to get the proper modules loaded for your hardware.
>=20

Uhm, AFIAK, you should _NOT_ install the drivers from the lm-sensors
package, but use those in the kernel.  Check the docs, they explicitly
say that you should only do:

  # make user user_install

if you have 2.6 kernel.  Further, you do not _need_ lm-sensors package,
as if you only want to check/monitor one setting, you can get it from
/sys, and if you use gkrellm, it do not even use libsensors anymore
(and thus works without, as it have since 2.6 support, before even
libsensors was ported to understand sysfs) ...


--=20
Martin Schlemmer

--=-yIzmcJ8wBhv4o4pPMrBO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAEckqburzKaJYLYRAmfdAJ9og2T6HbL0Yj8vFgnDxnEB75ZBMQCeIT04
8wiTmsrj3pdWJo9gK27QLOM=
=es4o
-----END PGP SIGNATURE-----

--=-yIzmcJ8wBhv4o4pPMrBO--

