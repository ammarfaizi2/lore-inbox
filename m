Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUHUQj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUHUQj4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 12:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUHUQj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 12:39:56 -0400
Received: from 34.67-18-129.reverse.theplanet.com ([67.18.129.34]:9604 "EHLO
	krish.dnshostnetwork.net") by vger.kernel.org with ESMTP
	id S266748AbUHUQjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 12:39:51 -0400
Message-ID: <000c01c4879d$574ce950$9f59023d@dreammachine>
From: "Pankaj Agarwal" <pankaj@pnpexports.com>
To: =?iso-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
       <linux-kernel@vger.kernel.org>
References: <002301c485cc$3777fed0$9159023d@dreammachine> <200408191127.37990.ender@debian.org>
Subject: Re: Help Root Raid
Date: Sat, 21 Aug 2004 22:07:06 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - krish.dnshostnetwork.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pnpexports.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ender,

this isn't the case...however i tried by changing the 83 to FD but it
doesn't worked.

its already enabled and the kernel is reading these partitions as well....i
guess because of these messages during bootup and shutdown....

Part of BOOTUP message ...
"
autodetecting Raid Arrays
autorun...
...autorun DONE
"

Part of shutdown message ....
"
md recovery thread got woken
md recovery thread finished
mdrecoveryd(7) flushing signals
Stopping all md devices.
"
Hope it helps you in helping me further.

thanks and regards,

Pankaj

----- Original Message -----
From: "David Martínez Moreno" <ender@debian.org>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, August 19, 2004 2:57 PM
Subject: Re: Help Root Raid


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Jueves, 19 de Agosto de 2004 11:09, Pankaj Agarwal escribió:
> Hi,
>
> I need your help regarding root raid. I have a root raid implemented
server
> and it not booting anymore. I tried to use that harddisc as secondary hard
> disk to on of my other linux installation..so i can take a backup of
files.
> The other installation has raid precompiled....as in booting process it
> checks for raid arays and at shutdown it gives messages regarding md
> devices. however it doesn't show any dev in lsdev or /proc/mdstat. My
> problem is when i try to mount it using "mount -t ext2 /dev/md0 /mnt/hdc1"
> it gives me error as "wronf fs, bad option, bad superblock on
> /dev/md0.........................(aren't you trying to mount a block
device
> on a logical device)". Kindly show me the way to mount the filesystem.

Hello, Pankaj.

Probably you are not starting your RAID. You can check it with
cat /proc/mdstat. If not, well, you can mark the partitions forming the RAID
with persistent superblock (fd partition type in fdisk)) for starting
automatically the RAID on boot, or fill in the /etc/raidtab file with the
values of your current RAID and start it manually (see raidtools2 package).

Also you can read RAID-HOWTO for unvaluable information.

Regards,


Ender.
- --
What was that, honey? It was bad. It had no fire, no energy, no nothing.
 So tomorrow from 5 to 7 will you PLEASE act like you have more than a
 two word vocabulary. It must be green.
-- DJ Ruby Rhod (The Fifth Element).
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Red.es - Madrid (Spain)
Tlf (+34) 91.212.76.25
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBJHKJWs/EhA1iABsRAj4iAJ451GvM6qHxXZN1kNoVNZ3ZyCk6WQCgqK/u
rqn0vN10pei/DdkMhhROJVA=
=1nAH
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



