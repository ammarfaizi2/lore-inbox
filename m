Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318359AbSGYIWJ>; Thu, 25 Jul 2002 04:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318366AbSGYIWJ>; Thu, 25 Jul 2002 04:22:09 -0400
Received: from viefep13-int.chello.at ([213.46.255.15]:2864 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id <S318359AbSGYIWI>; Thu, 25 Jul 2002 04:22:08 -0400
Message-Id: <5.0.2.1.2.20020725101620.01ccb0a0@pop.tvnet.hu>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Thu, 25 Jul 2002 10:19:21 +0100
To: linux-kernel@vger.kernel.org
From: Newsmail <newsmail@satimex.tvnet.hu>
Subject: cmd680 problem in 2.4.19-rc3-ac3
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I just bought a new kouwell udma133+raid (KW-571B) card that has a cmd680 
chip on it.
the card detects nicely my HDs, but after when linux boots I get something 
like this:

Jul 23 18:43:28 wk kernel: hdi: IC35L120AVVA07-0, ATA DISK drive
Jul 23 18:43:28 wk kernel: hdj: 2AIC35L120AVVA07-0, ATA DISK drive

Jul 23 18:43:28 wk kernel: hdi: host protected area => 
1
Jul 23 18:43:28 wk kernel: hdi: 241254720 sectors (123522 MB) w/1863KiB 
Cache, CHS=239340/16/63, UDMA(100)
Jul 23 18:43:28 wk kernel: hdj: task_no_data_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 23 18:43:28 wk kernel: hdj: task_no_data_intr: error=0x04 { 
DriveStatusError }
Jul 23 18:43:28 wk kernel: hdj: setmax_ext LBA 1, 
native  0
Jul 23 18:43:28 wk kernel: hdj: 0 sectors (0 MB) w/1KiB Cache, 
CHS=0/255/63, DMA
Jul 23 18:43:28 wk kernel: hdj: set_multmode: status=0x51 { DriveReady 
SeekComplete Error }

both HDs are the same IBM120GXP drives. both are perfect, for sure. after 
this, I tried this controller card with some maxtor drives. then I got this:

Jul 23 18:43:28 wk kernel: hde: MAXTOR 4K080H4, ATA DISK drive
Jul 23 18:43:28 wk kernel: hdf: 00MAXTOR 4K080H4, ATA DISK drive

Jul 23 18:43:28 wk kernel: hde: host protected area => 
1
Jul 23 18:43:28 wk kernel: hde: 156301488 sectors (80026 MB) w/2000KiB 
Cache, CHS=155061/16/63, UDMA(100)
Jul 23 18:43:28 wk kernel: hdf: task_no_data_intr: status=0x53 { DriveReady 
SeekComplete Index Error }
Jul 23 18:43:28 wk kernel: hdf: task_no_data_intr: error=0x04 { 
DriveStatusError }
Jul 23 18:43:28 wk kernel: hdf: -122814464 sectors (2136142 MB) w/1KiB 
Cache, CHS=259704/255/63, DMA
Jul 23 18:43:28 wk kernel: hdf: set_multmode: status=0x51 { DriveReady 
SeekComplete Error }
Jul 23 18:43:28 wk kernel: hdf: set_multmode: error=0x04 { DriveStatusError 
}

In both cases the SLAVE drive wasnt detected correctly, and after reported 
errors. after I tried this out with another card from the same brand, I 
tried primary and secondary channel, no luck, I got these same sypmtoms. 
all drives worked perfect with promise controllers.
the kernel I used: 2.4.19-rc3-ac3.
I use an asus cuv4x-d motherboard, with 2 pIII 850.
I hope these informations are enough,
best wishes,
greg



