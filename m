Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131712AbRBWSeL>; Fri, 23 Feb 2001 13:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRBWSeB>; Fri, 23 Feb 2001 13:34:01 -0500
Received: from mta05.mail.au.uu.net ([203.2.192.85]:33152 "EHLO
	mta05.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S131712AbRBWSd4>; Fri, 23 Feb 2001 13:33:56 -0500
Date: Sat, 24 Feb 2001 04:33:50 +1000
To: linux-kernel@vger.kernel.org
Subject: 3c509 + sb16 bug
Message-ID: <20010224043350.A14635@ozemail.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Steve <sjthorne@ozemail.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The evidence really speaks for itself:

firstly, I have been running a 2.2.18 kernel system, with a 3c509b and a=20
soundblaster 16 (and sundry other hardware).

The soundblaster 16 is on 0x220, irq 5. Its a soundblaster 16 (vibra 16b, '=
94)
The 3c509 is pnp and detects under 2.2.18 as the following:
eth0: 3c509 at 0x300 tag 1, 10baseT port, address  00 a0 24 75 b7 28, IRQ 1=
0.

Both cards work perfectly, and autodetect without any arguments.

Now:

Here are the interesting bits of the boot of the 2.4.x kernel:

PCI: PCI BIOS revision 2.10 entry at 0xfb4f0,
last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent=20
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
isapnp: Scanning for Pnp cards...
isapnp: Card '3Com 3C509B EtherLink III'
isapnp: 1 Plug & Play card detected total

eth0: 3c509 at 0x220, 10baseT port, address  00 20 24 75 b7 28, IRQ 5.
3c509.c:1.16 (2.2) 2/3/98 becker@cesdis.gsfc.nasa.gov.

Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: No ISAPnP cards found, trying standard ones...=20
sb: I/O, IRQ, and DMA are mandatory

NB: PCI stuff was interesting, but I'm not sure if its connected to this
situation.

After bootup, at a random time interval between 10 seconds and 5 minutes the
following error spams the screen:
eth0: infinite loop in interrupt, status 2001

I can only conclude that the kernel has mistaken an ethernet card for a
sound card.

for convience, here is an lspci:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev c3)
00:08.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millenn=
ium]
(rev 01)
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c2)

Stephen Thorne

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6lq0O380pq7byIKgRApv4AJ9jTmfnk5lJe8pexo/HH0IKux95zACgitIl
1de7yUguRw28ZKLnTzSOEGc=
=I10O
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
