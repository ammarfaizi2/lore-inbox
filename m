Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbRBCDym>; Fri, 2 Feb 2001 22:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbRBCDyc>; Fri, 2 Feb 2001 22:54:32 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:3321 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129144AbRBCDyS>; Fri, 2 Feb 2001 22:54:18 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102030353.f133rt002211@webber.adilger.net>
Subject: Re: A buglet with LVM-0.9.1
In-Reply-To: <3A7A1519.E140A726@toyota.com> from J Sloan at "Feb 1, 2001 06:02:01
 pm"
To: J Sloan <jjs@toyota.com>
Date: Fri, 2 Feb 2001 20:53:54 -0700 (MST)
CC: Linux kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan writes:
> I discovered that lvm seems to have a problem
> with compaq raid controllers - the partitions
> don't have the normal names like /dev/sda1,
> but instead names like /dev/ida/c0d0p1 -
> 
> lvm seems to works OK, but lvmdiskscan freaks...
> 
> lvmdiskscan -- filling directory cache...
> lvmdiskscan -- walking through all found disks / partitions
> lvmdiskscan -- /dev/ida/c0d0p1  [    1000.06 MB] free whole disk
> lvmdiskscan -- no valid disks / partitions found
> lvmdiskscan -- please check your disk device special files!

LVM _should_ take care of such devices as well, because there are several
block devices which don't live directly in /dev, especially with devfs.
According to "lvm_dir_cache.c", it should already check /dev/ida for disks.

If it doesn't work for you, this is a bug.  It would be useful if you ran
"lvmdiskscan -d" and "cat /proc/partitions" and sent the output to
linux-lvm@sistina.com

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
