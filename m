Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281916AbRLZTZy>; Wed, 26 Dec 2001 14:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283286AbRLZTZp>; Wed, 26 Dec 2001 14:25:45 -0500
Received: from oyster.morinfr.org ([62.4.22.234]:23205 "EHLO
	oyster.morinfr.org") by vger.kernel.org with ESMTP
	id <S281916AbRLZTZe>; Wed, 26 Dec 2001 14:25:34 -0500
Date: Wed, 26 Dec 2001 20:25:35 +0100
From: Guillaume Morin <guillaume@morinfr.org>
To: linux-kernel@vger.kernel.org
Subject: Re: severe slowdown with 2.4 series w/heavy disk access
Message-ID: <20011226192535.GA11896@morinfr.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

I experience the same problem with recent kernels. I run 2.4.16. When I
copy a file from one hd to another, ls'ing a empty directory takes about
6-7 secs.

Disks are

/dev/hda:

non-removable ATA device, with non-removable media
        Model Number:           QUANTUM FIREBALLP LM15
        Serial Number:          883011568812
        Firmware Revision:      A35.0700
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 1
        Supported: 1 2 3 4 5
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    32256           (obsolete)
        bytes/sector:   21298           (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 29336832
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 1900.0kB   ECC bytes: 4    Queue depth: 1
        Standby timer values: spec'd by Vendor, no device specific
minimum
        r/w multiple sector transfer: Max = 16  Current = 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        12min for SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

/dev/hdd:

non-removable ATA device, with non-removable media
        Model Number:           WDC WD400BB-00CLB0
        Serial Number:          WD-WMAAN1229771
        Firmware Revision:      05.04E05
Standards:
        Supported: 1 2 3 4 5
        Likely used: 5
Configuration:
        Logical         max     current
        cylinders       16383   17475
        heads           16      15
        sectors/track   63      63
        bytes/track:    57600           (obsolete)
        bytes/sector:   600             (obsolete)
        current sector capacity: 16513875
        LBA user addressable sectors = 78165360
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 2048.0kB   ECC bytes: 40   Queue depth: 1
        Standby timer values: spec'd by standard, with device specific
minimum
        r/w multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                SET MAX security extension
           *    DOWNLOAD MICROCODE cmd
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 1 determined by the jumper
Checksum: correct

at boot :

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 29336832 sectors (15020 MB) w/1900KiB Cache, CHS=1826/255/63,
UDMA(66)
hdd: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
UDMA(33)

Let me know if you want me to test patches or provide more information.

Regards,

-- 
Guillaume Morin <guillaume@morinfr.org>

                             La vie est facétieuse
