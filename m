Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRDMPab>; Fri, 13 Apr 2001 11:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDMPaV>; Fri, 13 Apr 2001 11:30:21 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:26379 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131386AbRDMPaF> convert rfc822-to-8bit; Fri, 13 Apr 2001 11:30:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Peter <ujq7@rz.uni-karlsruhe.de>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Subject: Re: SW-RAID0 Performance problems
Date: Fri, 13 Apr 2001 17:36:55 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01041317365500.00665@debian>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn schrieb:
> > hdparm -t /dev/md0 : 20.25 MB/sec
> > hdparm -t /dev/hda : 20.51 MB/sec
> > hdaprm -t /dev/hdc : 20.71 MB/sec
>
> md0 is composed of partitions located where on hda and hdc?
> also, what's your CPU?

This is my raidtab file:

raiddev                 /dev/md0
 
raid-level              0    # it's not obvious but this *must* be
                             # right after raiddev
 
persistent-superblock   1    # set this to 1 if you want autostart,
                             # BUT SETTING TO 1 WILL DESTROY PREVIOUS
                             # CONTENTS if this is a RAID0 array created
                             # by older raidtools (0.40-0.51) or mdtools!
 
chunk-size              32
 
nr-raid-disks           2
nr-spare-disks          0
 
device                  /dev/hda3
raid-disk               0
 
device                  /dev/hdc3
raid-disk               1

The partition table:

Disk /dev/hda: 16 heads, 63 sectors, 59556 cylinders
Units = cylinders of 1008 * 512 bytes
 
   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1        21     10552+  83  Linux
/dev/hda2            22       542    262584   82  Linux swap
/dev/hda3           543     59556  29743056   fd  Linux raid autodetect

My board is a Gigabyte 6BXDS BX-Chipset 2 Celerons@533 MHz

Andreas
-- 
Andreas Peter *** ujq7@rz.uni-karlsruhe.de

