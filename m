Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVAQPqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVAQPqL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVAQPqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:46:11 -0500
Received: from sd291.sivit.org ([194.146.225.122]:63369 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261807AbVAQPpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:45:41 -0500
Date: Mon, 17 Jan 2005 16:45:40 +0100
From: Luc Saillard <luc@saillard.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Udo van den Heuvel <udovdh@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine ethernet driver bug
Message-ID: <20050117154540.GA2642@sd291.sivit.org>
References: <001001c4faf7$71a26230$450aa8c0@hierzo> <20050117120427.GA20370@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117120427.GA20370@logos.cnet>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 10:04:27AM -0200, Marcelo Tosatti wrote:
> On Sat, Jan 15, 2005 at 12:43:33PM +0100, Udo van den Heuvel wrote:

> > On my firewall (VIA EPIA CL-6000 with VIA Rhine network chips running FC3
> > and custom kernels) I see messages like:
> 
> What kernel version are you using? Its important to inform that.

Hi,
 I've the same problem with a VIA EPIA M9000 using the Via rhine controller.
My kernel is 2.6.10-ac7. But the problem can be see with a 2.4.27.
String use to identify the driver:

via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
eth0: VIA Rhine II at 0xe800, 00:40:63:c5:00:f0, IRQ 15.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.

It's not a critical bug, but if we can resolv the bug ...

Luc

# mii-tool
eth0: negotiated 100baseTx-FD flow-control, link ok
eth1: negotiated 100baseTx-FD flow-control, link ok


eth0      Link encap:Ethernet  HWaddr 00:40:63:C5:00:F0
          inet addr:00000000000000  Bcast:00000000000000  Mask:0000000000000
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:42973550 errors:0 dropped:0 overruns:0 frame:686
          TX packets:46277158 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1051423138 (1002.7 MiB)  TX bytes:412421040 (393.3 MiB)
          Interrupt:15 Base address:0xe800


Linux version 2.6.10-ac7 (luc@elite1) (version gcc 3.3.5 (Debian 1:3.3.5-5)) #1 Sun Jan 9 12:08:51 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000dff0000 (usable)
 BIOS-e820: 000000000dff0000 - 000000000dff3000 (ACPI NVS)
 BIOS-e820: 000000000dff3000 - 000000000e000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
223MB LOWMEM available.
On node 0 totalpages: 57328
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 53232 pages, LIFO batch:12
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Built 1 zonelists
Kernel command line: root=/dev/hda7 ro ide1=noprobe ide2=noprobe ide3=noprobe ide4=noprobe ide5=noprobe video=vesa:ywrap,vram:32 vga=788 panic=60 
ide_setup: ide1=noprobe
ide_setup: ide2=noprobe
ide_setup: ide3=noprobe
ide_setup: ide4=noprobe
ide_setup: ide5=noprobe
Initializing CPU#0
CPU 0 irqstacks, hard=c03a5000 soft=c03a4000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 930.029 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 223556k/229312k available (1788k kernel code, 5256k reserved, 762k data, 128k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1854.66 BogoMIPS (lpj=9273344)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 00803035 80803035 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps:        00803135 80803035 00000000 00000000
CPU: Centaur VIA Ezra stepping 0a
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb260, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Via IRQ fixup
PCI: Via IRQ fixup
PCI: Using IRQ router default [1106/3123] at 0000:00:00.0
Initializing Cryptographic API
vesafb: framebuffer at 0xe4000000, mapped to 0xce880000, using 1875k, total 32768k
vesafb: mode is 800x600x16, linelength=1600, pages=31
vesafb: protected mode interface info at c000:7dc7
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
mtrr: 0xe4000000,0x2000000 overlaps existing 0xe4000000,0x800000
mtrr: 0xe4000000,0x1000000 overlaps existing 0xe4000000,0x800000
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: Maximum main memory to use for agp memory: 176M
agpgart: AGP aperture is 64M @ 0xe0000000
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
loop: loaded (max 8 devices)
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
eth0: VIA Rhine II at 0xe800, 00:40:63:c5:00:f0, IRQ 15.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
Probing IDE interface ide0...
hda: IC25N030ATCS04-0, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/1768KiB Cache, CHS=58140/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 1.0.6 (Sun Aug 15 07:17:53 2004 UTC).
PCI: Setting latency timer of device 0000:00:11.5 to 64
ALSA device list:
  #0: VIA 8235 with VT1616i at 0xe400, irq 10
u32 classifier
    Perfomance counters on
    OLD policer on 
    input device check on 
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (1791 buckets, 14328 max) - 300 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 128k freed
Adding 497972k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda7, internal journal
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth1: e100_probe: addr 0xeb101000, irq 11, MAC addr 00:D0:B7:21:DA:44
e100: eth1: e100_watchdog: link up, 100Mbps, full-duplex
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
HTB init, kernel part version 3.17
Ingress scheduler: Classifier actions prefered over netfilter




Jan 16 10:42:00 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x0 length 0 status 00000600!
Jan 16 10:42:00 epia kernel: eth0: Oversized Ethernet frame cd503000 vs cd503000.
Jan 16 10:42:00 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x1 length 1646 status 066e8d00!
Jan 16 10:42:00 epia kernel: eth0: Oversized Ethernet frame cd503010 vs cd503010.
Jan 16 10:53:02 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x1 length 0 status 00000600!
Jan 16 10:53:02 epia kernel: eth0: Oversized Ethernet frame cd503010 vs cd503010.
Jan 16 10:53:02 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x2 length 1646 status 066e8d00!
Jan 16 10:53:02 epia kernel: eth0: Oversized Ethernet frame cd503020 vs cd503020.
Jan 16 10:53:03 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x4 length 0 status 00000600!
Jan 16 10:53:03 epia kernel: eth0: Oversized Ethernet frame cd503040 vs cd503040.
Jan 16 10:53:03 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x5 length 1646 status 066e8d00!
Jan 16 10:53:03 epia kernel: eth0: Oversized Ethernet frame cd503050 vs cd503050.
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xf length 0 status 00000600!
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame cd5030f0 vs cd5030f0.
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x0 length 1646 status 066e8d00!
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame cd503000 vs cd503000.
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x4 length 0 status 00000600!
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame cd503040 vs cd503040.
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x5 length 1672 status 06888d00!
Jan 16 11:10:52 epia kernel: eth0: Oversized Ethernet frame cd503050 vs cd503050.
Jan 16 11:10:53 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x1 length 0 status 00000600!
Jan 16 11:10:53 epia kernel: eth0: Oversized Ethernet frame cd503010 vs cd503010.
Jan 16 11:10:53 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x2 length 1542 status 06068d00!
Jan 16 11:10:53 epia kernel: eth0: Oversized Ethernet frame cd503020 vs cd503020.
Jan 16 11:13:03 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xd length 0 status 00000600!
Jan 16 11:13:03 epia kernel: eth0: Oversized Ethernet frame cd5030d0 vs cd5030d0.
Jan 16 11:13:03 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0xe length 1848 status 07388d00!
Jan 16 11:13:03 epia kernel: eth0: Oversized Ethernet frame cd5030e0 vs cd5030e0.
Jan 16 11:13:10 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x5 length 0 status 00000600!
Jan 16 11:13:10 epia kernel: eth0: Oversized Ethernet frame cd503050 vs cd503050.
Jan 16 11:13:10 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x6 length 1646 status 066e8d00!
Jan 16 11:13:10 epia kernel: eth0: Oversized Ethernet frame cd503060 vs cd503060.
Jan 16 11:13:34 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x2 length 0 status 00000600!
Jan 16 11:13:34 epia kernel: eth0: Oversized Ethernet frame cd503020 vs cd503020.
Jan 16 11:13:34 epia kernel: eth0: Oversized Ethernet frame spanned multiple buffers, entry 0x3 length 1984 status 07c08d00!

