Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316589AbSFKAaa>; Mon, 10 Jun 2002 20:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSFKAaa>; Mon, 10 Jun 2002 20:30:30 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:22278 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S316582AbSFKAa2>;
	Mon, 10 Jun 2002 20:30:28 -0400
Message-ID: <3D054432.88C5BE59@torque.net>
Date: Mon, 10 Jun 2002 20:28:34 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: fdisk on scsi disks in 2.5.21
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ fdisk -l /dev/sda

Disk /dev/sda: 1 heads, 35843670 sectors, 1 cylinders
Units = cylinders of 35843670 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1         1     32098+  83  Linux
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(0, 1, 1) logical=(0, 0, 64)
Partition 1 has different physical/logical endings:
     phys=(3, 254, 63) logical=(0, 0, 64260)
Partition 1 does not end on cylinder boundary:
     phys=(3, 254, 63) should be (3, 0, 35843670)
/dev/sda2             1         1    168682+  83  Linux
Partition 2 has different physical/logical beginnings (non-Linux?):
     phys=(4, 0, 1) logical=(0, 0, 64261)
Partition 2 has different physical/logical endings:
     phys=(24, 254, 63) logical=(0, 0, 401625)
Partition 2 does not end on cylinder boundary:
     phys=(24, 254, 63) should be (24, 0, 35843670)
....

One head, one cylinder and lots of sectors??
I put some debug in drivers/scsi/scsicam.c and it doesn't
seem like it was called.

Is my fdisk (from RH 7.2) too old?

Doug Gilbert
