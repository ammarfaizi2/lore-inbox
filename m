Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbTFUUM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 16:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbTFUUM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 16:12:26 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:52664 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S265366AbTFUUMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 16:12:20 -0400
Date: Sun, 22 Jun 2003 00:26:18 +0400
To: Bill Davidsen <davidsen@tmr.com>, Andrey Panin <pazke@donpac.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030621202618.GA830@pazke>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org
References: <20030620061020.GC786@pazke> <Pine.LNX.3.96.1030620135641.17926A-101000@gatekeeper.tmr.com> <20030621175358.A2848@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20030621175358.A2848@Marvin.DL8BCU.ampr.org>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -10.5 (----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+On 172, 06 21, 2003 at 05:53:59 +0000, Thorsten Kranzkowski wrote:
> On Fri, Jun 20, 2003 at 02:00:14PM -0400, Bill Davidsen wrote:
> > On Fri, 20 Jun 2003, Andrey Panin wrote:
> >=20
> > > On 171, 06 20, 2003 at 06:55:47AM +0100, Russell King wrote:
> > > > The problem is one of a lack of historical information on why it was
> > > > added.  The driver itself allows serial ports to share interrupts b=
etween
> > > > themselves.  Maybe tytso knows why the "Rockwell 56K ACF II Fax+Dat=
a+Voice
> > > > Modem" is unable to share IRQs?
> > >=20
> > > It was me who added this crappy quirk.
> > >=20
> > > My ELine modem which identified itself "Rockwell 56K ACF II Fax+Data+=
Voice Modem"
> > > was going mad when its IRQ was shared with any device. So I decided t=
o add this
> > > quirk.
> > >=20
> > > Personally I think that ISA IRQ sharing should be absolutely last res=
ort technic,
> > > because ISA bus was never designed to support IRQ sharing sanely. If =
you have to
> > > enable ISA PnP device and do not have enough IRQ, you must print BIG =
FAT WARNING
> > > before doing this. May be kernel config options must be added for bra=
ve guys
> > > wanting to use ISA IRQ sharing.
>=20
> Problem is, 'unprepared' ISA cards are electrically unable to share inter=
rupts=20
> (like in: an interrupting card cant't drive the interrupt line high while=
 at=20
> the same time another one actively drives it at a low level). You _can_ m=
ake=20
> things work when you replace the IRQ-selection-jumper on all sharing devi=
ces=20
> with a diode and add a pull down resistor.  BTDT - works sufficiently wel=
l.

Problem is that almost all all ISA cards fall into 'unprepared' category,
unable to share interrupts with another card. ISA IRQ sharing allways was t=
he
risky bussiness, depending on electrical characteristics of both IRQ sharin=
g=20
devices.

> > But dumb multiport boards support sharing just fine:
>=20
> Yes, they usually contain the necessary sharing circuity onboard. But you=
=20
> can't share them with other instances of the same or other cards unless y=
ou=20
> make the modifications above.
>=20
> Unfortunately on-board serial ports seldom have IRQ-jumpers - which makes=
 them=20
> practically not shareable at all.

It's exactly my point beyond the ugly quirk which disables ISA IRQ sharing.

>=20
> And for PNP devices, well they also don't have jumpers. It is possible
> to find the necessary wires on the pcb though ..... ;-)=20

Reverse enginerring of the PCB layout is not acceptable for allmost all use=
rs=20
of ISA PnP boards :)

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9L9qby9O0+A2ZecRAjALAKClmo6khLs44c/lZWtr2hNk8dw33QCfYGVS
51nGHzqH9UyHpFOELxVDSlc=
=jdne
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
