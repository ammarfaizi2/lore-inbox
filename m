Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbSLKKd3>; Wed, 11 Dec 2002 05:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267109AbSLKKd3>; Wed, 11 Dec 2002 05:33:29 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:3595 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S267102AbSLKKdZ>;
	Wed, 11 Dec 2002 05:33:25 -0500
Subject: Re: CD Writing in 2.5.51
From: mdew <mdew@orcon.net.nz>
To: Markus Plail <linux-kernel@gitteundmarkus.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87adjc3n30.fsf@web.de>
References: <1039598049.480.7.camel@nirvana> <87fzt43nm4.fsf@web.de>
	<1039599708.711.9.camel@nirvana>  <87adjc3n30.fsf@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Dec 2002 23:40:58 +1300
Message-Id: <1039603261.531.6.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 22:46, Markus Plail wrote:
> * mdew  writes:
> >On Wed, 2002-12-11 at 22:34, Markus Plail wrote:
> >>You don't need any additional modules. Just don't activate ide-scsi by
> >>either not appending ide-scsi/scsi=hdX or not compiling ide-scsi
> >>support in the kernel.
> >can i completely remove scsi support then? (I dont have any scsi device)
> 
> Yes.

awesome, i got it to work, thanks.. tho I'm now trying to enable the DMA
on the drives... (unsuccessfully)
 
/dev/hda == CDRW (24/12/40)
/dev/hdb == DVDROM (8/40)

nirvana:~# hdparm /dev/hda

/dev/hda:
 HDIO_GET_MULTCOUNT failed: Inappropriate ioctl for device
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Inappropriate ioctl for device
nirvana:~# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)
nirvana:~# hdparm -d1 /dev/hdb

/dev/hdb:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)


Linux version 2.5.51 (root@nirvana) (gcc version 3.2.2 20021202 (Debian
prerelease)) #3 Wed Dec 11 23:04:28 NZDT 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)
 BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98288
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94192 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux25 root=2102
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 599.229 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1183.74 BogoMIPS
Memory: 385044k/393152k available (2329k kernel code, 7352k reserved,
526k data, 308k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Celeron (Coppermine) stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 599.0313 MHz.
..... host bus clock speed is 66.0590 MHz.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
mtrr: v2.0 (20020519)
device class 'cpu': registering
device class cpu: adding driver system:cpu
PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Using configuration type 1
device class cpu: adding device CPU 0
interfaces: adding device CPU 0
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.93 (c) Adam Belay
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe58, dseg 0xf0000
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
aio_setup: sizeof(struct page) = 40
[c13de040] eventpoll: successfully initialized.
Journalled Block Device driver loaded
udf: registering filesystem
SGI XFS for Linux 2.5.51 with ACLs, realtime, no debug enabled
Limiting direct PCI/PCI transfers.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_mux: aa55f00f52ad51(3e)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_mux: aa55f00f52ad51(3e)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Linux agpgart interface v1.0 (c) Dave Jones
agpgart: Detected Intel 440BX chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0xe0000000
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ASUS CRW-2410A, ATAPI CD/DVD-ROM drive
hdb: ASUS DVD-ROM E608, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PDC20262: IDE controller at PCI slot 00:0e.0
PCI: Found IRQ 9 for device 00:0e.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0xe7000000
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:DMA, hdh:DMA
hde: ST330630A, ATA DISK drive
ide2 at 0xb000-0xb007,0xb402 on irq 9
hde: setmax LBA 59777641, native  59777640
hde: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=59303/16/63,
UDMA(66)
 hde: hde1 hde2 hde3 hde4 < hde5 >
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.0
uhci-hcd 00:07.2: Intel Corp. 82371AB/EB/MB PIIX4
uhci-hcd 00:07.2: irq 10, io base 0000a000
drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
drivers/usb/core/hub.c: USB hub found at 0
drivers/usb/core/hub.c: 2 ports detected
device class 'input': registering
register interface 'mouse' with class 'input'
mice: PS/2 mouse device common for all mice
register interface 'event' with class 'input'
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10
19:48:18 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
PCI: Found IRQ 5 for device 00:09.0
ALSA device list:
  #0: Yamaha DS-XG PCI (YMF744) at 0xd8816000, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session:
CDROMMULTISESSION not supported: rc=-25
UDF-fs DEBUG fs/udf/super.c:1471:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:459:udf_vrs: Starting at sector 16 (2048
byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem ide2(33,2)
Ending clean XFS mount for filesystem: ide2(33,2)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 308k freed
drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 2
drivers/usb/core/hub.c: USB hub found at 1
drivers/usb/core/hub.c: 4 ports detected
drivers/usb/core/hub.c: new USB device 00:07.2-2, assigned address 3
drivers/usb/core/hub.c: USB hub found at 2
drivers/usb/core/hub.c: 4 ports detected
Adding 642592k swap on /dev/hde3.  Priority:-1 extents:1
drivers/usb/core/hub.c: new USB device 00:07.2-2.1, assigned address 4
drivers/usb/core/hub.c: new USB device 00:07.2-1.1, assigned address 5
drivers/usb/core/hub.c: new USB device 00:07.2-1.3, assigned address 6
Module crc32 cannot be unloaded due to unsafe usage in lib/crc32.c:554
8139too Fast Ethernet driver 0.9.26
PCI: Found IRQ 10 for device 00:0b.0
eth0: RealTek RTL8139 Fast Ethernet at 0xd887a000, 00:30:4f:0b:43:a8,
IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.6:USB Scanner Driver
input: A4Tech USB Optical Mouse on usb-00:07.2-1.1
drivers/usb/core/usb.c: registered new driver usb_mouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
NTFS driver 2.1.0 [Flags: R/O MODULE].
NTFS volume version 3.0.
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
Module smbfs cannot be unloaded due to unsafe usage in
fs/smbfs/smbiod.c:285
hda: DMA disabled
end_request: I/O error, dev hda, sector 0
hda: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
hdb: DMA disabled
end_request: I/O error, dev hdb, sector 0
hdb: ATAPI 40X DVD-ROM drive, 128kB Cache


