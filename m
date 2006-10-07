Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932794AbWJGTs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbWJGTs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932793AbWJGTs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:48:57 -0400
Received: from hentges.net ([81.169.178.128]:55194 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S932792AbWJGTs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:48:56 -0400
Subject: Re: sky2 (was Re: 2.6.18-mm2)
From: Matthias Hentges <oe@hentges.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
In-Reply-To: <20061003202643.0e0ceab2@localhost.localdomain>
References: <20060928155053.7d8567ae.akpm@osdl.org>
	 <451C5599.80402@garzik.org> <20060928161956.5262e5d3@freekitty>
	 <1159930628.16765.9.camel@mhcln03>
	 <20061003202643.0e0ceab2@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ms8PJ+STvJCn+RKlI0ed"
Date: Sat, 07 Oct 2006 21:48:49 +0200
Message-Id: <1160250529.4575.7.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ms8PJ+STvJCn+RKlI0ed
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

Am Dienstag, den 03.10.2006, 20:26 -0700 schrieb Stephen Hemminger:

[...]

> > while the above patch indeed removes the error messages from my previou=
s
> > mail, I have since seen random but reproduceable  freezes of the box in
> > question. I believe they are sky2 related since the freeze can be
> > triggered by continuous network traffic (like playing a movie over NFS
> > etc.).
>=20
> When it fixes what does the log say. I'm probably going to back out
> the PCI express extended error using the pci_XXX functions.


> > The freezes only happen with 2.6.18-mm2 and 2.6.18-mm3. 2.6.18-mm1 work=
s
> > perfectly fine.
> > I've hooked up the box to my laptop via a serial cable and captured all
> > kernel messages from booting up the machine to the freeze. You'll note
> > that the last messages are from the sky2 driver ;)
> >=20
>=20
> Does it still happen with linus git tree. If so, a git bisect might
> help. It might not be sky2 related at all, there has been lots of changes=
.

I am doing a bisect right now which is kind of a PITA as the freeze is
completely random.
I have since noticed that the freeze happens shortly after the network
dies, possibly during the "rrmod sky2 / moprobe sky2" my script is
doing.

> > Once frozen the network is dead, the screen won't wake up from suspend
> > and CAPSLOCK can not be toggled. SYSRQ (sp?) still works tho.
> >=20
> > Any help in debugging this problem would be appreciated =3D)
>=20
> The TX timeout is a symptom of a common bug still not fixed where
> the transmitter stops. I'm working on reproducing it on my hardware and s=
witches,
> because without a reproducible test, its just shooting in the dark and
> that isn't working.

I'd be happy to assist with that as I have his bug up to 5 times a day :
\
--=20
Matthias 'CoreDump' Hentges=20

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice

--=-ms8PJ+STvJCn+RKlI0ed
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFKAShAq2P5eLUP5IRAi4tAKCHBcOCTCikc4+QjLDJglzohrGCuwCgm3/o
rs5riLyePPao8bDgbnOifyM=
=HfMw
-----END PGP SIGNATURE-----

--=-ms8PJ+STvJCn+RKlI0ed--

