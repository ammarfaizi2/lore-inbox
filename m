Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266588AbRGEA7B>; Wed, 4 Jul 2001 20:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266589AbRGEA6w>; Wed, 4 Jul 2001 20:58:52 -0400
Received: from water.CC.McGill.CA ([132.206.27.29]:2281 "EHLO
	water.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id <S266588AbRGEA6m>; Wed, 4 Jul 2001 20:58:42 -0400
Date: Wed, 4 Jul 2001 20:51:46 -0400 (EDT)
From: Felix Braun <Felix.Braun@McGill.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Random lockups with kernels 2.4.6-pre8+
Message-ID: <Pine.LNX.4.33L2.0107042038190.1073-100000@eressea.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have been experiencing seemingly random lock ups with kernels 2.4.6-pre8
and 2.4.6-final which didn't occur when running on 2.4.6-pre5. I am not
yet able to reproduce this behaviour (I will look into this as soon as I
get some more time) but when it occurs the symptoms are consistent (it
happened three times so far):

Some programs consistently hang while others seem to continue running. For
example X and enlightenment run while top hangs (it has even segfaulted
once) xdm runs partially it sets up a new X session when reset, backgroud
colour and so forth, but the xdm-greeter does not appear. When trying to
shut down the computer from this state it consistently hangs while trying
to kill xfsft. SysReq works like a charm :-)

I am running on a Fujitsu Lifbook B110 with Intel PIIX4 Chipset 32MB of
RAM 64MB of swap APM enabled. As I have no clue what causes this erratic
behaviour, I don't know what other information might be relevant but will
gladly provide it if somebody asks. Just in case I'll attach the output of
dmesg (running 2.4.6-pre5 BTW unlike this kernel 2.4.6-pre8 and final were 
compiled with gcc-2.95.3)

I'll follow up when I'm able to reliably reproduce the lock ups.

Bye
Felix

--

Linux version 2.4.6-pre5 (root@eressea) (gcc version 3.0) #15 Sun Jun 24 21:54:46 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f1000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000001fec000 (usable)
 BIOS-e820: 0000000001fec000 - 0000000001ff0000 (ACPI data)
 BIOS-e820: 0000000001ff0000 - 0000000002000000 (ACPI NVS)
 BIOS-e820: 00000000ffff1000 - 0000000100000000 (reserved)
On node 0 totalpages: 8172
zone(0): 4096 pages.
zone(1): 4076 pages.
zone(2): 0 pages.
Kernel command line: rw root=305 mem=32688K
Initializing CPU#0
Detected 232.106 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 463.66 BogoMIPS
Memory: 30328k/32688k available (884k kernel code, 1972k reserved, 189k data, 176k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
Intel old style machine check architecture supported.
Intel old style machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Mobile Pentium MMX stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfda20, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:01.0
  got res[10000000:10000fff] for resource 0 of Ricoh Co Ltd RL5c475
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.14)
Starting kswapd v1.8
devfs: v0.106 (20010617) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
pty: 256 Unix98 ptys configured
block: queued sectors max/low 20032kB/6677kB, 64 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 09
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf4f0-0xf4f7, BIOS settings: hda:DMA, hdb:pio
hda: FUJITSU MHD2032AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 6354432 sectors (3253 MB), CHS=788/128/63, UDMA(33)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 >
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
fatfs: bogus logical sector size 5376
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 176k freed
Adding Swap: 32220k swap-space (priority 0)
Adding Swap: 32216k swap-space (priority 1)
inserting floppy driver for 2.4.6-pre5
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
reiserfs: checking transaction log (device 03:09) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
SB 3.01 detected OK (220)
ESS chip ES1879 detected
<ESS ES1879 AudioDrive (rev 11) (3.01)> at 0x220 irq 5 dma 0,5
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1

