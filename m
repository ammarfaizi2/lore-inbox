Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTLIXNY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTLIXNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:13:24 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:64946
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S263400AbTLIXNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:13:21 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog
From: Ian Kumlien <pomac@vapor.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: ross@datscreative.com.au, linux-kernel@vger.kernel.org, recbo@nishanet.com
In-Reply-To: <1071007478.5293.11.camel@athlonxp.bradney.info>
References: <1070827127.1991.16.camel@big.pomac.com>
	 <200312081207.45297.ross@datscreative.com.au>
	 <1070993538.1674.10.camel@big.pomac.com>
	 <1071007478.5293.11.camel@athlonxp.bradney.info>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gpgAARUFegvZkfU8eqrA"
Message-Id: <1071011604.1670.16.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 10 Dec 2003 00:13:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gpgAARUFegvZkfU8eqrA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-09 at 23:04, Craig Bradney wrote:
> On Tue, 2003-12-09 at 19:12, Ian Kumlien wrote:
> > Bob wrote:
> > > Using a patch that fixes a number of people's nforce2
> > > lockups while enabling io-apic edge timer, I can now
> > > use nmi_watchdog=3D2 but not =3D1
> >=20
> > Why regurgitate patches that are outdated, Personally i find int
> > outdated after Ross made his patches available and they DO enable
> > nmi_watchdog=3D1. (I have seen the old patches mentioned more than once=
,
> > if something better comes along, please move to that instead.)
> >=20
> > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D107080280512734&w=3D=
2
> >=20
> > Anyways, Is there anyway to detect if the cpu is "disconnected" or, is
> > there anyway to see when the kernel sends it's halts that triggers the
> > disconnect? (or is it automagic?)
> >=20
> > If there was a way to check, then thats all thats needed, all delays ca=
n
> > be removed and the code can be more generalized.
> >=20
> > (Since doubt that this is apic torment. It's more apic trying to talk t=
o
> > a disconnected cpu... (which both approaches hints at imho))
>=20
> Have these patches been submitted for review for inclusion into the main
> kernel?

No, there is no final patch in anyway, there are just dodgy workarounds.
I just deem this better with working nmi_watchdog=3D1

> I'm still running the old IO-APIC patch (Uptime 3d 20h) and having no
> issues whatsoever.

They fix the same problem..=20

> Are all of the patches at that address you provide necessary?=20

nope, but they are all nforce2 related.

> What do the IDE ones claim to fix? I have had no real issue with IDE at
> all.. being able to burn CDs, DVDs, use my ATA133 drive for hdparm,
> greps, compilation, and general use.....

it's just a cleanup afair.

Anyways, I think that if we find someway to detect cpu disconnect, then
we just need that "detection" prior to the apic ack...=20
(just a guess though)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-gpgAARUFegvZkfU8eqrA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/1lcU7F3Euyc51N8RAqtHAJ48bQ27oR4oBZ9QVSE5NmwRNCYFDwCeLicP
ObUogMdxr1iQi736fPzXcps=
=0h58
-----END PGP SIGNATURE-----

--=-gpgAARUFegvZkfU8eqrA--

