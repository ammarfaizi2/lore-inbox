Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSF1RPE>; Fri, 28 Jun 2002 13:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSF1RPC>; Fri, 28 Jun 2002 13:15:02 -0400
Received: from pop.gmx.de ([213.165.64.20]:64832 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317468AbSF1ROz>;
	Fri, 28 Jun 2002 13:14:55 -0400
Date: Fri, 28 Jun 2002 19:17:05 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24  IDE 94
Message-Id: <20020628191705.18f16b52.sebastian.droege@gmx.de>
In-Reply-To: <3D18A024.5000301@evision-ventures.com>
References: <Pine.LNX.4.33.0206201614450.1316-100000@penguin.transmeta.com>
	<3D18A024.5000301@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.L)3WqYz5t0.bE("
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.L)3WqYz5t0.bE(
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
after applying this patch I get the following error after some time of audiocd ripping with cdparanoia:
hdd: packet command error: status=0x51 [ drive ready,seek complete,error] 
hdd: packet command error: error=0x51
ATAPI device hdd:
  Error: Illegal request -- (Sense key=0x05)
  Illegal mode for this track or incompatible medium -- (asc=0x64, ascq=0x00)
  The failed "Request Sense" packet command was: 
  "03 00 00 00 12 00 00 00 00 00 00 00 "

cdparanoia doesn't respond after this anymore and only a reboot can make the cdrom driver work again
before this patch I got freezes when ripping audio data from cds (nothing in syslog)

ide-cd is compiled as module, the other ide stuff is compiled directly into the kernel
The IDE controller is a "VIA Technologies, Inc. Bus Master IDE (rev 06)" and the cdrom drive a "TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM" drive at udma-2 but I had this with another cdrom drive, too

This behaviour is completely reproducable

Bye
--=.L)3WqYz5t0.bE(
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9HJoTe9FFpVVDScsRAraOAJ9IteIw3Fou/Iw2n6VVIDM6hM17fwCg2Et2
MWX85NokPg7g+fDncma4p6g=
=O8Rg
-----END PGP SIGNATURE-----

--=.L)3WqYz5t0.bE(--

