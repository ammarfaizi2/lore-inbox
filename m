Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135542AbRALWbu>; Fri, 12 Jan 2001 17:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135582AbRALWbn>; Fri, 12 Jan 2001 17:31:43 -0500
Received: from smtp4.mail.yahoo.com ([128.11.69.101]:6159 "HELO
	smtp4.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135581AbRALWbc>; Fri, 12 Jan 2001 17:31:32 -0500
X-Apparently-From: <andrelourenco@yahoo.com>
Message-ID: <014f01c07ce6$e7536b20$71a941c2@fabi>
From: "andre lourenco" <andrelourenco@yahoo.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <3A5EFB40.6080B6F3@sw.com.sg>
Subject: problem with a copy (cdrom to disk) under 2.4.0
Date: Fri, 12 Jan 2001 22:25:06 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have a problem:

when i try to copy a big (maybe >200MB) from my CDROM to my disk the system
gives me an input/output error...

if I run dmesg i have this:

[root@localhost andyrock]# dmesg
Linux version 2.4.0 (root@localhost.localdomain) (gcc version 2.95.3
19991030 (prerelease)) #1 Qui Jan 11 12:22:42 WET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01223000)
Kernel command line: mem=131072K  root=/dev/hdb5  ide1=autotune
ide0=autotune
ide_setup: ide1=autotune
ide_setup: ide0=autotune
Initializing CPU#0
Detected 334.095 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 666.82 BogoMIPS
Memory: 126340k/131072k available (1215k kernel code, 4344k reserved, 472k
data, 220k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: Card 'ESS ES1868 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.0 present.
32 structures occupying 792 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 08/10/98
Starting kswapd v1.8
vesafb: framebuffer at 0xe5400000, mapped to 0xc8800000, size 4096k
vesafb: mode is 800x600x16, linelength=1600, pages=3
vesafb: protected mode interface info at c000:1759
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 100x37
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
ide3: ESS ES1868 Plug and Play AudioDrive IDE interface
hda: FUJITSU MPE3170AT, ATA DISK drive
hdb: QUANTUM FIREBALL EX3.2A, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6402B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 33360580 sectors (17081 MB) w/512KiB Cache, CHS=2076/255/63
hdb: 6306048 sectors (3229 MB) w/418KiB Cache, CHS=782/128/63, UDMA(33)
hdc: ATAPI 32X CD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 > hda3 hda4
 hdb: hdb1 hdb2 < hdb5 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
udf: registering filesystem
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
es1371: version v0.27 time 12:26:33 Jan 11 2001
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xe000, IRQ 9
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack (1024 buckets, 8192 max)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Adding Swap: 128516k swap-space (priority -1)
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: ESS ES1868 Plug and Play AudioDrive detected
sb: ISAPnP reports 'ESS ES1868 Plug and Play AudioDrive' at i/o 0x220, irq
5, dma 1, 3
SB 3.01 detected OK (220)
ESS chip ES1868 detected
sb: ESS ES1868 Plug and Play AudioDrive detected
sb: Failed to initialize ESS ES1868 Plug and Play AudioDrive
sb: 1 Soundblaster PnP card(s) found.
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 16
0x378: readIntrThreshold is 16
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x48
0x378: ECP settings irq=7 dma=<none or set by other means>
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,EPP,ECP]
parport0: irq 7 detected
parport0: cpp_mux: aa55f00f52ad51(07)
parport0: Found 1 daisy-chained devices
lp0: using parport0 (polling).
hdc: irq timeout: status=0xd0 { Busy }
hdc: DMA disabled
hdc: ATAPI reset complete
VFS: Disk change detected on device ide1(22,0)
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45152 ino=53408
isofs_read_level3_size: More than 100 file sections ?!?, aborting...
isofs_read_level3_size: inode=45232 ino=53488
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18476
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18480
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18484
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18488
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18492
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18468
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51
end_request: I/O error, dev 16:00 (hdc), sector 18472
[root@localhost andyrock]#


do you know what is this?
thank's,

Andre Lourenco

ver_linux:
Linux localhost.localdomain 2.4.0 #2 Qui Jan 11 19:34:32 WET 2001 i686
unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         parport_pc lp parport nfsd lockd sunrpc autofs opl3
sb
sb_lib uart401 sound nls_iso8859-1 nls_cp437 vfat fat



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
