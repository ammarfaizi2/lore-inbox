Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbRFNMlT>; Thu, 14 Jun 2001 08:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbRFNMlK>; Thu, 14 Jun 2001 08:41:10 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:64811 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262432AbRFNMlG>; Thu, 14 Jun 2001 08:41:06 -0400
Date: Thu, 14 Jun 2001 14:40:39 +0200 (MET DST)
From: Udo Wolter <uwp@dicke-aersche.de>
Reply-To: uwp@dicke-aersche.de
To: linux-kernel@vger.kernel.org
Subject: EXT2FS problems & 2.2.19 & 3ware RAID
Message-ID: <Pine.SOL.4.10.10106141420580.20645-100000@blasuarr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm hosting a server with 120 GB disk space. This disk space consists of
a RAID10 via a 3ware Escalade 6800 controller. As you can see, the disks are
IDE disks (4 x 60 GB) but the controller maps it as scsi-devices to
the system. It runs fine but from time to time I get those errors:

kernel: EXT2-fs warning (device sd(8,6)): ext2_free_inode: bit already cleared for inode 885312
kernel: EXT2-fs warning (device sd(8,6)): ext2_free_inode: bit already cleared for inode 885258

etc.

The messages are coming almost once a week. As long as those messages are not
harming the filesystem, I had no problems with them (in fact, they say, they
are warnings and no errors). But the last times I tried to do a du over the
full partition, I got 2 or 3 files and directories which say that that they
can't be accessed -> I/O-Error. Neither I can't delete them nor I can
access them in any way, not even list.

After using debugfs (read only mode during the mount) I can see the files
in the listing but even here they are not accessible.

I shut the machine down for 2 hours to do a fsck and the errors had been
gone but after some days the errors came back (different files and directories,
not the same). At this time it's not possible to shut it down because
more than 5000 users use it at the moment. Anyway before doing a fsck again
I'd like to solve the problem so that the system couldn't get corrupted again.

The kernel-version is 2.2.19. Maybe switching to 2.4.x helps but I really
like to know what has happened and why, before I'll do such a big step.

BTW, 3ware has a tool to check for the disks etc. This tool says that
everything is fine so it can only be an EXT2FS problem.

If you'd like to answer my questions, please do it via Mail-CC because I don't
read all of this mailing list (only some parts of the archives, this is heavy
enough for me :))

Thanx for any hints !

Bye,
	Udo

-- 
Udo Wolter
email:    uwp@dicke-aersche.de
www:      www.dicke-aersche.de
Fonautic:   0700 - UDO - 00000 


