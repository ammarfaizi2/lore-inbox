Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264894AbRFYRNA>; Mon, 25 Jun 2001 13:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264900AbRFYRMv>; Mon, 25 Jun 2001 13:12:51 -0400
Received: from mail.bartnet.net ([12.149.177.6]:37286 "EHLO mail.bartnet.net")
	by vger.kernel.org with ESMTP id <S264894AbRFYRMi>;
	Mon, 25 Jun 2001 13:12:38 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_4JWHG9J7SQ96JAEQX2Q9"
From: JorgP <jorgp@bartnet.net>
To: cooker@linux-mandrake.com
Subject: problem using PlexWriter 8/4/32A
Date: Mon, 25 Jun 2001 11:59:28 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01062511592801.01166@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_4JWHG9J7SQ96JAEQX2Q9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Subject: 

I am using AMD 1.2Gig w/ 512Meg Ram, MSI 6330-K7ProA motherboard.

hda: QUANTUM FIREBALLP LM10.2, ATA DISK drive
hdb: IBM-DPTA-372050, ATA DISK drive
hdc: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W8432T, ATAPI CD/DVD-ROM drive

base install is Mandrake 8.0 from CD
it did not work and then tried latest cooker kernel 2.4.5-8 same thing.
I have also tried redhat 7.1 with all recommended updates 2.4.3-12 kernel 
same thing.

using ide-scsi module.
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W8432T  Rev: 1.09
  Type:   CD-ROM                             ANSI SCSI revision: 02

when trying to mount a CD in the plextor the system accesses the drive for a 
few seconds then hangs the process hangs and can not be killed.
If I use X-CD-Roast it tries to access the drive and after a few seconds the 
CPU goes to 100% usage and hangs the machine, have to hard reset it can not 
sys-req it either.

The other CD-Rom drive works great.

This setup works great under a dual boot of Windows 2000, and I can access 
the drive and burn CD's all day long.

cdrecord --scanbus see's the drive the until the first time I try to access 
it the drive, then cdrecord --scanbus hangs.

Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 Jörg Schilling
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) 'PLEXTOR ' 'CD-R   PX-W8432T' '1.09' Removable CD-ROM
        0,1,0     1) *
        0,2,0     2) *
        0,3,0     3) *
        0,4,0     4) *
        0,5,0     5) *
        0,6,0     6) *
        0,7,0     7) *

I will attach my dmesg...

Please help.
Thanks
Jorg
--------------Boundary-00=_4JWHG9J7SQ96JAEQX2Q9
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Description: My Dmesg output...
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.4.3-12 (root@porky.devel.redhat.com) (gcc version 2.96 20=
000731 (Red Hat Linux 7.1 2.96-85)) #1 Fri Jun 8 13:35:30 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 131056
zone(0): 4096 pages.
zone(1): 126960 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D347 BOOT_FILE=3D/b=
oot/vmlinuz-2.4.3-12 hdd=3Dide-scsi
ide_setup: hdd=3Dide-scsi
Initializing CPU#0
Detected 1331.610 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2654.20 BogoMIPS
Memory: 509088k/524224k available (1246k kernel code, 10656k reserved, 93=
k data, 228k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0183f9ff c1c7f9ff 00000000, vendor =3D 2
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After vendor init, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:     After generic, caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU:             Common caps: 0183f9ff c1c7f9ff 00000000 00000000
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:07.3
Applying VIA PCI latency patch (found VT82C686B).
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
pty: 512 Unix98 ptys configured
block: queued sectors max/low 338074kB/207002kB, 1024 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP LM10.2, ATA DISK drive
hdb: IBM-DPTA-372050, ATA DISK drive
hdc: ATAPI 52X CDROM, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W8432T, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 20066251 sectors (10274 MB) w/1900KiB Cache, CHS=3D1249/255/63, UDMA=
(33)
hdb: 40088160 sectors (20525 MB) w/1961KiB Cache, CHS=3D2495/255/63, UDMA=
(33)
Partition check:
 hda: hda1
 hdb: hdb1 < hdb5 hdb6 hdb7 hdb8 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.05a (2001-03-20) with MANY_PORTS MULTIPORT SHARE_=
IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10d
md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md.c: sizeof(mdp_super_t) =3D 4096
autodetecting RAID arrays
autorun ...
=2E.. autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 228k freed
Adding Swap: 514040k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 13:51:44 Jun  8 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:07.3
usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 10 for device 00:07.3
PCI: The same IRQ used for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W8432T  Rev: 1.09
  Type:   CD-ROM                             ANSI SCSI revision: 02
Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
SMSC Super-IO detection, now testing Ports 2F0, 370 ...
parport0: PC-style at 0x378 [PCSPP,EPP]
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport_pc: Via 686A parallel port: io=3D0x378
ip_conntrack (4095 buckets, 32760 max)
PPP generic driver version 2.4.1
PPP BSD Compression module registered
PPP Deflate Compression module registered
Via 686a audio driver 1.1.14b
PCI: Assigned IRQ 10 for device 00:07.5
ac97_codec: AC97 Audio codec, id: 0x4943:0x4511 (ICE1232)
via82cxxx: board #1 at 0xDC00, IRQ 10
via_audio: ignoring drain playback error -11
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status timeout: status=3D0xd0 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete
PPP: VJ decompression error
PPP: VJ decompression error
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: status timeout: status=3D0xd0 { Busy }
hdc: drive not ready for command
hdc: ATAPI reset complete

--------------Boundary-00=_4JWHG9J7SQ96JAEQX2Q9--
