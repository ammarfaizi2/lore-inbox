Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286299AbRLTRjZ>; Thu, 20 Dec 2001 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286301AbRLTRjQ>; Thu, 20 Dec 2001 12:39:16 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:716 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S286299AbRLTRjD>;
	Thu, 20 Dec 2001 12:39:03 -0500
Date: Thu, 20 Dec 2001 18:41:17 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Harddrive Performance
Message-Id: <20011220184117.46cde456.sebastian.droege@gmx.de>
In-Reply-To: <E16H6tc-0000jz-00@phalynx>
In-Reply-To: <01122013105001.27161@spikes>
	<E16H6tc-0000jz-00@phalynx>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.QHogtuCyy'Yzr?"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.QHogtuCyy'Yzr?
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
My disc throughput on a Intel PIIX4 with an IBM-DTTA-351010 (10 GB/hda) and a Western Digital WD800BB-00BSA0 (80 GB/hdb)
Kernel is 2.5.1-dj2
Maybe it helps a bit ;)
Little question for the masters of hardware here in the list... buffer-chache reads speed is just the speed of the cache, right?
So I think only buffered disk reads say something about the real speed of the drive. And 10 or 11 MB/sec aren't much...

---------------------------------------------------------------------------------------------------

root:/home/slomo# hdparm -Tt /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  1.49 seconds = 85.91 MB/sec
 Timing buffered disk reads:  64 MB in  5.93 seconds = 10.79 MB/sec

root:/home/slomo# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1232/255/63, sectors = 19807200, start = 0

root:/home/slomo# hdparm -I /dev/hda

/dev/hda:

non-removable ATA device, with non-removable media
        Model Number:           IBM-DTTA-351010
        Serial Number:                   WF0WFHH5554
        Firmware Revision:      T56OA73A
Standards:
        Used: ATA/ATAPI-4 T13 1153D revision 17
        Supported: 1 2 3 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 19807200
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 466.0kB    ECC bytes: 34   Queue depth: 32
        Standby timer values: spec'd by standard, no device specific minimum
        r/w multiple sector transfer: Max = 16  Current = 16
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
                release interrupt
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
           *    SMART feature set
           *    READ/WRITE DMA QUEUED
Security:
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        22min for SECURITY ERASE UNIT.

-------------------------------------------------------------------------------------------------

root:/home/slomo# hdparm -Tt /dev/hdb

/dev/hdb:
 Timing buffer-cache reads:   128 MB in  1.39 seconds = 92.09 MB/sec
 Timing buffered disk reads:  64 MB in  5.61 seconds = 11.41 MB/sec

root:/home/slomo# hdparm /dev/hdb

/dev/hdb:
 multcount    = 16 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 155061/16/63, sectors = 156301488, start = 0

root:/home/slomo# hdparm -I /dev/hdb

/dev/hdb:

non-removable ATA device, with non-removable media
        Model Number:           WDC WD800BB-00BSA0
        Serial Number:          WD-WMA6S1226085
        Firmware Revision:      12.08C12
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
        LBA user addressable sectors = 156301488
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 2048.0kB   ECC bytes: 40   Queue depth: 1
        Standby timer values: spec'd by standard, with device specific minimum
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
           *    SMART feature set
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


--=.QHogtuCyy'Yzr?
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8IiK/vIHrJes3kVIRAtQVAJ92rk4ZEy8wTQjr4OYiD857JMiyTgCgsImq
Cs6otlOgrJqKYQ298BqoL/A=
=qKr+
-----END PGP SIGNATURE-----

--=.QHogtuCyy'Yzr?--

