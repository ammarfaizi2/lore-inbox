Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbRCaNI1>; Sat, 31 Mar 2001 08:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132374AbRCaNIS>; Sat, 31 Mar 2001 08:08:18 -0500
Received: from zeus.kernel.org ([209.10.41.242]:3034 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132373AbRCaNIE>;
	Sat, 31 Mar 2001 08:08:04 -0500
Message-ID: <3AC5D65E.15E5142F@gte.net>
Date: Sat, 31 Mar 2001 08:06:38 -0500
From: "Stephen E. Clark" <sclark46@gte.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lk <linux-kernel@vger.kernel.org>
Subject: MTRR on AMD THUNDERBIRD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know the status of mtrr the AMD Thunderbird? It does not seem to
work for me anymore.

 cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=16711936MB: write-back, count=1
joker:/
# echo "base=0xd4000000 size=0x2000000 type=write-combining" >|
/proc/mtrr
joker:/
# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=16711936MB: write-back, count=1 

Linux version 2.4.2-ac18 (root@joker.seclark.com) (gcc version
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #5 Mon Mar 19 17:42:56
EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=l-2.4.2ac18pnp ro root=1601
ramdisk=0 mem=256M
Initializing CPU#0
Detected 800.056 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1595.80 BogoMIPS
Memory: 255176k/262144k available (1327k kernel code, 6580k reserved,
422k data, 224k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Bus master Pipeline request disabled
PCI: Disabled enhanced CPU to PCI writes
PCI: Bursting cornercase bug worked around
PCI: Post Write Fail set to Retry
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: Card 'SMC EtherEZ (8416)'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
parport_pc: Strange, can't probe Via 686A parallel port: io=0x378,
irq=7, dma=-1parport0: PC-style at 0x378 [PCSPP(,...)]
also *************** any ideas about the above message
*********************

i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 169546kB/56515kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: JTS CORPORATION CHAMPION MODEL C3200-2A, ATA DISK drive
hdb: Maxtor 91366U4, ATA DISK drive
hdc: Maxtor 53073H4, ATA DISK drive
hdd: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6306048 sectors (3229 MB) w/512KiB Cache, CHS=6256/16/63, DMA
hdb: 26684784 sectors (13663 MB) w/2048KiB Cache, CHS=1661/255/63,
UDMA(66)
hdc: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63,
UDMA(66)
hdd: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
 hdb: hdb1 hdb2 hdb3
 hdc: hdc1 hdc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
smc-ultra.c: ISAPnP reports SMC EtherEZ (8416) at i/o 0x240, irq 5.
smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth0: SMC EtherEZ at 0x240, 00 E0 29 03 E5 92,assigned  IRQ 5 memory
0xc8000-0xc9fff.
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Linux Tulip driver version 0.9.14c (March 3, 2001)
PCI: Found IRQ 10 for device 00:0a.0
eth1: Lite-On 82c168 PNIC rev 32 at 0xe400, 00:A0:CC:26:9F:55, IRQ 10.
eth1:  MII transceiver #1 config 3100 status 7829 advertising 01e1.
PPP generic driver version 2.4.1
Universal TUN/TAP device driver 1.3 (C)1999-2000 Maxim Krasnyansky
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:09.0
scsi: ***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-948 PCI Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.06I, I/O Address: 0xE000, IRQ Channel:
11/Level
scsi0:   PCI Bus: 0, Device: 9, Address: 0xDB000000, Host Adapter SCSI
ID: 7
scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
scsi0:   Synchronous Negotiation: Fast, Wide Negotiation: Disabled
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
scsi0:   SCSI Bus Termination: Enabled, SCAM: Disabled
scsi0: *** BusLogic BT-948 Initialized Successfully ***
scsi0 : BusLogic BT-948
  Vendor: IBM       Model: DCAS-32160        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150N          Rev: 0023
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15150N          Rev: 0022
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: Target 0: Queue Depth 28, Synchronous at 10.0 MB/sec, offset 15
scsi0: Target 3: Queue Depth 28, Synchronous at 10.0 MB/sec, offset 15
scsi0: Target 4: Queue Depth 28, Synchronous at 10.0 MB/sec, offset 15
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
SCSI device sda: 4226725 512-byte hdwr sectors (2164 MB)
 sda: sda1 sda2 sda3
SCSI device sdb: 8388315 512-byte hdwr sectors (4295 MB)
 sdb: sdb1
SCSI device sdc: 8388315 512-byte hdwr sectors (4295 MB)
 sdc: sdc1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
ip_conntrack (2048 buckets, 16384 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding Swap: 66020k swap-space (priority -1)
Adding Swap: 40156k swap-space (priority -2)
Adding Swap: 65532k swap-space (priority -3)
Adding Swap: 65532k swap-space (priority -4)
/dev/vmmon: Module vmmon: registered with major=10 minor=165 tag=$Name:
build-799 $
/dev/vmmon: Module vmmon: initialized
/dev/vmnet: open called by PID 565 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth1: up
bridge-eth1: attached
/dev/vmnet: open called by PID 579 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 589 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
es1371: version v0.27 time 16:06:48 Mar 19 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x07
PCI: Found IRQ 9 for device 00:0c.0
es1371: found es1371 rev 7 at io 0xe800 irq 9
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
mtrr: type mismatch for d4000000,2000000 old: write-back new:
write-combining
