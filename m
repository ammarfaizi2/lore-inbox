Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbUCCTnW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUCCTnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:43:21 -0500
Received: from butters.phys.uwm.edu ([129.89.57.31]:40635 "EHLO
	butters.phys.uwm.edu") by vger.kernel.org with ESMTP
	id S262561AbUCCTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:43:04 -0500
Date: Wed, 3 Mar 2004 13:43:03 -0600 (CST)
From: Paul Armor <parmor@gravity.phys.uwm.edu>
X-X-Sender: parmor@butters.phys.uwm.edu
To: linux-kernel@vger.kernel.org
Subject: SCSI Abort kernel messages while moving lots of data on external
 RAID enclosure.
In-Reply-To: <Pine.LNX.4.44.0403031301380.2787-100000@butters.phys.uwm.edu>
Message-ID: <Pine.LNX.4.44.0403031340190.2787-100000@butters.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
sorry, I forgot to put a subject in my original post.

Thanks!
Paul

On Wed, 3 Mar 2004, Paul Armor wrote:

> Hi,
> Can anyone offer opinions as to what may be going wrong here.  I've put 
> info for the config in question at the bottom, and I'll have a snippet of 
> the kernel errors I've seen placed before the config.  In short, I'm in 
> the process of trying to recover from a crash, and to backup data I'm 
> dd-ing large sections of data between partitions.  After about 20 hours 
> of dd-ing, I got this error this morning.  (note I'd been seeing similar 
> error msgs right before the crash, but I've since updated the F/W on the 
> the Promise boxes and not seen these errors in some time)
> 
> <snip>
> Mar  3 09:42:04 storage2 kernel: scsi0:0:2:0: Attempting to queue an ABORT 
> message
> Mar  3 09:42:04 storage2 kernel: CDB: 0x2a 0x0 0x7c 0x34 0x9b 0x46 0x0 0x3 
> 0x30 0x0
> Mar  3 09:42:04 storage2 kernel: scsi0: At time of recovery, card was not 
> paused
> Mar  3 09:42:04 storage2 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins 
> <<<<<<<<<<<<<<<<<
> Mar  3 09:42:04 storage2 kernel: scsi0: Dumping Card State while idle, at 
> SEQADDR 0x8
> Mar  3 09:42:04 storage2 kernel: Card was paused
> Mar  3 09:42:04 storage2 kernel: ACCUM = 0x0, SINDEX = 0x4a, DINDEX = 
> 0xe4, ARG_2 = 0x0
> Mar  3 09:42:04 storage2 kernel: HCNT = 0x0 SCBPTR = 0x5
> Mar  3 09:42:04 storage2 kernel: SCSIPHASE[0x0] SCSISIGI[0x0] ERROR[0x0] 
> SCSIBUSL[0x0] 
> Mar  3 09:42:04 storage2 kernel: LASTPHASE[0x1] SCSISEQ[0x12] SBLKCTL[0x6] 
> SCSIRATE[0x0] 
> Mar  3 09:42:04 storage2 kernel: SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] 
> SSTAT1[0x8] 
> Mar  3 09:42:04 storage2 kernel: SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x8] 
> SIMODE1[0xa4] 
> Mar  3 09:42:04 storage2 kernel: SXFRCTL0[0x80] DFCNTRL[0x0] 
> DFSTATUS[0x89] 
> Mar  3 09:42:04 storage2 kernel: STACK: 0x0 0x163 0x109 0x3
> Mar  3 09:42:06 storage2 kernel: SCB count = 254
> Mar  3 09:42:06 storage2 kernel: Kernel NEXTQSCB = 99
> Mar  3 09:42:06 storage2 kernel: Card NEXTQSCB = 99
> Mar  3 09:42:06 storage2 kernel: QINFIFO entries: 
> Mar  3 09:42:06 storage2 kernel: Waiting Queue entries: 
> Mar  3 09:42:06 storage2 kernel: Disconnected Queue entries: 27:109 2:27 
> 11:198 26:120 8:190 21:129 31:203 0:248 24:0 10:33 7:24 3:52 
> Mar  3 09:42:06 storage2 kernel: QOUTFIFO entries: 
> Mar  3 09:42:06 storage2 kernel: Sequencer Free SCB List: 5 28 22 9 29 30 
> 1 17 23 6 14 16 12 15 20 25 4 13 19 18 
> </snip> 
> 
> 
> 
> 
> Configuration:
> 
> motherboard - 		Asus A7M266
> 
> kernel - 		linux-2.4.24
> 
> controller - 		Adaptec AIC7xxx driver version: 6.2.36
> 	 		Adaptec 29160 Ultra160 SCSI adapter
> 			aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
> 
> ext. RAID arrays -	4 x Promise UltraTrak SX8000
> 			F/W version 1.1.0.30 (2/4/2003)
> 
> Each box has three partitions
> 
> We're running software raid 0 striping across the 4 boxes such that 
>     md0=sd[abcd]1, md1=sd[abcd]2, md2=sd[abcd]3.
> 
> 
> Thanks!
> Paul
> 

