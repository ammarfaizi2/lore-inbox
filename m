Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVASOo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVASOo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVASOo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:44:58 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:63721 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261736AbVASOou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:44:50 -0500
Subject: Re: [ANNOUNCEMENT] Collision regression test suite released
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
In-Reply-To: <1106123242.6310.78.camel@laptopd505.fenrus.org>
References: <1106088908.3832.56.camel@localhost.localdomain>
	 <1106123242.6310.78.camel@laptopd505.fenrus.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Etz8EOayAhcagwRdTlT0"
Date: Wed, 19 Jan 2005 15:43:47 +0100
Message-Id: <1106145827.3832.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Etz8EOayAhcagwRdTlT0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El mi=E9, 19-01-2005 a las 09:27 +0100, Arjan van de Ven escribi=F3:
> On Tue, 2005-01-18 at 23:55 +0100, Lorenzo Hern=E1ndez Garc=EDa-Hierro
> wrote:
> > Also, maybe an ExecShield specific test (see [1] and [2]) and possibly =
a
> > few other tests related with BSD Jails.
>=20
> > [1]: http://212.130.50.194/papers/attack/ExploitingFedora.txt
>=20
> fwiw this paper is about exploiting prelink more than execshield; the
> proposed technique only works because the system was prelinked (without
> prelink every time you start a program all addresses get randomized,
> with prelink the addresses randomize every 2 weeks) and the "security
> sensitive" application was not made a PIE.

Right, that's a point I forgot to talk about.

> The first makes it really hard to write generic exploits (but means you
> can do a local based attack within 2 weeks), the second means that the
> exploit technique only works for a subset of programs; in Fedora most
> (if not all) network daemons and a bunch of other things are PIE, and
> there even is an entire gentoo distribution which is entirely PIE.

Yes, the address space layout randomization (ASLR) as PaX calls it,
makes really difficult to get done the so-called ret2libc attacks, but
anyway it could be interesting to write some tests trying to achieve it,
most for fun than an useful thing, as (unexpected) results might be as
randomized as the address space can be ;D

PIE is, hopefully, also being introduced in Debian-based systems by the
Hardened Debian project.
Gentoo has the Hardened Gentoo official sub project, which is doing (and
has did) a great work around this stuff, among the deployment of other
security technologies.

Cheers and thanks for the comments,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-Etz8EOayAhcagwRdTlT0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB7nIjDcEopW8rLewRAsyoAKCwj9uQBu0LzLaXx1pjtu5Ozi78qwCglEf3
/RhVIUKQgPC23Nlp63lLJ44=
=wND6
-----END PGP SIGNATURE-----

--=-Etz8EOayAhcagwRdTlT0--

