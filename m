Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264612AbTFELRW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264614AbTFELRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:17:22 -0400
Received: from info.ii.uj.edu.pl ([149.156.65.40]:61966 "EHLO
	pingu.ii.uj.edu.pl") by vger.kernel.org with ESMTP id S264612AbTFELRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:17:17 -0400
Date: Thu, 5 Jun 2003 13:33:11 +0200
From: Piotr Krukowiecki <piotr@pingu.ii.uj.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: ide problem - is this a known problem, or is the disk dead?
Message-ID: <20030605133311.A24963@pingu.ii.uj.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not subscribed here, please CC me on replays]

Hi, i have similar problems with my cdrom.
Everything was fine in 2.4.20. After upgrading to 2.4.21-rc6 i 
can't mount my cdrom, it prints this message to syslog:

hdb: timeout waiting for DMA
hdb: timeout waiting for DMA
hdb: (__ide_dma_test_irq) called while not waiting

and then hangs and i have to reboot.

Disabling DMA (hdparm -d0 /dev/hdb) helps, no errors whatsover - but
in 2.4.20 i didn't have to disable dma.

The config for both 2.4.20 and 2.4.21-rc6 are the same, with one difference 
- in .20 CONFIG_BLK_DEV_ADMA was set, it's not in .21-rc6 (and it's named 
ADMA100 afaik)
I can send .config if needed.


And here's boot messages from 2.4.20 and 2.4.21-rc6:


klogd 1.4.1#10, log source = /proc/kmsg started.
Inspecting /boot/System.map-2.4.20
Loaded 15447 symbols from /boot/System.map-2.4.20.
Symbols match kernel version 2.4.20.
Loaded 70 symbols from 8 modules.
Linux version 2.4.20 (root@localhost) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 wto gru 3 22:18:40 CET 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000008000000 (usable)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hdg3 mem=131072K
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 851.955 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1697.38 BogoMIPS
Memory: 127504k/131072k available (1010k kernel code, 3184k reserved, 276k data, 248k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 851.9290 MHz.
..... host bus clock speed is 100.2268 MHz.
cpu: 0, clocks: 1002268, slice: 501134
CPU0<T0:1002256,T1:501120,D:2,S:501134,C:1002268>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:13.1
HPT366: chipset revision 1
HPT366: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 99
PCI: Found IRQ 11 for device 00:13.1
PCI: Sharing IRQ 11 with 00:13.0
HPT366: chipset revision 1
HPT366: not 100%% native mode: will probe irqs later
    ide3: BM-DMA at 0xe000-0xe007, BIOS settings: hdg:DMA, hdh:pio
hda: ST360021A, ATA DISK drive
hdb: CRD-8400C, ATAPI CD/DVD-ROM drive
hdg: ST340823A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0xd800-0xd807,0xdc02 on irq 11
blk: queue c02ae8e4, I/O limit 4095Mb (mask 0xffffffff)
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
blk: queue c02af310, I/O limit 4095Mb (mask 0xffffffff)
hdg: 78165360 sectors (40021 MB) w/512KiB Cache, CHS=77545/16/63, UDMA(66)
Partition check:
 hda: hda1 hda2
 hdg: [PTBL] [4865/255/63] hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 hdg7 hdg8 hdg9 hdg10 hdg11 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.


klogd 1.4.1#10, log source = /proc/kmsg started.
Inspecting /boot/System.map-2.4.21-rc6
Loaded 15924 symbols from /boot/System.map-2.4.21-rc6.
Symbols match kernel version 2.4.21.
Loaded 70 symbols from 8 modules.
Linux version 2.4.21-rc6 (root@localhost) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 ¶ro cze 4 11:45:43 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 00000000000f0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 0000000008000000 (usable)
128MB LOWMEM available.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hdg3 mem=131072K
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 851.944 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1697.38 BogoMIPS
Memory: 127464k/131072k available (1032k kernel code, 3224k reserved, 290k data, 248k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 851.9239 MHz.
..... host bus clock speed is 100.2262 MHz.
cpu: 0, clocks: 1002262, slice: 501131
CPU0<T0:1002256,T1:501120,D:5,S:501131,C:1002262>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller at PCI slot 00:13.0
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:13.1
HPT366: chipset revision 1
HPT366: not 100%% native mode: will probe irqs later
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
PCI: Found IRQ 11 for device 00:13.1
PCI: Sharing IRQ 11 with 00:13.0
    ide3: BM-DMA at 0xe000-0xe007, BIOS settings: hdg:DMA, hdh:pio
hda: ST360021A, ATA DISK drive
hdb: CRD-8400C, ATAPI CD/DVD-ROM drive
blk: queue c02b7fe0, I/O limit 4095Mb (mask 0xffffffff)
hdb: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdb: set_drive_speed_status: error=0xb4
hdg: ST340823A, ATA DISK drive
blk: queue c02b8d3c, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide3 at 0xd800-0xd807,0xdc02 on irq 11
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
hdg: attached ide-disk driver.
hdg: host protected area => 1
hdg: 78165360 sectors (40021 MB) w/512KiB Cache, CHS=77545/16/63, UDMA(66)
Partition check:
 hda: hda1 hda2
 hdg: [PTBL] [4865/255/63] hdg1 hdg2 hdg3 hdg4 < hdg5 hdg6 hdg7 hdg8 hdg9 hdg10 hdg11 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

-- 
Piotrek
irc: #debian.pl
Mors Drosophilis melanogastribus!
