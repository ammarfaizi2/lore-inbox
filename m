Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272314AbTG3W4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272320AbTG3W4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:56:15 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:55428 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272314AbTG3WzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:55:25 -0400
Date: Thu, 31 Jul 2003 00:55:00 +0200
From: Pavel Machek <pavel@suse.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about taskfile?
Message-ID: <20030730225500.GC144@elf.ucw.cz>
References: <20030730205935.GA238@elf.ucw.cz> <Pine.SOL.4.30.0307302336410.1566-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307302336410.1566-100000@mion.elka.pw.edu.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I had some strange fs corruption, and andi suggested that it probably
> > is TASKFILE-related. Perhaps this is good idea?
> 
> Idea is good.
> 
> Did corruption go away after disabling taskfile?

Not sure, it took week for corruption to creep in, and it might have
been loop-related or swsusp-related. I'm not at all sure it was
TASKFILE, but I'm turning it off for now.

At least it is strange to have option that says both "experimental"
and "it is safe to say Y". What are those "most cases"?

								Pavel

config IDE_TASKFILE_IO
        bool 'IDE Taskfile IO (EXPERIMENTAL)'
        depends on BLK_DEV_IDE && EXPERIMENTAL
        default n
        ---help---
          Use new taskfile IO code.

          It is safe to say Y to this question, in most cases.


> Taskfile was by default on for 2.5.72 and 2.5.73 and Andi's unexplained
> x86-64 + AMD8111 corruption was the only one reported to me / on lkml.
> 
> dmesg and hdparm /dev/scratchdisk for a start, please.

Linux version 2.6.0-test2 (pavel@amd) (gcc version 2.95.4 20011002 (Debian prerelease)) #9 Mon Jul 28 21:19:57 CEST 2003
Video mode to be used for restore is 317
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7c20
ACPI: RSDT (v001 PTLTD    RSDT   01540.00000) @ 0x0fffcc46
ACPI: FADT (v001 ALI    M1533    01540.00000) @ 0x0fffef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.00000) @ 0x0fffefd8
ACPI: DSDT (v001 COMPAL      736 01540.00000) @ 0x00000000
ACPI: BIOS passes blacklist
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=test ro root=304 BOOT_FILE=/boot/test enableapic hdc=ide-scsi resume=/dev/hda1
ide_setup: hdc=ide-scsi
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 900.409 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 1773.56 BogoMIPS
Memory: 253632k/262080k available (3175k kernel code, 7724k reserved, 1434k data, 184k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383f9ff c1c7f9ff 00000000 00000020
CPU: AMD mobile AMD Athlon(tm) 4 Processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfd8b0, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030714
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................
Table [DSDT](id F004) - 329 Objects with 28 Devices 84 Methods 9 Regions
ACPI Namespace successfully loaded at root c05ce95c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 63 [_GPE] 8 regs at 0000000000008018 on int 9
Completing Region/Field/Buffer/Package initialization:...............................................
Initialized 9/9 Regions 0/0 Fields 22/22 Buffers 16/16 Packages (337 nodes)
Executing all Device _STA and_INI methods:.............................
29 Devices found containing: 29 _STA, 0 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 7, disabled)
ACPI: PCI Interrupt Link [LNKD] (IRQs 11, disabled)
ACPI: PCI Interrupt Link [LNKU] (IRQs *9)
ACPI: Embedded Controller [EC0] (gpe 25)
ACPI: Power Resource [PFAN] (off)
SCSI subsystem initialized
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
 pci_irq-0294 [17] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:0f.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.0 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
irda_init()
vesafb: framebuffer at 0xee000000, mapped to 0xd0808000, size 8192k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at c000:7652
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f7ab0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:2 (@c00f7ae4)
powernow:  cpuid: 0x761	fsb: 100	maxFID: 0xc	startvid: 0xc
powernow:    FID: 0x10 (3.0x [300MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x4 (5.0x [500MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x6 (6.0x [600MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x8 (7.0x [700MHz])	VID: 0xc (1.400V)
powernow:    FID: 0xc (9.0x [900MHz])	VID: 0xc (1.400V)

powernow: Minimum speed 300 MHz. Maximum speed 900 MHz.
Coda Kernel/Venus communications, v5.3.15, coda@cs.cmu.edu
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.4 [Flags: R/O DEBUG].
udf: registering filesystem
Limiting direct PCI/PCI transfers.
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SBTN]
Initing ACPI health:
~~~~~~~~~~~~~~~~~~~:
Calling \RIN1
health: calling \RIN1 failed
1.8V: -1
Calling \RIN2
health: calling \RIN2 failed
3.3V: -1
Calling \RIN3
health: calling \RIN3 failed
5V: -1
Calling \RIN4
health: calling \RIN4 failed
12V: -1
Calling \RIN5
health: calling \RIN5 failed
-12V: -1
Calling \TIN1
health: calling \TIN1 failed
CPU internal temp: -1
Calling \TIN2
health: calling \TIN2 failed
CPU external temp: -1
Calling \RFN1
health: calling \RFN1 failed
CPU fan: -1
Calling \RFN2
health: calling \RFN2 failed
System fan: -1
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2, 8 throttling states)
[ACPI Debug] String: __________________________________
[ACPI Debug] String: 
[ACPI Debug] String: _SCP
[ACPI Debug] String: __________________________________
ACPI: Thermal Zone [THRM] (31 C)
lp: driver loaded but no devices found
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP(,...)]
parport0: irq 7 detected
lp0: using parport0 (polling).
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
pcnet32.c:v1.27b 01.10.2002 tsbogend@alpha.franken.de
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Enabling device 0000:00:10.0 (0010 -> 0013)
eth0: ADMtek Comet rev 17 at 0xd1009000, 00:D0:59:91:66:18, IRQ 11.
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:0f.0
 pci_irq-0294 [18] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:0f.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:0f.0 - using IRQ 255
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23CA-20, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: TOSHIBA DVD-ROM SD-R2002, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=38760/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2002  Rev: 1029
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
Console: switching to colour frame buffer device 128x48
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000006
Yenta IRQ list 04b8, PCI irq11
Socket status: 30000010
Intel PCIC probe: not found.
ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
ohci-hcd 0000:00:02.0: irq 9, pci mem d1013000
ohci-hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
drivers/usb/core/usb.c: registered new driver acm
drivers/usb/class/cdc-acm.c: v0.21:USB Abstract Control Model driver for USB modems and ISDN adapters
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver vicam
drivers/usb/core/usb.c: registered new driver usbnet
mice: PS/2 mouse device common for all mice
input: PC Speaker
atkbd.c: keyboard reset failed on isa0060/serio1
input: PS/2 Synaptics TouchPad on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-ali1535 version 2.7.0 (20021208)
i2c-ali15x3.o version 2.7.0 (20021208)
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
ALSA device list:
  #0: ESS Allegro PCI at 0x1400, irq 5
oprofile: using timer interrupt.
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
irlan_init()
irlan_register_netdev()
IrCOMM protocol (Dag Brattli)
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S1 S3 S4 S4bios S5)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
Resume Machine: resuming from /dev/hda1
Resuming from device hda1
Resume Machine: This is normal swap space
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 184k freed
Adding 433712k swap on /dev/hda1.  Priority:-1 extents:1
end_request: I/O error, dev fd0, sector 0
cs: IO port probe 0x0310-0x0380: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0x60000000-0x60ffffff: clean.
eth1: NE2000 Compatible: io 0x320, irq 7, hw_addr 00:80:C8:80:25:99
coda_read_super: Bad mount data
coda_read_super: device index: 0
coda_read_super: No pseudo device

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 38760/16/63, sectors = 39070080, start = 0


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
