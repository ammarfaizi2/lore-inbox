Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbTAAUcS>; Wed, 1 Jan 2003 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbTAAUcS>; Wed, 1 Jan 2003 15:32:18 -0500
Received: from mail.mediaways.net ([193.189.224.113]:10747 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S264001AbTAAUbm>; Wed, 1 Jan 2003 15:31:42 -0500
Subject: Re: 2.4.21-pre2 harddisk not in /proc/partitions with pdc_new
From: Soeren Sonnenburg <kernel@nn7.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1041453776.21708.7.camel@irongate.swansea.linux.org.uk>
References: <1041416324.982.11.camel@sun>
	 <1041453776.21708.7.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-Xhwy0MClZ4U6gESpKXOA"
Organization: 
Message-Id: <1041453380.965.11.camel@sun>
Mime-Version: 1.0
Date: 01 Jan 2003 21:36:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Xhwy0MClZ4U6gESpKXOA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-01-01 at 21:42, Alan Cox wrote:
> On Wed, 2003-01-01 at 10:18, Soeren Sonnenburg wrote:
> > As this box has two pdc20268 (promise tx2) ide controllers I can
> > reproduce this behaviour on both of them with different harddisks.
> > 
> > Linux was booting using a harddisk on the onboard via vt8235 chipset
> > (asus a7v8x).
> > 
> > This problem does not occur with 2.4.20. 
> > 
> > I will happily supply additional information if needed.
> 
> Please provide a full lspci and also the dmesg of the boot. I know what
> this might be, the boot logs should confirm my suspicion one way or
> another

Atm I have the disks on the secondary controllers (dmesg) ... IIRC I did
one where the drive was on the primary controller ... should be in
dmesg_prim... I will switch the drive again if needed.

Soeren.

--=-Xhwy0MClZ4U6gESpKXOA
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Linux version 2.4.21-pre2 (sonne@sun) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Sat Dec 28 17:44:16 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fffc000 (usable)
 BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
 BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393212
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 163836 pages.
Kernel command line: root=/dev/hda1 rw vga=0x030c
Found and enabled local APIC!
Initializing CPU#0
Detected 2000.120 MHz processor.
Console: colour VGA+ 132x60
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 1551004k/1572848k available (1800k kernel code, 21452k reserved, 690k data, 116k init, 655344k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2000.1071 MHz.
..... host bus clock speed is 266.6809 MHz.
cpu: 0, clocks: 2666809, slice: 1333404
CPU0<T0:2666800,T1:1333392,D:4,S:1333404,C:2666809>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1720, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
parport0: PC-style at 0x278 (0x678) [PCSPP(,...)]
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
spurious 8259A interrupt: IRQ7.
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1430M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: AGP aperture is 128M @ 0xf0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20268: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:07.0
PCI: Sharing IRQ 10 with 00:08.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller at PCI slot 00:0f.0
PCI: Found IRQ 7 for device 00:0f.0
PCI: Sharing IRQ 7 with 00:09.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0x7000-0x7007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x7008-0x700f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1800JB-00DUA0, ATA DISK drive
hda: DMA disabled
blk: queue c03bd740, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD1800JB-00DUA0, ATA DISK drive
hdc: DMA disabled
blk: queue c03bdbac, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 4D080K4, ATA DISK drive
blk: queue c03be484, I/O limit 4095Mb (mask 0xffffffff)
hdk: Maxtor 4D080H4, ATA DISK drive
blk: queue c03bed5c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0xa800-0xa807,0xa402 on irq 10
ide5 at 0x9000-0x9007,0x8802 on irq 7
hda: host protected area => 1
hda: 351651888 sectors (180046 MB) w/8192KiB Cache, CHS=21889/255/63, UDMA(100)
hdc: host protected area => 1
hdc: 351651888 sectors (180046 MB) w/8192KiB Cache, CHS=21889/255/63, UDMA(100)
hdg: host protected area => 1
hdg: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdk: host protected area => 1
hdk: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 >
 hdg:<6> [PTBL] [9964/255/63] hdg1
 hdk: hdk1
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 3 for device 00:10.3
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
hcd.c: ehci-hcd @ 00:10.3, VIA Technologies, Inc. USB 2.0
hcd.c: irq 9, pci mem f883c000
usb.c: new USB bus registered, assigned bus number 1
hcd/ehci-hcd.c: USB 2.0 support enabled, EHCI rev 1.00, ehci-hcd 2002-Sep-23
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 17:45:23 Dec 28 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 3 for device 00:10.0
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x8000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 3 for device 00:10.1
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x7800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 3 for device 00:10.2
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x7400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  3054.400 MB/sec
   32regs    :  2696.800 MB/sec
   pIII_sse  :  2146.800 MB/sec
   pII_mmx   :  4671.600 MB/sec
   p5_mmx    :  5984.000 MB/sec
raid5: using function: pIII_sse (2146.800 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
BlueZ HCI USB driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ SCO ver 0.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ BNEP ver 1.1
Copyright (C) 2001,2002 Inventel Systemes
Written 2001,2002 by Clement Moreau <clement.moreau@inventel.fr>
Written 2001,2002 by David Libault <david.libault@inventel.fr>
Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem).
Freeing unused kernel memory: 116k freed
Adding Swap: 1028120k swap-space (priority 1)
Adding Swap: 1028120k swap-space (priority 1)
hub.c: new USB device 00:10.1-1, assigned address 2
hub.c: USB hub found
hub.c: 5 ports detected
i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-viapro.o version 2.7.0 (20021208)
i2c-viapro.o: Found Via VT8233A/8235 device
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-proc.o version 2.7.0 (20021208)
w83781d.o version 2.7.0 (20021208)
hub.c: new USB device 00:10.1-1.1, assigned address 3
 [events: 00000056]
 [events: 00000056]
md: autorun ...
md: considering hdc6 ...
md:  adding hdc6 ...
md:  adding hda6 ...
md: created md0
md: bind<hda6,1>
md: bind<hdc6,2>
md: running: <hdc6><hda6>
md: hdc6's event counter: 00000056
md: hda6's event counter: 00000056
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid0: looking at hda6
raid0:   comparing hda6(94654848) with hda6(94654848)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc6
raid0:   comparing hdc6(94654848) with hda6(94654848)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hda6 ... contained as device 0
  (94654848) is smallest!.
raid0: checking hdc6 ... contained as device 1
raid0: zone->nb_dev: 2, size: 189309696
raid0: current zone offset: 94654848
raid0: done.
raid0 : md_size is 189309696 blocks.
raid0 : conf->smallest->size is 189309696 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdc6 [events: 00000057]<6>(write) hdc6's sb offset: 94654848
md: hda6 [events: 00000057]<6>(write) hda6's sb offset: 94654848
md: ... autorun DONE.
 [events: 00000025]
 [events: 00000025]
md: autorun ...
md: considering hdc7 ...
md:  adding hdc7 ...
md:  adding hda7 ...
md: created md1
md: bind<hda7,1>
md: bind<hdc7,2>
md: running: <hdc7><hda7>
md: hdc7's event counter: 00000025
md: hda7's event counter: 00000025
md1: max total readahead window set to 248k
md1: 1 data-disks, max readahead per data-disk: 248k
raid5: device hdc7 operational as raid disk 1
raid5: device hda7 operational as raid disk 0
raid5: allocated 2241kB for md1
raid5: raid level 5 set md1 active with 2 out of 2 devices, algorithm 2
RAID5 conf printout:
 --- rd:2 wd:2 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda7
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc7
RAID5 conf printout:
 --- rd:2 wd:2 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda7
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc7
md: updating md1 RAID superblock on device
md: hdc7 [events: 00000026]<6>(write) hdc7's sb offset: 80035712
md: hda7 [events: 00000026]<6>(write) hda7's sb offset: 80035712
md: ... autorun DONE.
usb.c: USB device 3 (vend/prod 0x698/0x1786) is not claimed by any active driver.
hub.c: new USB device 00:10.1-1.2, assigned address 4
input0: USB HID v1.00 Mouse [Cypress Sem. USB Mouse] on usb3:4.0
reiserfs: checking transaction log (device 09:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
raid5: switching cache buffer size, 4096 --> 1024
raid5: switching cache buffer size, 1024 --> 4096
reiserfs: checking transaction log (device 09:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Broadcom 4401 Ethernet Driver bcm4400 ver. 1.0.1 (08/26/02)
PCI: Found IRQ 7 for device 00:09.0
PCI: Sharing IRQ 7 with 00:0f.0
eth0: Broadcom BCM4401 100Base-T found at mem e3000000, IRQ 7, node addr 00e018b976f7
NETDEV WATCHDOG: eth0: transmit timed out
bcm4400: eth0 NIC Link is Up, 100 Mbps full duplex
lirc_serial: auto-detected active low receiver
PCI: Found IRQ 4 for device 00:11.5
IRQ routing conflict for 00:11.5, have irq 9, want irq 4
PCI: Setting latency timer of device 00:11.5 to 64
i2c-algo-bit.o: i2c bit algorithm module version 2.7.0 (20021208)
PCI: Found IRQ 11 for device 00:0a.0
PCI: Sharing IRQ 11 with 01:00.0
em8300: EM8300 8300 (rev 1) bus: 0, devfn: 80, irq: 11, memory: 0xe2800000.
em8300: mapped-memory at 0xf8c17000
em8300: using MTRR
em8300: 1 EM8300 card(s) found.
em8300_main.o: Chip revision: 1
adv717x.o: ADV7175A chip detected
adv717x.o: Configuring for PAL 60
adv717x.o: Configuring for PAL
em8300_audio.o: Analog audio enabled
em8300: Microcode version 0x29 loaded
em8300_audio.o: Digital PCM audio enabled
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
NVRM: AGPGART: unknown chipset
NVRM: AGPGART: aperture: 128M @ 0xf0000000
NVRM: AGPGART: aperture mapped from 0xf0000000 to 0xf9e28000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages

--=-Xhwy0MClZ4U6gESpKXOA
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
	Subsystem: Asustek Computer, Inc.: Unknown device 807f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e5000000-e66fffff
	Prefetchable memory behind bridge: e7700000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e4800000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at d800 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 RAID bus controller: Promise Technology, Inc.: Unknown device 3376 (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 809e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d400 [size=64]
	Region 1: I/O ports at d000 [size=16]
	Region 2: I/O ports at b800 [size=128]
	Region 3: Memory at e4000000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at e3800000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: BROADCOM Corporation: Unknown device 4401 (rev 01)
	Subsystem: Asustek Computer, Inc.: Unknown device 80a8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at e3000000 (32-bit, non-prefetchable) [size=8K]
	Expansion ROM at e76f0000 [disabled] [size=16K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e2800000 (32-bit, non-prefetchable) [size=1M]

00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e6800000 (32-bit, prefetchable) [size=4K]

00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b000 [size=4]
	Region 2: I/O ports at a800 [size=8]
	Region 3: I/O ports at a400 [size=4]
	Region 4: I/O ports at a000 [size=16]
	Region 5: Memory at e2000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at 9800 [size=8]
	Region 1: I/O ports at 9400 [size=4]
	Region 2: I/O ports at 9000 [size=8]
	Region 3: I/O ports at 8800 [size=4]
	Region 4: I/O ports at 8400 [size=16]
	Region 5: Memory at e1800000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 4: I/O ports at 8000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 9
	Region 4: I/O ports at 7800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at 7400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at e1000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Asustek Computer, Inc.: Unknown device 808c
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 7000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
	Subsystem: Asustek Computer, Inc.: Unknown device 8095
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev a3) (prog-if 00 [VGA])
	Subsystem: Unknown device 17f2:8007
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 2: Memory at e7800000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at e77e0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=x4


--=-Xhwy0MClZ4U6gESpKXOA
Content-Disposition: attachment; filename=dmesg_prim
Content-Type: text/plain; name=dmesg_prim; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Linux version 2.4.21-pre2 (sonne@sun) (gcc version 2.95.4 20011002 (Debian prerelease)) #3 Sat Dec 28 17:44:16 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005fffc000 (usable)
 BIOS-e820: 000000005fffc000 - 000000005ffff000 (ACPI data)
 BIOS-e820: 000000005ffff000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
639MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 393212
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 163836 pages.
Kernel command line: root=/dev/hda1 rw vga=0x030c
Found and enabled local APIC!
Initializing CPU#0
Detected 2000.120 MHz processor.
Console: colour VGA+ 132x60
Calibrating delay loop... 3984.58 BogoMIPS
Memory: 1551004k/1572848k available (1800k kernel code, 21452k reserved, 690k data, 116k init, 655344k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(TM) XP 2400+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1999.9871 MHz.
..... host bus clock speed is 266.6649 MHz.
cpu: 0, clocks: 2666649, slice: 1333324
CPU0<T0:2666640,T1:1333312,D:4,S:1333324,C:2666649>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xf1720, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/3177] at 00:11.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
BlueZ Core ver 2.2 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S1 S4 S5
Processor[0]: C0 C1
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
parport0: PC-style at 0x278 (0x678) [PCSPP(,...)]
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
spurious 8259A interrupt: IRQ7.
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1430M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: AGP aperture is 128M @ 0xf0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20268: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 10 for device 00:0e.0
PCI: Sharing IRQ 10 with 00:07.0
PCI: Sharing IRQ 10 with 00:08.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
PDC20268: IDE controller at PCI slot 00:0f.0
PCI: Found IRQ 7 for device 00:0f.0
PCI: Sharing IRQ 7 with 00:09.0
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
    ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:pio, hdj:pio
    ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:pio, hdl:pio
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0x7000-0x7007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x7008-0x700f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1800JB-00DUA0, ATA DISK drive
hda: DMA disabled
blk: queue c03bd740, I/O limit 4095Mb (mask 0xffffffff)
hdc: WDC WD1800JB-00DUA0, ATA DISK drive
hdc: DMA disabled
blk: queue c03bdbac, I/O limit 4095Mb (mask 0xffffffff)
hde: Maxtor 4D080H4, ATA DISK drive
blk: queue c03be018, I/O limit 4095Mb (mask 0xffffffff)
hdg: Maxtor 4D080K4, ATA DISK drive
blk: queue c03be484, I/O limit 4095Mb (mask 0xffffffff)
hdi: Pioneer DVD-ROM ATAPIModel DVD-105S 012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb400-0xb407,0xb002 on irq 10
ide3 at 0xa800-0xa807,0xa402 on irq 10
ide4 at 0x9800-0x9807,0x9402 on irq 7
hda: host protected area => 1
hda: 351651888 sectors (180046 MB) w/8192KiB Cache, CHS=21889/255/63, UDMA(100)
hdc: host protected area => 1
hdc: 351651888 sectors (180046 MB) w/8192KiB Cache, CHS=21889/255/63, UDMA(100)
hde: host protected area => 1
hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
hdg: host protected area => 1
hdg: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdi: ATAPI 40X DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdc: hdc1 hdc2 < hdc5 hdc6 hdc7 >
 hde: hde1
 hdg:<6> [PTBL] [9964/255/63] hdg1
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 3 for device 00:10.3
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
hcd.c: ehci-hcd @ 00:10.3, VIA Technologies, Inc. USB 2.0
hcd.c: irq 9, pci mem f883c000
usb.c: new USB bus registered, assigned bus number 1
hcd/ehci-hcd.c: USB 2.0 support enabled, EHCI rev 1.00, ehci-hcd 2002-Sep-23
hub.c: USB hub found
hub.c: 6 ports detected
usb-uhci.c: $Revision: 1.275 $ time 17:45:23 Dec 28 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 3 for device 00:10.0
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x8000, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 3 for device 00:10.1
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x7800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 3 for device 00:10.2
IRQ routing conflict for 00:10.0, have irq 9, want irq 3
IRQ routing conflict for 00:10.1, have irq 9, want irq 3
IRQ routing conflict for 00:10.2, have irq 9, want irq 3
IRQ routing conflict for 00:10.3, have irq 9, want irq 3
usb-uhci.c: USB UHCI at I/O 0x7400, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 4
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  3054.800 MB/sec
   32regs    :  2697.200 MB/sec
   pIII_sse  :  1629.200 MB/sec
   pII_mmx   :  4671.600 MB/sec
   p5_mmx    :  5984.000 MB/sec
raid5: using function: pIII_sse (1629.200 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
BlueZ HCI USB driver ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
usb.c: registered new driver hci_usb
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
ip_conntrack version 2.1 (8192 buckets, 65536 max) - 292 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
arp_tables: (C) 2002 David S. Miller
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ SCO ver 0.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ BNEP ver 1.1
Copyright (C) 2001,2002 Inventel Systemes
Written 2001,2002 by Clement Moreau <clement.moreau@inventel.fr>
Written 2001,2002 by David Libault <david.libault@inventel.fr>
Copyright (C) 2002 Maxim Krasnyanskiy <maxk@qualcomm.com>
reiserfs: checking transaction log (device 03:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem).
Freeing unused kernel memory: 116k freed
Adding Swap: 1028120k swap-space (priority 1)
Adding Swap: 1028120k swap-space (priority 1)
 [events: 00000042]
 [events: 00000042]
md: autorun ...
md: considering hdc6 ...
md:  adding hdc6 ...
md:  adding hda6 ...
md: created md0
md: bind<hda6,1>
md: bind<hdc6,2>
md: running: <hdc6><hda6>
md: hdc6's event counter: 00000042
md: hda6's event counter: 00000042
md0: max total readahead window set to 496k
md0: 2 data-disks, max readahead per data-disk: 248k
raid0: looking at hda6
raid0:   comparing hda6(94654848) with hda6(94654848)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdc6
raid0:   comparing hdc6(94654848) with hda6(94654848)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: zone 0
raid0: checking hda6 ... contained as device 0
  (94654848) is smallest!.
raid0: checking hdc6 ... contained as device 1
raid0: zone->nb_dev: 2, size: 189309696
raid0: current zone offset: 94654848
raid0: done.
raid0 : md_size is 189309696 blocks.
raid0 : conf->smallest->size is 189309696 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: updating md0 RAID superblock on device
md: hdc6 [events: 00000043]<6>(write) hdc6's sb offset: 94654848
md: hda6 [events: 00000043]<6>(write) hda6's sb offset: 94654848
md: ... autorun DONE.
 [events: 00000011]
 [events: 00000011]
md: autorun ...
md: considering hdc7 ...
md:  adding hdc7 ...
md:  adding hda7 ...
md: created md1
md: bind<hda7,1>
md: bind<hdc7,2>
md: running: <hdc7><hda7>
md: hdc7's event counter: 00000011
md: hda7's event counter: 00000011
md1: max total readahead window set to 248k
md1: 1 data-disks, max readahead per data-disk: 248k
raid5: device hdc7 operational as raid disk 1
raid5: device hda7 operational as raid disk 0
raid5: allocated 2241kB for md1
raid5: raid level 5 set md1 active with 2 out of 2 devices, algorithm 2
RAID5 conf printout:
 --- rd:2 wd:2 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda7
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc7
RAID5 conf printout:
 --- rd:2 wd:2 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:hda7
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:hdc7
md: updating md1 RAID superblock on device
md: hdc7 [events: 00000012]<6>(write) hdc7's sb offset: 80035712
md: hda7 [events: 00000012]<6>(write) hda7's sb offset: 80035712
md: ... autorun DONE.
hub.c: new USB device 00:10.1-1, assigned address 2
hub.c: USB hub found
hub.c: 5 ports detected
hub.c: new USB device 00:10.1-1.1, assigned address 3
usb.c: USB device 3 (vend/prod 0x698/0x1786) is not claimed by any active driver.
hub.c: new USB device 00:10.1-1.2, assigned address 4
input0: USB HID v1.00 Mouse [Cypress Sem. USB Mouse] on usb3:4.0
reiserfs: checking transaction log (device 09:00) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 21:01) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002
Broadcom 4401 Ethernet Driver bcm4400 ver. 1.0.1 (08/26/02)
PCI: Found IRQ 7 for device 00:09.0
PCI: Sharing IRQ 7 with 00:0f.0
eth0: Broadcom BCM4401 100Base-T found at mem e3000000, IRQ 7, node addr 00e018b976f7
bcm4400: eth0 NIC Link is Up, 100 Mbps full duplex

--=-Xhwy0MClZ4U6gESpKXOA--

