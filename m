Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271575AbRHUHDf>; Tue, 21 Aug 2001 03:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271578AbRHUHD0>; Tue, 21 Aug 2001 03:03:26 -0400
Received: from [217.27.32.7] ([217.27.32.7]:14528 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S271575AbRHUHDP>;
	Tue, 21 Aug 2001 03:03:15 -0400
Date: Tue, 21 Aug 2001 09:53:47 +0300
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.8] high load with disk operations
Message-ID: <20010821095347.A14337@francoudi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux leonid.francoudi.com 2.4.8-lm1
X-Uptime: 9:32am  up 4 days, 18:07,  7 users,  load average: 1.31, 1.28, 0.86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I have noticed that with kernel 2.4.8 my machine gets high load average
while perfoming disk operations like copying/moving some files.
Usually, my load average is 0.00 or 0.01 :) , but when I start copying
~200 MB from one disk to another, load average goes up to 2.50.  

My machine is PIII 664MHz, 128 MB RAM, 256 MB swap.

IDE devices:
hda: WDC WD100AA, ATA DISK drive
hdc: CREATIVECD-RW RW121032E, ATAPI CD/DVD-ROM drive
hdd: Compaq CRD-8402B, ATAPI CD/DVD-ROM drive

Partition table of /dev/hda:
[root@leonid /root]# fdisk -l /dev/hda

Disk /dev/hda: 240 heads, 63 sectors, 1292 cylinders
Units = cylinders of 15120 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
   /dev/hda1             1        33    249448+   5  Extended
   /dev/hda2            34       574   4089960   83  Linux
   /dev/hda3   *       575      1292   5428080   83  Linux
   /dev/hda5             1        33    249417   82  Linux swap
   

Is there any patch I should try?
TIA

-- 
 Best regards,
 Leonid Mamtchenkov
 Red Hat Certified Linux Engineer (RHCE)
 System Administrator
 Francoudi & Stephanou Ltd

