Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263106AbUKZURI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbUKZURI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbUKZUQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:16:39 -0500
Received: from smtp.wp.pl ([212.77.101.160]:25939 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S263106AbUKZTno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:43:44 -0500
Subject: Re: MTRR vesafb and wrong X performance
From: Pawel Fengler <pawfen@wp.pl>
Reply-To: pawfen@wp.pl
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041124171805.0586a5a1.akpm@osdl.org>
References: <1101338139.1780.9.camel@PC3.dom.pl>
	 <20041124171805.0586a5a1.akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-2
Date: Thu, 25 Nov 2004 22:56:43 +0100
Message-Id: <1101419803.1764.23.camel@PC3.dom.pl>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92-1mdk 
Content-Transfer-Encoding: 8bit
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO(Body=1 Fuz1=1 Fuz2=1) AS2=YES(0.999930) AS3=NO AS4=NO                         
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 24-11-2004, ¶ro o godzinie 17:18 -0800, Andrew Morton napisa³(a):

> Please send the full dmesg output and the contents of /proc/mtrr for
> 2.6.10-rc2.

Thank you for your letter. 
I find it necessary to inform you that problem with mtrr and vesafb
still exists for kernel 2.6.10-rc2. Warning message
"(WW) NV(0): Failed to set up write-combining range" in Xorg.log
appears as well. Xserver performance is wrong too.
 
As you wish I send dmesg output and the contents of /proc/mtrr for
2.6.10-rc2 from my first computer. 

Pawel Fengler 
-------------------------------------------------------------
cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 128MB: write-back, count=1
reg01: base=0x08000000 ( 128MB), size=  64MB: write-back, count=1
reg02: base=0xe3000000 (3632MB), size=   4MB: write-combining, count=1

dmesg
Linux version 2.6.10-rc2 (root@pc3) (gcc version 3.4.1 (Mandrakelinux
10.1 3.4.1-4mdk)) #1 Thu Nov 25 21:04:20 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000c000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
192MB LOWMEM available.
On node 0 totalpages: 49152
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 45056 pages, LIFO batch:11
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.1 present.
ACPI: Unable to locate RSDP
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2610rc2 ro root=2102 acpi=ht
resume=/dev/hde1 splash=silent
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 400.889 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 191476k/196608k available (1902k kernel code, 4696k reserved,
407k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 790.52 BogoMIPS (lpj=395264)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps:        0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 172k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041105
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: ACPI disable
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbfd0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbff8, dseg 0xf0000
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1101415675.269:0): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
vesafb: framebuffer at 0xe3000000, mapped to 0xcc880000, using 1875k,
total 4096k
vesafb: mode is 800x600x16, linelength=1600, pages=3
vesafb: protected mode interface info at c000:029f
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
ide0: Wait for ready failed before probe !
hdb: HL-DT-ST RW/DVD GCC-4320B, ATAPI CD/DVD-ROM drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
SiI680: IDE controller at PCI slot 0000:00:10.0
PCI: Found IRQ 5 for device 0000:00:10.0
SiI680: chipset revision 2
SiI680: BASE CLOCK == 133
SiI680: 100% native mode on irq 5
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y200P0, ATA DISK drive
ide2 at 0xcc80e080-0xcc80e087,0xcc80e08a on irq 5
Probing IDE interface ide3...
hdg: ST36421A, ATA DISK drive
ide3 at 0xcc80e0c0-0xcc80e0c7,0xcc80e0ca on irq 5
hde: max request size: 64KiB
hde: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63,
UDMA(133)
hde: cache flushes supported
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3
hdg: max request size: 64KiB
hdg: 12596850 sectors (6449 MB) w/256KiB Cache, CHS=13330/15/63, UDMA
(33)
hdg: cache flushes not supported
 /dev/ide/host2/bus1/target0/lun0: p1 p2 < p5 >
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 1
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 208k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 10 for device 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:14.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0xa000
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
EXT3 FS on hde2, internal journal
Adding 497972k swap on /dev/hde1.  Priority:-1 extents:1
Adding 128480k swap on /dev/hdg5.  Priority:-2 extents:1
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440LX Chipset.
agpgart: Maximum main memory to use for agp memory: 150M
agpgart: AGP aperture is 16M @ 0xe2000000
input: PC Speaker
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
hdb: ATAPI 8X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 11 for device 0000:00:0f.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0f.0: 3Com PCI 3c590 Vortex 10Mbps at 0xa400. Vers LK1.1.19
0000:00:0f.0: Overriding PCI latency timer (CFLT) setting of 64, new
value is 248.
PCI: Found IRQ 3 for device 0000:00:12.0
0000:00:12.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xbc00. Vers LK1.1.19
inserting floppy driver for 2.6.10-rc2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET: Registered protocol family 17
Creative EMU10K1 PCI Audio Driver, version 0.20a, 20:36:27 Nov 25 2004
PCI: Found IRQ 10 for device 0000:00:14.0
PCI: Sharing IRQ 10 with 0000:00:07.2
emu10k1: EMU10K1 rev 7 model 0x8064 found, IO at 0xc000-0xc01f, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
emu10k1: SBLive! 5.1 card detected

-- 


