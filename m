Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTIDA7x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 20:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTIDA7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 20:59:53 -0400
Received: from dragon.woods.net ([166.70.175.35]:3200 "EHLO c.smtp.woods.net")
	by vger.kernel.org with ESMTP id S264469AbTIDA7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 20:59:50 -0400
Date: Wed, 3 Sep 2003 18:59:48 -0600 (MDT)
From: Aaron Dewell <acd@woods.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: partition weirdness
In-Reply-To: <20030904024941.A2658@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.44.0309031856530.385-100000@dragon.woods.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Sep 2003, Andries Brouwer wrote:
 > Does the kernel have support for sun partition tables built in?

Yes.  Without it, the partition table is not recognized at all.

 > What are the kernel boot messages about the disk?

Attached scsi disk sdc at scsi1, channel 0, id 15, lun 0
[...]
SCSI device sdc: 8498506 512-byte hdwr sectors (4351 MB)
 /dev/scsi/host1/bus0/target15/lun0: p1 p2 p3 p4 p6 p7

 > What does /proc/partitions say?

   8    32    4249253 scsi/host1/bus0/target15/lun0/disc 498 30954 62904 7200 0 0 0 0 0 3640 7200
   8    33      99696 scsi/host1/bus0/target15/lun0/part1 0 0 0 0 0 0 0 0 0 0 0
   8    34    1046808 scsi/host1/bus0/target15/lun0/part2 0 0 0 0 0 0 0 0 0 0 0
   8    35    4237080 scsi/host1/bus0/target15/lun0/part3 0 0 0 0 0 0 0 0 0 0 0
   8    36     510942 scsi/host1/bus0/target15/lun0/part4 205 12795 26000 2880 0 0 0 0 0 1450 2880
   8    38    1021884 scsi/host1/bus0/target15/lun0/part6 149 9267 18832 2100 0 0 0 0 0 1060 2100
   8    39    1557750 scsi/host1/bus0/target15/lun0/part7 143 8889 18064 2210 0 0 0 0 0 1120 2210

 > What does fdisk -l say?


Disk /dev/discs/disc2/disc (Sun disk label): 134 heads, 62 sectors, 1020 cylinders
Units = cylinders of 8308 * 512 bytes

                Device Flag    Start       End    Blocks   Id  System
/dev/discs/disc2/part1             0        24     99696   83  Linux native
/dev/discs/disc2/part2  u         24       276   1046808   82  Linux swap
/dev/discs/disc2/part3             0      1020   4237080    5  Whole disk
/dev/discs/disc2/part4           276       399    510942   83  Linux native
/dev/discs/disc2/part6           399       645   1021884   83  Linux native
/dev/discs/disc2/part7           645      1020   1557750   83  Linux native


Looks a little fishy between fdisk and /proc/partitions, but I don't
know enough to say what, or if it is weird for sure.

Aaron

