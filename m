Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSGDK0X>; Thu, 4 Jul 2002 06:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317388AbSGDK0X>; Thu, 4 Jul 2002 06:26:23 -0400
Received: from sultan.hu ([195.228.172.145]:9996 "EHLO sultan.danube.hu")
	by vger.kernel.org with ESMTP id <S317386AbSGDK0U>;
	Thu, 4 Jul 2002 06:26:20 -0400
Date: Thu, 4 Jul 2002 12:29:23 +0200 (CEST)
From: nigga <nigga@sultan.hu>
X-X-Sender: nigga@sultan.danube.hu
To: linux-kernel@vger.kernel.org
Subject: ide problems
Message-ID: <Pine.LNX.4.43.0207041215070.3487-100000@sultan.danube.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having problems with my IDE HDDs. THe box is freezing after 5-10hours
uptime.
Here is what I could grab from kern.log after reboot:

Jul  4 02:40:14 andaxin kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Jul  4 02:40:14 andaxin kernel: hde: lost interrupt
Jul  4 02:40:14 andaxin kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Jul  4 02:40:14 andaxin kernel: hdo: lost interrupt
Jul  4 02:40:14 andaxin kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Jul  4 02:40:14 andaxin kernel: hdk: lost interrupt
Jul  4 05:21:06 andaxin kernel: 13: @cff3d540  length 800005ea status 000105ea
Jul  4 05:21:06 andaxin kernel: 14: @cff3d580  length 800005ea status 000105ea
Jul  4 05:21:06 andaxin kernel: 15: @cff3d5c0  length 800005ea status 000105ea
Jul  4 05:30:26 andaxin kernel: ide_dmaproc: chipset supported ide_dma_lostirq func only: 13
Jul  4 05:30:26 andaxin kernel: hda: lost interrupt

etc etc etc
this error has occured for most drives in the box.
here is the config:

Linux version 2.4.18-rc1 (root@andaxin) (gcc version 2.95.4
20011002 (Debian prerelease)) #1 Wed Jul 3 14:06:35 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=2418-rc1 ro root=301
Initializing CPU#0
Detected 850.063 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 256224k/262080k available (767k kernel code, 5472k reserved, 192k
data, 196k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Duron(tm) processor stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb4e0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Disabling VIA memory write queue: [55] 89->09
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
HPT370A: IDE controller on PCI bus 00 dev 48
PCI: Found IRQ 10 for device 00:09.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xbc00-0xbc07, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdg:DMA, hdh:pio
HPT370: IDE controller on PCI bus 00 dev 68
PCI: Found IRQ 12 for device 00:0d.0
PCI: Sharing IRQ 12 with 00:0f.0
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide4: BM-DMA at 0xd000-0xd007, BIOS settings: hdi:DMA, hdj:DMA
    ide5: BM-DMA at 0xd008-0xd00f, BIOS settings: hdk:DMA, hdl:pio
CMD649: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 11 for device 00:11.0
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
    ide6: BM-DMA at 0xe800-0xe807, BIOS settings: hdm:pio, hdn:pio
    ide7: BM-DMA at 0xe808-0xe80f, BIOS settings: hdo:pio, hdp:pio
hda: QUANTUM FIREBALLlct10 15, ATA DISK drive
hde: Maxtor 98196H8, ATA DISK drive
hdg: Maxtor 98196H8, ATA DISK drive
hdi: Maxtor 4G120J6, ATA DISK drive
hdj: Maxtor 98196H8, ATA DISK drive
hdk: Maxtor 4D080H4, ATA DISK drive
hdo: Maxtor 4W100H6, ATA DISK drive
hdp: Maxtor 4W100H6, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xac00-0xac07,0xb002 on irq 10
ide3 at 0xb400-0xb407,0xb802 on irq 10
ide4 at 0xc000-0xc007,0xc402 on irq 12
ide5 at 0xc800-0xc807,0xcc02 on irq 12
ide7 at 0xe000-0xe007,0xe402 on irq 11
hda: 29336832 sectors (15020 MB) w/418KiB Cache, CHS=1826/255/63, (U)DMA
hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdg: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdi: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=238216/16/63, UDMA(100)
hdj: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdk: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(100)
hdo: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=194158/16/63, UDMA(100)
hdp: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=194158/16/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
 hde: [PTBL] [9964/255/63] hde1
 hdg: [PTBL] [9964/255/63] hdg1
 hdi: [PTBL] [14946/255/63] hdi1
 hdj: hdj1
 hdk: hdk1
 hdo: unknown partition table
 hdp: unknown partition table
PCI: Found IRQ 12 for device 00:0f.0
PCI: Sharing IRQ 12 with 00:0d.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0f.0: 3Com PCI 3c905C Tornado at 0xd400. Vers LK1.1.16
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 48188k swap-space (priority -1)
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack (2047 buckets, 16376 max)
LVM version 1.0.1-rc4(ish)(03/10/2001) module loaded
reiserfs: checking transaction log (device 03:03) ...
reiserfs: replayed 1 transactions in 1 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
reiserfs: replayed 1 transactions in 1 seconds
Using r5 hash to sort names
Removing [13323 28947 0x0 SD]..<4>done
Removing [9871 28941 0x0 SD]..<4>done
There were 2 uncompleted unlinks/truncates. Completed
ReiserFS version 3.6.25
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on lvm(58,0), internal journal
ext3_orphan_cleanup: deleting unreferenced inode 966683
EXT3-fs: lvm(58,0): 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
nacctd uses obsolete (PF_INET,SOCK_PACKET)


The CMD649 card is just installed but I met this problem before I
installed it as well.
i tried to change cables, location of IDE cards.
anyone met this problem? if so, what is the solution.


Thanks for your help.

Regards, N.

