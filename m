Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267469AbTBML3Q>; Thu, 13 Feb 2003 06:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268022AbTBML3Q>; Thu, 13 Feb 2003 06:29:16 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:49391 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S267469AbTBML3P>; Thu, 13 Feb 2003 06:29:15 -0500
Subject: Re: select returning slow on RH 2.4.18-14 (RH 8.0) kernel.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3E4B60A1.2060209@candelatech.com>
References: <3E4B60A1.2060209@candelatech.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-45JlsNdNHU4Rim308ESs"
Organization: Red Hat, Inc.
Message-Id: <1045136340.2313.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 13 Feb 2003 12:39:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-45JlsNdNHU4Rim308ESs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-02-13 at 10:08, Ben Greear wrote:
> I've been doing some testing with RH 8.0 on an Ezra 800Mhz
> machine.
>=20
> Even when lightly loaded select() often returns 3-9 miliseconds slower
> than the timeout would suggest.  I know select is not guaranteed to
> return with < 10ms accuracy, but with almost no load, shouldn't it
> at least return with 1ms accuracy on average?
no
the kernel.org kernels will return in multiple-of-10ms quantities due to
HZ having the value of 100.
2.4.18-14 (which is btw obsoleted by several security errata) has a HZ
value of 512 so will return in shorter quantities, EXCEPT when you
always try to wait exactly 10ms of course....

--=-45JlsNdNHU4Rim308ESs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+S4PUxULwo51rQBIRAgwwAJ9UKBYIUHR2c+gFDS6LwlkMEkiQEQCfSLRh
f8IjlnoIEykfrNK67vTzqlc=
=ZzaC
-----END PGP SIGNATURE-----

--=-45JlsNdNHU4Rim308ESs--
