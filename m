Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUAKRll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265875AbUAKRll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:41:41 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:18057 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265468AbUAKRlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:41:39 -0500
Subject: Re: [PATCH][TRIVIAL] Remove bogus "value 0x37ffffff truncated to
	0x37ffffff" warning.
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Bart Samwel <bart@samwel.tk>, Tim Cambrant <tim@cambrant.com>,
       Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0401110852030.19685-100000@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0401110852030.19685-100000@bigblue.dev.mdolabs.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ALdnhQIxn6em6J7yILio"
Message-Id: <1073843075.9096.125.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 19:44:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ALdnhQIxn6em6J7yILio
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-11 at 18:53, Davide Libenzi wrote:
> On Sun, 11 Jan 2004, Bart Samwel wrote:
>=20
> > Now it seems to behave correctly: for '~' it always warns, for '-' it=20
> > only warns if the negative value is below -0x80000000. I'll submit a=20
> > patch to this effect (including the format extensions) to the binutils=20
> > people.
>=20
> binutils 2.14 works fine, so I believe they already fixed it.
>=20

I would beg to differ:

--
nosferatu linux # make
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/asm-i386/asm_offsets.h
  CHK     include/linux/compile.h
  AS      arch/i386/boot/setup.o
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 0x37ffff=
ff
  LD      arch/i386/boot/setup
  BUILD   arch/i386/boot/bzImage
Root device is (8, 3)
Boot sector 512 bytes.
Setup is 4799 bytes.
System is 1366 kB
Kernel: arch/i386/boot/bzImage is ready
  Building modules, stage 2.
  MODPOST
nosferatu linux # ld --version
GNU ld version 2.14.90.0.7 20031029
Copyright 2002 Free Software Foundation, Inc.
This program is free software; you may redistribute it under the terms of
the GNU General Public License.  This program has absolutely no warranty.
nosferatu linux #
--


--=20
Martin Schlemmer

--=-ALdnhQIxn6em6J7yILio
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAYuDqburzKaJYLYRAiDSAJ9UFfcRmot5tIiSpzAl1MGwKRo9PwCePM0o
h11XFgJ+7JTCDXaZXlOy9f8=
=Qbus
-----END PGP SIGNATURE-----

--=-ALdnhQIxn6em6J7yILio--

