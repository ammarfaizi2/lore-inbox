Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSGZHBI>; Fri, 26 Jul 2002 03:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317221AbSGZHBI>; Fri, 26 Jul 2002 03:01:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:15569 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S317192AbSGZHBH>; Fri, 26 Jul 2002 03:01:07 -0400
Date: Fri, 26 Jul 2002 09:04:20 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marshal Newrock <marshal@simons-rock.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: HTP372 on K7RA-RAID / kernel 2.4.19rc3
In-Reply-To: <Pine.LNX.4.44.0207241953240.16813-100000@minerva.simons-rock.edu>
Message-ID: <Pine.NEB.4.44.0207260858290.15439-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002, Marshal Newrock wrote:

> HPT372 IDE RAID chip on an Abit K7RA-RAID
> running a freshly installed Gentoo (has gcc-2.95)
> kernel 2.4.19rc3, using devfs.
> Western Digital 40GB ATA100 drive on /dev/hde, one partition, ext2
> filesystem.
>
> The system has no problem recognizing the HPT372, and can see the drive
> and partitions.  I can generally mount it (mount /dev/hde1 /mnt), and 'ls
> /mnt' lists the directories.  'ls -l /mnt' will give an 'input/output
> error' for each directory.  Sometimes the ls or mount will hang, and I
> have to kill the login from another shell.
>
> Right now, I have the drive connected as /dev/hdc (replacing the CD
> drives), and working fine.
>
> I'm sure more info is needed, so tell me what you want me to do to help
> troubleshoot this.  Please reply to me off-list as I am not subscribed.

The -ac kernels contain some IDE updates including updates to hpt366.c
(AFAIR the HPT372 isn't really supported in 2.4.19-rc3). Could you try
whether 2.4.19-rc3-ac3 (apply [1] on top of 2.4.19-rc3 and run
"make clean oldconfig dep bzImage modules") fixes your problem?

> Thanx.  :)

cu
Adrian

[1] ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/patch-2.4.19-rc3-ac3.gz


-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

