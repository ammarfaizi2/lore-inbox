Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUAKJwZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 04:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUAKJwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 04:52:25 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:38528 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S265835AbUAKJwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 04:52:17 -0500
Subject: Re: 2.6.1 and irq balancing
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Ethan Weinstein <lists@stinkfoot.org>
In-Reply-To: <4000C544.1040301@cyberone.com.au>
References: <40008745.4070109@stinkfoot.org> <200401102139.09883.edt@aei.ca>
	 <4000C544.1040301@cyberone.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-suq98Fk1xB7eNwXQN0Tf"
Organization: Red Hat, Inc.
Message-Id: <1073814722.4431.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 11 Jan 2004 10:52:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-suq98Fk1xB7eNwXQN0Tf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 04:38, Nick Piggin wrote:
> Ed Tomlinson wrote:
>=20
> >Hi,
> >
> >What is the load on the box when this is happening?  If its low think
> >this is optimal (for cache reasons).
> > =20
> >
>=20
> I'd rather see different interrupt sources run on different CPUs
> initially, which would help fairness a little bit, and should be
> more optimal with big interrupt loads.
>=20
>=20
> 0:      xxx1     0      0      0
> 1:      0     xxx2      0      0
> 2:      0        0   xxx3      0
> 3:      0        0      0   xxx4
>=20
> This would delay the need for interrupt balancing in the case where
> 2 or more interrupts are heavily used.

this is what irqbalanced will do (but more inteligent than just using
the irq number as round robin seed).


--=-suq98Fk1xB7eNwXQN0Tf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAARzCxULwo51rQBIRAqr7AJoDcSG9NZR2EOzkQWY3TAMilpcbhQCeInk5
M+m4wBbON3NxBOs09zEEK2s=
=hoYt
-----END PGP SIGNATURE-----

--=-suq98Fk1xB7eNwXQN0Tf--
