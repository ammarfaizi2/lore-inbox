Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265397AbTFRRFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265394AbTFRRFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:05:19 -0400
Received: from mx1.aruba.it ([62.149.128.130]:37027 "HELO mx1.aruba.it")
	by vger.kernel.org with SMTP id S265397AbTFRRDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:03:51 -0400
Message-ID: <3EF09EB9.9010000@despammed.com>
Date: Wed, 18 Jun 2003 19:17:45 +0200
From: Dialtone <dialtone@despammed.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.4.21-ck1] Problem with nforce2 and X
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Rating: mx1.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all. I've been using kernel 2.4.21-rc3 for some time without
any problems since the day it was released.

Now that official 2.4.21 has been released I compiled it but
problems started.

Ok now, where is the problem. Well the screen seems to go
in standby after I run X, and I must reboot since
Alt+Ctrl+123456 doesn't work. I have the same problem when
I upgrade to the latest bios from Epox (I have an Epox 8RDA+
with nforce2 chipset and GeForce Ti4200) with kernel 2.4.21-rc3.

I patched the kernel 2.4.21 with ck1 patch for O(1) sched and
agpgart and so on. But I think the problem is not here since it
comes also with another BIOS and the working kernel.

Down here I report my dmesg. There are
no Xfree errors so I guess is not its fault too.
If you need also my kernel conf file I can post it.

Thanks for your help.

I forgot... I use vesa framebuffer for console, and apm
(acpi gives me more errors like "Lost hdb interrupt").
My CPU is an Athlon Xp 2000+ core Palomino.
Here is my lspci:

dialtone@vercingetorix:~/News$ lspci
00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0d.0 FireWire (IEEE 1394): nVidia Corporation nForce2 FireWire (IEEE 
1394) Controller (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2)
01:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
01:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 
07)
01:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 07)
02:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 
4200] (rev a3)

*********************dmesg********************
Linux version 2.4.21-ck1 (root@vercingetorix) (gcc version 3.3 (Debian)) 
#1 lun giu 16 22:24:26 CEST 2003
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=346 hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Found and enabled local APIC!
Initializing CPU#0
Detected 1670.544 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 3329.22 BogoMIPS
Memory: 515308k/524224k available (1834k kernel code, 8528k reserved, 
599k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
CPU: AMD Athlon(tm) XP 2000+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1670.1913 MHz.
..... host bus clock speed is 267.1305 MHz.
cpu: 0, clocks: 1336305, slice: 668152
CPU0<T0:1336304,T1:668144,D:8,S:668152,C:1336305>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb4f0, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 00:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd & kiswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
NTFS driver v1.1.22 [Flags: R/O]
udf: registering filesystem
ACPI: APM is already active, exiting
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-bit.o: i2c bit algorithm module
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-proc.o version 2.6.1 (20010825)
vesafb: framebuffer at 0xd0000000, mapped to 0xe080d000, size 20480k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:e870
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xe1c0e000, 00:50:fc:27:e7:6e, 
IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Nvidia Nforce2 chipset
agpgart: AGP aperture is 256M @ 0xc0000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 
controller on pci00:09.0
   ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
   ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y060L0, ATA DISK drive
hdb: QUANTUM FIREBALLP KX13.6, ATA DISK drive
blk: queue c03b29a0, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c03b2ae0, I/O limit 4095Mb (mask 0xffffffff)
hdc: Pioneer DVD-ROM ATAPIModel DVD-103S 011, ATAPI CD/DVD-ROM drive
hdd: YAMAHA CRW-F1E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63, 
UDMA(100)
hdb: attached ide-disk driver.
spurious 8259A interrupt: IRQ7.
hdb: host protected area => 1
hdb: 26771672 sectors (13707 MB) w/418KiB Cache, CHS=1666/255/63
Partition check:
/dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
/dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Setting latency timer of device 00:02.2 to 64
ehci-hcd 00:02.2: PCI device 10de:0068 (nVidia Corporation)
ehci-hcd 00:02.2: irq 5, pci mem e1c7a000
usb.c: new USB bus registered, assigned bus number 1
PCI: 00:02.2 PCI cache line size set incorrectly (0 bytes) by BIOS/FW.
PCI: 00:02.2 PCI cache line size corrected to 64.
ehci-hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jan-22
hub.c: USB hub found
hub.c: 6 ports detected
PCI: Setting latency timer of device 00:02.0 to 64
host/usb-ohci.c: USB OHCI at membase 0xe1c7c000, IRQ 10
host/usb-ohci.c: usb-00:02.0, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
PCI: Setting latency timer of device 00:02.1 to 64
host/usb-ohci.c: USB OHCI at membase 0xe1c7e000, IRQ 11
host/usb-ohci.c: usb-00:02.1, PCI device 10de:0067 (nVidia Corporation)
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 3 ports detected
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 14
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
 (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
  (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
I2O LAN OSM (C) 1999 University of Helsinki.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
UDF-fs DEBUG lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not 
supported: rc=-22
UDF-fs DEBUG super.c:1421:udf_read_super: Multi-session=0
UDF-fs DEBUG super.c:410:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs DEBUG super.c:1157:udf_check_valid: Failed to read byte 32768. 
Assuming open disc. Skipping validity check
UDF-fs DEBUG misc.c:285:udf_read_tagged: location mismatch block 256, 
tag 18 != 256
UDF-fs DEBUG super.c:1211:udf_load_partition: No Anchor block found
UDF-fs: No partition found (1)
reiserfs: checking transaction log (device 03:46) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 124k freed
hub.c: new USB device 00:02.1-2, assigned address 2
usb.c: USB device 2 (vend/prod 0x458/0x2011) is not claimed by any 
active driver.
Adding Swap: 265064k swap-space (priority -1)
ohci1394: $Rev: 896 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e3003000-e30037ff]  Max 
Packet=[2048]
ohci1394_0: SelfID received outside of bus reset sequence
SCSI subsystem driver Revision: 1.00
hdc: attached ide-scsi driver.
hdd: attached ide-scsi driver.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
 Vendor: PIONEER   Model: DVD-ROM DVD-103   Rev: 1.15
 Type:   CD-ROM                             ANSI SCSI revision: 02
 Vendor: YAMAHA    Model: CRW-F1E           Rev: 1.0f
 Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 10x/44x writer cd/rw xa/form2 cdda tray
gameport0: Emu10k1 Gameport at 0xd800 size 8 speed 817 kHz
input0: Microsoft SideWinder GamePad on gameport0.0 [3-bit id 75 data 5]
usb.c: registered new driver usbscanner
scanner.c: USB scanner device (0x0458/0x2011) now attached to scanner0
scanner.c: 0.4.12:USB Scanner Driver
Linux video capture interface: v1.00
bttv: driver version 0.7.104 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
bttv: Host bridge is PCI device 10de:01e0 (nVidia Corporation)
ieee1394: Host added: Node[00:1023]  GUID[00046103bae78a8b]  [Linux 
OHCI-1394]
Linux video capture interface: v1.00
reiserfs: checking transaction log (device 03:47) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:48) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:49) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:45) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
reiserfs: checking transaction log (device 03:04) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
lp0: console ready
*************************************************

-- 
try: troll.uses(Brain)
except TypeError, data: 
   troll.plonk()
Linux User #310274, Debian Sid Proud User


