Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270189AbTGUQDX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270472AbTGUQDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:03:23 -0400
Received: from 69.Red-217-126-207.pooles.rima-tde.net ([217.126.207.69]:51462
	"EHLO server01.nullzone.prv") by vger.kernel.org with ESMTP
	id S270189AbTGUQAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:00:31 -0400
Message-Id: <5.2.1.1.2.20030721173557.00d56450@192.168.2.130>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 21 Jul 2003 18:15:32 +0200
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Problems with IDE - Ultra-ATA devices on a SiI chipset IDE
  controler
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there.

    I have a production server with a SiI680 pci device beeing used as a 
IDE controler.
    Conected to the external IDE controler I have 4 120GB IDE disks just in 
raid5 Linux-software mode.

Well, I have detected some problems that i cannot understand (I am not a 
expert so ... :-( ) ...
( I was using a HighPoint some time ago which gave me the same problems. I 
though I had got to fix the problems getting a new IDE controler but its 
coming back and ... i prefer to fix the problem before I lose more 
information (critical one) as i got after these last problems).

I am getting problems in the ide-buses (I guess).

a) I have cheked the 4 HD just doing:

badblocks -b 4096 -o /tmp/hde_badblocks /dev/hde
badblocks -b 4096 -o /tmp/hdf_badblocks /dev/hdf
badblocks -b 4096 -o /tmp/hdg_badblocks /dev/hdg
badblocks -b 4096 -o /tmp/hdh_badblocks /dev/hdh

and all is OK so i think its a problem in the IDE controler or just in the 
driver (I am not sure).

b) the cables are new. I got new cables (certificated) when i got the 
HighPoint out just with the same problems (resets on IDE buses ...).
The IDE controler is new too.

Please, could any help me a bit?
Please...

Could be the problem the temperature in the Box?

(My english is terrible .. please sorry me).

------------------------------------------------------------------------------------------
I will add this info:

1- Log with the problems detected by the kernel (paste)
2- System information (from boot logs)
----

1 *** Problems logs:

Jul 20 00:00:57 server01 kernel: hdf: dma_timer_expiry: dma status == 0x60
Jul 20 00:00:57 server01 kernel: hdf: timeout waiting for DMA
Jul 20 00:00:57 server01 kernel: hdf: timeout waiting for DMA
Jul 20 00:00:57 server01 kernel: hdh: dma_timer_expiry: dma status == 0x61
Jul 20 00:01:07 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:01:07 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:08 server01 kernel: hdh: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:08 server01 kernel: hdh: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:08 server01 kernel: hdg: DMA disabled
Jul 20 00:01:09 server01 kernel: ide3: reset: success
Jul 20 00:01:17 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 20 00:01:27 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:01:27 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:01:27 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 00:01:27 server01 kernel:
Jul 20 00:01:27 server01 kernel: hdf: drive not ready for command
Jul 20 00:01:27 server01 kernel: hde: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:27 server01 kernel: hde: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:27 server01 kernel: hde: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:27 server01 kernel: hde: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:28 server01 kernel: hde: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:28 server01 kernel: hde: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:28 server01 kernel: hde: read_intr: status=0x51 { DriveReady 
SeekComplete Error }
Jul 20 00:01:28 server01 kernel: hde: read_intr: error=0x04 { 
DriveStatusError }
Jul 20 00:01:28 server01 kernel: ide2: reset: success
Jul 20 00:01:28 server01 kernel: blk: queue c02c8e08, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 20 00:01:29 server01 kernel: hdh: dma_timer_expiry: dma status == 0x41
Jul 20 00:01:39 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:01:39 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:01:39 server01 kernel: hdg: status error: status=0x7f { 
DriveReady DeviceFault SeekComplete DataRequest CorrectedError Ind
ex Error }
Jul 20 00:01:39 server01 kernel: hdg: status error: error=0x7f { 
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFo
und AddrMarkNotFound }, LBAsect=8830695997311, high=526350, low=8355711, 
sector=62666160
Jul 20 00:01:39 server01 kernel: hdg: drive not ready for command
Jul 20 00:01:39 server01 kernel: ide3: reset: success
Jul 20 00:01:39 server01 kernel: blk: queue c02c93c8, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 20 00:01:48 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 20 00:01:58 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:01:58 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:01:59 server01 kernel: hdh: dma_timer_expiry: dma status == 0x41
Jul 20 00:02:08 server01 kernel: hdf: lost interrupt
Jul 20 00:02:08 server01 kernel: blk: queue c02c8f54, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 20 00:02:08 server01 kernel: hdf: dma_intr: status=0x40 { DriveReady }
Jul 20 00:02:08 server01 kernel:
Jul 20 00:02:08 server01 kernel: hdf: dma_intr: status=0x40 { DriveReady }
Jul 20 00:02:08 server01 kernel:
Jul 20 00:02:08 server01 kernel: hdf: dma_intr: status=0x40 { DriveReady }
Jul 20 00:02:08 server01 kernel:
Jul 20 00:02:08 server01 kernel: hdf: dma_intr: status=0x40 { DriveReady }
Jul 20 00:02:08 server01 kernel:
Jul 20 00:02:08 server01 kernel: hdf: DMA disabled
Jul 20 00:02:08 server01 kernel: ide2: reset: success
Jul 20 00:02:09 server01 kernel: blk: queue c02c8e08, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 20 00:02:09 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:02:09 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:02:09 server01 kernel: blk: queue c02c93c8, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 20 00:02:29 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 20 00:02:29 server01 kernel: hdh: dma_timer_expiry: dma status == 0x41
Jul 20 00:02:39 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:02:39 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:02:39 server01 kernel: hdf: status error: status=0x7f { 
DriveReady DeviceFault SeekComplete DataRequest CorrectedError Ind
ex Error }
Jul 20 00:02:39 server01 kernel: hdf: status error: error=0x7f { 
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFo
und AddrMarkNotFound }, LBAsect=149568947698815, high=8915003, 
low=16727167, sector=62669312
Jul 20 00:02:39 server01 kernel: hdf: drive not ready for command
Jul 20 00:02:39 server01 kernel: ide2: reset: success
Jul 20 00:02:39 server01 kernel: blk: queue c02c8e08, I/O limit 4095Mb 
(mask 0xffffffff)
Jul 20 00:02:39 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:02:39 server01 kernel: hdh: timeout waiting for DMA
Jul 20 00:02:39 server01 kernel: hdg: status error: status=0x7f { 
DriveReady DeviceFault SeekComplete DataRequest CorrectedError Ind
ex Error }
Jul 20 00:02:39 server01 kernel: hdg: status error: error=0x7f { 
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFo
und AddrMarkNotFound }, LBAsect=8831518080895, high=526399, low=8355711, 
sector=62656544
Jul 20 00:02:39 server01 kernel: hdg: drive not ready for command
Jul 20 00:02:40 server01 kernel: ide3: reset: success
Jul 20 00:02:59 server01 kernel: hde: dma_timer_expiry: dma status == 0x21
Jul 20 00:03:09 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:03:09 server01 kernel: hde: timeout waiting for DMA
Jul 20 00:03:09 server01 kernel: hde: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jul 20 00:03:09 server01 kernel:
Jul 20 00:03:09 server01 kernel: hde: drive not ready for command
Jul 20 00:03:09 server01 kernel: hde: status timeout: status=0xd0 { Busy }
Jul 20 00:03:09 server01 kernel:
Jul 20 00:03:09 server01 kernel: hde: no DRQ after issuing WRITE
Jul 20 00:03:10 server01 kernel: ide2: reset: success
Jul 20 00:03:12 server01 kernel: is_tree_node: node level 89 does not match 
to the expected one 1
Jul 20 00:03:12 server01 kernel: vs-5150: search_by_key: invalid format 
found in block 16938917. Fsck?
Jul 20 00:03:12 server01 kernel: vs-13070: reiserfs_read_inode2: i/o 
failure occurred trying to find stat data of [29810 29818 0x0 S
D]
Jul 20 00:03:12 server01 kernel: is_tree_node: node level 0 does not match 
to the expected one 1
Jul 20 00:03:12 server01 kernel: vs-5150: search_by_key: invalid format 
found in block 16939041. Fsck?
Jul 20 00:03:12 server01 kernel: vs-13070: reiserfs_read_inode2: i/o 
failure occurred trying to find stat data of [29737 29745 0x0 S
D]
Jul 20 00:03:12 server01 kernel: is_tree_node: node level 65 does not match 
to the expected one 1
Jul 20 00:03:12 server01 kernel: vs-5150: search_by_key: invalid format 
found in block 16939427. Fsck?

-- <- PROBLEMS in ReiserFS here (generated by the IDE failures). Got the 
info back doing a --rebuild.tree but ... what are the names of the files?? 
i dont know ...

Jul 20 01:10:38 server01 kernel:
Jul 20 01:10:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:10:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:10:38 server01 kernel:
Jul 20 01:10:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:10:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:10:38 server01 kernel:
Jul 20 01:10:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:10:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:10:38 server01 kernel:
Jul 20 01:10:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:10:38 server01 kernel: ide2: reset: success
Jul 20 01:30:39 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:30:39 server01 kernel:
Jul 20 01:30:39 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:30:39 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:30:39 server01 kernel:
Jul 20 01:30:39 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:30:39 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:30:39 server01 kernel:
Jul 20 01:30:39 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:30:39 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:30:39 server01 kernel:
Jul 20 01:30:39 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:30:39 server01 kernel: ide2: reset: success
Jul 20 01:40:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:40:38 server01 kernel:
Jul 20 01:40:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:40:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:40:38 server01 kernel:
Jul 20 01:40:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:40:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:40:38 server01 kernel:
Jul 20 01:40:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:40:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 01:40:38 server01 kernel:
Jul 20 01:40:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 01:40:38 server01 kernel: ide2: reset: success
Jul 20 02:05:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 02:05:38 server01 kernel:
Jul 20 02:05:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 02:05:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 02:05:38 server01 kernel:
Jul 20 02:05:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 02:05:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 02:05:38 server01 kernel:
Jul 20 02:05:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 02:05:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 02:05:38 server01 kernel:
Jul 20 02:05:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 02:05:38 server01 kernel: ide2: reset: success
Jul 20 08:25:11 server01 kernel: is_tree_node: node level 80 does not match 
to the expected one 1
Jul 20 08:25:11 server01 kernel: vs-5150: search_by_key: invalid format 
found in block 17561769. Fsck?
Jul 20 08:25:11 server01 kernel: zam-7001: io error in reiserfs_find_entry

-- <- more and more logs about ReiserFS consistence. Needing a fsck..

Jul 20 09:45:37 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 09:45:37 server01 kernel:
Jul 20 09:45:37 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 09:45:37 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 09:45:37 server01 kernel:
Jul 20 09:45:37 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 09:45:37 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 09:45:37 server01 kernel:
Jul 20 09:45:37 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 09:45:37 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 09:45:37 server01 kernel:
Jul 20 09:45:37 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 09:45:37 server01 kernel: ide2: reset: success
--
Jul 20 11:35:06 server01 kernel: hdf: read_intr: status=0x59 { DriveReady 
SeekComplete DataRequest Error }
Jul 20 11:35:06 server01 kernel: hdf: read_intr: error=0x10 { 
SectorIdNotFound }, LBAsect=46433302, high=2, low=12878870, sector=464
33248
--
Jul 20 11:50:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 11:50:38 server01 kernel:
Jul 20 11:50:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 11:50:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 11:50:38 server01 kernel:
Jul 20 11:50:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 11:50:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 11:50:38 server01 kernel:
Jul 20 11:50:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 11:50:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 11:50:38 server01 kernel:
Jul 20 11:50:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 11:50:38 server01 kernel: ide2: reset: success
--
Jul 20 12:00:39 server01 kernel: hde: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jul 20 12:00:39 server01 kernel:
Jul 20 12:00:39 server01 kernel: hde: drive not ready for command
Jul 20 12:00:39 server01 kernel: hde: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 12:00:39 server01 kernel:
Jul 20 12:00:39 server01 kernel: hde: no DRQ after issuing WRITE
Jul 20 12:00:39 server01 kernel: hde: status timeout: status=0xd0 { Busy }
Jul 20 12:00:39 server01 kernel:
Jul 20 12:00:39 server01 kernel: hde: drive not ready for command
Jul 20 12:00:39 server01 kernel: ide2: reset: success
--
Jul 20 12:20:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 12:20:38 server01 kernel:
Jul 20 12:20:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 12:20:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 12:20:38 server01 kernel:
Jul 20 12:20:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 12:20:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 12:20:38 server01 kernel:
Jul 20 12:20:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 12:20:38 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 12:20:38 server01 kernel:
Jul 20 12:20:38 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 12:20:38 server01 kernel: ide2: reset: success
--
more and more about hdf
--
Jul 20 15:10:38 server01 kernel: hde: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jul 20 15:10:38 server01 kernel:
Jul 20 15:10:38 server01 kernel: hde: drive not ready for command
Jul 20 15:10:38 server01 kernel: hde: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 15:10:38 server01 kernel:
Jul 20 15:10:38 server01 kernel: hde: no DRQ after issuing WRITE
Jul 20 15:10:38 server01 kernel: hde: status timeout: status=0xd0 { Busy }
Jul 20 15:10:38 server01 kernel:
Jul 20 15:10:38 server01 kernel: hde: drive not ready for command
Jul 20 15:10:38 server01 kernel: ide2: reset: success
Jul 20 15:20:03 server01 kernel: hde: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jul 20 15:20:03 server01 kernel:
Jul 20 15:20:03 server01 kernel: hde: drive not ready for command
Jul 20 15:20:03 server01 kernel: hde: status timeout: status=0xd0 { Busy }
Jul 20 15:20:03 server01 kernel:
Jul 20 15:20:03 server01 kernel: hde: no DRQ after issuing WRITE
Jul 20 15:20:03 server01 kernel: ide2: reset: success
--


and so on ....

AT THE FINISH hdf goes out of raid5:


Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x58 { 
DriveReady SeekComplete DataRequest }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x50 { 
DriveReady SeekComplete }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: no DRQ after issuing WRITE
Jul 20 17:16:34 server01 kernel: ide2: reset: success
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: ide2: reset: success
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: end_request: I/O error, dev 21:41 (hdf), 
sector 11464
Jul 20 17:16:34 server01 kernel: raid5: Disk failure on hdf1, disabling 
device. Operation continuing on 3 devices
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: hdf: status error: status=0x00 { }
Jul 20 17:16:34 server01 kernel:
Jul 20 17:16:34 server01 kernel: hdf: drive not ready for command
Jul 20 17:16:34 server01 kernel: md: updating md0 RAID superblock on device
Jul 20 17:16:34 server01 kernel: md: hdh1 [events: 0000000f]<6>(write) 
hdh1's sb offset: 117218176
Jul 20 17:16:34 server01 kernel: md: recovery thread got woken up ...
Jul 20 17:16:34 server01 kernel: md0: no spare disk to reconstruct array! 
-- continuing in degraded mode
Jul 20 17:16:34 server01 kernel: md: recovery thread finished ...
Jul 20 17:16:34 server01 kernel: md: hdg1 [events: 0000000f]<6>(write) 
hdg1's sb offset: 117218176
Jul 20 17:16:34 server01 kernel: md: (skipping faulty hdf1 )
Jul 20 17:16:34 server01 kernel: md: hde1 [events: 0000000f]<6>(write) 
hde1's sb offset: 117218176
Jul 20 17:16:34 server01 kernel: ide2: reset: success

<- HERE (17:22:12) i come back from my vacations (just in time!) and reset 
the system.

i have re-add the ide device to the Raid and all is perfect (by the moment 
...).

--------------------------------------------------------------------------------------------------------------

2 *** System Information:

Jul  7 21:31:49 server01 kernel: Detected 1002.298 MHz processor.
Jul  7 21:31:49 server01 kernel: Memory: 127380k/131072k available
--
Jul  7 21:31:49 server01 kernel: Intel machine check architecture supported.
Jul  7 21:31:49 server01 kernel: Intel machine check reporting enabled on 
CPU#0.
--
Jul  7 21:31:49 server01 kernel: CPU: Intel Celeron (Coppermine) stepping 0a
--
Jul  7 21:31:49 server01 kernel: SiI680: IDE controller at PCI slot 00:09.0
Jul  7 21:31:49 server01 kernel: PCI: Found IRQ 11 for device 00:09.0
Jul  7 21:31:49 server01 kernel: SiI680: chipset revision 2
Jul  7 21:31:49 server01 kernel: SiI680: not 100%% native mode: will probe 
irqs later
Jul  7 21:31:49 server01 kernel: SiI680: BASE CLOCK == 100
--
Jul  7 21:31:49 server01 kernel:     ide2: MMIO-DMA , BIOS settings: 
hde:pio, hdf:pio
Jul  7 21:31:49 server01 kernel:     ide3: MMIO-DMA , BIOS settings: 
hdg:pio, hdh:pio
Jul  7 21:31:49 server01 kernel: hde: ST3120022A, ATA DISK drive
Jul  7 21:31:49 server01 kernel: hdf: ST3120022A, ATA DISK drive
Jul  7 21:31:49 server01 kernel: blk: queue c02c8e08, I/O limit 4095Mb 
(mask 0xffffffff)
Jul  7 21:31:49 server01 kernel: blk: queue c02c8f54, I/O limit 4095Mb 
(mask 0xffffffff)
Jul  7 21:31:49 server01 kernel: hdg: IC35L120AVV207-0, ATA DISK drive
Jul  7 21:31:49 server01 kernel: hdh: ST3120022A, ATA DISK drive
Jul  7 21:31:49 server01 kernel: blk: queue c02c927c, I/O limit 4095Mb 
(mask 0xffffffff)
Jul  7 21:31:49 server01 kernel: blk: queue c02c93c8, I/O limit 4095Mb 
(mask 0xffffffff)
Jul  7 21:31:49 server01 kernel: ide2 at 0xc8818080-0xc8818087,0xc881808a 
on irq 11
Jul  7 21:31:49 server01 kernel: ide3 at 0xc88180c0-0xc88180c7,0xc88180ca 
on irq 11
--
Jul  7 21:31:49 server01 kernel: hde: attached ide-disk driver.
Jul  7 21:31:49 server01 kernel: hde: host protected area => 1
Jul  7 21:31:49 server01 kernel: hde: 234441648 sectors (120034 MB) 
w/2048KiB Cache, CHS=14593/255/63, UDMA(100)
Jul  7 21:31:49 server01 kernel: hdf: attached ide-disk driver.
Jul  7 21:31:49 server01 kernel: hdf: host protected area => 1
Jul  7 21:31:49 server01 kernel: hdf: 234441648 sectors (120034 MB) 
w/2048KiB Cache, CHS=14593/255/63, UDMA(100)
Jul  7 21:31:49 server01 kernel: hdg: attached ide-disk driver.
Jul  7 21:31:49 server01 kernel: hdg: host protected area => 1
Jul  7 21:31:49 server01 kernel: hdg: 241254720 sectors (123522 MB) 
w/1821KiB Cache, CHS=15017/255/63, UDMA(100)
Jul  7 21:31:49 server01 kernel: hdh: attached ide-disk driver.
Jul  7 21:31:49 server01 kernel: hdh: host protected area => 1
Jul  7 21:31:49 server01 kernel: hdh: 234441648 sectors (120034 MB) 
w/2048KiB Cache, CHS=14593/255/63, UDMA(100)
--

