Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUFEXlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUFEXlW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUFEXlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:41:22 -0400
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:53720 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S262398AbUFEXlN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:41:13 -0400
From: Luis Miguel =?iso-8859-1?q?Garc=EDa_Mancebo?= <ktech@wanadoo.es>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc1 breaks forcedeth
Date: Sun, 6 Jun 2004 01:41:09 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406060141.09394.ktech@wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

(sorry with my poor english)

I have not been able to make my ethernet card to work in post-2.6.6 kernels. 
This is a nforce2 motherboard, and as Jeff pointed, nothing has changed in 
the driver (forcedeth), and the problem could be acpi or routing in the 
kernel. In fact, I have a "Disabling IRQ #11" message. Here is the dmesg:

P.S.: I have tested noapic, acpi=off, pci=noapic. But this doesn't fix 
nothing.



Linux version 2.6.7-rc2-Redeeman1 (root@evanescence) (gcc versi?n 3.4.0 
20040519 (Gentoo Linux 3.4.0-r5, ssp-3.4-2, pie-8.7.6.2)) #4 Sun Jun 6 
00:32:25 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Built 1 zonelists
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6.7rc2-rd1 ro root=304 acpi=off noapic 
pci=noacpi
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2126.237 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 906844k/917504k available (1789k kernel code, 9912k reserved, 518k 
data, 120k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4194.30 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm)  stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
Machine check exception polling timer started.
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: ST380023A, ATA DISK drive
Using cfq io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-ST GCE-8520B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 > p3 p4
hdc: ATAPI 40X CD-ROM CD-R/RW CD-MRW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
VFS: Mounted root (reiser4 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 120k freed
Adding 498004k swap on /dev/hda3.  Priority:-1 extents:1
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 256M @ 0xa0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49297 usecs
intel8x0: clocking to 47483
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 11, pci mem f8a04000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
irq 11: nobody cared!
 [<c01059aa>]
 [<c0105ac3>]
 [<c0105db8>]
 [<c01040a8>]
 [<c01191b0>]
 [<c0119236>]
 [<c0105dc5>]
 [<c01040a8>]
 [<c01e8dbe>]
 [<f8a8b8a2>]
 [<c0115a38>]
 [<f8a36870>]
 [<f8a3bd6a>]
 [<c01eca72>]
 [<c01ecacc>]
 [<c01ecb0c>]
 [<c0229b9f>]
 [<c0229cf2>]
 [<c0229fb1>]
 [<c022a45f>]
 [<c01ecddc>]
 [<f8a02020>]
 [<c012bd9f>]
 [<c0103f3b>]

handlers:
[<f8a37800>]
Disabling IRQ #11
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.2
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
trying access hardware directly.
inserting floppy driver for 2.6.7-rc2-Redeeman1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.25.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
open: SetupReg5, Bit 31 remained off


Note: That 4 last lines was bacause I unloaded and loaded the forcedeth 
driver.

Any tip?

-- 
Luis Miguel García Mancebo
Universidad de Deusto / Deusto University
Spain
