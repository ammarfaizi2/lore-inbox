Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTEEQ4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbTEEQ4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:56:02 -0400
Received: from mail.goshen.edu ([199.8.232.22]:63956 "EHLO mail.goshen.edu")
	by vger.kernel.org with ESMTP id S263700AbTEEQyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:54:50 -0400
Subject: Re: partitions in meta devices
From: Ezra Nugroho <ezran@goshen.edu>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EB69883.8090609@gmx.net>
References: <1052153060.29588.196.camel@ezran.goshen.edu>
		<3EB693B1.9020505@gmx.net> <1052153834.29676.219.camel@ezran.goshen.edu> 
	<3EB69883.8090609@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9.7x.1) 
Date: 05 May 2003 12:21:24 -0500
Message-Id: <1052155284.29676.250.camel@ezran.goshen.edu>
Mime-Version: 1.0
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 11:59, Carl-Daniel Hailfinger wrote:
> Ezra Nugroho wrote:
> > On Mon, 2003-05-05 at 11:39, Carl-Daniel Hailfinger wrote:
> > 
> >>Ezra Nugroho wrote:
> >>
> >>>however, I couldn't create any file system for them, or mount them.
> >>>/dev/md0px just don't exist.
> >>>
> >>
> >>Please reboot after partitioning.
> > 
> > I did. Nothing changed. fdisk reported the changes still.
> 
> OK. Maybe I wasn't clear enough.
> 1. Partition a drive
> 2. Reboot
> 3. Now the kernel should see the partitions and let you create file
> systems on them.

Did all that, kernel didn't see the partition.
 
> You rebooted and fdisk sees the partitions now. Fine. Please try to
> mke2fs /dev/md0p1

This didn't work, because /dev/md0p1 doesn't exists.

> That should work. If it doesn't, devfs could be the problem.

It could be.
 
> Could you please tell us which kernel version you're using?

My linux is:
Linux version 2.4.20 (root@localhost) (gcc version 3.2.2)

kernel config related to raid:

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MD_MULTIPATH=m
# CONFIG_BLK_DEV_LVM is not set


My raidtab is:
       raiddev /dev/md0
           raid-level              5
           nr-raid-disks           3
           nr-spare-disks          0
           persistent-superblock   1
           chunk-size              32
           parity-algorithm        left-symmetric

           device                  /dev/hdc
           raid-disk               0
           device                  /dev/hde
           raid-disk               1
           device                  /dev/hdg
           raid-disk               2


any idea?

