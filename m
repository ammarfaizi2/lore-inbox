Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132437AbRBDX7t>; Sun, 4 Feb 2001 18:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRBDX7j>; Sun, 4 Feb 2001 18:59:39 -0500
Received: from cp38760-a.roose1.nb.nl.home.com ([212.204.135.104]:60944 "EHLO
	obelix.fvdpol.home.nl") by vger.kernel.org with ESMTP
	id <S132437AbRBDX7Z>; Sun, 4 Feb 2001 18:59:25 -0500
Date: Mon, 5 Feb 2001 00:59:18 +0100
From: Frank van de Pol <fvdpol@home.nl>
To: linux-kernel@vger.kernel.org
Subject: IDE CD writer fails on 2.4.x
Message-ID: <20010205005918.A10412@idefix.fvdpol.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.2-pre1 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Though I was successfull using my cdwriter under the pre series and win98 it
fails using 2.4.x (i tested it with 2.4.0 and 2.4.2-pre1).


cd writer software in use:
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling


caps according to hdparm:
/dev/hdd:

 Model=PHILIPS CDD3610 CD-R/RW, FwRev=V:003.01,
SerialNo=4VO22985121772100210
 Config={ Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=3900kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=yes, tPIO={min:208,w/IORDY:127}, tDMA={min:127,rec:127}
 PIO modes: pio0 pio1 pio2 pio3 
 DMA modes: sdma0 sdma1 sdma2 mdma0 *mdma1 



scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: E-IDE     Model: CD-ROM 36X/AKU    Rev: U21I
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PHILIPS   Model: CDD3610 CD-R/RW   Rev: 3.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Detected scsi CD-ROM sr1 at scsi1, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 0x/36x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 2x/6x writer cd/rw xa/form2 cdda tray
VFS: Disk change detected on device sr(11,1)
attempt to access beyond end of device
0b:01: rw=0, want=34, limit=2
isofs_read_super: bread failed, dev=0b:01, iso_blknum=16, block=16
Uniform CD-ROM driver unloaded
hdb: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdb: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
scsi : aborting command due to timeout : pid 0, scsi1, channel 0, id 1, lun
0 Write (10) 00 00 00 04 5c 00 00 1f 00 
hdd: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdd: irq timeout: status=0xd0 { Busy }
hdd: DMA disabled
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xd0 { Busy }
hdd: status timeout: status=0xd0 { Busy }
hdd: drive not ready for command
hdd: ATAPI reset complete
scsi1 : channel 0 target 1 lun 0 request sense failed, performing reset.
SCSI bus is being reset for host 1 channel 0.


/proc/ide/ide1/hdd/settings:

name			value		min		max		mode
----			-----		---		---		----
bios_cyl                0               0               1023            rw
bios_head               0               0               255             rw
bios_sect               0               0               63              rw
current_speed           33              0               69              rw
ide_scsi                0               0               1               rw
init_speed              33              0               69              rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
log                     0               0               1               rw
nice1                   1               0               1               rw
number                  3               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
transform               1               0               3               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw


-- 
+---- --- -- -  -   -    - 
|Frank van de Pol                  -o)
| FvdPol@home.nl                   /\\
|                                 _\_v
|Linux - Why use Windows, since there is a door?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
