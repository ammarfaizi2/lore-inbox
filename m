Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbUKNN27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUKNN27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 08:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbUKNN2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 08:28:15 -0500
Received: from mail.aknet.ru ([217.67.122.194]:33041 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261301AbUKNN1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 08:27:02 -0500
Message-ID: <41975D3D.10106@aknet.ru>
Date: Sun, 14 Nov 2004 16:27:25 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: zwane@linuxpower.ca, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
References: <200411141211.iAECBKco011487@harpo.it.uu.se>
In-Reply-To: <200411141211.iAECBKco011487@harpo.it.uu.se>
Content-Type: multipart/mixed;
 boundary="------------060207010608010807010405"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060207010608010807010405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Mikael Pettersson wrote:
>>CPU0: AMD Athlon(tm) Processor stepping 02
> Please post the contents of /proc/cpuinfo. The age
OK.

> If a previous kernel successfully found the local APIC,
> then please state which one and post its boot log.
Attached is the dmesg from 2.6.8-rc1.
2.6.9 also finds it if I specify "lapic",
but dmesg contains nothing, while 2.6.8-rc1
screams out loudly about APIC. Would be
nice to get these messages back btw.

> (And please use nmi_watchdog=2 so we can confirm that
> it's there and working.)
OK. And I think it was really working
because of the non-zero NMI count in
/proc/interrupts. I used NMI to debug
some stuff.


--------------060207010608010807010405
Content-Type: text/plain;
 name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpuinfo"

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 705.182
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr pni syscall mmxext 3dnowext 3dnow
bogomips	: 1388.54


--------------060207010608010807010405
Content-Type: text/plain;
 name="dmsg1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmsg1"

Linux version 2.6.8-rc1 (root@lin) (gcc version 3.4.0 (Red Hat Linux 3.4.0-1)) #6 SMP Sun Nov 14 16:04:21 MSK 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI disabled because your bios is from 2000                       and too old
You can enable it with acpi=force
Built 1 zonelists
Kernel command line: ro root=/dev/hdc2 apm=power-off lapic nmi_watchdog=2
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 705.165 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515000k/524224k available (2078k kernel code, 8464k reserved, 829k data, 172k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1392.64 BogoMIPS
Security Scaffold v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: After vendor identify, caps:  0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps:        0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) Processor stepping 02
per-CPU timeslice cutoff: 730.92 usecs.
task migration cache decay timeout: 1 msecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
testing NMI watchdog ... OK.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 704.0786 MHz.
..... host bus clock speed is 201.0367 MHz.
Brought up 1 CPUs
CPU0:  online
 domain 0: span 1
  groups: 1
spurious 8259A interrupt: IRQ7.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd9e1, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7a30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6944, dseg 0xf0000
PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:04.0
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1100448595.142:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M, fd1 is 1.2M
FDC 0 is a post-1991 82077
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hda: FUJITSU MPG3409AT E, ATA DISK drive
hdb: FUJITSU MPE3102AT, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: Maxtor 6Y080L0, ATA DISK drive
hdd: CD-S500/A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80063424 sectors (40992 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15 >
hdb: max request size: 128KiB
hdb: 20016348 sectors (10248 MB) w/512KiB Cache, CHS=19857/16/63
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
hdc: max request size: 128KiB
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc14 >
hdd: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
logibm.c: Didn't find Logitech busmouse at 0x23c
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 32Kbytes
TCP: Hash tables configured (established 16384 bind 21845)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 172k freed
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 10 for device 0000:00:04.2
PCI: Sharing IRQ 10 with 0000:00:04.3
PCI: Sharing IRQ 10 with 0000:00:10.0
uhci_hcd 0000:00:04.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:04.2: irq 10, io base 0000d400
uhci_hcd 0000:00:04.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:04.3
PCI: Sharing IRQ 10 with 0000:00:04.2
PCI: Sharing IRQ 10 with 0000:00:10.0
uhci_hcd 0000:00:04.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:04.3: irq 10, io base 0000d800
uhci_hcd 0000:00:04.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using address 2
usbcore: registered new driver hiddev
input: USB HID v1.00 Mouse [1241:1111] on usb-0000:00:04.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 1-2: new full speed USB device using address 3
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: JetFlash  Model: TS256MJF2A        Rev: 1.00
  Type:   Direct-Access                      ANSI SCSI revision: 02
USB Mass Storage device found at 3
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
SCSI device sda: 512000 512-byte hdwr sectors (262 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
EXT3 FS on hdc2, internal journal
Adding 530104k swap on /dev/hda9.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc13, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc11, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc14, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
NTFS driver 2.1.15 [Flags: R/W MODULE].
NTFS-fs warning (device hdb1): ntfs_fill_super(): Atime updates are not implemented yet.  Disabling them.
NTFS volume version 3.1.
NTFS-fs warning (device hda13): ntfs_fill_super(): Atime updates are not implemented yet.  Disabling them.
NTFS volume version 3.1.
FAT: utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
ip_tables: (C) 2000-2002 Netfilter core team
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:04.3
PCI: Sharing IRQ 10 with 0000:00:04.2
divert: allocating divert_blk for eth0
eth0: RealTek RTL-8029 found at 0xc800, IRQ 10, 00:C0:26:EF:74:E6.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: Legacy device
lp0: using parport0 (interrupt-driven).
lp0: console ready
IN=eth0 OUT= MAC=00:c0:26:ef:74:e6:00:40:f4:70:07:19:08:00 SRC=192.168.2.114 DST=192.168.3.28 LEN=48 TOS=0x00 PREC=0x00 TTL=128 ID=48108 PROTO=TCP SPT=3378 DPT=139 WINDOW=64240 RES=0x00 SYN URGP=0 
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0390f40(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
eth0: no IPv6 routers present

--------------060207010608010807010405--
