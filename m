Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262218AbSJVFXH>; Tue, 22 Oct 2002 01:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSJVFXH>; Tue, 22 Oct 2002 01:23:07 -0400
Received: from smtpcl1.fiducia.de ([195.200.32.50]:35229 "EHLO
	smtpcl1.fiducia.de") by vger.kernel.org with ESMTP
	id <S262218AbSJVFXA>; Tue, 22 Oct 2002 01:23:00 -0400
Sensitivity: 
Subject: PCI: Failed to allocate resource in 2.4.20pre10 and 11 - broken IRQ-router?
To: "linux-kernel" <linux-kernel@vger.kernel.org>
From: "Andreas Hartmann" <andreas.hartmann@fiducia.de>
Date: Tue, 22 Oct 2002 07:28:55 +0100
Message-ID: <OF4ECECA8D.86071157-ON41256C5A.0022B0DA@fag.fiducia.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm using an IBM Thinkpad T21 with a dockingstation, which has an own additional
ide-controller. At this controller, one more ATA-IDE hd is connected (/dev/hde).
dmesg with kernel 2.4.19 looks like this (correct version):

Linux version 2.4.19 (root@d172343) (gcc version 2.95.3 20010315 (SuSE)) #6 Sam Sep 21 14:45:45 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: auto BOOT_IMAGE=2419 ro root=303 BOOT_FILE=/boot/vmlinuz-2.4.19 hdc=cdrom pci=biosirq init 1
ide_setup: hdc=cdrom
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 796.544 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1589.24 BogoMIPS
Memory: 257344k/262080k available (858k kernel code, 4348k reserved, 348k data, 84k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=14
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c10-0x1c17, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c18-0x1c1f, BIOS settings: hdc:DMA, hdd:pio
CMD648: IDE controller on PCI bus 08 dev 08
CMD648: detected chipset, but driver not compiled in!
PCI: Found IRQ 11 for device 08:01.0
PCI: Sharing IRQ 11 with 00:02.1
CMD648: chipset revision 1
CMD648: 100% native mode on irq 11
    ide2: BM-DMA at 0x2000-0x2007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0x2008-0x200f, BIOS settings: hdg:pio, hdh:pio
hda: IBM-DJSA-220, ATA DISK drive
hdc: CD-224E, ATAPI CD/DVD-ROM drive
hde: IC25N030ATDA04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x2020-0x2027,0x2016 on irq 11
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2584/240/63
hde: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=62016/15/63
Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
 hde: hde1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 84k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 287272k swap-space (priority 42)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A


If I use 2.4.20pre10 or 11, the kernel can't find the additional ide-controller in the dockingstation no more.
The errormessage is:
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=14
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Cannot allocate resource region 0 of device 08:01.0
PCI: Cannot allocate resource region 1 of device 08:01.0
PCI: Cannot allocate resource region 2 of device 08:01.0
PCI: Cannot allocate resource region 3 of device 08:01.0
PCI: Cannot allocate resource region 4 of device 08:01.0
PCI: Cannot allocate resource region 0 of device 08:02.0
PCI: Cannot allocate resource region 0 of device 08:02.1
PCI: Failed to allocate resource 4(0-f) for 08:01.0
PCI: Failed to allocate resource 0(0-fff) for 08:02.0
PCI: Failed to allocate resource 0(0-fff) for 08:02.1

dmesg all in one looks like this:


Linux version 2.4.20-pre10 (root@d172343) (gcc version 2.95.3 20010315 (SuSE)) #1 Son Okt 13 09:06:10 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: auto BOOT_IMAGE=2420pre10 ro root=303 BOOT_FILE=/boot/vmlinuz-2.4.20pre10 hdc=cdrom pci=biosirq init 1
ide_setup: hdc=cdrom
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 796.552 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1589.24 BogoMIPS
Memory: 257328k/262080k available (854k kernel code, 4364k reserved, 215k data, 236k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=14
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Cannot allocate resource region 0 of device 08:01.0
PCI: Cannot allocate resource region 1 of device 08:01.0
PCI: Cannot allocate resource region 2 of device 08:01.0
PCI: Cannot allocate resource region 3 of device 08:01.0
PCI: Cannot allocate resource region 4 of device 08:01.0
PCI: Cannot allocate resource region 0 of device 08:02.0
PCI: Cannot allocate resource region 0 of device 08:02.1
PCI: Failed to allocate resource 4(0-f) for 08:01.0
PCI: Failed to allocate resource 0(0-fff) for 08:02.0
PCI: Failed to allocate resource 0(0-fff) for 08:02.1
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
Starting kswapd
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c10-0x1c17, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c18-0x1c1f, BIOS settings: hdc:DMA, hdd:pio
CMD648: IDE controller on PCI bus 08 dev 08
CMD648: detected chipset, but driver not compiled in!
PCI: Device 08:01.0 not available because of resource collisions
PCI: Device 08:01.0 not available because of resource collisions
CMD648: (ide_setup_pci_device:) Could not enable device.
hda: IBM-DJSA-220, ATA DISK drive
hdc: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1874KiB Cache, CHS=2584/240/63
Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3 hda4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
reiserfs: checking transaction log (device 03:03) ...
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 236k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 287272k swap-space (priority 42)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
blk: queue c02729c4, I/O limit 4095Mb (mask 0xffffffff)


Kind regards,
Andreas Hartmann


