Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267832AbRGRF14>; Wed, 18 Jul 2001 01:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267833AbRGRF1i>; Wed, 18 Jul 2001 01:27:38 -0400
Received: from rodney.concentric.net ([207.155.252.4]:12437 "EHLO
	rodney.cnchost.com") by vger.kernel.org with ESMTP
	id <S267832AbRGRF12>; Wed, 18 Jul 2001 01:27:28 -0400
Message-ID: <3B552C5D.7080705@rootslash.org>
Date: Wed, 18 Jul 2001 01:27:41 -0500
From: The Cat In The Hat <catnthat@rootslash.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.6 i686; en-US; rv:0.9.1) Gecko/20010620
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: APIC and Sound Blaster AWE 64 PNP conflict.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Developers,

	I searched the linux-kernel archives and didn't see much on this and 
nothing in regards to a solution as of yet so I would like to provide 
you with some information regarding this issue.

	When I compile APIC into my 2.4.6 kernel I am unable to use my Sound 
Blaster AWE 64 PNP card due to its inability to receive an acceptable 
response when checking the IRQ on the sound card.  When I remove the 
APIC from my kernel I am able to use my sound card.  The following are 
the configs of my system.

	If I can be of any futher assistance please contact me off list as I am 
not currently subscribed.

-- dmesg --
Please note the line "sb: Interrupt test on IRQ7 failed - Probable IRQ 
conflict" - there is no other device currently using that IRQ.

Linux version 2.4.6 (root@dawntreader) (gcc version 2.95.4 20010703 
(Debian prerelease)) #1 Tue Jul 17 10:43:25 EST 2001
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000002fff0000 (usable)
  BIOS-e820: 000000002fff0000 - 000000002fff3000 (ACPI NVS)
  BIOS-e820: 000000002fff3000 - 0000000030000000 (ACPI data)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01cc6000)
Kernel command line: auto BOOT_IMAGE=l ro root=301
Initializing CPU#0
Detected 1200.055 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 769684k/786368k available (1827k kernel code, 16296k reserved, 
728k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor = 2
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb430, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Applying VIA PCI latency patch (found VT82C686B).
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: Calling quirk for 01:00
isapnp: SB audio device quirk - increasing port range
isapnp: Calling quirk for 01:02
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 PnP'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
NTFS version 010116
ACPI: APM is already active, exiting
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x00
0x378: ECP settings irq=<none or set by other means> dma=<none or set by 
other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=0x378
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV16 framebuffer ver 0.9.2a (GeForce2-MX, 32MB @ 
0xD0000000)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Real Time Clock Driver v1.10d
ppdev: user-space parallel port driver
block: queued sectors max/low 510914kB/379842kB, 1536 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:DMA, hdd:DMA
HPT370A: IDE controller on PCI bus 00 dev 98
PCI: Found IRQ 10 for device 00:13.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0xe400-0xe407, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xe408-0xe40f, BIOS settings: hdg:pio, hdh:pio
hda: QUANTUM FIREBALL ST6.4A, ATA DISK drive
hdb: QUANTUM FIREBALL SE8.4A, ATA DISK drive
hdc: Maxtor 5T040H4, ATA DISK drive
hdd: ATAPI-CD ROM-DRIVE-50MAX, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12594960 sectors (6449 MB) w/81KiB Cache, CHS=13328/15/63, UDMA(33)
hdb: 16514064 sectors (8455 MB) w/80KiB Cache, CHS=16383/16/63, UDMA(33)
hdc: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=79408/16/63
hdd: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
hdb: hdb1
  hdc: [PTBL] [4982/255/63] hdc1
floppy0: no floppy controllers found
Loading I2O Core - (c) Copyright 1999 Red Hat Software
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
    (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O LAN OSM (C) 1999 University of Helsinki.
loop: loaded (max 8 devices)
Linux Tulip driver version 0.9.15-pre6 (July 2, 2001)
PCI: Found IRQ 5 for device 00:0b.0
PCI: Sharing IRQ 5 with 00:07.2
PCI: Sharing IRQ 5 with 00:07.3
eth0: Lite-On PNIC-II rev 37 at 0xcc00, 00:A0:CC:37:13:6B, IRQ 5.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 690M
agpgart: Detected Via Apollo Pro KT133 chipset
agpgart: AGP aperture is 64M @ 0xd8000000
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 11 for device 00:0f.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
         <Adaptec 2940 Ultra2 SCSI adapter>
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs

   Vendor: YAMAHA    Model: CRW6416S          Rev: 1.0c
   Type:   CD-ROM                             ANSI SCSI revision: 02
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 15)
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE64 PnP detected
sb: ISAPnP reports 'Creative SB AWE64 PnP' at i/o 0x220, irq 7, dma 1, 5
sb: Interrupt test on IRQ7 failed - Probable IRQ conflict
sb: 1 Soundblaster PnP card(s) found.
ISAPnP reports AWE64 WaveTable at i/o 0x620
<SoundBlaster EMU8000 (RAM512k)>
usb.c: registered new driver hub
PCI: Found IRQ 5 for device 00:07.2
PCI: Sharing IRQ 5 with 00:07.3
PCI: Sharing IRQ 5 with 00:0b.0
uhci.c: USB UHCI at I/O 0xc400, IRQ 5
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 5 for device 00:07.3
PCI: Sharing IRQ 5 with 00:07.2
PCI: Sharing IRQ 5 with 00:0b.0
uhci.c: USB UHCI at I/O 0xc800, IRQ 5
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: :USB Universal Host Controller Interface driver
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
usb.c: registered new driver usblp
printer.c: v0.8:USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
i2o_scsi.c: Version 0.0.1
   chain_pool: 0 bytes @ efcc9ec0
   (512 byte buffers X 4 can_queue X 0 i2o controllers)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 62364k swap-space (priority -1)

-- Interupts --

  CPU0
   0:     222279          XT-PIC  timer
   1:       3581          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:       4203          XT-PIC  usb-uhci, usb-uhci, eth0
   7:          1          XT-PIC  soundblaster
   8:          1          XT-PIC  rtc
  11:         42          XT-PIC  aic7xxx
  12:     184506          XT-PIC  PS/2 Mouse
  14:      14213          XT-PIC  ide0
  15:       1104          XT-PIC  ide1
NMI:          0
ERR:          0
MIS:          0

-- dma --
  1: SoundBlaster8
  4: cascade
  5: SoundBlaster16

Regards

