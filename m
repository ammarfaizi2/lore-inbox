Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTKQHl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 02:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTKQHl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 02:41:58 -0500
Received: from ns.media-solutions.ie ([212.67.195.98]:12041 "EHLO
	mx.media-solutions.ie") by vger.kernel.org with ESMTP
	id S263375AbTKQHlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 02:41:52 -0500
To: linux-kernel@vger.kernel.org
Subject: >>2.4.18 fork & defunct child.
Message-ID: <1069054910.3fb87bbe23861@ssl.buz.org>
Date: Mon, 17 Nov 2003 07:41:50 +0000 (GMT)
From: Keith Whyte <keith@media-solutions.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.8
X-RelayImmunity: 212.67.195.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, some more info i should have included about this machine:

Nov 16 21:24:16 califas syslogd 1.4.1: restart.
Nov 16 21:24:17 califas kernel: klogd 1.4.1, log source = /proc/kmsg started.
Nov 16 21:24:17 califas kernel: Linux version 2.4.18 (root@midas) (gcc version 
2.95.3 20010315 (release)) #4 Fri May 31 01:25:31 PDT
 2002
Nov 16 21:24:17 califas kernel: BIOS-provided physical RAM map:
Nov 16 21:24:17 califas kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Nov 16 21:24:17 califas kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Nov 16 21:24:17 califas kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 
(reserved)
Nov 16 21:24:17 califas kernel:  BIOS-e820: 0000000000100000 - 000000001fe40000 
(usable)
Nov 16 21:24:17 califas kernel:  BIOS-e820: 000000001fe40000 - 000000001fe50000
(ACPI data)
Nov 16 21:24:17 califas kernel:  BIOS-e820: 000000001fe50000 - 000000001ff00000
(ACPI NVS)
Nov 16 21:24:17 califas kernel: On node 0 totalpages: 130624
Nov 16 21:24:17 califas kernel: zone(0): 4096 pages.
Nov 16 21:24:17 califas kernel: zone(1): 126528 pages.
Nov 16 21:24:17 califas kernel: zone(2): 0 pages.
Nov 16 21:24:17 califas kernel: Kernel command line: BOOT_IMAGE=Linux ro 
root=301
Nov 16 21:24:17 califas kernel: Initializing CPU#0
Nov 16 21:24:17 califas kernel: Detected 1999.970 MHz processor.
Nov 16 21:24:17 califas kernel: Console: colour dummy device 80x25
Nov 16 21:24:17 califas kernel: Calibrating delay loop... 3984.58 BogoMIPS
Nov 16 21:24:17 califas kernel: Memory: 511428k/522496k available (1536k kernel 
code, 10680k reserved, 426k data, 228k init, 0k high
mem)
Nov 16 21:24:17 califas kernel: Dentry-cache hash table entries: 65536 (order: 
7, 524288 bytes)
Nov 16 21:24:17 califas kernel: Inode-cache hash table entries: 32768 (order: 
6, 262144 bytes)
Nov 16 21:24:17 califas kernel: Mount-cache hash table entries: 8192 (order: 4, 
65536 bytes)
Nov 16 21:24:17 califas kernel: Buffer-cache hash table entries: 32768 (order: 
5, 131072 bytes)
Nov 16 21:24:17 califas kernel: Page-cache hash table entries: 131072 (order: 
7, 524288 bytes)
Nov 16 21:24:17 califas kernel: CPU: Before vendor init, caps: 3febfbff 
00000000 00000000, vendor = 0
Nov 16 21:24:17 califas kernel: CPU: L1 I cache: 12K, L1 D cache: 8K
Nov 16 21:24:17 califas kernel: CPU: L2 cache: 512K
Nov 16 21:24:17 califas kernel: CPU: After vendor init, caps: 3febfbff 00000000 
00000000 00000000
Nov 16 21:24:17 califas kernel: Intel machine check architecture supported.
Nov 16 21:24:17 califas kernel: Intel machine check reporting enabled on CPU#0.
Nov 16 21:24:17 califas kernel: CPU:     After generic, caps: 3febfbff 00000000 
00000000 00000000
Nov 16 21:24:17 califas kernel: CPU:             Common caps: 3febfbff 00000000 
00000000 00000000
Nov 16 21:24:17 califas kernel: CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 
04
Nov 16 21:24:17 califas kernel: Enabling fast FPU save and restore... done.
Nov 16 21:24:17 califas kernel: Enabling unmasked SIMD FPU exception support... 
done.
Nov 16 21:24:17 califas kernel: Checking 'hlt' instruction... OK.
Nov 16 21:24:17 califas kernel: Checking for popad bug... OK.
Nov 16 21:24:17 califas kernel: POSIX conformance testing by UNIFIX
Nov 16 21:24:17 califas kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Nov 16 21:24:18 califas kernel: mtrr: detected mtrr type: Intel
Nov 16 21:24:18 califas kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0031, 
last bus=1
Nov 16 21:24:18 califas kernel: PCI: Using configuration type 1
Nov 16 21:24:18 califas kernel: PCI: Probing PCI hardware
Nov 16 21:24:18 califas kernel: PCI: Using IRQ router PIIX [8086/24c0] at 
00:1f.0
Nov 16 21:24:18 califas kernel: PCI: Found IRQ 9 for device 00:1f.1
Nov 16 21:24:18 califas kernel: PCI: Sharing IRQ 9 with 00:1d.2
Nov 16 21:24:18 califas kernel: PCI: Sharing IRQ 9 with 01:02.0
Nov 16 21:24:18 califas kernel: Linux NET4.0 for Linux 2.4
Nov 16 21:24:18 califas kernel: Based upon Swansea University Computer Society 
NET3.039
Nov 16 21:24:18 califas kernel: Initializing RT netlink socket
Nov 16 21:24:18 califas kernel: Starting kswapd
Nov 16 21:24:18 califas kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Nov 16 21:24:18 califas kernel: Journalled Block Device driver loaded
Nov 16 21:24:18 califas kernel: vesafb: framebuffer at 0xf0000000, mapped to 
0xe080d000, size 832k
Nov 16 21:24:18 califas kernel: vesafb: mode is 1024x768x8, linelength=1024, 
pages=0
Nov 16 21:24:18 califas kernel: vesafb: protected mode interface info at 
a5f3:1f5f
Nov 16 21:24:18 califas kernel: vesafb: scrolling: redraw
Nov 16 21:24:18 califas kernel: Console: switching to colour frame buffer 
device 128x48
Nov 16 21:24:18 califas kernel: fb0: VESA VGA frame buffer device
Nov 16 21:24:18 califas kernel: Detected PS/2 Mouse Port.
Nov 16 21:24:18 califas kernel: pty: 512 Unix98 ptys configured
Nov 16 21:24:18 califas kernel: Serial driver version 5.05c (2001-07-08) with 
HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enable
d
Nov 16 21:24:18 califas kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Nov 16 21:24:18 califas kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Nov 16 21:24:18 califas kernel: Real Time Clock Driver v1.10e
Nov 16 21:24:18 califas kernel: block: 128 slots per queue, batch=32
Nov 16 21:24:18 califas kernel: RAMDISK driver initialized: 16 RAM disks of 
7777K size 1024 blocksize
Nov 16 21:24:18 califas kernel: Uniform Multi-Platform E-IDE driver Revision: 
6.31
Nov 16 21:24:18 califas kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Nov 16 21:24:18 califas kernel: PCI_IDE: unknown IDE controller on PCI bus 00 
device f9, VID=8086, DID=24cb
Nov 16 21:24:18 califas kernel: PCI: Device 00:1f.1 not available because of 
resource collisions
Nov 16 21:24:18 califas kernel: PCI_IDE: chipset revision 1
Nov 16 21:24:18 califas kernel: PCI_IDE: not 100%% native mode: will probe irqs 
later
Nov 16 21:24:18 califas kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS 
settings: hda:DMA, hdb:pio
Nov 16 21:24:18 califas kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS 
settings: hdc:pio, hdd:pio
Nov 16 21:24:18 califas kernel: hda: WDC WD800BB-00CAA1, ATA DISK drive
Nov 16 21:24:18 califas kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 16 21:24:18 califas kernel: hda: 156301488 sectors (80026 MB) w/2048KiB 
Cache, CHS=9729/255/63
Nov 16 21:24:18 califas kernel: ide-floppy driver 0.97.sv
Nov 16 21:24:18 califas kernel: Partition check:
Nov 16 21:24:18 califas kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Nov 16 21:24:18 califas kernel: Floppy drive(s): fd0 is 1.44M
Nov 16 21:24:18 califas kernel: FDC 0 is a post-1991 82077
Nov 16 21:24:18 califas kernel: loop: loaded (max 8 devices)
Nov 16 21:24:18 califas kernel: ide-floppy driver 0.97.sv
Nov 16 21:24:18 califas kernel: SCSI subsystem driver Revision: 1.00
Nov 16 21:24:18 califas kernel: request_module[scsi_hostadapter]: Root fs not 
mounted
Nov 16 21:24:18 califas last message repeated 2 times
Nov 16 21:24:18 califas kernel: md: linear personality registered as nr 1
Nov 16 21:24:18 califas kernel: md: raid0 personality registered as nr 2
Nov 16 21:24:18 califas kernel: md: raid1 personality registered as nr 3
Nov 16 21:24:18 califas kernel: md: raid5 personality registered as nr 4
Nov 16 21:24:18 califas kernel: raid5: measuring checksumming speed
Nov 16 21:24:18 califas kernel:    8regs     :  2297.200 MB/sec
Nov 16 21:24:18 califas kernel:    32regs    :  1719.200 MB/sec
Nov 16 21:24:18 califas kernel:    pIII_sse  :  2601.200 MB/sec
Nov 16 21:24:18 califas kernel:    pII_mmx   :  2293.200 MB/sec
Nov 16 21:24:18 califas kernel:    p5_mmx    :  2262.800 MB/sec
Nov 16 21:24:18 califas kernel: raid5: using function: pIII_sse (2601.200 
MB/sec)
Nov 16 21:24:18 califas kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, 
MD_SB_DISKS=27
Nov 16 21:24:18 califas kernel: md: Autodetecting RAID arrays.
Nov 16 21:24:18 califas kernel: md: autorun ...
Nov 16 21:24:18 califas kernel: md: ... autorun DONE.
Nov 16 21:24:18 califas kernel: LVM version 1.0.1-rc4(ish)(03/10/2001)
Nov 16 21:24:18 califas kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Nov 16 21:24:18 califas kernel: IP Protocols: ICMP, UDP, TCP
Nov 16 21:24:18 califas kernel: IP: routing cache hash table of 4096 buckets, 
32Kbytes
Nov 16 21:24:18 califas kernel: TCP: Hash tables configured (established 32768 
bind 32768)
Nov 16 21:24:18 califas kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
Nov 16 21:24:18 califas kernel: VFS: Mounted root (ext2 filesystem) readonly.
Nov 16 21:24:18 califas kernel: Freeing unused kernel memory: 228k freed
Nov 16 21:24:18 califas kernel: Adding Swap: 995988k swap-space (priority -1)
Nov 16 21:24:18 califas kernel: PCI: Found IRQ 11 for device 01:01.0
Nov 16 21:24:18 califas kernel: 3c59x: Donald Becker and others. 
www.scyld.com/network/vortex.html
Nov 16 21:24:18 califas kernel: 01:01.0: 3Com PCI 3c905B Cyclone 100baseTx at 
0xdc00. Vers LK1.1.16
Nov 16 21:24:18 califas kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
Nov 16 21:24:18 califas kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and oth
ers
Nov 16 21:24:18 califas kernel: PCI: Found IRQ 9 for device 01:02.0
Nov 16 21:24:18 califas kernel: PCI: Sharing IRQ 9 with 00:1d.2
Nov 16 21:24:18 califas kernel: PCI: Sharing IRQ 9 with 00:1f.1
Nov 16 21:24:18 califas kernel: eth1: Intel Corp. 82557 [Ethernet Pro 100], 
00:A0:C9:59:F4:65, IRQ 9.
Nov 16 21:24:18 califas kernel:   Receiver lock-up bug exists -- enabling work-
around.
Nov 16 21:24:18 califas kernel:   Board assembly 661949-004, Physical 
connectors present: RJ45
Nov 16 21:24:18 califas kernel:   Primary interface chip DP83840A PHY #1.
Nov 16 21:24:18 califas kernel:   DP83840 specific setup, setting register 23 
to 8462.
Nov 16 21:24:18 califas kernel:   General self-test: passed.
Nov 16 21:24:18 califas kernel:   Serial sub-system self-test: passed.
Nov 16 21:24:18 califas kernel:   Internal registers self-test: passed.
Nov 16 21:24:18 califas kernel:   ROM checksum self-test: passed (0x49caa8d6).
Nov 16 21:24:18 califas kernel:   Receiver lock-up workaround activated.


