Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUFVRNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUFVRNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUFVRJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:09:47 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:28601 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264982AbUFVQ4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:56:37 -0400
Message-ID: <40D864BF.9000304@g-house.de>
Date: Tue, 22 Jun 2004 18:56:31 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Klaus Dittrich <kladit@t-online.de>
CC: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-bk5 scheduling while atomic
References: <20040622135529.GA838@xeon2.local.here>
In-Reply-To: <20040622135529.GA838@xeon2.local.here>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040603000207010609070004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040603000207010609070004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Klaus Dittrich wrote:
> System smp (2 x XEON, I7505) preemptive
>
> With kernel-2.6.7-bk5 I get a lot of
> "kernel: bad: scheduling while atomic!" messages
> during startup.
>
> 2.6.7 runs fine using the basically the same configuration.
>
> Did anybody else see this ?
>
> Here is an excerpt of /var/log/messages  ..
>
> Jun 22 14:58:52 xeon2 kernel: bad: scheduling while atomic!
> Jun 22 14:58:52 xeon2 kernel: bad: scheduling while atomic!
> Jun 22 14:58:52 xeon2 kernel:  [schedule+2000/2064]
[schedule+2000/2064] schedule+0x7d0/0x810
[...]

yes, "me too". but i was not able to get the messages flushed to the
disk. this is 2.6.7-BK kernel from 2004-06-21 (around 4p.m., GMT+1).

it happens upon mounting of nfs shares from a linux 2.6 kernel-nfs
server; the console is flooded with messages like yours and also i don't
have them at hand, i'd say they are the same.

Christian.
- --
BOFH excuse #425:

stop bit received
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA2GS/+A7rjkF8z0wRAmjJAKCJpzK+KPJcvyCK5gZ9sgCVX64ApgCdF1bK
LIBnzTRoxJ3hFLsphLp1aqg=
=aGiI
-----END PGP SIGNATURE-----

--------------040603000207010609070004
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.7 (evil@prinz) (gcc version 3.4.0 (Debian 20040516)) #2 Sat Jun 19 22:32:44 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ec000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI disabled because your bios is from 2000 and too old
You can enable it with acpi=force
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6-BK-old ro root=805
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 902.212 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 515816k/524224k available (2164k kernel code, 7644k reserved, 689k data, 388k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1777.66 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 901.0914 MHz.
..... host bus clock speed is 200.0425 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
vesafb: framebuffer at 0xd0000000, mapped to 0xe0800000, size 2560k
vesafb: mode is 1280x1024x8, linelength=1280, pages=2
vesafb: protected mode interface info at c000:bbe0
vesafb: scrolling: redraw
spurious 8259A interrupt: IRQ7.
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
Console: switching to colour frame buffer device 160x64
PCI: Found IRQ 9 for device 0000:00:0a.0
PCI: Sharing IRQ 9 with 0000:00:0e.0
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0a.0: 3Com PCI 3c905C Tornado at 0xcc00. Vers LK1.1.19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: IRQ probe failed (0xfffffffa)
hda: CRD-8483B, ATAPI CD/DVD-ROM drive
hdb: AOPEN CD-RW CRW3248 1.17 20020620, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PDC20265: IDE controller at PCI slot 0000:00:10.0
PCI: Found IRQ 10 for device 0000:00:10.0
PCI: Sharing IRQ 10 with 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:07.2
PDC20265: chipset revision 2
PDC20265: ROM enabled at 0xdffe0000
PDC20265: 100% native mode on irq 10
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:pio, hdh:pio
hde: ST320413A, ATA DISK drive
ide2 at 0xbc00-0xbc07,0xb802 on irq 10
hde: max request size: 128KiB
hde: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=38792/16/63, UDMA(100)
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4
PCI: Found IRQ 11 for device 0000:00:0c.0
sym0: <895> rev 0x1 at pci 0000:00:0c.0 irq 11
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.18j
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
  Vendor: IBM-ESXS  Model: ST318305LW    !#  Rev: B245
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym0:0:0: tagged command queuing enabled, command queue depth 16.
scsi(0:0:0:0): Beginning Domain Validation
sym0:0: asynchronous.
sym0:0: wide asynchronous.
sym0:0: FAST-40 WIDE SCSI 80.0 MB/s ST (25.0 ns, offset 31)
scsi(0:0:0:0): Ending Domain Validation
SCSI device sda: 35548320 512-byte hdwr sectors (18201 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 10 for device 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:10.0
uhci_hcd 0000:00:07.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:07.2: irq 10, io base 0000d000
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:07.3
PCI: Sharing IRQ 10 with 0000:00:07.2
PCI: Sharing IRQ 10 with 0000:00:10.0
uhci_hcd 0000:00:07.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:07.3: irq 10, io base 0000d400
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
PM: Reading pmdisk image.
PM: Resume from disk failed.
BIOS EDD facility v0.15 2004-May-17, 6 devices found
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 388k freed
usb 1-1: new low speed USB device using address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:07.2-1
usb 1-2: new low speed USB device using address 3
input: USB HID v1.00 Keyboard [046a:0001] on usb-0000:00:07.2-2
Adding 292840k swap on /dev/sda6.  Priority:0 extents:1
EXT3 FS on sda5, internal journal
Real Time Clock Driver v1.12
PCI: Found IRQ 9 for device 0000:00:0e.0
PCI: Sharing IRQ 9 with 0000:00:0a.0
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
Linux agpgart interface v0.100 (c) Dave Jones
nvidia: module license 'NVIDIA' taints kernel.
0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed Jan 14 18:29:26 PST 2004
devfs_mk_dev: could not append to parent for nvidiactl
devfs_mk_dev: could not append to parent for nvidia0
0: NVRM: AGPGART: unable to retrieve symbol table
drivers/usb/input/hid-input.c: event field not found
NTFS driver 2.1.14 [Flags: R/O DEBUG MODULE].
NTFS volume version 3.0.
hda: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdb: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
NTFS volume version 3.0.

--------------040603000207010609070004--
