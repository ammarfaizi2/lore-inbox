Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266746AbRG1O6n>; Sat, 28 Jul 2001 10:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266688AbRG1O6c>; Sat, 28 Jul 2001 10:58:32 -0400
Received: from pixie.isr.ist.utl.pt ([193.136.138.97]:1796 "EHLO
	pixie.isr.ist.utl.pt") by vger.kernel.org with ESMTP
	id <S266710AbRG1O62>; Sat, 28 Jul 2001 10:58:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.4.7 and VIA IDE
Content-Type: text/plain; charset=US-ASCII
From: Rodrigo Ventura <yoda@isr.ist.utl.pt>
Date: 28 Jul 2001 15:58:22 +0100
Message-ID: <lxvgkddrsh.fsf@pixie.isr.ist.utl.pt>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


        Hi. I've just upgraded my box to 2.4.7 and suse 7.1. I've just
got this messages in dmesg after a bootup:

------------------------------------------------------------
Linux version 2.4.7 (root@pixie) (gcc version 2.95.2 19991024 (release)) #3 Fri 
Jul 27 14:49:02 WEST 2001
[...]
CPU: AMD-K6(tm) 3D processor stepping 0c
[...]
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 90845U2, ATA DISK drive
hdc: SAMSUNG CD-ROM SC-148F, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 16514064 sectors (8455 MB) w/2048KiB Cache, CHS=1027/255/63, UDMA(33)
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
[...]
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 184k freed
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Adding Swap: 265064k swap-space (priority -1)
[...]
eth0: using NWAY device table, not 8
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative ViBRA16C PnP detected
[...]
------------------------------------------------------------

The output of hdparm /dev/hda is:

------------------------------------------------------------
/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1027/255/63, sectors = 16514064, start = 0
------------------------------------------------------------

and of hdparm -i /dev/hda is:

------------------------------------------------------------
/dev/hda:

 Model=Maxtor 90845U2, FwRev=FA550480, SerialNo=E20BW5GC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16514064
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 
 Drive Supports : ATA/ATAPI-4 T13 1153D revision 17 : ATA-1 ATA-2 ATA-3 ATA-4 AT
A-5 
 Kernel Drive Geometry LogicalCHS=1027/255/63 PhysicalCHS=16383/16/63
------------------------------------------------------------

        Any clue of what's happening?

        Cheers,

-- 

*** Rodrigo Martins de Matos Ventura <yoda@isr.ist.utl.pt>
***  Web page: http://www.isr.ist.utl.pt/~yoda
***   Teaching Assistant and PhD Student at ISR:
***    Instituto de Sistemas e Robotica, Polo de Lisboa
***     Instituto Superior Tecnico, Lisboa, PORTUGAL
*** PGP fingerprint = 0119 AD13 9EEE 264A 3F10  31D3 89B3 C6C4 60C6 4585
