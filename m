Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUHSJbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUHSJbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUHSJbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:31:39 -0400
Received: from chico.rediris.es ([130.206.1.3]:47829 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S264953AbUHSJ1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:27:02 -0400
From: David =?iso-8859-1?q?Mart=EDnez_Moreno?= <ender@debian.org>
Organization: Debian
To: <linux-kernel@vger.kernel.org>
Subject: Re: Help Root Raid
Date: Thu, 19 Aug 2004 11:27:37 +0200
User-Agent: KMail/1.6.2
References: <002301c485cc$3777fed0$9159023d@dreammachine>
In-Reply-To: <002301c485cc$3777fed0$9159023d@dreammachine>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408191127.37990.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Jueves, 19 de Agosto de 2004 11:09, Pankaj Agarwal escribió:
> Hi,
>
> I need your help regarding root raid. I have a root raid implemented server
> and it not booting anymore. I tried to use that harddisc as secondary hard
> disk to on of my other linux installation..so i can take a backup of files.
> The other installation has raid precompiled....as in booting process it
> checks for raid arays and at shutdown it gives messages regarding md
> devices. however it doesn't show any dev in lsdev or /proc/mdstat. My
> problem is when i try to mount it using "mount -t ext2 /dev/md0 /mnt/hdc1"
> it gives me error as "wronf fs, bad option, bad superblock on
> /dev/md0.........................(aren't you trying to mount a block device
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
