Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUAMJNx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 04:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAMJNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 04:13:53 -0500
Received: from AGrenoble-101-1-2-140.w193-253.abo.wanadoo.fr ([193.253.227.140]:63416
	"EHLO awak.dyndns.org") by vger.kernel.org with ESMTP
	id S263561AbUAMJNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 04:13:44 -0500
Subject: Re: Laptops & CPU frequency
From: Xavier Bestel <xavier.bestel@free.fr>
To: john stultz <johnstul@us.ibm.com>
Cc: Robert Love <rml@ximian.com>, jlnance@unity.ncsu.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073945248.28098.49.camel@cog.beaverton.ibm.com>
References: <20040111025623.GA19890@ncsu.edu>
	 <1073791061.1663.77.camel@localhost>  <1073816858.6189.186.camel@nomade>
	 <1073817226.6189.189.camel@nomade>
	 <1073937159.28098.46.camel@cog.beaverton.ibm.com>
	 <1073942913.724.10.camel@nomade>
	 <1073945248.28098.49.camel@cog.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-a2knkyKMUfutdzrQ1Agw"
Message-Id: <1073985236.758.3.camel@nomade>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 13 Jan 2004 10:13:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a2knkyKMUfutdzrQ1Agw
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Le lun 12/01/2004 =E0 23:07, john stultz a =E9crit :
> Please do. I have code in the kernel that tries to detect when the
> problem you see occurs, so we will drop back to the PIT automatically.
> Somehow it seems we're not triggering that code in your case.=20

Here are the dmesgs. I did the diff to simplify your life.
Tell me if you need more.

	Xav

--- dmesg_acpower       2004-01-13 10:09:10.000000000 +0100
+++ dmesg_battery       2004-01-13 10:09:20.000000000 +0100
@@ -18,10 +18,10 @@
 Could not enable APIC!
 Initializing CPU#0
 PID hash table entries: 1024 (order 10: 8192 bytes)
-Detected 300.092 MHz processor.
+Detected 153.050 MHz processor.
 Console: colour VGA+ 80x25
 Memory: 154816k/163808k available (1494k kernel code, 8416k reserved, 603k=
 data, 224k init, 0k highmem)
-Calibrating delay loop... 589.82 BogoMIPS
+Calibrating delay loop... 294.91 BogoMIPS
 Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)





--=-a2knkyKMUfutdzrQ1Agw
Content-Disposition: inline; filename=dmesg_acpower
Content-Type: text/plain; name=dmesg_acpower; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.0-1-686 (herbert@gondolin) (gcc version 3.3.2 (Debian)) #2 Sun Jan 11 16:59:17 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000009ff8000 (usable)
 BIOS-e820: 0000000009ff8000 - 000000000a000000 (ACPI NVS)
0MB HIGHMEM available.
159MB LOWMEM available.
On node 0 totalpages: 40952
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 36856 pages, LIFO batch:8
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Building zonelist for node : 0
Kernel command line: root=/dev/hda5 acpi=off single
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 300.092 MHz processor.
Console: colour VGA+ 80x25
Memory: 154816k/163808k available (1494k kernel code, 8416k reserved, 603k data, 224k init, 0k highmem)
Calibrating delay loop... 589.82 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 4224k freed
CPU:     After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0484, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x4a42, dseg 0xf0000
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4224 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\done.
VFS: Mounted root (cramfs filesystem).
Freeing unused kernel memory: 224k freed
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Module ide_probe_mod cannot be unloaded due to unsafe usage in include/linux/module.h:483
hda: IBM-DADA-25400, ATA DISK drive
hdb: UJDA150, ATAPI CD/DVD-ROM drive
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:DMA
Module piix cannot be unloaded due to unsafe usage in include/linux/module.h:483
hda: max request size: 128KiB
hda: 10553760 sectors (5403 MB) w/460KiB Cache, CHS=11168/15/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 > p4
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 264560k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
Real Time Clock Driver v1.12
NET: Registered protocol family 17
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
synaptics reset failed
synaptics reset failed
synaptics reset failed
Unable to query/initialize Synaptics hardware.
input: PS/2 Synaptics TouchPad on isa0060/serio1
mice: PS/2 mouse device common for all mice
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
evbug.c: Connected device: "AT Translated Set 2 keyboard", isa0060/serio0/input0
evbug.c: Connected device: "PS/2 Synaptics TouchPad", isa0060/serio1/input0
tsdev: module license 'unspecified' taints kernel.
ts: Compaq touchscreen protocol output
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00001000
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected

--=-a2knkyKMUfutdzrQ1Agw
Content-Disposition: inline; filename=dmesg_battery
Content-Type: text/plain; name=dmesg_battery; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.0-1-686 (herbert@gondolin) (gcc version 3.3.2 (Debian)) #2 Sun Jan 11 16:59:17 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000009ff8000 (usable)
 BIOS-e820: 0000000009ff8000 - 000000000a000000 (ACPI NVS)
0MB HIGHMEM available.
159MB LOWMEM available.
On node 0 totalpages: 40952
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 36856 pages, LIFO batch:8
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
Building zonelist for node : 0
Kernel command line: root=/dev/hda5 acpi=off single
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 153.050 MHz processor.
Console: colour VGA+ 80x25
Memory: 154816k/163808k available (1494k kernel code, 8416k reserved, 603k data, 224k init, 0k highmem)
Calibrating delay loop... 294.91 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an initrd
Freeing initrd memory: 4224k freed
CPU:     After generic identify, caps: 0183f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0183f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU:     After all inits, caps: 0183f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0484, last bus=0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe2d0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x4a42, dseg 0xf0000
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 256 Unix98 ptys configured
Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET: Registered protocol family 8
NET: Registered protocol family 20
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4224 blocks [1 disk] into ram disk... |/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\|/-\done.
VFS: Mounted root (cramfs filesystem).
Freeing unused kernel memory: 224k freed
NET: Registered protocol family 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Module ide_probe_mod cannot be unloaded due to unsafe usage in include/linux/module.h:483
hda: IBM-DADA-25400, ATA DISK drive
hdb: UJDA150, ATAPI CD/DVD-ROM drive
ide2: I/O resource 0x3EE-0x3EE not free.
ide2: ports already in use, skipping probe
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:DMA
Module piix cannot be unloaded due to unsafe usage in include/linux/module.h:483
hda: max request size: 128KiB
hda: 10553760 sectors (5403 MB) w/460KiB Cache, CHS=11168/15/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 > p4
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 264560k swap on /dev/hda6.  Priority:-1 extents:1
EXT3 FS on hda5, internal journal
Real Time Clock Driver v1.12
NET: Registered protocol family 17
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
synaptics reset failed
synaptics reset failed
synaptics reset failed
Unable to query/initialize Synaptics hardware.
input: PS/2 Synaptics TouchPad on isa0060/serio1
mice: PS/2 mouse device common for all mice
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
evbug.c: Connected device: "AT Translated Set 2 keyboard", isa0060/serio0/input0
evbug.c: Connected device: "PS/2 Synaptics TouchPad", isa0060/serio1/input0
tsdev: module license 'unspecified' taints kernel.
ts: Compaq touchscreen protocol output
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:07.2
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 00001000
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected

--=-a2knkyKMUfutdzrQ1Agw--

