Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTLYSPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 13:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTLYSPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 13:15:45 -0500
Received: from smtp06.ya.com ([62.151.11.163]:63426 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S264340AbTLYSPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 13:15:18 -0500
Message-ID: <3FEB49F4.1090405@wanadoo.es>
Date: Thu, 25 Dec 2003 21:35:00 +0100
From: =?ISO-8859-1?Q?Luis_Miguel_Garc=EDa?= <ktech@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031206 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LINUX KERNEL MAILING LIST <linux-kernel@vger.kernel.org>,
       Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
References: <3FEAECA4.6030201@wanadoo.es> <3FEAF5A3.2090307@wmich.edu>
In-Reply-To: <3FEAF5A3.2090307@wmich.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had never seen this, but could be related:

hda: ST380023A, ATA DISK drive

hda: IRQ probe failed (0xfdba)

hdb: IRQ probe failed (0xfdba)

hdb: IRQ probe failed (0xfdba)

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive

ide1 at 0x170-0x177,0x376 on irq 15

hda: max request size: 128KiB



IRQ probe failed? What is this? Any tip?

Full dmesg:


Linux version 2.6.0-test11 (root@txiki) (gcc versión 3.3.2 20031022 
(Gentoo Linux 3.3.2-r3, propolice)) #1 Sun Nov 30 13:57:31 CET 2003

BIOS-provided physical RAM map:

BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)

BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)

BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)

BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)

BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

Warning only 896MB will be used.

Use a HIGHMEM enabled kernel.

896MB LOWMEM available.

On node 0 totalpages: 229376

 DMA zone: 4096 pages, LIFO batch:1

 Normal zone: 225280 pages, LIFO batch:16

 HighMem zone: 0 pages, LIFO batch:1

DMI 2.2 present.

ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6b60

ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000

ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040

ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff79c0

ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000

Building zonelist for node : 0

Kernel command line: BOOT_IMAGE=260test11 ro root=304

Initializing CPU#0

PID hash table entries: 4096 (order 12: 32768 bytes)

Detected 1883.387 MHz processor.

Console: colour VGA+ 80x25

Memory: 904716k/917504k available (1855k kernel code, 12004k reserved, 
724k data, 116k init, 0k highmem)

Calibrating delay loop... 3727.36 BogoMIPS

Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)

Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000

CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000

CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)

CPU: L2 Cache: 512K (64 bytes/line)

CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: AMD Athlon(tm)  stepping 00

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

NET: Registered protocol family 16

PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

ACPI: Subsystem revision 20031002

ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd

ACPI: Interpreter enabled

ACPI: Using PIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]

ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]

ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)

ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)

ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)

ACPI: PCI Interrupt Link [APC1] (IRQs *16)

ACPI: PCI Interrupt Link [APC2] (IRQs 17)

ACPI: PCI Interrupt Link [APC3] (IRQs *18)

ACPI: PCI Interrupt Link [APC4] (IRQs *19)

ACPI: PCI Interrupt Link [APCE] (IRQs 16)

ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCS] (IRQs *23)

ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)

ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)

Linux Plug and Play Support v0.97 (c) Adam Belay

ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 10

ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 11

ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5

ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10

ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10

ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 10

ACPI: PCI Interrupt Link [LACI] enabled at IRQ 5

ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 11

ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 11

ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11

ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5

PCI: Using ACPI for IRQ routing

PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'

devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)

devfs: boot_options: 0x0

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

ACPI: Power Button (FF) [PWRF]

ACPI: Fan [FAN] (on)

ACPI: Processor [CPU0] (supports C1)

ACPI: Thermal Zone [THRM] (33 C)

pty: 256 Unix98 ptys configured

Using anticipatory io scheduler

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

NFORCE2: IDE controller at PCI slot 0000:00:09.0

NFORCE2: chipset revision 162

NFORCE2: not 100% native mode: will probe irqs later

NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller

   ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA

   ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA

hda: ST380023A, ATA DISK drive

hda: IRQ probe failed (0xfdba)

hdb: IRQ probe failed (0xfdba)

hdb: IRQ probe failed (0xfdba)

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive

ide1 at 0x170-0x177,0x376 on irq 15

hda: max request size: 128KiB

hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, 
UDMA(100)

/dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3 p4

hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

Uniform CD-ROM driver Revision: 3.12

mice: PS/2 mouse device common for all mice

input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

serio: i8042 AUX port at 0x60,0x64 irq 12

input: AT Translated Set 2 keyboard on isa0060/serio0

serio: i8042 KBD port at 0x60,0x64 irq 1

NET: Registered protocol family 2

IP: routing cache hash table of 8192 buckets, 64Kbytes

TCP: Hash tables configured (established 262144 bind 65536)

NET: Registered protocol family 1

NET: Registered protocol family 17

found reiserfs format "3.6" with standard journal

Reiserfs journal params: device hda4, size 8192, journal first block 18, 
max trans len 1024, max batch 900, max commit age 30, max trans age 30

reiserfs: checking transaction log (hda4) for (hda4)

Using r5 hash to sort names

VFS: Mounted root (reiserfs filesystem) readonly.

Freeing unused kernel memory: 116k freed

Adding 498004k swap on /dev/hda3.  Priority:-1 extents:1

SCSI subsystem initialized

nvnet: no version for "struct_module" found: kernel tainted.

nvnet: module license 'NVIDIA' taints kernel.

PCI: Setting latency timer of device 0000:00:04.0 to 64

nvnet: selecting duplex setting as auto duplex mode.

nvnet: selecting speed settings as auto-negotiation.

nvnet: Optimizing driver for throughput

Linux agpgart interface v0.100 (c) Dave Jones

agpgart: Detected NVIDIA nForce2 chipset

agpgart: Maximum main memory to use for agp memory: 816M

agpgart: AGP aperture is 64M @ 0xd0000000

drivers/usb/core/usb.c: registered new driver usbfs

drivers/usb/core/usb.c: registered new driver hub

Real Time Clock Driver v1.12

PCI: Setting latency timer of device 0000:00:06.0 to 64

intel8x0: clocking to 47491

Linux video capture interface: v1.00

bttv: driver version 0.9.12 loaded

bttv: using 8 buffers with 2080k (520 pages) each for capture

bttv: Bt8xx card found (0).

bttv0: Bt878 (rev 2) at 0000:01:08.0, irq: 11, latency: 32, mmio: 0xd4000000

bttv0: using: Prolink PixelView PlayTV pro [card=37,insmod option]

bttv0: using tuner=2

bttv0: i2c: checking for TDA9875 @ 0xb0... not found

bttv0: i2c: checking for TDA7432 @ 0x8a... not found

tuner: chip found @ 0xc2

tuner(bttv): type forced to 1 (Philips PAL_I (FI1246 and compatibles)) 
[insmod]

tuner: type already set (1)

registering 0-0061

bttv0: registered device video0

bttv0: registered device vbi0

bttv0: PLL: 28636363 => 35468950 .. ok

ehci_hcd 0000:00:02.2: EHCI Host Controller

PCI: Setting latency timer of device 0000:00:02.2 to 64

ehci_hcd 0000:00:02.2: irq 10, pci mem f8a31000

ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1

PCI: cache line size of 64 is not supported by device 0000:00:02.2

ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13

hub 1-0:1.0: USB hub found

hub 1-0:1.0: 6 ports detected

ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)

ohci_hcd: block sizes: ed 64 td 64

ohci_hcd 0000:00:02.0: OHCI Host Controller

PCI: Setting latency timer of device 0000:00:02.0 to 64

ohci_hcd 0000:00:02.0: irq 11, pci mem f8a40000

ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2

hub 2-0:1.0: USB hub found

hub 2-0:1.0: 3 ports detected

ohci_hcd 0000:00:02.1: OHCI Host Controller

PCI: Setting latency timer of device 0000:00:02.1 to 64

ohci_hcd 0000:00:02.1: irq 5, pci mem f8a42000

ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3

hub 3-0:1.0: USB hub found

hub 3-0:1.0: 3 ports detected

vmmon: no version magic, tainting kernel.

vmmon: module license 'unspecified' taints kernel.

/dev/vmmon: Module vmmon: registered with major=10 minor=165

/dev/vmmon: Module vmmon: initialized

vmnet: no version magic, tainting kernel.

vmnet: module license 'unspecified' taints kernel.

/dev/vmnet: open called by PID 4795 (vmnet-bridge)

/dev/vmnet: hub 0 does not exist, allocating memory.

/dev/vmnet: port on hub 0 successfully opened

bridge-eth0: up

bridge-eth0: attached

/dev/vmnet: open called by PID 4837 (vmnet-natd)

/dev/vmnet: hub 8 does not exist, allocating memory.

/dev/vmnet: port on hub 8 successfully opened

/dev/vmnet: open called by PID 5227 (vmnet-netifup)

/dev/vmnet: port on hub 8 successfully opened

/dev/vmnet: open called by PID 5226 (vmnet-netifup)

/dev/vmnet: hub 1 does not exist, allocating memory.

/dev/vmnet: port on hub 1 successfully opened

/dev/vmnet: open called by PID 5265 (vmnet-dhcpd)

/dev/vmnet: port on hub 8 successfully opened

/dev/vmnet: open called by PID 5258 (vmnet-dhcpd)

/dev/vmnet: port on hub 1 successfully opened

fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, 
Starnberg, GERMANY' taints kernel.

[fglrx] Maximum main memory to use for locked dma buffers: 804 MBytes.

[fglrx] module loaded - fglrx 3.2.8 [Sep 21 2003] on minor 0

[fglrx] AGP detected, AgpState   = 0x1f00421b (hardware caps of chipset)

agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.

agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode

agpgart: Putting AGP V3 device at 0000:02:00.0 into 8x mode

[fglrx] AGP enabled,  AgpCommand = 0x1f004312 (selected caps)

[fglrx] free  AGP = 54800384

[fglrx] max   AGP = 54800384

[fglrx] free  LFB = 126099456

[fglrx] max   LFB = 126099456

[fglrx] free  Inv = 0

[fglrx] max   Inv = 0

[fglrx] total Inv = 0

[fglrx] total TIM = 0

[fglrx] total FB  = 0

[fglrx] total AGP = 16384




Ed Sweetman wrote:

> Perhaps a dmesg output can provide some commanility with other people 
> seeing a loss? Maybe some side by side's of 2.4 performance tests?
>
> Also, you're not nicing any of the tests from 0, right?
>
>
>
> Luis Miguel García wrote:
>
>> Hello:
>>
>> Any of you knows how to look at this results? They still seems very 
>> low for me. It's an AMD Athlon 2500+. Hard Disc Seagate Barracuda ATA 
>> V. Nforce-2 motherboard.
>>
>> kernel 2.6.0-test11
>>
>> Any tip? Or is this correct?
>>
>> bonnie++
>>
>> Version  1.03       ------Sequential Output------ --Sequential Input- 
>> --Random-
>>                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
>> --Seeks--
>> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec 
>> %CP  /sec %CP
>> txiki            2G 21270  87 32856  11 10533   3 10962  51 28744   5 
>> 157.0   0
>>                    ------Sequential Create------ --------Random 
>> Create--------
>>                    -Create-- --Read--- -Delete-- -Create-- --Read--- 
>> -Delete--
>>              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  
>> /sec %CP
>>                 16 21675  96 +++++ +++ 23523 100 23700  99 +++++ +++ 
>> 13062  61
>> txiki,2G,21270,87,32856,11,10533,3,10962,51,28744,5,157.0,0,16,21675,96,+++++,++ 
>>
>> +,23523,100,23700,99,+++++,+++,13062,61
>> bash-2.05b$
>
>
>
>

