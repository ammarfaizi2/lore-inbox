Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUEBKC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUEBKC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 06:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbUEBKC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 06:02:27 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:4801 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262956AbUEBKCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 06:02:08 -0400
Subject: Re: [PATCH][2.4] remove amd7(saucy)_tco
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Willy Tarreau <willy@w.ods.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20040502084841.GA10228@alpha.home.local>
References: <Pine.LNX.4.58.0405011534230.2332@montezuma.fsmlabs.com>
	 <20040502084841.GA10228@alpha.home.local>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z4SP7UUNlJaFXQGW9yM1"
Message-Id: <1083492123.1100.48.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 02 May 2004 12:02:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z4SP7UUNlJaFXQGW9yM1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-05-02 at 10:48, Willy Tarreau wrote:
> On Sat, May 01, 2004 at 03:37:36PM -0400, Zwane Mwaikambo wrote:
> > Hello Marcelo,
> > 	This driver has already been removed in 2.6, essentially we've had
> > problems getting it working (it's been a while now) with a lot of board=
s,
> > all seems to be alright until the actual point where the hardware is
> > supposed to reset the system. So lets just back it out.
>=20
> Indeed, I've just checked here, because I believed I had seen it working,
> but now I think it was the softdog. It does nothing at all. I've download=
ed
> and read AMD's datasheet and the driver seems to do the right thing. BTW,
> I wonder if the chip is buggy or not, because I tried to play with the
> SYSRST and FULLRST bits in the 0xCF9 register. Changing SYSRST to 1 does =
not
> change anything, and changing FULLRST to 1 immediately reboots the machin=
e
> even if no reset was pending !

Exactly the same thing we (zwane and I) saw when trying to fix it. We
gave up after some time. We tested it on the 760mpx chipset on an Asus
A7M-266D motherboard (don't remember which north/south bridge
combination that is)

We've also seen even weirder things on the same chipset but from another
motherboard-manufacturer. There absolutely nothing happened after the
timer reached 0. No bits set anywhere. On my board we at least got that.

I use pci-based watchdog cards instead...

--=20
/Martin

--=-Z4SP7UUNlJaFXQGW9yM1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAlMcbWm2vlfa207ERAuRxAJ9VnVWUR8dPJ/mcPJikdE7H6pu14wCcD0N9
KpyvgqQe7z7IFa8Cz+Y6P10=
=9mKe
-----END PGP SIGNATURE-----

--=-Z4SP7UUNlJaFXQGW9yM1--
