Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTI1TEm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbTI1TEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:04:42 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:65518 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S262676AbTI1TEj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:04:39 -0400
Subject: Re: [PATCH] i386 do_machine_check() is redundant.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Brian Gerst <bgerst@didntduck.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GudGFSBi8dGD/4XCOygf"
Organization: Red Hat, Inc.
Message-Id: <1064775868.5045.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Sun, 28 Sep 2003 21:04:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GudGFSBi8dGD/4XCOygf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-09-28 at 20:24, Linus Torvalds wrote:
> On Sun, 28 Sep 2003, Brian Gerst wrote:
> >
> > Use machine_check_vector in the entry code instead.
>=20
> This is wrong. You just lost the "asmlinkage" thing, which means that it=20
> breaks when asmlinkage matters.
>=20
> And yes, asmlinkage _can_ matter, even on x86. It disasbles regparm, for
> one thing, so it makes a huge difference if the kernel is compiled with
> -mregparm=3D3 (which used to work, and which I'd love to do, but gcc has
> often been a tad fragile).

gcc 3.2 and later are supposed to be ok (eg during 3.2 development a
long standing bug with regparm was fixed and now is believed to work)...
since our makefiles check gcc version already... this can be made gcc
version dependent as well for sure..

--=-GudGFSBi8dGD/4XCOygf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dzC8xULwo51rQBIRAkmeAJ9IBGXRTZsl20Uv8hdqp5vX1ENLuwCeOcEV
TOKjeyIuB1YXkGRRQbGGZsE=
=+Wjw
-----END PGP SIGNATURE-----

--=-GudGFSBi8dGD/4XCOygf--
