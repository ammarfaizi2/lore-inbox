Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSF2Ohh>; Sat, 29 Jun 2002 10:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312601AbSF2Ohg>; Sat, 29 Jun 2002 10:37:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:15730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S312590AbSF2Ohf>;
	Sat, 29 Jun 2002 10:37:35 -0400
Date: Sat, 29 Jun 2002 16:39:42 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24  IDE 94
Message-Id: <20020629163942.36362fb1.sebastian.droege@gmx.de>
In-Reply-To: <20020628191705.18f16b52.sebastian.droege@gmx.de>
References: <Pine.LNX.4.33.0206201614450.1316-100000@penguin.transmeta.com>
	<3D18A024.5000301@evision-ventures.com>
	<20020628191705.18f16b52.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.:_Um7EKBZ0_H6r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.:_Um7EKBZ0_H6r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2002 19:17:05 +0200
Sebastian Droege <sebastian.droege@gmx.de> wrote:

> Hi,
> after applying this patch I get the following error after some time of audiocd ripping with cdparanoia:
> hdd: packet command error: status=0x51 [ drive ready,seek complete,error] 
> hdd: packet command error: error=0x51
> ATAPI device hdd:
>   Error: Illegal request -- (Sense key=0x05)
>   Illegal mode for this track or incompatible medium -- (asc=0x64, ascq=0x00)
>   The failed "Request Sense" packet command was: 
>   "03 00 00 00 12 00 00 00 00 00 00 00 "
> 
> cdparanoia doesn't respond after this anymore and only a reboot can make the cdrom driver work again
> before this patch I got freezes when ripping audio data from cds (nothing in syslog)
> 
> ide-cd is compiled as module, the other ide stuff is compiled directly into the kernel
> The IDE controller is a "VIA Technologies, Inc. Bus Master IDE (rev 06)" and the cdrom drive a "TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM" drive at udma-2 but I had this with another cdrom drive, too
> 
> This behaviour is completely reproducable
> 
> Bye

After more testing I found 3 possible errors, which can happen while cd ripping...
-the system freezes completely
-cdparanoia gets unkillable and I first have to reboot to use the cdrom drive again (sometimes I got the error from my previous mail)
-I get the error from my previous mail and everything works fine
This happens with ide-cd as module or directly compiled into the kernel

It is nearly impossible to rip one complete cd

Bye
--=.:_Um7EKBZ0_H6r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Hcaxe9FFpVVDScsRAr2EAKC+w9MffKYk0sd8JFNWfjMlmT3nPgCfTsiu
Vu/+p385CN94mE7l2E5MpU4=
=9+3s
-----END PGP SIGNATURE-----

--=.:_Um7EKBZ0_H6r--

