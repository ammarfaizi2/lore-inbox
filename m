Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBYPYQ>; Sun, 25 Feb 2001 10:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129376AbRBYPX5>; Sun, 25 Feb 2001 10:23:57 -0500
Received: from B112d.pppool.de ([213.7.17.45]:3076 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id <S129363AbRBYPXp>;
	Sun, 25 Feb 2001 10:23:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
Subject: Problem with DMA or agpgart on VIA686a-boards consists with kernel 2.4.2?
Date: Sun, 25 Feb 2001 16:21:20 +0100
X-Mailer: KMail [version 1.2.1]
MIME-Version: 1.0
Message-Id: <01022515592800.00283@athlon>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Used hardware:
AMD Athlon 800
VIA KX133-Chipsatz with AGP

Chipset: ATI 264LT Pro (3D Rage LT Pro) (Port Probed)
Memory:  8192 Kbytes
RAMDAC:  ATI Mach64 integrated 15/16/24/32-bit DAC w/clock
                 (with 6-bit wide lookup tables (or in 6-bit mode))
                 (programmable for 6/8-bit wide lookup tables)
Attached graphics coprocessor:
                Chipset: ATI Mach64
                Memory:  8192 Kbytes


used software-versions:
- Kernel 2.3.x until 2.4.2
- Kernel 2.4test
- activated support for VIA82Cxxx and using DMA by default
- X 3.3.6
- agpgart-module
- glx from sourceforge.net with DMA and agpgart
- reiserfs
- DMA-mode of the hd (WDC WD205AA) is turned on with hdparm and runs 
   in UDMA4-mode.




Hallo all,

I already found in some 2.3-versions or in the 2.4test-versions the following 
problem:
The X-screen suddenly begins blinking and can't be stabilized without 
rebooting the machine (which did not freeze!). A restart of X-Server doesn't 
help. The problem persists.
Unfortunately I couldn't find any error-log. A hint maybe the output of the 
glx.log when started in "damaged" situation (negative benchmarks):

   119:dma buffer transfer speed:
 13698:DmaBenchmark 0xfde00 bytes, 0.010 sec: 97 mb/s
 15092:DmaBenchmark 0xfde00 bytes, -0.019 sec: -51 mb/s
 13647:DmaBenchmark 0xfde00 bytes, 0.010 sec: 103 mb/s

In not damaged situation, you can find something like this:
   119:dma buffer transfer speed:
 20007:DmaBenchmark 0xfde00 bytes, 0.016 sec: 61 mb/s
 10397:DmaBenchmark 0xfde00 bytes, 0.006 sec: 163 mb/s
 10296:DmaBenchmark 0xfde00 bytes, 0.006 sec: 164 mb/s

Some information to glx:
glx provides 3D-functions under X 3.3.6 with my graphic-chip and uses 
therefore DMA and agpgart. glx uses too a "little" file in the 
/tmp-directory, which resides on a reiserfs-partition.

There are no problems with kernel 2.2.x and the special IDE-patches from 
Andre Hedrick.

Now some interesting information perhaps:
The patches from Alan Cox 2.4.1ac9 or ac17 (I didn't test the others) are 
working fine. I couldn't find any problem with these patches.

I would be very appreciated if the related patches of Alan Cox could find 
there way in the official kernel!

Kind regards,
Andreas Hartmann
