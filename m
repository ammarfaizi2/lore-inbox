Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVCJM3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVCJM3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVCJM3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:29:52 -0500
Received: from nessie.weebeastie.net ([220.233.7.36]:32663 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262546AbVCJM3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:29:37 -0500
Date: Thu, 10 Mar 2005 23:28:24 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: ITE8212
Message-ID: <20050310122824.GX1811@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I got my ITE8212 today (only ordered it last night - whee) and here
are the happy fun results. Basically the card shoved itself to the front
of the queue, gave some weird errors on bootup and had no multisec set
on the drives attached to it. I can boot the machine though and am using
it right now to route my traffic (amongst other things). Am quite happy
to help debug - just need to know what to do. :)

Thanks.

IT8212: IDE controller at PCI slot 0000:00:0d.0
PCI: Found IRQ 11 for device 0000:00:0d.0
IT8212: chipset revision 17
it821x: controller in smart mode.
IT8212: 100% native mode on irq 11
    ide0: BM-DMA at 0x1040-0x1047, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1048-0x104f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: ST3200822A, ATA DISK drive
hda: Performing identify fixups.
ide0 at 0x1050-0x1057,0x1072 on irq 11
Probing IDE interface ide1...
hdc: IC35L060AVV207-0, ATA DISK drive
hdc: Performing identify fixups.
ide1 at 0x1058-0x105f,0x1076 on irq 11
PIIX4: IDE controller at PCI slot 0000:00:14.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x10a0-0x10a7, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x10a8-0x10af, BIOS settings: hdg:DMA, hdh:DMA
Probing IDE interface ide2...
hde: SAMSUNG SV1022D, ATA DISK drive
ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide3...
hdg: AOPEN CD-RW CRW3248 1.12 20020417, ATAPI CD/DVD-ROM drive
hdh: QUANTUM FIREBALLlct20 10, ATA DISK drive
ide3 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, BUG
hda: cache flushes not supported
 hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hda: recal_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: unknown
 hda1
hdc: max request size: 128KiB
hdc: 120103200 sectors (61492 MB) w/1821KiB Cache, CHS=16383/255/63, BUG
hdc: cache flushes not supported
 hdc:hdc: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: recal_intr: error=0x04 { DriveStatusError }
ide: failed opcode was: unknown
 hdc1 hdc2
hde: max request size: 128KiB
hde: 19931184 sectors (10204 MB) w/472KiB Cache, CHS=19773/16/63
hde: cache flushes not supported
 hde: hde1 hde2 hde3 hde4 < hde5 hde6 hde7 >
hdh: max request size: 128KiB
hdh: 20044080 sectors (10262 MB) w/418KiB Cache, CHS=19885/16/63
hdh: cache flushes not supported
 hdh: hdh1 hdh2
hdg: ATAPI 48X CD-ROM CD-R/RW drive, 8192kB Cache

root@nessie:~# hdparm -v /dev/hda

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 24321/255/63, sectors = 200049647616, start = 0
root@nessie:~# hdparm -v /dev/hdc

/dev/hdc:
 multcount    =  0 (off)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 16383/255/63, sectors = 61492838400, start = 0

Both drives have a multcount:


/dev/hda:

 Model=ST3200822A, FwRev=3.01, SerialNo=3LJ22Y8F
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=8192kB, MaxMultSect=16, MultSect=off
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=268435455
 IORDY=on/off
 PIO modes:  pio0 pio1 pio2 
 DMA modes:  mdma0 mdma1 mdma2 
 AdvancedPM=no
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 2: 

 * signifies the current active mode


/dev/hda:

ATA device, with non-removable media
        Model Number:       ST3200822A                              
        Serial Number:      3LJ22Y8F
        Firmware Revision:  3.01    
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 2 
        Supported: 6 5 4 3 
Configuration:
        Logical         max     current
        cylinders       16383   65535
        heads           16      1
        sectors/track   63      63
        --
        CHS current addressable sectors:    4128705
        LBA    user addressable sectors:  268435455
        LBA48  user addressable sectors:  390721968
        device size with M = 1024*1024:      190782 MBytes
        device size with M = 1000*1000:      200049 MBytes (200 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = ?
        Recommended acoustic management value: 128, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    48-bit Address feature set 
                SET MAX security extension
Security: 
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by CSEL
Checksum: correct

/dev/hdc:

 Model=IC35L060AVV207-0, FwRev=V22OA63A, SerialNo=VNVB01G2RAK8XH
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=52
 BuffType=DualPortCache, BuffSize=1821kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=120103200
 IORDY=on/off
 PIO modes:  pio0 pio1 pio2 
 DMA modes:  mdma0 mdma1 mdma2 
 AdvancedPM=no
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a: 

 * signifies the current active mode


/dev/hdc:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
        Model Number:       IC35L060AVV207-0                        
        Serial Number:      VNVB01G2RAK8XH
        Firmware Revision:  V22OA63A
Standards:
        Used: ATA/ATAPI-6 T13 1410D revision 3a 
        Supported: 6 5 4 3 
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  120103200
        LBA48  user addressable sectors:  120103200
        device size with M = 1024*1024:       58644 MBytes
        device size with M = 1000*1000:       61492 MBytes (61 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 52     Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4 
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                Release interrupt
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command 
           *    48-bit Address feature set 
                Automatic Acoustic Management feature set 
                SET MAX security extension
                Address Offset Reserved Area Boot
                SET FEATURES subcommand required to spinup after power up
                Power-Up In Standby feature set
                Advanced Power Management feature set
           *    General Purpose Logging feature set
Security: 
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        30min for SECURITY ERASE UNIT. 
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

-- 
    Red herrings strewn hither and yon.
