Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUKANBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUKANBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKANBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:01:54 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:64980 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261782AbUKANAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:00:00 -0500
Message-ID: <4186334E.40109@verizon.net>
Date: Mon, 01 Nov 2004 07:59:58 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Jez <dave.jez@seznam.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI & IRQ problems on TI Extensa 600CD
References: <20041023142906.GA15789@stud.fit.vutbr.cz> <417AB69E.8010709@verizon.net> <20041025161945.GA82114@stud.fit.vutbr.cz> <20041029081848.GA5240@stud.fit.vutbr.cz> <41821250.70502@verizon.net> <20041101084211.GA98600@stud.fit.vutbr.cz>
In-Reply-To: <20041101084211.GA98600@stud.fit.vutbr.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Mon, 1 Nov 2004 06:59:59 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Jez wrote:
>>Naah.  I have a piix chipset.  My problem (per David Hinds) is that my 
>>laptop is even more b0rken than yours - IBM never hooked up the PCI INTx 
>>lines on the TI 1130.  My laptop never worked with Cardbus stuff - even in 
>>Windows.
> 
>   Jim, just for fun: can you send me your dmesg, lspci -n and dump_pirq
> results?
> 

Need to compile a new kernel for this thing w/o tridentfb - doesn't work right on 
my system for some reason.

<dmesg - haven't compiled a 2.6.9 for it yet>

Linux version 2.6.9-rc4Thinkpad.1 (root@david) (gcc version 3.3.3 20040412 (Red 
Hat Linux 3.3.3-7)) #6 Thu Oct 14 17:05:32 EDT 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 0000000005000000 (usable)
  BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
80MB LOWMEM available.
On node 0 totalpages: 20480
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 16384 pages, LIFO batch:4
   HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6_test ro root=303 
video=tridentfb:1024x768,bpp=16,noaccel
Initializing CPU#0
PID hash table entries: 512 (order: 9, 8192 bytes)
Detected 132.645 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 78200k/81920k available (1589k kernel code, 3296k reserved, 693k data, 
112k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 260.09 BogoMIPS (lpj=130048)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 000001bf 00000000 00000000 00000000
CPU: After vendor identify, caps:  000001bf 00000000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After all inits, caps:        000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
PCI: Using configuration type 1
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
tridentfb: Trident framebuffer 0.7.8-NEWAPI initializing
tridentfb: framebuffer size = 2048 Kb
tridentfb: 0000:00:03.0 board found
tridentfb: 1024x768 flat panel found
Console: switching to colour frame buffer device 128x48
tridentfb: fb0: Trident frame buffer device 1024x768-16bpp
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIXa: IDE controller at PCI slot 0000:00:01.0
PIIXa: chipset revision 2
PIIXa: bad irq (0): will probe later
PIIXa: neither IDE port enabled (BIOS)
Probing IDE interface ide0...
hda: IBM-DCRA-22110, ATA DISK drive
Probing IDE interface ide1...
ide1: Wait for ready failed before probe !
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 4128768 sectors (2113 MB) w/96KiB Cache, CHS=4096/16/63
hda: cache flushes not supported
  hda: hda1 hda2 hda3
PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Please try using 
pci=biosirq.
Yenta: CardBus bridge found at 0000:00:02.0 [0000:0000]
Yenta: ISA IRQ mask 0x06b8, PCI irq 0
Socket status: 30000006
PCI: No IRQ known for interrupt pin B of device 0000:00:02.1. Please try using 
pci=biosirq.
Yenta: CardBus bridge found at 0000:00:02.1 [0000:0000]
Yenta: ISA IRQ mask 0x06b8, PCI irq 0
Socket status: 30000006
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS/2 Generic Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 112k freed
Adding 98776k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
usbcore: registered new driver hub
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
USB Universal Host Controller Interface driver v2.2

<lspci -n>

00:00.0 Class 0600: 8086:1235 (rev 02)
00:01.0 Class 0601: 8086:122e (rev 02)
00:02.0 Class 0607: 104c:ac12 (rev 04)
00:02.1 Class 0607: 104c:ac12 (rev 04)
00:03.0 Class 0300: 1023:9660 (rev d3)
00:05.0 Class 0400: 1014:0057

<dump_pirq.pl>

No PCI interrupt routing table was found.

Interrupt router at 00:01.0: Intel 82371FB PIIX PCI-to-ISA bridge
   PIRQ1 (link 0x60): irq 11
   PIRQ2 (link 0x61): irq 11
   PIRQ3 (link 0x62): unrouted
   PIRQ4 (link 0x63): unrouted
   Serial IRQ: [disabled] [quiet] [frame=17] [pulse=4]
   Level mask: 0x0800 [11]

