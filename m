Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbSLZSdi>; Thu, 26 Dec 2002 13:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSLZSdi>; Thu, 26 Dec 2002 13:33:38 -0500
Received: from hunnerberg.nijmegen.internl.net ([217.149.192.32]:6643 "EHLO
	hunnerberg.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id <S261353AbSLZSdh>; Thu, 26 Dec 2002 13:33:37 -0500
Date: Thu, 26 Dec 2002 19:40:43 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alot of DMA errors in 2.4.18, 2.4.20 and 2.5.52
Message-ID: <20021226184043.GA6403@iapetus.localdomain>
References: <1040815160.533.6.camel@devcon-x> <20021225115820.GB7348@louise.pinerecords.com> <20021226123710.GA2442@iapetus.localdomain> <20021226132228.GE7348@louise.pinerecords.com> <20021226164229.GA26413@iapetus.localdomain> <20021226173528.GF7348@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021226173528.GF7348@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2002 at 06:35:28PM +0100, Tomas Szepe wrote:
>
> Fair enough.  Can you give me your PCI ids, Promise BIOS version

Don't know how to obtain BIOS # without a reboot, will have to wait
half an hour for this.

lspci -n header:
00:12.0 Class 0180: 105a:4d68 (rev 02) (prog-if 85)

lspci -vvv:
00:12.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc. Ultra100TX2
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d800 [size=8]
        Region 1: I/O ports at dc00 [size=4]
        Region 2: I/O ports at e000 [size=8]
        Region 3: I/O ports at e400 [size=4]
        Region 4: I/O ports at e800 [size=16]
        Region 5: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at e2000000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


> and "hdparm -Iv /dev/hda"?

/dev/hde:
 multcount    =  0 (off)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 193821/16/63, sectors = 195371568, start = 0

ATA device, with non-removable media
        Model Number:       WDC WD1000BB-00CCB0
        Serial Number:      WD-WMA9P1116311
        Firmware Revision:  22.04A22
Standards:
        Supported: 5 4 3 2
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  195371568
        device size with M = 1024*1024:       95396 MBytes
        device size with M = 1000*1000:      100030 MBytes (100 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, with device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
                Automatic Acoustic Management feature set
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
        Device num = 0 determined by CSEL
Checksum: correct

-- 
Frank
