Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262693AbSJBXqP>; Wed, 2 Oct 2002 19:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262698AbSJBXqP>; Wed, 2 Oct 2002 19:46:15 -0400
Received: from list-svr.nventure.com ([208.186.46.9]:18420 "EHLO
	list-svr.nventure.com") by vger.kernel.org with ESMTP
	id <S262693AbSJBXqI>; Wed, 2 Oct 2002 19:46:08 -0400
Message-ID: <3D9B85A8.4050803@nventure.com>
Date: Wed, 02 Oct 2002 16:47:52 -0700
From: Bryan Hundven <bryanh@nventure.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP: errors.
Content-Type: multipart/mixed;
 boundary="------------070303010208050608080805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070303010208050608080805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The dmesg for my kernel is attached, which should explain it all.

The errors that I am concerned about are:
    bad: scheduling while atomic!
and...
    Debug: sleeping function called from illegal context at slab.c:1374

This next one really isn't an error, but I have seen this in 2.4 as 
well... The motherboard is an asus p2b-d.
    mtrr: v2.0 (20020519)
    mtrr: your CPUs had inconsistent fixed MTRR settings
    mtrr: your CPUs had inconsistent variable MTRR settings
    mtrr: probably your BIOS does not setup all CPUs

When my computer starts up it says it found 2 cpu's. So if the bios says 
it found 2 cpu's, it doesn't mean that it set them up?

Otherwise, everything built fine.

I had an error with the menuconfig when trying to access the alsa menu, 
but I sent that error to mec at shout dot net already.

One last question. Now that Aureal has gone out of business. They left 
behind some nice sound cards that have some lame drivers.
Does anyone think that they will every be released to the public, or are 
they doomed in license hell for ever?

Bryan Hundven

--------------070303010208050608080805
Content-Type: text/plain;
 name="dmesg-2.5.40"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg-2.5.40"

R Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 001 01  1    1    0   0   0    1    1    71
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9-> 0:20
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 400.0846 MHz.
..... host bus clock speed is 100.0211 MHz.
cpu: 0, clocks: 100211, slice: 3036
CPU0<T0:100208,T1:97168,D:4,S:3036,C:100211>
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 100211, slice: 3036
CPU1<T0:100208,T1:94128,D:8,S:3036,C:100211>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
e7fcbef8 c011917d c03493a0 00000000 00000000 00000000 00000000 00000000 
       e7fca000 e7fcbf94 e7fcbf98 e7fcbf78 c0119a69 00000000 e7fce060 c0119660 
       00000000 00000000 c01183f1 e7fcbf58 c042d4a0 00000001 e7fce060 c0119660 
Call Trace:
 [<c011917d>]schedule+0x3d/0x4d0
 [<c0119a69>]wait_for_completion+0x129/0x1e0
 [<c0119660>]default_wake_function+0x0/0x40
 [<c01183f1>]try_to_wake_up+0x331/0x340
 [<c0119660>]default_wake_function+0x0/0x40
 [<c011b58e>]set_cpus_allowed+0x22e/0x250
 [<c011b600>]migration_thread+0x50/0x5b0
 [<c011b5b0>]migration_thread+0x0/0x5b0
 [<c011b5b0>]migration_thread+0x0/0x5b0
 [<c0107179>]kernel_thread_helper+0x5/0xc

bad: scheduling while atomic!
e7fc9f10 c011917d c03493a0 00000000 e7fc8000 c0125310 c0440e80 c04259a4 
       e7fc8000 e7fc9fac e7fc9fb0 e7fc9f90 c0119a69 00000000 e7fce780 c0119660 
       00000000 00000000 c01183f1 e7fc9f70 c042d4a0 00000001 e7fce780 c0119660 
Call Trace:
 [<c011917d>]schedule+0x3d/0x4d0
 [<c0125310>]tasklet_hi_action+0x80/0xd0
 [<c0119a69>]wait_for_completion+0x129/0x1e0
 [<c0119660>]default_wake_function+0x0/0x40
 [<c01183f1>]try_to_wake_up+0x331/0x340
 [<c0119660>]default_wake_function+0x0/0x40
 [<c011b58e>]set_cpus_allowed+0x22e/0x250
 [<c012545b>]ksoftirqd+0x5b/0x110
 [<c0125400>]ksoftirqd+0x0/0x110
 [<c0107179>]kernel_thread_helper+0x5/0xc

CPUS done 4294967295
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
adding '' to cpu class interfaces
adding '' to cpu class interfaces
ACPI: Subsystem revision 20020918
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00fd2c0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xd2f0, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x290-0x297 has been reserved
PnPBIOS: PNP0c02: ioport range 0xe400-0xe43f has been reserved
PnPBIOS: PNP0c02: ioport range 0xe800-0xe83f could not be reserved
usb.c: registered new driver usbfs
usb.c: registered new driver hub
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16)
00:00:0c[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17)
00:00:0c[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18)
00:00:0c[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19)
00:00:0c[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
aio_setup: sizeof(struct page) = 40
Journalled Block Device driver loaded
Capability LSM initialized
Limiting direct PCI/PCI transfers.
ACPI: Power Button (FF) [PWRF]
ACPI: Processor [CPU] (supports C1)
ACPI: Processor [CPU1] (supports C1)
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: faking semi-colon
parport0: Printer, HEWLETT-PACKARD DESKJET 720C
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-algo-bit.o: i2c bit algorithm module version 2.6.4 (20020719)
i2c-philips-par.o: i2c Philips parallel port adapter module version 2.6.4 (20020719)
i2c-philips-par.o: attaching to parport0
i2c-dev.o: Registered 'Philips Parallel port adapter' as minor 0
i2c-algo-pcf.o: i2c pcf8584 algorithm module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
matroxfb: Matrox G550 detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xE2000000, mapped to 0xe881b000, size 33554432
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
parport0: no more devices allowed
lp: driver loaded but no devices found
Real Time Clock Driver v1.11
ppdev: user-space parallel port driver
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 564M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
[drm] AGP 0.99 on Intel 440BX @ 0xe4000000 64MB
MTRR: setting reg 2
MTRR: setting reg 2
[drm] Initialized mga 3.0.2 20010321 on minor 0
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/100 Network Driver - version 2.1.15-k1
Copyright (c) 2002 Intel Corporation

e100: eth0: Intel(R) PRO/100+ Management Adapter
  Mem:0xe0000000  IRQ:19  Speed:0 Mbps  Dx:N/A
  Failed to detect cable link
  Speed and duplex will be determined at time of connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: SAMSUNG SV2001H, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
Debug: sleeping function called from illegal context at slab.c:1374
e7fd9e8c c011bc26 c03494c0 c034b4c2 0000055e c04ea1bc c013eea1 c034b4c2 
       0000055e c04ea340 00000000 00000046 c010eaa2 e7fd8000 e7fd8000 0000000e 
       e7fd8000 c04ea1bc c04ea1f4 c04ea1ac c04ea1bc c024bdd1 c1701650 000001d0 
Call Trace:
 [<c011bc26>]__might_sleep+0x56/0x5d
 [<c013eea1>]kmem_cache_alloc+0x21/0x2f0
 [<c010eaa2>]i8259A_irq_pending+0xc2/0xd0
 [<c024bdd1>]blk_init_free_list+0x61/0x100
 [<c024be7d>]blk_init_queue+0xd/0xf0
 [<c0263a28>]ide_init_queue+0x28/0x70
 [<c026a670>]do_ide_request+0x0/0x20
 [<c0263da0>]init_irq+0x330/0x410
 [<c026415c>]hwif_init+0x10c/0x260
 [<c026394d>]probe_hwif_init+0x1d/0x70
 [<c0277531>]ide_setup_pci_device+0x41/0x70
 [<c010511b>]init+0x8b/0x250
 [<c0105090>]init+0x0/0x250
 [<c0107179>]kernel_thread_helper+0x5/0xc

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM 52X L, ATAPI CD/DVD-ROM drive
hdd: RWD RW2224, ATAPI CD/DVD-ROM drive
Debug: sleeping function called from illegal context at slab.c:1374
e7fd9e8c c011bc26 c03494c0 c034b4c2 0000055e c04ea7b0 c013eea1 c034b4c2 
       0000055e c04ea934 00000000 00000046 c010eaa2 e7fd8000 e7fd8000 0000000f 
       e7fd8000 c04ea7b0 c04ea7e8 c04ea7a0 c04ea7b0 c024bdd1 c1701650 000001d0 
Call Trace:
 [<c011bc26>]__might_sleep+0x56/0x5d
 [<c013eea1>]kmem_cache_alloc+0x21/0x2f0
 [<c010eaa2>]i8259A_irq_pending+0xc2/0xd0
 [<c024bdd1>]blk_init_free_list+0x61/0x100
 [<c024be7d>]blk_init_queue+0xd/0xf0
 [<c0263a28>]ide_init_queue+0x28/0x70
 [<c026a670>]do_ide_request+0x0/0x20
 [<c0263da0>]init_irq+0x330/0x410
 [<c026415c>]hwif_init+0x10c/0x260
 [<c026394d>]probe_hwif_init+0x1d/0x70
 [<c0277555>]ide_setup_pci_device+0x65/0x70
 [<c010511b>]init+0x8b/0x250
 [<c0105090>]init+0x0/0x250
 [<c0107179>]kernel_thread_helper+0x5/0xc

ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 39179952 sectors (20060 MB) w/1945KiB Cache, CHS=2438/255/63, UDMA(33)
 hda: hda1
hdb: host protected area => 1
hdb: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=4866/255/63, UDMA(33)
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 >
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: RWD       Model: RW2224            Rev: 2.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Debug: sleeping function called from illegal context at slab.c:1374
e7fd9ee8 c011bc26 c03494c0 c034b4c2 0000055e e7ffc060 c013f1bf c034b4c2 
       0000055e e7fd9f18 00000286 00000286 e7dfac00 c024bd53 e7dfac1c e7dfac28 
       e7dfac00 00000001 e7d8d800 e7ffd000 00001000 e7fd8000 00001000 c013d1dd 
Call Trace:
 [<c011bc26>]__might_sleep+0x56/0x5d
 [<c013f1bf>]kmalloc+0x4f/0x330
 [<c024bd53>]blk_cleanup_queue+0x53/0x70
 [<c013d1dd>]get_vm_area+0x1d/0x140
 [<c013d54b>]__vmalloc+0x3b/0x120
 [<c013d646>]vmalloc+0x16/0x20
 [<c0286fae>]sg_init+0xbe/0x160
 [<c027c65d>]scsi_register_device+0x8d/0x130
 [<c010511b>]init+0x8b/0x250
 [<c0105090>]init+0x0/0x250
 [<c0107179>]kernel_thread_helper+0x5/0xc

matroxfb_crtc2: secondary head of fb0 was registered as fb1
i2c-dev.o: Registered 'DDC:fb0 #0 on i2c-matroxfb' as minor 1
i2c-dev.o: Registered 'DDC:fb0 #1 on i2c-matroxfb' as minor 2
i2c-dev.o: Registered 'MAVEN:fb0 on i2c-matroxfb' as minor 3
uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
hcd-pci.c: uhci-hcd @ 00:04.2, Intel Corp. 82371AB/EB/MB PIIX4 USB
hcd-pci.c: irq 19, io base 0000d400
hcd.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found at 0
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v2.0:USB HID core driver
register interface 'mouse' with class 'input
mice: PS/2 mouse device common for all mice
register interface 'event' with class 'input
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
i2c-core.o: i2c core module version 2.6.4 (20020719)
i2c-dev.o: i2c /dev entries driver module version 2.6.4 (20020719)
i2c-proc.o version 2.6.4 (20020719)
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :   732.000 MB/sec
   32regs    :   360.000 MB/sec
   pII_mmx   :   892.000 MB/sec
   p5_mmx    :   916.000 MB/sec
raid5: using function: p5_mmx (916.000 MB/sec)
md: multipath personality registered as nr 7
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 64Kbytes
TCP: Hash tables configured (established 131072 bind 43690)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 336k freed
hub.c: new USB device 00:04.2-1, assigned address 2
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-00:04.2-1
Adding 128512k swap on /dev/hdb3.  Priority:-1 extents:1
Adding 128512k swap on /dev/hdb2.  Priority:-2 extents:1
Adding 128480k swap on /dev/hdb5.  Priority:-3 extents:1
Adding 128480k swap on /dev/hdb6.  Priority:-4 extents:1
Adding 128480k swap on /dev/hdb7.  Priority:-5 extents:1
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,72), internal journal
FAT: Using codepage cp437
FAT: Using IO charset iso8859-1
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,73), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
hdd: DMA disabled
au88xx: Loading...
au88xx: Found vortex PCI device:
au88xx: id=0x0001
au88xx: bar0=0xde800000
au88xx: irq=17
au88xx: Add device, audio=3, mixer=0, midi=2

--------------070303010208050608080805--

