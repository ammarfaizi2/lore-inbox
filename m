Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263368AbTCNRQa>; Fri, 14 Mar 2003 12:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbTCNRQa>; Fri, 14 Mar 2003 12:16:30 -0500
Received: from B573e.pppool.de ([213.7.87.62]:13196 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S263368AbTCNRQ3>; Fri, 14 Mar 2003 12:16:29 -0500
Subject: Re: 2.4.20 and 2.5.64 NIC missing interrupts in APIC mode
From: Daniel Egger <degger@fhm.edu>
To: Roger Luethi <rl@hellgate.ch>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20030313202407.GA10774@k3.hellgate.ch>
References: <1047581900.1513.36.camel@sonja>
	 <20030313202407.GA10774@k3.hellgate.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-V4t6T/KHNB8Z9KYu22n/"
Organization: 
Message-Id: <1047662819.7452.17.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 14 Mar 2003 18:27:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V4t6T/KHNB8Z9KYu22n/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, 2003-03-13 um 21.24 schrieb Roger Luethi:

> > As soon as I enable the APIC mode in the BIOS the onboard PHY seems
> > to ignore any packets which are thrown at it *after* the kernel
> > initialised itself which is especially nasty since the system is bootin=
g
> > from network effectively stopping its boot when trying to get an IP
> > using DHCP or mounting a NFS volume in case the IP is fixed. The onboar=
d
> > NIC is a VIA Rhine II (VT6102).

> You may want to try 2.4.x-ac kernels, I believe Alan fixed some VIA APIC
> issues.

According to Alans changelog the 2.5-ac has a forwardport of the VIA
interrupt line patch, after some difficulties applying 2.5.64-ac3 to=20
a rsynched post 2.5.64 kernel (some parts of the console changes didn't
apply cleanly) I now tried it and it shows exactly the same symptoms.

Are there more VIA patches floating aroung? A short search on google
didn't find anything particularly interesting.

Almost more annoying is that even after removing the fb support I cannot
see enough of the messages to be helpful here, neither scrolllock nor
shift-pgup help, probably also an interrupt issue though a bit seems
to go through:
atkbd.c: Unknown key (set 2, scancode 0xb6, on isa0060/serio0) pressed.

--=20
Servus,
       Daniel

--=-V4t6T/KHNB8Z9KYu22n/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+chDjchlzsq9KoIYRAjKfAKCndKNYMm+xQZMIzWYIkS29/bHRbwCgp8YG
gLaLhR3RahUnZ4G4p0dQyXQ=
=4ds5
-----END PGP SIGNATURE-----

--=-V4t6T/KHNB8Z9KYu22n/--

