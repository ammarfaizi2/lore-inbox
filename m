Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129857AbRABRZa>; Tue, 2 Jan 2001 12:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129967AbRABRZV>; Tue, 2 Jan 2001 12:25:21 -0500
Received: from mail.radioamp.com ([64.28.86.169]:11026 "EHLO mail.radioamp.com")
	by vger.kernel.org with ESMTP id <S129857AbRABRZJ>;
	Tue, 2 Jan 2001 12:25:09 -0500
User-Agent: Microsoft-Entourage/9.0.2509
Date: Tue, 02 Jan 2001 11:54:40 -0500
Subject: Error with RAID:  Physical Drive 0:1 killed due to SCSI phase
	sequence error 
From: Tim Bithoney <tim@radioamp.com>
To: <linux-kernel@vger.kernel.org>
Message-ID: <B67771FF.253A%tim@radioamp.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens 1 time per week it seems, I can fix it manually by doing Alt-R
and marking all drives as online again. But essentially we lose the RAID
each week because of these sequence errors and then we need to reboot and
fix the RAID card, then its fine for a week.

Here is the relevant info:

Driver:

***** DAC960 RAID Driver Version 2.2.5 of 23 January 2000 *****
Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex DAC960PTL1 PCI RAID Controller
Firmware Version: 4.07-0-29, Channels: 1, Memory Size: 8MB

Kernel:

Linux spica.broadcastme.eng 2.2.14-5.0.14 #1 Sun Mar 26 13:11:01 PST 2000
i686 unknown

Proc:

***** DAC960 RAID Driver Version 2.2.5 of 23 January 2000 *****
Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex DAC960PTL1 PCI RAID Controller
  Firmware Version: 4.07-0-29, Channels: 1, Memory Size: 8MB
  PCI Bus: 0, Device: 10, Function: 1, I/O Address: Unassigned
  PCI Address: 0xDF000000 mapped at 0xD0009000, IRQ Channel: 5
  Controller Queue Depth: 124, Maximum Blocks per Command: 128
  Driver Queue Depth: 123, Maximum Scatter/Gather Segments: 33
  Stripe Size: 64KB, Segment Size: 8KB, BIOS Geometry: 128/32
  Physical Devices:
    0:1  Vendor: QUANTUM   Model: ATLAS IV 18 SCA   Revision: 0808
         Serial Number: 361911132776
         Disk Status: Dead, 35883008 blocks, 1 resets
    0:2  Vendor: QUANTUM   Model: ATLAS IV 18 SCA   Revision: 0808
         Serial Number: 361911134050
         Disk Status: Dead, 35883008 blocks, 1 resets
    0:4  Vendor: QUANTUM   Model: ATLAS IV 18 SCA   Revision: 0808
         Serial Number: 361918430439
         Disk Status: Dead, 35883008 blocks, 1 resets
    0:8  Vendor: QUANTUM   Model: ATLAS IV 18 SCA   Revision: 0808
         Serial Number: 361918430278
         Disk Status: Dead, 35883008 blocks, 1 resets
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Offline, 107649024 blocks, Write Thru
  No Rebuild or Consistency Check in Progress

Logs:

/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:1 killed due to SCSI phase sequence error
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:2 killed due to SCSI phase sequence error
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:4 killed due to SCSI phase sequence error
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:8 killed due to SCSI phase sequence error
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:1 killed because it was removed
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:1 is now DEAD 
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:2 is now DEAD 
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:4 is now DEAD 
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Physical Drive
0:8 is now DEAD 
/var/log/messages.1:Dec 29 19:43:34 spica kernel: DAC960#0: Logical Drive 0
(/dev/rd/c0d0) is now OFFLINE
/var/log/messages.1:Dec 29 19:43:44 spica kernel: DAC960#0: Physical Drive
0:2 killed because it was removed
/var/log/messages.1:Dec 29 19:43:44 spica kernel: DAC960#0: Physical Drive
0:4 killed because it was removed
/var/log/messages.1:Dec 29 19:43:54 spica kernel: DAC960#0: Physical Drive
0:8 killed because it was removed

-- 

Tim Bithoney                      |  31 Saint James Avenue  Suite 925
Director of Technical Operations  |  Boston, MA 02116
Radio Active Media Partners       |  617-654-9009 ext. 26 or 617-967-1776

                 "Who want's to ROCK?!?" -- Clutch

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
