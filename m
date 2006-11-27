Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933168AbWK0TBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbWK0TBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540AbWK0TBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:01:53 -0500
Received: from bundure.hst.terra.com.br ([200.176.10.195]:14563 "EHLO
	bundure.hst.terra.com.br") by vger.kernel.org with ESMTP
	id S1757894AbWK0TBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:01:51 -0500
X-Terra-Karma: -2%
X-Terra-Hash: 488b9f9633c5412ed1fe0bd48a8447c2
Message-ID: <456B3621.4010806@terra.com.br>
Date: Mon, 27 Nov 2006 17:01:53 -0200
From: Piter PUNK <piterpk@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060914 SeaMonkey/1.0.5
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sis900: Disabling IRQ 3 - not working!
Content-Type: multipart/mixed;
 boundary="------------040400070506090604030905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040400070506090604030905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

	I have one Acer Aspire 3003LCi laptop with a sis900 built-in
card. In any kernel from 2.6 series when i "ifconfig" or "dhcpcd" the
sis900 card, the machine hangs a little time give error messages in
the console (talking about irqpoll) and them start to work again,
disabling the IRQ 3. It works fine (without hang or anything) if
i disable ACPI.

	Trying to solve the problem, i upgrade the kernel to 2.6.19rc6
and now i have a new problem. If i boot with "acpi=off", all works
fine and yenta and sis900 shares the IRQ 3. You can see that in
dmesg-2.6.19-rc6-acpi_off and proc_interrupts-2.6.19-rc6-acpi_off.

	With acpi=on and (with or without) irqpoll the card is dead.
It hangs the machine a little, disables the interrupt (as does in
2.6.17.13) but the card won't work and won't talk with other cards
in three or four different networks.

	I attach the dmesg and /proc/interrupts from that non-working
situations:

	- dmesg-2.6.19-rc6-acpi_on
	- dmesg-2.6.19-rc6-irqpoll (with acpi activated)
	- proc_interrupts-2.6.19-rc6-acpi_on
	- proc_interrupts-2.6.19-rc6-irqpoll (with acpi activated)

	Maybe the problem isn't in sis900 driver, but in yenta. That
doesn't catch the IRQ 3 when using ACPI.

				Thanks for your help,

							Piter PUNK

PS/1> If you need any extra information i will be glad to give it to you
PS/2> I don't subscribe LKML, please CC the answers to me.
-- 
     |        E-Mail: piterpk@terra.com.br        (personal)
    .|.               roberto.batista@ntux.com.br (professional)
    /V\
   // \\      UIN:116043354  Homepage:http://piterpunk.info02.com.br
  /(   )\
   ^`~'^         ----> Slackware Linux - The Best One! <----
  #105432

--------------040400070506090604030905
Content-Type: text/plain;
 name="dmesg-2.6.19-rc6-acpi_off"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.19-rc6-acpi_off"

Linux version 2.6.19-rc6 (root@megaman) (gcc version 3.4.6) #1 Thu Nov 23 16:01:38 BRST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
 BIOS-e820: 000000001bef0000 - 000000001befa000 (ACPI data)
 BIOS-e820: 000000001befa000 - 000000001bf00000 (ACPI NVS)
 BIOS-e820: 000000001bf00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
446MB LOWMEM available.
Entering add_active_range(0, 0, 114416) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   114416
  HighMem    114416 ->   114416
early_node_map[1] active PFN ranges
    0:        0 ->   114416
On node 0 totalpages: 114416
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 861 pages used for memmap
  Normal zone: 109459 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI present.
Allocating PCI resources starting at 30000000 (gap: 20000000:dff00000)
Detected 1800.159 MHz processor.
Built 1 zonelists.  Total pages: 113523
Kernel command line: BOOT_IMAGE=Linux-Test ro root=305 acpi=off
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449252k/457664k available (2383k kernel code, 7860k reserved, 704k data, 208k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffea000 - 0xfffff000   (  84 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xdc800000 - 0xff7fe000   ( 559 MB)
    lowmem  : 0xc0000000 - 0xdbef0000   ( 446 MB)
      .init : 0xc0406000 - 0xc043a000   ( 208 kB)
      .data : 0xc0353de5 - 0xc0403ff4   ( 704 kB)
      .text : 0xc0100000 - 0xc0353de5   (2383 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3601.94 BogoMIPS (lpj=7203886)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff c3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 128K (64 bytes/line)
CPU: After all inits, caps: 078bfbff c3d3fbff 00000000 00000410 00000001 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Mobile AMD Sempron(tm) Processor 3000+ stepping 02
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 376k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd776, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
Boot video device is 0000:01:00.0
PCI: Using IRQ router SIS [1039/0963] at 0000:00:02.0
PCI: setting IRQ 4 as level-triggered
PCI: Found IRQ 4 for device 0000:00:02.1
PCI: Sharing IRQ 4 with 0000:00:0b.0
PCI: setting IRQ 7 as level-triggered
PCI: Found IRQ 7 for device 0000:00:02.5
PCI: setting IRQ 3 as level-triggered
PCI: Found IRQ 3 for device 0000:00:06.0
PCI: Sharing IRQ 3 with 0000:00:04.0
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: e2100000-e21fffff
  PREFETCH window: e8000000-efffffff
PCI: Bus 2, cardbus bridge: 0000:00:06.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
PCI: Found IRQ 3 for device 0000:00:06.0
PCI: Sharing IRQ 3 with 0000:00:04.0
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
apm: BIOS not found.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xe8000000, mapped to 0xdc800000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at cbe6:000c
vesafb: pmi: set display start = c00cbe96, set palette = c00cbeda
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PCI: setting IRQ 5 as level-triggered
PCI: Found IRQ 5 for device 0000:00:02.6
PCI: Sharing IRQ 5 with 0000:00:02.7
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
PCI: Found IRQ 7 for device 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS424040M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Slimtype COMBO SOSC-2483K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78140160 sectors (40007 MB) w/1739KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
EXT2-fs warning (device hda5): ext2_fill_super: mounting ext3 filesystem as ext2
VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... <6>input: AT Translated Set 2 keyboard as /class/input/input0
okay
Freeing unused kernel memory: 208k freed
Adding 1004020k swap on /dev/hda1.  Priority:-1 extents:1 across:1004020k
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected SiS 760 chipset
agpgart: AGP aperture is 4M @ 0xe0000000
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: setting IRQ 9 as level-triggered
PCI: Found IRQ 9 for device 0000:00:03.0
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.0: irq 9, io mem 0xe2002000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
libata version 2.00 loaded.
PCI: setting IRQ 11 as level-triggered
PCI: Found IRQ 11 for device 0000:00:03.1
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.1: irq 11, io mem 0xe2003000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
sis900.c: v1.08.10 Apr. 2 2006
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x8100
PCI: setting IRQ 10 as level-triggered
PCI: Found IRQ 10 for device 0000:00:03.2
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: irq 10, io mem 0xe2004000
ehci_hcd 0000:00:03.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
input: PC Speaker as /class/input/input1
Yenta: CardBus bridge found at 0000:00:06.0 [1025:0083]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:06.0, mfunc 0x00521d22, devctl 0x64
Yenta: ISA IRQ mask 0x0040, PCI irq 3
Socket status: 30000006
PCI: Found IRQ 3 for device 0000:00:04.0
PCI: Sharing IRQ 3 with 0000:00:06.0
0000:00:04.0: Realtek RTL8201 PHY transceiver found at address 13.
0000:00:04.0: Using transceiver found at address 13 as default
eth0: SiS 900 PCI Fast Ethernet at 0x1800, IRQ 3, 00:c0:9f:da:d1:08.
PCI: Found IRQ 5 for device 0000:00:02.7
PCI: Sharing IRQ 5 with 0000:00:02.6
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0xa00-0xaff: clean.
intel8x0_measure_ac97_clock: measured 55456 usecs
intel8x0: clocking to 48000
lp: driver loaded but no devices found
fuse init (API version 7.7)
Capability LSM initialized
powernow-k8: Found 1 Mobile AMD Sempron(tm) Processor 3000+ processors (version 2.00.00)
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x13
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xc
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period
TSC appears to be running slowly. Marking it as unstable
Time: pit clocksource has been installed.
eth0: Media Link On 100mbps full-duplex 
eth0: no IPv6 routers present

--------------040400070506090604030905
Content-Type: text/plain;
 name="proc_interrupts-2.6.19-rc6-acpi_off"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_interrupts-2.6.19-rc6-acpi_off"

           CPU0       
  0:     868462    XT-PIC-XT        timer
  1:       6839    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  3:     423582    XT-PIC-XT        yenta, eth0
  5:       3432    XT-PIC-XT        SiS SI7012
  8:          1    XT-PIC-XT        rtc
  9:          0    XT-PIC-XT        ohci_hcd:usb1
 10:          0    XT-PIC-XT        ehci_hcd:usb3
 11:          0    XT-PIC-XT        ohci_hcd:usb2
 12:     286840    XT-PIC-XT        i8042
 14:      13078    XT-PIC-XT        ide0
 15:         69    XT-PIC-XT        ide1
NMI:          0 
ERR:          0

--------------040400070506090604030905
Content-Type: text/plain;
 name="dmesg-2.6.19-rc6-acpi_on"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.19-rc6-acpi_on"

Linux version 2.6.19-rc6 (root@megaman) (gcc version 3.4.6) #1 Thu Nov 23 16:01:38 BRST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
 BIOS-e820: 000000001bef0000 - 000000001befa000 (ACPI data)
 BIOS-e820: 000000001befa000 - 000000001bf00000 (ACPI NVS)
 BIOS-e820: 000000001bf00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
446MB LOWMEM available.
Entering add_active_range(0, 0, 114416) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   114416
  HighMem    114416 ->   114416
early_node_map[1] active PFN ranges
    0:        0 ->   114416
On node 0 totalpages: 114416
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 861 pages used for memmap
  Normal zone: 109459 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7f60
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1bef619d
ACPI: FADT (v001 SiS    755F     0x06040000 PTL  0x000f4240) @ 0x1bef9e3e
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1bef9eb2
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1bef9f88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1bef9fd8
ACPI: DSDT (v001 PTLTD       755 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 20000000:dff00000)
Detected 1800.146 MHz processor.
Built 1 zonelists.  Total pages: 113523
Kernel command line: BOOT_IMAGE=Linux-Test ro root=305 3
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449252k/457664k available (2383k kernel code, 7860k reserved, 704k data, 208k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffea000 - 0xfffff000   (  84 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xdc800000 - 0xff7fe000   ( 559 MB)
    lowmem  : 0xc0000000 - 0xdbef0000   ( 446 MB)
      .init : 0xc0406000 - 0xc043a000   ( 208 kB)
      .data : 0xc0353de5 - 0xc0403ff4   ( 704 kB)
      .text : 0xc0100000 - 0xc0353de5   (2383 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3601.97 BogoMIPS (lpj=7203943)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff c3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 128K (64 bytes/line)
CPU: After all inits, caps: 078bfbff c3d3fbff 00000000 00000410 00000001 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Mobile AMD Sempron(tm) Processor 3000+ stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0800 (from 0eb8)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 376k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd776, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 *7 9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: e2100000-e21fffff
  PREFETCH window: e8000000-efffffff
PCI: Bus 2, cardbus bridge: 0000:00:06.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
ACPI: Unable to derive IRQ for device 0000:00:06.0
ACPI: PCI Interrupt 0000:00:06.0[A]: no GSI
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x38 set to 0x1
apm: BIOS not found.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xe8000000, mapped to 0xdc880000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at cbe6:000c
vesafb: pmi: set display start = c00cbe96, set palette = c00cbeda
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.6[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt for device 0000:00:02.6 disabled
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:02.5[A] -> Link [LNKA] -> GSI 7 (level, low) -> IRQ 7
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS424040M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Slimtype COMBO SOSC-2483K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78140160 sectors (40007 MB) w/1739KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
input: AT Translated Set 2 keyboard as /class/input/input0
EXT2-fs warning (device hda5): ext2_fill_super: mounting ext3 filesystem as ext2
VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... okay
Freeing unused kernel memory: 208k freed
Adding 1004020k swap on /dev/hda1.  Priority:-1 extents:1 across:1004020k
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
input: PC Speaker as /class/input/input1
Linux agpgart interface v0.101 (c) Dave Jones
libata version 2.00 loaded.
sis900.c: v1.08.10 Apr. 2 2006
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
intel8x0_measure_ac97_clock: measured 55470 usecs
intel8x0: clocking to 48000
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
agpgart: Detected SiS 760 chipset
agpgart: AGP aperture is 4M @ 0xe0000000
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x8100
Yenta: CardBus bridge found at 0000:00:06.0 [1025:0083]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:06.0, mfunc 0x00521d22, devctl 0x64
Yenta: request_irq() in yenta_probe_cb_irq() failed!
Yenta TI: socket 0000:00:06.0 no PCI interrupts. Fish. Please report.
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x0658, PCI irq 0
Socket status: 30000006
ACPI: Unable to derive IRQ for device 0000:00:04.0
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI - using IRQ 3
PCI: setting IRQ 3 as level-triggered
0000:00:04.0: Realtek RTL8201 PHY transceiver found at address 13.
0000:00:04.0: Using transceiver found at address 13 as default
eth0: SiS 900 PCI Fast Ethernet at 0x1800, IRQ 3, 00:c0:9f:da:d1:08.
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKE] -> GSI 9 (level, low) -> IRQ 9
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:03.0: irq 9, io mem 0xe2002000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.1[B] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.1: irq 11, io mem 0xe2003000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:03.2[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 3
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: irq 10, io mem 0xe2004000
ehci_hcd 0000:00:03.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0xa00-0xaff: clean.
lp: driver loaded but no devices found
fuse init (API version 7.7)
Capability LSM initialized
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
powernow-k8: Found 1 Mobile AMD Sempron(tm) Processor 3000+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xc
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x13
Time: acpi_pm clocksource has been installed.
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period
irq 3: nobody cared (try booting with the "irqpoll" option)
 [<c013b72a>] __report_bad_irq+0x2a/0x90
 [<c013b859>] note_interrupt+0x99/0xd0
 [<c013be20>] handle_level_irq+0xd0/0x100
 [<c0104ff8>] do_IRQ+0x48/0x90
 [<c0104ffd>] do_IRQ+0x4d/0x90
 [<c010335a>] common_interrupt+0x1a/0x20
 [<c01303b1>] hrtimer_get_softirq_time+0x31/0xb0
 [<c0130384>] hrtimer_get_softirq_time+0x4/0xb0
 [<c01308a5>] hrtimer_run_queues+0x15/0xc0
 [<c01231c2>] run_timer_softirq+0x12/0x190
 [<c01231b4>] run_timer_softirq+0x4/0x190
 [<c011e831>] __do_softirq+0x51/0xb0
 [<c011e8c5>] do_softirq+0x35/0x40
 [<c0104ffd>] do_IRQ+0x4d/0x90
 [<c010335a>] common_interrupt+0x1a/0x20
 =======================
handlers:
[<dcc7cbf0>] (sis900_interrupt+0x0/0x120 [sis900])
Disabling IRQ #3
eth0: Media Link On 100mbps full-duplex 
eth0: no IPv6 routers present

--------------040400070506090604030905
Content-Type: text/plain;
 name="dmesg-2.6.19-rc6-irqpoll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg-2.6.19-rc6-irqpoll"

Linux version 2.6.19-rc6 (root@megaman) (gcc version 3.4.6) #1 Thu Nov 23 16:01:38 BRST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f400 (usable)
 BIOS-e820: 000000000009f400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001bef0000 (usable)
 BIOS-e820: 000000001bef0000 - 000000001befa000 (ACPI data)
 BIOS-e820: 000000001befa000 - 000000001bf00000 (ACPI NVS)
 BIOS-e820: 000000001bf00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
446MB LOWMEM available.
Entering add_active_range(0, 0, 114416) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   114416
  HighMem    114416 ->   114416
early_node_map[1] active PFN ranges
    0:        0 ->   114416
On node 0 totalpages: 114416
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 861 pages used for memmap
  Normal zone: 109459 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f7f60
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1bef619d
ACPI: FADT (v001 SiS    755F     0x06040000 PTL  0x000f4240) @ 0x1bef9e3e
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x1bef9eb2
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1bef9f88
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1bef9fd8
ACPI: DSDT (v001 PTLTD       755 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 30000000 (gap: 20000000:dff00000)
Detected 1800.155 MHz processor.
Built 1 zonelists.  Total pages: 113523
Kernel command line: BOOT_IMAGE=Linux-Test ro root=305 irqpoll
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 449252k/457664k available (2383k kernel code, 7860k reserved, 704k data, 208k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffea000 - 0xfffff000   (  84 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xdc800000 - 0xff7fe000   ( 559 MB)
    lowmem  : 0xc0000000 - 0xdbef0000   ( 446 MB)
      .init : 0xc0406000 - 0xc043a000   ( 208 kB)
      .data : 0xc0353de5 - 0xc0403ff4   ( 704 kB)
      .text : 0xc0100000 - 0xc0353de5   (2383 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3602.00 BogoMIPS (lpj=7204007)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 078bfbff c3d3fbff 00000000 00000000 00000001 00000000 00000001
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 128K (64 bytes/line)
CPU: After all inits, caps: 078bfbff c3d3fbff 00000000 00000410 00000001 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: AMD Mobile AMD Sempron(tm) Processor 3000+ stepping 02
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0800 (from 0eb8)
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 376k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd776, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Uncovering SIS963 that hid as a SIS503 (compatible=0)
Enabling SiS 96x SMBus.
PCI: Ignoring BAR0-3 of IDE controller 0000:00:02.5
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 *7 9 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 *4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 9 10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 *9 10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: e2100000-e21fffff
  PREFETCH window: e8000000-efffffff
PCI: Bus 2, cardbus bridge: 0000:00:06.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Enabling device 0000:00:06.0 (0000 -> 0003)
ACPI: Unable to derive IRQ for device 0000:00:06.0
ACPI: PCI Interrupt 0000:00:06.0[A]: no GSI
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x38 set to 0x1
apm: BIOS not found.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xe8000000, mapped to 0xdc880000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=4
vesafb: protected mode interface info at cbe6:000c
vesafb: pmi: set display start = c00cbe96, set palette = c00cbeda
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.6[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt for device 0000:00:02.6 disabled
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:00:02.5[A] -> Link [LNKA] -> GSI 7 (level, low) -> IRQ 7
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: HTS424040M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
spurious 8259A interrupt: IRQ7.
hdc: Slimtype COMBO SOSC-2483K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 78140160 sectors (40007 MB) w/1739KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 > hda3
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbmon: debugfs is not available
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Time: tsc clocksource has been installed.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
input: AT Translated Set 2 keyboard as /class/input/input0
EXT2-fs warning (device hda5): ext2_fill_super: mounting ext3 filesystem as ext2
VFS: Mounted root (ext2 filesystem) readonly.
Trying to move old root to /initrd ... okay
Freeing unused kernel memory: 208k freed
Adding 1004020k swap on /dev/hda1.  Priority:-1 extents:1 across:1004020k
sis96x_smbus 0000:00:02.1: SiS96x SMBus base address: 0x8100
Linux agpgart interface v0.101 (c) Dave Jones
libata version 2.00 loaded.
agpgart: Detected SiS 760 chipset
agpgart: AGP aperture is 4M @ 0xe0000000
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKC] -> GSI 5 (level, low) -> IRQ 5
input: PC Speaker as /class/input/input1
sis900.c: v1.08.10 Apr. 2 2006
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
intel8x0_measure_ac97_clock: measured 55456 usecs
intel8x0: clocking to 48000
ACPI: Unable to derive IRQ for device 0000:00:04.0
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI - using IRQ 3
PCI: setting IRQ 3 as level-triggered
0000:00:04.0: Realtek RTL8201 PHY transceiver found at address 13.
0000:00:04.0: Using transceiver found at address 13 as default
eth0: SiS 900 PCI Fast Ethernet at 0x1800, IRQ 3, 00:c0:9f:da:d1:08.
Yenta: CardBus bridge found at 0000:00:06.0 [1025:0083]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:06.0, mfunc 0x00521d22, devctl 0x64
Yenta: request_irq() in yenta_probe_cb_irq() failed!
Yenta TI: socket 0000:00:06.0 no PCI interrupts. Fish. Please report.
Yenta: no PCI IRQ, CardBus support disabled for this socket.
Yenta: check your BIOS CardBus, BIOS IRQ or ACPI settings.
Yenta: ISA IRQ mask 0x0650, PCI irq 0
Socket status: 30000006
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:03.2[D] -> Link [LNKH] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:03.2: EHCI Host Controller
ehci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:03.2
ehci_hcd 0000:00:03.2: irq 10, io mem 0xe2004000
ehci_hcd 0000:00:03.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKE] -> GSI 9 (level, low) -> IRQ 9
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:03.0: irq 9, io mem 0xe2002000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:03.1[B] -> Link [LNKF] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:03.1: irq 11, io mem 0xe2003000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0x800-0x80f: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0xa00-0xaff: clean.
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
lp: driver loaded but no devices found
fuse init (API version 7.7)
Capability LSM initialized
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
powernow-k8: Found 1 Mobile AMD Sempron(tm) Processor 3000+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0xc
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x13
Time: acpi_pm clocksource has been installed.
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x126eb1, caps: 0xa04713/0x4000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hda7: found reiserfs format "3.6" with standard journal
ReiserFS: hda7: using ordered data mode
ReiserFS: hda7: journal params: device hda7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda7: checking transaction log (hda7)
ReiserFS: hda7: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda10, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period
eth0: Media Link Off
ADDRCONF(NETDEV_UP): eth0: link is not ready
irq 3: nobody cared (try booting with the "irqpoll" option)
 [<c013b72a>] __report_bad_irq+0x2a/0x90
 [<c013b859>] note_interrupt+0x99/0xd0
 [<c013be20>] handle_level_irq+0xd0/0x100
 [<c0104ff8>] do_IRQ+0x48/0x90
 [<c01fbe93>] acpi_hw_register_write+0xe3/0x1e9
 [<c010335a>] common_interrupt+0x1a/0x20
 [<dccf4d61>] acpi_processor_idle+0x1f3/0x317 [processor]
 [<c01010cc>] cpu_idle+0x1c/0x60
 [<c0406816>] start_kernel+0x1b6/0x220
 [<c04062f0>] unknown_bootoption+0x0/0x1e0
 =======================
handlers:
[<dcc69bf0>] (sis900_interrupt+0x0/0x120 [sis900])
Disabling IRQ #3

--------------040400070506090604030905
Content-Type: text/plain;
 name="proc_interrupts-2.6.19-rc6-acpi_on"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_interrupts-2.6.19-rc6-acpi_on"

           CPU0       
  0:      43315    XT-PIC-XT        timer
  1:        438    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:          0    XT-PIC-XT        SiS SI7012
  8:          1    XT-PIC-XT        rtc
  9:          2    XT-PIC-XT        ohci_hcd:usb1
 10:          2    XT-PIC-XT        ehci_hcd:usb3
 11:         52    XT-PIC-XT        acpi, ohci_hcd:usb2
 12:        124    XT-PIC-XT        i8042
 14:      11843    XT-PIC-XT        ide0
 15:         37    XT-PIC-XT        ide1
NMI:          0 
ERR:          0

--------------040400070506090604030905
Content-Type: text/plain;
 name="proc_interrupts-2.6.19-rc6-irqpoll"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc_interrupts-2.6.19-rc6-irqpoll"

           CPU0       
  0:     111482    XT-PIC-XT        timer
  1:        330    XT-PIC-XT        i8042
  2:          0    XT-PIC-XT        cascade
  5:       3382    XT-PIC-XT        SiS SI7012
  8:          1    XT-PIC-XT        rtc
  9:          2    XT-PIC-XT        ohci_hcd:usb2
 10:          2    XT-PIC-XT        ehci_hcd:usb1
 11:         57    XT-PIC-XT        acpi, ohci_hcd:usb3
 12:       3993    XT-PIC-XT        i8042
 14:      13855    XT-PIC-XT        ide0
 15:         50    XT-PIC-XT        ide1
NMI:          0 
ERR:        155

--------------040400070506090604030905--
