Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRFNNBC>; Thu, 14 Jun 2001 09:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbRFNNAx>; Thu, 14 Jun 2001 09:00:53 -0400
Received: from Expansa.sns.it ([192.167.206.189]:49926 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S262568AbRFNNAm>;
	Thu, 14 Jun 2001 09:00:42 -0400
Date: Thu, 14 Jun 2001 15:00:25 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Udo Wolter <uwp@dicke-aersche.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: EXT2FS problems & 2.2.19 & 3ware RAID
In-Reply-To: <Pine.SOL.4.10.10106141420580.20645-100000@blasuarr>
Message-ID: <Pine.LNX.4.33.0106141454440.28405-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jun 2001, Udo Wolter wrote:

> Hi !
>
> I'm hosting a server with 120 GB disk space. This disk space consists of
> a RAID10 via a 3ware Escalade 6800 controller. As you can see, the disks are
> IDE disks (4 x 60 GB) but the controller maps it as scsi-devices to
> the system. It runs fine but from time to time I get those errors:
>
> kernel: EXT2-fs warning (device sd(8,6)): ext2_free_inode: bit already cleared for inode 885312
> kernel: EXT2-fs warning (device sd(8,6)): ext2_free_inode: bit already cleared for inode 885258
>
when i saw something similar, with a configuration really similar to your,
but on scsi disks, it was because a disc was near to break.
I had to change the disk and everything went ok.

It also happened to me after a crash on a disk due to eathing
problems, last august. Same messages,
and thanx God the disk was not really damnaged, so low level formatted
the disk, rebuilt partition table, then I rebuilt the fs to restore my
backup and everything went ok.
So my suggestion is to loock for HW problems.

> etc.
>
> The messages are coming almost once a week. As long as those messages are not
> harming the filesystem, I had no problems with them (in fact, they say, they
> are warnings and no errors). But the last times I tried to do a du over the
> full partition, I got 2 or 3 files and directories which say that that they
> can't be accessed -> I/O-Error. Neither I can't delete them nor I can
> access them in any way, not even list.
>
> After using debugfs (read only mode during the mount) I can see the files
> in the listing but even here they are not accessible.
>
> I shut the machine down for 2 hours to do a fsck and the errors had been
> gone but after some days the errors came back (different files and directories,
> not the same). At this time it's not possible to shut it down because
> more than 5000 users use it at the moment. Anyway before doing a fsck again
> I'd like to solve the problem so that the system couldn't get corrupted again.
>
exactly, that what I saw myself on the soon to get broken disk.

bests

Luigi Genoni




