Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUAJFXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 00:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264935AbUAJFXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 00:23:25 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:11655 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S264929AbUAJFXV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 00:23:21 -0500
Subject: Re: problems with CONFIG_PCI_USE_VECTOR in 2.6.1
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: "Eric C. Cooper" <ecc@cmu.edu>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040110042108.GB313@localhost>
References: <20040110042108.GB313@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-edbc6stY+aZ7MGAB8zSJ"
Message-Id: <1073712375.12069.1.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 07:26:15 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-edbc6stY+aZ7MGAB8zSJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-10 at 06:21, Eric C. Cooper wrote:
> When I tried a 2.6.1 kernel with CONFIG_PCI_USE_VECTOR, my onboard
> Ethernet (sis900) produced nothing but watchdog timeouts.  It worked
> fine with the old IRQ routing.
>=20
> When I looked in /var/log/syslog, I noticed that the Ethernet driver
> was using a different IRQ, so I suspected the vector routing.  I found
> the following suspicious entries:
>=20
> Jan  9 20:09:08 jaguar kernel: PCI: PCI BIOS revision 2.10 entry at 0xf11=
b0, last bus=3D1
> Jan  9 20:09:08 jaguar kernel: PCI: Using configuration type 1
> Jan  9 20:09:08 jaguar kernel: mtrr: v2.0 (20020519)
> Jan  9 20:09:08 jaguar kernel: ACPI: Subsystem revision 20031002
> Jan  9 20:09:08 jaguar kernel: IOAPIC[0]: Set PCI routing entry (2-20 -> =
0xa9 -> IRQ 20 Mode:1 Active:1)
> Jan  9 20:09:08 jaguar kernel: ACPI: SCI (IRQ20) allocation failed
> Jan  9 20:09:08 jaguar kernel:     ACPI-0133: *** Error: Unable to instal=
l System Control Interrupt Handler, AE_NOT_ACQUIRED
> Jan  9 20:09:08 jaguar kernel: ACPI: Unable to start the ACPI Interpreter
> Jan  9 20:09:08 jaguar kernel: Trying to free free IRQ20
> Jan  9 20:09:08 jaguar kernel: ACPI: ACPI tables contain no PCI IRQ routi=
ng entries
> Jan  9 20:09:08 jaguar kernel: PCI: Invalid ACPI-PCI IRQ routing table
> Jan  9 20:09:08 jaguar kernel: PCI: Probing PCI hardware
> Jan  9 20:09:08 jaguar kernel: PCI: Probing PCI hardware (bus 00)
> Jan  9 20:09:08 jaguar kernel: Enabling SiS 96x SMBus.
> Jan  9 20:09:08 jaguar kernel: PCI: Using IRQ router default [1039/0963] =
at 0000:00:02.0
> Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!
> Jan  9 20:09:08 jaguar last message repeated 9 times
> Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 1!
> Jan  9 20:09:08 jaguar kernel: PCI BIOS passed nonexistent PCI bus 0!
>=20

Looks like acpi failing - what about trying with latest acpi update:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-m=
m1/broken-out/acpi-20031203.patch
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-m=
m1/broken-out/acpi-20031203-fix.patch


--=20
Martin Schlemmer

--=-edbc6stY+aZ7MGAB8zSJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA//4z3qburzKaJYLYRAtnwAJ4jvS+mlijAUAeyuuNE7Ip5gO3BlgCdGHM3
IY8LcaCCnN3ThJVpaYXBjKs=
=L2RZ
-----END PGP SIGNATURE-----

--=-edbc6stY+aZ7MGAB8zSJ--

