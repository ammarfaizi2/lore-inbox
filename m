Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293191AbSB1OCZ>; Thu, 28 Feb 2002 09:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293335AbSB1OAA>; Thu, 28 Feb 2002 09:00:00 -0500
Received: from [195.239.244.122] ([195.239.244.122]:7187 "EHLO mail.tibc.ru")
	by vger.kernel.org with ESMTP id <S293390AbSB1N6x>;
	Thu, 28 Feb 2002 08:58:53 -0500
Date: Thu, 28 Feb 2002 16:58:41 +0300
From: shura <shura@tibc.ru>
X-Mailer: The Bat! (v1.00 Build 1311) Registered to Andy Malyshev
Reply-To: shura <shura@tibc.ru>
Organization: TIBC
Message-ID: <8707.020228@tibc.ru>
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm setting up a new machine with a pair of IDE drives connected to
HPT 370 controller. I defined a RAID-1 array using the HPT370 bios
setting utility.
Description - hard:
motherboard Abit ST6-RAID, HPT370, 2 identical hard disks as
primary/secondary master on ide3/ide4
- bios:
Primary Master:   Mirror (Raid 1) for Array #0 UDMA 5 78150 BOOT
Primary Slave:    No drive
Secondary Master: Mirror (Raid 1) for Array #0 UDMA 5 78150 HIDDEEN
Secondary Slave:  No drive
- os:
Linux RedHat 7.1 & kernel 2.4.17
with compilation option
CONFIG_BLK_DEV_ATARAID_HPT=y
Lilo:
...
root=/dev/hde10
...

During system booting i see following
...
ataraid/d0: ataraid/d0p1 ataraid/d0p2 ataraid/d0p3 ataraid/d0p4 <>
Highpoint HPT370 Softwareraid driver for linux version 0.01
Drive 0 is 76319 Mb
Drive 6 is 76319 Mb
Raid array consists of 2 drivers
...
Kernel panic: VFS: Unable to mount root fs on 21:0a
...

And system stop

Booting with option root=/dev/atarad/d0p1 ro
(or root=/dev/ataraid/d0p10 ro)
and etc - no effect

Any hints?

