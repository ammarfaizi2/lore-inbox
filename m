Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319583AbSIMU6A>; Fri, 13 Sep 2002 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319766AbSIMU6A>; Fri, 13 Sep 2002 16:58:00 -0400
Received: from momus.sc.intel.com ([143.183.152.8]:14049 "EHLO
	momus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S319583AbSIMU57>; Fri, 13 Sep 2002 16:57:59 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470580D1AE@hdsmsx103.hd.intel.com>
From: "Cress, Andrew R" <andrew.r.cress@intel.com>
To: "'Helge Hafting'" <helge.hafting@broadpark.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: 2.5.34 unable to mount root fs on 09:00 (smp,raid1,devfs,scsi
	)
Date: Fri, 13 Sep 2002 14:02:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge,

You've probably already checked this, but is  CONFIG_BLK_DEV_MD=y ?
It won't work if you have a root mirror and this is a configured as a
module.

Andy Cress

-----Original Message-----
From: Helge Hafting [mailto:helge.hafting@broadpark.no] 
Sent: Thursday, September 12, 2002 1:24 PM
To: Linux Kernel Mailing List
Subject: 2.5.34 unable to mount root fs on 09:00 (smp,raid1,devfs,scsi)

2.5.33 works. 2.5.34 and 2.5.34-bk3 won't mount the
root fs.  The root fs is on /dev/md/1, composed
of 2 partitions on different scsi disks.

The RAID-1 setup is autodetected, so it don't look
like a hardware or scsi problem.  Everything seems normal
until the root mount fail and the kernel hangs.  Not
even sysrq works after that.

Helge Hafting
-

