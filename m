Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUCWPcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 10:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbUCWPcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 10:32:45 -0500
Received: from mail.eris.qinetiq.com ([128.98.1.1]:23915 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S262625AbUCWPcc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 10:32:32 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: |TEcHNO| <techno@punkt.pl>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.x][2.6.x]EIO AP-1600 ATA133 Controller Card
Date: Tue, 23 Mar 2004 15:22:43 +0000
User-Agent: KMail/1.5.3
References: <40601966.3010706@punkt.pl>
In-Reply-To: <40601966.3010706@punkt.pl>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200403231522.43676.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I have the same card:

SiI680: IDE controller at PCI slot 02:09.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

hde: attached ide-disk driver.
hde: host protected area => 1
hde: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(100)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)


02:09.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
        Subsystem: Unknown device 1771:1680
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 01
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at ecb8 [size=8]
        Region 1: I/O ports at ecb0 [size=4]
        Region 2: I/O ports at eca0 [size=8]
        Region 3: I/O ports at ec98 [size=4]
        Region 4: I/O ports at ec80 [size=16]
        Region 5: Memory at fe9ff400 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at fea00000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


Seems to work just fine with the two hard drives I have on it.

Mark.

> Hi,
> I recently bought this card, hopeing that it woudl work under linux,
> even the manufacurers page say's so. But afer installing it I found out
> that both 2.4.22, 2.4.25 and 2.6.4 fail to work with it correctly. They
> all report:
>
> SiI680: IDE controller at PCI slot 00:0d.0
> PCI: Found IRQ 9 for device 00:0d.0
> PCI: Sharing IRQ 9 with 00:09.0
> SiI680: chipset revision 2
> SiI680: not 100% native mode: will probe irqs later
> SiI680: BASE CLOCK == 133
>      ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
>      ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
> hda: ST330621A, ATA DISK drive
> hdb: ST3120026A, ATA DISK drive
> blk: queue c0526860, I/O limit 4095Mb (mask 0xffffffff)
> blk: queue c052699c, I/O limit 4095Mb (mask 0xffffffff)
> hdc: ST3120026A, ATA DISK drive
> blk: queue c0526cb4, I/O limit 4095Mb (mask 0xffffffff)
> hdf: PLEXTOR CD-R PX-W2410A, ATAPI CD/DVD-ROM drive
> hdf: set_drive_speed_status: status=0x41 { DriveReady Error }
> hdf: set_drive_speed_status: error=0x04
> hdf: set_drive_speed_status: status=0x41 { DriveReady Error }
> hdf: set_drive_speed_status: error=0x04
> hdf: set_drive_speed_status: status=0x41 { DriveReady Error }
> hdf: set_drive_speed_status: error=0x04
> hdh: LG CD-RW CED-8083B, ATAPI CD/DVD-ROM drive
> hdh: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hdh: set_drive_speed_status: error=0x04
> hdh: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
> hdh: set_drive_speed_status: error=0x04
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xc8810e80-0xc8810e87,0xc8810e8a on irq 9
> ide3 at 0xc8810ec0-0xc8810ec7,0xc8810eca on irq 9
>
> sometimes it's a bit diffrent(ie. last time hdf reported hdh error, and
> hdh none), but the CD's work (read and write alike).
> If I connect some HDD's they report hdh error, and then a number of
> other errors (which I don't have written, but they look like data
> gathering information errors). Sometimes it even detects my HDD's as 2TB
> drives and such (after reporting some errors) but even watinga lot
> didn't prove to help, it simply stops somewhere there.
>
> The chipset is exactly Sil0680ACL144. Controller BIOS 3.0.77.
>
> lspci -vvvvv
>
> 00:0d.0 Unknown mass storage controller: CMD Technology Inc PCI0680 (rev
> 02) Subsystem: CMD Technology Inc PCI0680
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR+ FastB2B-
>          Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>
>  >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
>
>          Latency: 64, cache line size 01
>          Interrupt: pin A routed to IRQ 9
>          Region 0: I/O ports at c400 [size=8]
>          Region 1: I/O ports at c000 [size=4]
>          Region 2: I/O ports at bc00 [size=8]
>          Region 3: I/O ports at b800 [size=4]
>          Region 4: I/O ports at b400 [size=16]
>          Region 5: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
>          Expansion ROM at dff00000 [disabled] [size=512K]
>          Capabilities: [60] Power Management version 2
>                  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=2 PME-
>
> Hope this helps, I'm nto subscribed so pleas CC: to me.
> I'm willing to help in testing of any patches etc.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAYFZDBn4EFUVUIO0RAr7NAKDwQ4jMk9cCwDW9GEt7qccqoZRqmQCfWnLx
3iaL/UqmnasFJkCvphQyHzs=
=lGMR
-----END PGP SIGNATURE-----

