Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbTIVAar (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 20:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbTIVAar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 20:30:47 -0400
Received: from freelists-180.iquest.net ([206.53.239.180]:36747 "EHLO
	turing.freelists.org") by vger.kernel.org with ESMTP
	id S262736AbTIVAa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 20:30:26 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: John Madden <weez@freelists.org>
Reply-To: weez@freelists.org
To: linux-kernel@vger.kernel.org
Subject: DAC960: Bad Data Block Found
Date: Sun, 21 Sep 2003 19:30:25 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200309211930.25350.weez@freelists.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there's some place better to post this, please let me know.  Since the 
DAC960 driver has been orphaned, I haven't heard of anyone stepping up to 
take it over, so I don't know where to go for help other than 
linux-kernel.

Basically, the problem here is that I've got a mission-critical box running 
on this controller and I'm starting to get some odd errors.  The 
controller and disks are about 3 years old, so I'm thinking this might be 
an EOL issue but I'm hoping, of course, that that's not the case.  I see 
in my kernel msgs:

DAC960#0: Error Condition MEDIUM ERROR on READ:
DAC960#0:   /dev/rd/c0d0:   absolute blocks 405095..405102
DAC960#0:   /dev/rd/c0d0p1: relative blocks 405032..405039
DAC960#0: Error Condition MEDIUM ERROR on READ:
DAC960#0:   /dev/rd/c0d0:   absolute blocks 405095..405102
DAC960#0:   /dev/rd/c0d0p1: relative blocks 405032..405039
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Bad Data Block Found

Sounds bad, but the drives are still ticking and I haven't noticed any fs 
corruption.  How serious is the error?  Can it be ignored?  Is it time to 
move to another array?  Would dropping everything, scrubbing, and 
restoring be sufficient?

Thanks,
  John


More info: 

Kernel: 2.4.21, stock build
Controller: Mylex 160LP, 16MB

# cat /proc/rd/c0/initial_status 
***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex AcceleRAID 160 PCI RAID Controller
  Firmware Version: 6.00-03, Channels: 1, Memory Size: 16MB
  PCI Bus: 0, Device: 11, Function: 1, I/O Address: Unassigned
  PCI Address: 0xDD000000 mapped at 0xE0800000, IRQ Channel: 16
  Controller Queue Depth: 512, Maximum Blocks per Command: 2048
  Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
  Physical Devices:
    0:0  Vendor: HP        Model: 18.2GB C 80-S60R  Revision: S60R
         Wide Synchronous at 80 MB/sec
         Serial Number:         TEL49262
         Disk Status: Online, 35532800 blocks
    0:1  Vendor: HP        Model: 18.2GB C 80-S60R  Revision: S60R
         Wide Synchronous at 80 MB/sec
         Serial Number:         TEL34793
         Disk Status: Online, 35532800 blocks
    0:2  Vendor: IBM       Model: DDYS-T18350M      Revision: S94N
         Wide Synchronous at 160 MB/sec
         Serial Number:         TEFX1786
         Disk Status: Online, 35807232 blocks
    0:3  Vendor: HP        Model: 18.2GB C 80-S60R  Revision: S60R
         Wide Synchronous at 80 MB/sec
         Serial Number:         TEL34013
         Disk Status: Online, 35532800 blocks
    0:4  Vendor: IBM       Model: DDYS-T18350M      Revision: S94N
         Wide Synchronous at 160 MB/sec
         Serial Number:         4EFTK069
         Disk Status: Online, 35807232 blocks
    0:7  Vendor: MYLEX     Model: AcceleRAID 160    Revision: 0600
         Wide Synchronous at 160 MB/sec
         Serial Number:   
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 142082048 blocks
                  Logical Device Initialized, BIOS Geometry: 255/63
                  Stripe Size: 64KB, Segment Size: 8KB
                  Read Cache Disabled, Write Cache Enabled






-- 
# John Madden  weez@freelists.org
# MailandFiles.com: Your mail, your files: http://www.mailandfiles.com
# FreeLists: Free mailing lists for all: http://www.freelists.org
# Linux, Apache, Perl and C: All the best things in life are free!

