Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278103AbRJKFU0>; Thu, 11 Oct 2001 01:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278100AbRJKFUQ>; Thu, 11 Oct 2001 01:20:16 -0400
Received: from dialup-65-169-128-25.olp.net ([65.169.128.25]:39300 "EHLO
	dialup-65-169-128-25.olp.net") by vger.kernel.org with ESMTP
	id <S278103AbRJKFUA>; Thu, 11 Oct 2001 01:20:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: arvest@orphansonfire.com
To: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.11 loses sda9
Date: Thu, 11 Oct 2001 00:20:17 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.GSO.4.21.0110110106070.21168-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110110106070.21168-100000@weyl.math.psu.edu>
X-identity: qwertyatorphansonfire
MIME-Version: 1.0
Message-Id: <01101100201700.04473@lithium>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 October 2001 00:07, Alexander Viro wrote:
> >  I recompiled (I used the same .10 conf) and rebooted, but my reboot
> > halted because /dev/sda9 didnt exist.  I checked this in fdisk, and it
> > didnt see it. I rebooted to the 2.4.10 kernel, and sda9 was there.  What
> > happened?
>
> Information from fdisk would help - from both versions (with 2.4.11 you'll
> need to boot with init=/bin/sh, obviously).  It may be a bug in partition
> code, it may be something fishy with guessing geometry (SCSI uses bread()
> for that) and it may be something fishy in block devices in pagecache
> stuff.
>
> If you have sfdisk, sfdisk /dev/sda -O /tmp/foo + mailing the result would
> make debugging the thing much simpler (that one - from the 2.4.10).

  I can get the system booted enough to work on (and totaly up) with this 
partition failing.  I dont know what more information from fdisk I can give 
you, sda9 is there with .10, and gone with .11  It even allowed me to add a 
new partition (i didnt save)  I tried sfdisk but it gave me these errors.

sfdisk /dev/sda -O /tmp/foo
Checking that no-one is using this disk right now ...
BLKRRPART: Device or resource busy
 
This disk is currently in use - repartitioning is probably a bad idea.
Umount all file systems, and swapoff all swap partitions on this disk.
Use the --no-reread flag to suppress this check.
Use the --force flag to overrule all checks.

  I didnt try the flags, Im worried that its going to overwrite my 
filesystem.  Heres my /proc/scsi/sym53c8xx/0 in case its needed.  My system 
is entirely scsi, except for an atapi burner.  All scsi compiled static.

General information:
  Chip sym53c875, device id 0xf, revision id 0x26
  On PCI bus 0, device 16, function 0, IRQ 9
  Synchronous period factor 12, max commands per lun 32

  Whats my next step?
