Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129224AbRBLOff>; Mon, 12 Feb 2001 09:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129327AbRBLOf0>; Mon, 12 Feb 2001 09:35:26 -0500
Received: from smtppop2pub.gte.net ([206.46.170.21]:38194 "EHLO
	smtppop2pub.verizon.net") by vger.kernel.org with ESMTP
	id <S129224AbRBLOfO>; Mon, 12 Feb 2001 09:35:14 -0500
Message-ID: <3A87F493.91CE1F61@gte.net>
Date: Mon, 12 Feb 2001 09:34:59 -0500
From: Stephen Clark <sclark46@gte.net>
Reply-To: sclark46@gte.net
Organization: Paradigm 4
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA DMA slowdown
In-Reply-To: <3A845D33.93A48B25@gte.net> <20010209224214.A3621@suse.cz> <3A85786B.D2E46917@gte.net> <20010210202802.B847@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Vojtech Pavlik wrote:

> On Sat, Feb 10, 2001 at 12:20:43PM -0500, Stephen E. Clark wrote:
> > Vojtech Pavlik wrote:
> > >
> > > On Fri, Feb 09, 2001 at 04:12:19PM -0500, Stephen Clark wrote:
> > > > Anybody else experience a DMA slowdown going from stock 2.4.1 to either
> > > > 2.4.2pre2 or 2.4.1ac8.
> > > >
> > > > My hdparm -t numbers dropped from 15mb+ to around 10mb.
> > >
> > > I've already seen reports like yours, and it was caused by ACPI.
> > >
> > > --
> > > Vojtech Pavlik
> > > SuSE Labs
> >
> > Thanks,
> >
> > I'll turn of ACPI and see what happens.
>
> Ok. If problem persists, tell me.
>
> --
> Vojtech Pavlik
> SuSE Labs

Vojtech,

Turning of ACPI did not help.
See below for details.

Regards,
Steve

*********************** stock 2.4.1 with ACPI turned on.
[root@pc-sec /root]# hdparm -vtT /dev/hda

/dev/hda:
 multcount    =  8 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1247/255/63, sectors = 20044080, start = 0
 Timing buffer-cache reads:   128 MB in  2.32 seconds = 55.17 MB/sec
 Timing buffered disk reads:  64 MB in  4.28 seconds = 14.95 MB/sec

[root@pc-sec /root]# hdparm -vtT /dev/hda

/dev/hda:
 multcount    =  8 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1247/255/63, sectors = 20044080, start = 0
 Timing buffer-cache reads:   128 MB in  2.39 seconds = 53.56 MB/sec
 Timing buffered disk reads:  64 MB in  4.56 seconds = 14.04 MB/sec

Linux version 2.4.1 (root@pc-sec.paradigm4.com) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #7 Tue Jan 30 16:28:51 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=l-2.4.1 ro root=302
Initializing CPU#0
Detected 501.147 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 126160k/131008k available (1330k kernel code, 4460k reserved, 493k data,
224k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb270, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.1 present.
33 structures occupying 873 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 03/31/99
System Vendor: VIA Technologies, Inc..
Product Name: VT82C597.
Version  .
Serial Number  .
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 83786kB/27928kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD102AA, ATA DISK drive
hdb: FX120T, ATAPI CD/DVD-ROM drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 20044080 sectors (10263 MB) w/2048KiB Cache, CHS=1247/255/63, UDMA(33)
hdb: ATAPI 12X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
udf: registering filesystem
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Linux Tulip driver version 0.9.13a (January 20, 2001)
PCI: Found IRQ 12 for device 00:09.0
eth0: ADMtek Comet rev 17 at 0xe800, 00:20:78:06:94:8E, IRQ 12.
Universal TUN/TAP device driver 1.3 (C)1999-2000 Maxim Krasnyansky
SCSI subsystem driver Revision: 1.00
Configuring Adaptec (SCSI-ID 7) at IO:330, IRQ 11, DMA priority 5
scsi0 : Adaptec 1542
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
ACPI: Core Subsystem version [20010125]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: System firmware supports: S0 S1 S4 S5
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding Swap: 72284k swap-space (priority -1)
Adding Swap: 65528k swap-space (priority -2)
Adding Swap: 65528k swap-space (priority -3)


****************************** 2.4.1-ac10 with ACPI turned OF
[root@pc-sec /root]# hdparm -vtT /dev/hda

/dev/hda:
 multcount    =  8 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1247/255/63, sectors = 20044080, start = 0
 Timing buffer-cache reads:   128 MB in  2.37 seconds = 54.01 MB/sec
 Timing buffered disk reads:  64 MB in  6.09 seconds = 10.51 MB/sec

[root@pc-sec /root]# hdparm -vtT /dev/hda

/dev/hda:
 multcount    =  8 (on)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 1247/255/63, sectors = 20044080, start = 0
 Timing buffer-cache reads:   128 MB in  2.44 seconds = 52.46 MB/sec
 Timing buffered disk reads:  64 MB in  6.78 seconds =  9.44 MB/sec


Linux version 2.4.1-ac10 (root@pc-sec.paradigm4.com) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #10 Mon Feb 12 08:38:00 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=l-2.4.1ac10 ro root=302
Initializing CPU#0
Detected 501.147 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 126256k/131008k available (1249k kernel code, 4364k reserved, 484k data,
224k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xfb270, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 83853kB/27951kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD102AA, ATA DISK drive
hdb: FX120T, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 20044080 sectors (10263 MB) w/2048KiB Cache, CHS=1247/255/63, UDMA(33)
hdb: ATAPI 12X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
udf: registering filesystem
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Linux Tulip driver version 0.9.13b (January 24, 2001)
PCI: Found IRQ 12 for device 00:09.0
eth0: ADMtek Comet rev 17 at 0xe800, 00:20:78:06:94:8E, IRQ 12.
Universal TUN/TAP device driver 1.3 (C)1999-2000 Maxim Krasnyansky
SCSI subsystem driver Revision: 1.00
Configuring Adaptec (SCSI-ID 7) at IO:330, IRQ 11, DMA priority 5
scsi0 : Adaptec 1542
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding Swap: 72284k swap-space (priority -1)
Adding Swap: 65528k swap-space (priority -2)
Adding Swap: 65528k swap-space (priority -3)


********************* PCI listing

[root@pc-sec /root]# lspci -vvvxx
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR+
        Latency: 16 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 06 11 98 05 06 00 90 82 04 00 00 06 00 10 00 00
10: 08 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
00: 06 11 98 85 07 00 20 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 00 00
20: 00 e4 f0 e5 00 e6 f0 e6 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0c 00

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP]
(rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0 set
00: 06 11 86 05 8f 00 00 02 47 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at e000 [size=16]
00: 06 11 71 05 07 00 80 02 06 8a 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02) (prog-if 00
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64 set, cache line size 08
        Interrupt: pin D routed to IRQ 12
        Region 4: I/O ports at e400 [size=32]
00: 06 11 38 30 07 00 00 02 02 00 03 0c 08 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 04 00 00

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
00: 06 11 40 30 00 00 80 02 10 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Ethernet controller: Bridgecom, Inc: Unknown device 0985 (rev 11)
        Subsystem: Bridgecom, Inc: Unknown device 0570
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 255 min, 255 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at e7000000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 17 13 85 09 07 00 90 02 11 00 00 02 08 40 00 00
10: 01 e8 00 00 00 00 00 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 02 02 00 00 17 13 70 05
30: 00 00 00 e7 c0 00 00 00 00 00 00 00 0c 01 ff ff

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev 7a)
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at d000 [size=256]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 5a 47 87 00 90 02 7a 00 00 03 08 40 00 00
10: 08 00 00 e6 01 d0 00 00 00 00 00 e5 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 84 00
30: 00 00 00 00 5c 00 00 00 00 00 00 00 0a 01 08 00


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
