Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130055AbRBIVM5>; Fri, 9 Feb 2001 16:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130694AbRBIVMr>; Fri, 9 Feb 2001 16:12:47 -0500
Received: from smtppop1pub.gte.net ([206.46.170.20]:8999 "EHLO
	smtppop1pub.verizon.net") by vger.kernel.org with ESMTP
	id <S130055AbRBIVM1>; Fri, 9 Feb 2001 16:12:27 -0500
Message-ID: <3A845D33.93A48B25@gte.net>
Date: Fri, 09 Feb 2001 16:12:19 -0500
From: Stephen Clark <sclark46@gte.net>
Reply-To: sclark46@gte.net
Organization: Paradigm 4
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: VIA DMA slowdown
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anybody else experience a DMA slowdown going from stock 2.4.1 to either
2.4.2pre2 or 2.4.1ac8.

My hdparm -t numbers dropped from 15mb+ to around 10mb.

Linux version 2.4.1-ac8 (root@pc-sec.paradigm4.com) (gcc version
egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #9 Fri Feb 9 15:41:34 EST 2001
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
Kernel command line: auto BOOT_IMAGE=l-2.4.1ac8 ro root=302
Initializing CPU#0
Detected 501.149 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 999.42 BogoMIPS
Memory: 126136k/131008k available (1339k kernel code, 4484k reserved,
508k data,
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
block: queued sectors max/low 83773kB/27924kB, 256 slots per queue
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD102AA, ATA DISK drive
hdb: FX120T, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 20044080 sectors (10263 MB) w/2048KiB Cache, CHS=1247/255/63,
UDMA(33)
hdb: ATAPI 12X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
udf: registering filesystem
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI
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
ACPI: Core Subsystem version [20010125]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3
ACPI: System firmware supports: S0 S1 S4 S5
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 224k freed
Adding Swap: 72284k swap-space (priority -1)
Adding Swap: 65528k swap-space (priority -2)
Adding Swap: 65528k swap-space (priority -3)


[root@pc-sec /root]# hdparm -tT /dev/hda
/dev/hda:
 Timing buffer-cache reads:   128 MB in  2.45 seconds = 52.24 MB/sec
 Timing buffered disk reads:  64 MB in  6.65 seconds =  9.62 MB/sec

Any ideas?
Steve

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
