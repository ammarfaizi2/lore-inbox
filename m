Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271558AbTGQSKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 14:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271574AbTGQSKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 14:10:45 -0400
Received: from CPE000625926cd6-CM014480115318.cpe.net.cable.rogers.com ([24.157.137.42]:39560
	"EHLO daedalus.samhome.net") by vger.kernel.org with ESMTP
	id S271558AbTGQSHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 14:07:38 -0400
Subject: Re: dma_timer_expiry on SATA siimage 3112 under 2.6.0-test1-ac1
From: Sam Bromley <sbromley@cogeco.ca>
Reply-To: sbromley@cogeco.ca
To: tea4two <tea4two@tin.it>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <bf6nb0$c3$1@main.gmane.org>
References: <1058389994.3220.20.camel@daedalus.samhome.net>
	 <bf6nb0$c3$1@main.gmane.org>
Content-Type: text/plain
Message-Id: <1058466147.3220.62.camel@daedalus.samhome.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 17 Jul 2003 14:22:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Success under both 2.4.21-ac4 and 2.6.0-test1-ac1 !!

Now this drive should support upwards of udma5.

Is it just a matter of the sil3112 driver maturing
a bit more then? Or do these protocols no longer
really mean anything in the context of SATA?

Thank you. *Much* appreciated.

New results are below.


On Thu, 2003-07-17 at 13:46, tea4two wrote:
> try:
> 
> hdparm -d1 -Xudma2 /dev/hde
> 
> other parameter don't work.
> 
> Plese repost your test.
> 
> Thank you
> Pierluigi
> 
> 
> 
> "Sam Bromley" <bromley@uoguelph.ca> ha scritto nel messaggio
> news:1058389994.3220.20.camel@daedalus.samhome.net...
> > Good day folks,
> > I am unable to enable DMA on a Maxtor 6Y120MO
> > on Asus A7N8X with a Silicon Image 3112 SATA
> > controller.
> >
> > Specifically, after hdparm -X whatever -d1 /dev/hde
> >
> > I get dma_timer_expiry errors and dma_status=0x21.
> >
> > System becomes unresponsive if access to the drive
> > is attempted, and the errors above repeat continuously.

dmesg: 

Linux version 2.4.21-ac4 (root@localhost) (gcc version 3.3.1 20030626
(Debian prerelease)) #1 Wed Jul 16 08:19:12 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 acpi=off hdc=none single
ide_setup: hdc=none
Found and enabled local APIC!
Initializing CPU#0
Detected 1804.087 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3604.48 BogoMIPS
Memory: 515576k/524224k available (1679k kernel code, 8260k reserved,
591k data, 108k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2200+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1804.1183 MHz.
..... host bus clock speed is 267.2766 MHz.
cpu: 0, clocks: 2672766, slice: 1336383
CPU0<T0:2672752,T1:1336368,D:1,S:1336383,C:2672766>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030522
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xfb560, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [10de/01e0] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbfd0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc000, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
Journalled Block Device driver loaded
udf: registering filesystem
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y120M0, ATA DISK drive
ide0 at 0xe0838080-0xe0838087,0xe083808a on irq 11
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=238216/16/63
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.0 to 64
host/usb-ohci.c: USB OHCI at membase 0xe083a000, IRQ 5
host/usb-ohci.c: usb-00:02.0, nVidia Corporation nForce2 USB Controller
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:02.1 to 64
host/usb-ohci.c: USB OHCI at membase 0xe083c000, IRQ 11
host/usb-ohci.c: usb-00:02.1, nVidia Corporation nForce2 USB Controller
(#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 108k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 500432k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
nvidia: loading NVIDIA Linux x86 NVdriver Kernel Module  1.0-3123  Tue
Aug 27 15:56:48 PDT 2002
PCI: Setting latency timer of device 00:04.0 to 64
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
spurious 8259A interrupt: IRQ7.
NVRM: AGPGART: unknown chipset
NVRM: AGPGART: aperture: 64M @ 0xd8000000
NVRM: AGPGART: aperture mapped from 0xd8000000 to 0xe19d1000
NVRM: AGPGART: mode 4x
NVRM: AGPGART: allocated 16 pages


/dev/hda:

ATA device, with non-removable media
	Model Number:       Maxtor 6Y120M0                          
	Serial Number:      Y3JV3FSE            
	Firmware Revision:  YAR51BW0
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  240121728
	device size with M = 1024*1024:      117246 MBytes
	device size with M = 1000*1000:      122942 MBytes (122 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	Automatic Acoustic Management feature set 
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct


hdparm -tT /dev/hda:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.31 seconds =412.90 MB/sec
 Timing buffered disk reads:  64 MB in 46.39 seconds =  1.38 MB/sec

hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 238216/16/63, sectors = 240121728, start = 0

hdparm -d1 -Xudma2 /dev/hda
hdparm /dev/hda:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 238216/16/63, sectors = 240121728, start = 0

hdparm -tT /dev/hda:

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.31 seconds =412.90 MB/sec
 Timing buffered disk reads:  64 MB in  1.25 seconds = 51.20 MB/sec

Sweet!

