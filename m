Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTFORLn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 13:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbTFORLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 13:11:43 -0400
Received: from [213.24.247.63] ([213.24.247.63]:19608 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S262427AbTFORLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 13:11:17 -0400
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: linux-kernel@vger.kernel.org
Subject: ACPI (20030522) breaks 3c59x in 2.4/2.5
Date: Sun, 15 Jun 2003 21:24:51 +0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jvK7+YQxQnS4LRK"
Message-Id: <200306152124.51449.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jvK7+YQxQnS4LRK
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody.
I've finally decided to try ACPI on my IBM ThinkPad T21 .
Mostly, it works nice and fine (although I'm still wondering what S1 sleep 
state _supposed_ to do, now it's acting weird), but one thing is a real 
showstoppper for me - 
with ACPI enabled, 3c556 mini-PCI NIC in this fine laptop ceases to function 
properly. I've tried to manually set IRQ for this card (using BIOS), tried to 
build kernel with/without APIC and/or IO-APIC - nothing helps. With acpi=off 
everything works OK, as well as when I'm enabling "CPU enumeration only" in 
menuconfig. This effect is present in 2.4.20/2.4.21-rc7/2.4.21/2.5.69/2.5.70, 
with 20030522 ACPI patches. 
Attached are dmesgs from acpi-enabled and non-acpi boots. 
I would be glad to provide additional info.

-- 
With all the best, yarick at relex dot ru.

--Boundary-00=_jvK7+YQxQnS4LRK
Content-Type: text/plain;
  charset="koi8-r";
  name="dmesg-acpi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg-acpi"

Linux version 2.4.21-laptop1 (root@YARICK) (gcc version 3.2.1 (ALT Linux, build 3.2.1-alt2)) #2 Sat Jun 14 17:57:23 MSD 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
ACPI: RSDP (v000 PTLTD                      ) @ 0x000f7120
ACPI: RSDT (v001 PTLTD    RSDT   01540.04432) @ 0x0fff4c5d
ACPI: FADT (v001 IBM    TP-T21   01540.04432) @ 0x0fffeb65
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 01540.04432) @ 0x0fffebd9
ACPI: DSDT (v001 IBM    TP-T21   01540.04432) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: MADT not present
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: root=/dev/hda5 
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 796.550 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1589.24 BogoMIPS
Memory: 256512k/262080k available (1490k kernel code, 5180k reserved, 348k data, 272k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030522
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S3 (swsusp) S4 S5)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: Power Resource [PSER] (off)
ACPI: Power Resource [PSIO] (on)
ACPI: Embedded Controller [EC] (gpe 9)
schedule_task(): keventd has not started
PCI: Probing PCI hardware
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20B, ATA DISK drive
blk: queue c033e440, I/O limit 4095Mb (mask 0xffffffff)
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2584/240/63, UDMA(33)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 272k freed
Adding Swap: 521600k swap-space (priority -1)
hdc: CHECK for good STATUS
udf: registering filesystem
PCI: Enabling device 00:03.0 (0000 -> 0003)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1400. Vers LK1.1.16
PCI: Setting latency timer of device 00:03.0 to 64
 ff:ff:ff:ff:ff:ff, IRQ 11
  product code ffff rev ffff.15 date 15-31-127
00:03.0: CardBus functions mapped 10000080->d094c080
Full duplex capable
  Internal config register is ffffffff, transceivers 0xffff.
  1024K word-wide RAM 3:5 Rx:Tx split, autoselect/<invalid transceiver> interface.
  Enabling bus-master transmits and early receives.
00:03.0: scatter/gather enabled. h/w checksums enabled
reiserfs: checking transaction log (device 03:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
MSDOS FS: IO charset koi8-r
MSDOS FS: Using codepage 866
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
usb-uhci.c: $Revision: 1.275 $ time 18:08:02 Jun 14 2003
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Crystal 4280/46xx + AC97 Audio, version 1.28.32, 18:07:48 Jun 14 2003
cs46xx: Card found at 0xe8100000 and 0xe8000000, IRQ 11
cs46xx: Thinkpad 600X/A20/T20 (1014:0153) at 0xe8100000/0xe8000000, IRQ 11
ac97_codec: AC97 Audio codec, id: CRY20 (Cirrus Logic CS4297A rev B)

--Boundary-00=_jvK7+YQxQnS4LRK
Content-Type: text/plain;
  charset="koi8-r";
  name="dmesg-acpi-off"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg-acpi-off"

Linux version 2.4.21-laptop1 (root@YARICK) (gcc version 3.2.1 (ALT Linux, build 3.2.1-alt2)) #2 Sat Jun 14 17:57:23 MSD 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fffec00 (ACPI data)
 BIOS-e820: 000000000fffec00 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
255MB LOWMEM available.
ACPI: have wakeup address 0xc0001000
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
IBM machine detected. Enabling interrupts during APM calls.
Kernel command line: root=/dev/hda5 acpi=off
Local APIC disabled by BIOS -- reenabling.
Could not enable APIC!
Initializing CPU#0
Detected 796.555 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1589.24 BogoMIPS
Memory: 256512k/262080k available (1490k kernel code, 5180k reserved, 348k data, 272k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
ACPI: Subsystem revision 20030522
ACPI: Disabled via command line (acpi=off)
PCI: PCI BIOS revision 2.10 entry at 0xfd94f, last bus=7
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Discovered primary peer bus 08 [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 64M @ 0xf8000000
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1c00-0x1c07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1c08-0x1c0f, BIOS settings: hdc:DMA, hdd:pio
hda: HITACHI_DK23BA-20B, ATA DISK drive
blk: queue c033e440, I/O limit 4095Mb (mask 0xffffffff)
hdc: MATSHITADVD-ROM SR-8175, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 39070080 sectors (20004 MB) w/2048KiB Cache, CHS=2584/240/63, UDMA(33)
hdc: attached ide-cdrom driver.
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 >
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
reiserfs: checking transaction log (device 03:05) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 272k freed
Adding Swap: 521600k swap-space (priority -1)
hdc: CHECK for good STATUS
udf: registering filesystem
PCI: Found IRQ 11 for device 00:03.0
PCI: Sharing IRQ 11 with 00:03.1
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
00:03.0: 3Com PCI 3c556B Laptop Hurricane at 0x1800. Vers LK1.1.16
 00:04:76:61:9a:bb, IRQ 11
  product code 0000 rev aa.8 date 03-01-00
00:03.0: CardBus functions mapped e8101000->d093c000
  Internal config register is 80600040, transceivers 0x40.
  8K byte-wide RAM 5:3 Rx:Tx split, MII interface.
  MII transceiver found at address 0, status 786d.
  Enabling bus-master transmits and whole-frame receives.
00:03.0: scatter/gather enabled. h/w checksums enabled
reiserfs: checking transaction log (device 03:08) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
MSDOS FS: IO charset koi8-r
MSDOS FS: Using codepage 866
reiserfs: checking transaction log (device 03:07) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
usb-uhci.c: $Revision: 1.275 $ time 18:08:02 Jun 14 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1c20, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
PCI: Found IRQ 11 for device 00:05.0
PCI: Sharing IRQ 11 with 00:02.0
PCI: Sharing IRQ 11 with 01:00.0
Crystal 4280/46xx + AC97 Audio, version 1.28.32, 18:07:48 Jun 14 2003
cs46xx: Card found at 0xe8100000 and 0xe8000000, IRQ 11
cs46xx: Thinkpad 600X/A20/T20 (1014:0153) at 0xe8100000/0xe8000000, IRQ 11
ac97_codec: AC97 Audio codec, id: CRY20 (Cirrus Logic CS4297A rev B)

--Boundary-00=_jvK7+YQxQnS4LRK--

