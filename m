Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVHPJad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVHPJad (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVHPJad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:30:33 -0400
Received: from hell.sks3.muni.cz ([147.251.211.39]:20697 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S965162AbVHPJac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:30:32 -0400
Date: Tue, 16 Aug 2005 11:30:55 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.[45] oops at boot
Message-ID: <20050816093054.GN15531@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

here is an oops I got during boot with kernel 2.6.12.4 or .5. Using debian
kernel 2.6.8 it's ok. (Dmesg from 2.6.8 kernel is attached)

PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI->APIC IRQ transform: 0000:00:02.a[A] -> IRQ 145
PCI->APIC IRQ transform: 0000:00:1b.0[A] -> IRQ 145
PCI->APIC IRQ transform: 0000:00:1d.0[A] -> IRQ 185
PCI->APIC IRQ transform: 0000:00:1d.1[B] -> IRQ 161
PCI->APIC IRQ transform: 0000:00:1d.2[C] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:1d.3[D] -> IRQ 145
PCI->APIC IRQ transform: 0000:00:1d.7[A] -> IRQ 185
PCI->APIC IRQ transform: 0000:00:1f.1[A] -> IRQ 153
PCI->APIC IRQ transform: 0000:00:1f.2[B] -> IRQ 161
PCI->APIC IRQ transform: 0000:00:1f.3[B] -> IRQ 161
PCI->APIC IRQ transform: 0000:02:04.0[A] -> IRQ 169
PCI->APIC IRQ transform: 0000:02:06.0[A] -> IRQ 177
Unable to handle kernel NULL pointer dereference at virtual address 00000496
 printing eip:
c00f0488
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c00f0488>]    Not tainted VLI
EFLAGS: 00010246   (2.6.12.5)
EIP is at 0xc00f0488
eax: 0000b100   ebx: 00000000   ecx: 00002502   edx: 25808086
esi: 00000001   edi: c03c488c   ebp: c191ff9c   esp: c191ff40
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c191e000 task=c18cba20)
Stack: b1000200 c00f026b c00f028d ff9c0200 0001488c 00002580 0100b102 8086c00f
       00540000 0282c00f c02b790e 00000060 00000000 c1962800 00000001 c02b7c4c
       00008086 00002580 00000001 c191ff9a c191ff9b 00000001 0000ffff c1962800
Call trace:
 [<c02b790e>] pci_bios_find_device+0x27/0x50
 [<c02b7c4c>] pcibios_sort+0x5a/0x174
 [<c0417b81>] pcibios_init+0x78/0x7e
 [<c03fe80f>] do_initcalls+0x53/0xb5
 [<c0100290>] init+0x0/0x108
 [<c0100290>] init+0x0/0x108
 [<c01002bf>] init+0x2f/0x108
 [<c01012f0>] kernel_thread_helper+0x0/0xb
 [<c01012f5>] kernel_thread_helper+0x5/0xb
Code: 81 fe 00 ff 5 05 8a c1 ee eb 11 66 81 fe 01 ff 75 07 66 8b c1 66 ef eb 03

-- 
Luká¹ Hejtmánek

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.8-2-386 (horms@tabatha.lab.ultramonkey.org) (gcc version =
3.3.5 (Debian 1:3.3.5-12)) #1 Thu May 19 17:40:50 JST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f7f0000 (usable)
 BIOS-e820: 000000003f7f0000 - 000000003f800000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: Unable to locate RSDP
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: TEMPLATE Product ID: ETEMPLATE    APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: root=3D/dev/md0 ro=20
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 3001.284 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 901692k/917504k available (1336k kernel code, 15020k reserved, 732k=
 data, 204k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5914.62 BogoMIPS
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-17, 2-22 not connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00170020
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0020
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 001 01  0    0    0   0   0    1    1    51
 07 001 01  0    0    0   0   0    1    1    59
 08 001 01  0    0    0   0   0    1    1    61
 09 001 01  0    0    0   0   0    1    1    69
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 001 01  0    0    0   0   0    1    1    71
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 001 01  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 001 01  1    1    0   1   0    1    1    99
 13 001 01  1    1    0   1   0    1    1    A1
 14 001 01  1    1    0   1   0    1    1    A9
 15 001 01  1    1    0   1   0    1    1    B1
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    B9
Using vector-based indexing
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ145 -> 0:16
IRQ153 -> 0:18
IRQ161 -> 0:19
IRQ169 -> 0:20
IRQ177 -> 0:21
IRQ185 -> 0:23
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 2999.0736 MHz.
=2E.... host bus clock speed is 199.0982 MHz.
checking if image is initramfs...it isn't (ungzip failed); looks like an in=
itrd
Freeing initrd memory: 4436k freed
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f5660
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x645a, dseg 0xf0000
pnp: 00:0d: ioport range 0x290-0x297 has been reserved
pnp: 00:0e: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0e: ioport range 0xcf8-0xcff could not be reserved
pnp: 00:0e: ioport range 0x480-0x4bf has been reserved
pnp: 00:0e: ioport range 0x800-0x87f has been reserved
pnp: 00:0e: ioport range 0x680-0x6ff has been reserved
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus 01 [IRQ]
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I2,P0) -> 145
PCI->APIC IRQ transform: (B0,I27,P0) -> 145
PCI->APIC IRQ transform: (B0,I29,P0) -> 185
PCI->APIC IRQ transform: (B0,I29,P1) -> 161
PCI->APIC IRQ transform: (B0,I29,P2) -> 153
PCI->APIC IRQ transform: (B0,I29,P3) -> 145
PCI->APIC IRQ transform: (B0,I29,P0) -> 185
PCI->APIC IRQ transform: (B0,I31,P0) -> 153
PCI->APIC IRQ transform: (B0,I31,P1) -> 161
PCI->APIC IRQ transform: (B0,I31,P1) -> 161
PCI->APIC IRQ transform: (B2,I4,P0) -> 169
PCI->APIC IRQ transform: (B2,I6,P0) -> 177
PCI: BIOS reporting unknown device 00:00
PCI: Device 00:10 not found by BIOS
PCI: BIOS reporting unknown device 00:e8
PCI: BIOS reporting unknown device 00:e9
PCI: BIOS reporting unknown device 00:ea
PCI: BIOS reporting unknown device 00:eb
PCI: BIOS reporting unknown device 00:ef
PCI: Device 00:f8 not found by BIOS
PCI: Device 00:f9 not found by BIOS
PCI: Device 00:fa not found by BIOS
PCI: Device 00:fb not found by BIOS
PCI: BIOS reporting unknown device 02:20
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
EISA: Probing bus 0 at eisa0
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 8
NET: Registered protocol family 20
RAMDISK: cramfs filesystem found at block 0
RAMDISK: Loading 4436 blocks [1 disk] into ram disk... |=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=
=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08=
/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=
=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08=
-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=
=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08=
\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=
=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08=
|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08-=08\=08|=08/=08done.
VFS: Mounted root (cramfs filesystem) readonly.
Freeing unused kernel memory: 204k freed
vesafb: probe of vesafb0 failed with error -6
NET: Registered protocol family 1
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: raid1 personality registered as nr 3
SCSI subsystem initialized
libata version 1.02 loaded.
ata_piix version 1.02
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xD080 ctl 0xD002 bmdma 0xC800 irq 161
ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xC882 bmdma 0xC808 irq 161
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
207f
ata2: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
Using anticipatory io scheduler
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160827AS       Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:1d.0: Intel Corp. I/O Controller Hub USB
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 185, io base 0000d880
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.1: Intel Corp. I/O Controller Hub USB
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 161, io base 0000d800
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.2: Intel Corp. I/O Controller Hub USB
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 153, io base 0000d480
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd 0000:00:1d.3: Intel Corp. I/O Controller Hub USB
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 145, io base 0000d400
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ehci_hcd 0000:00:1d.7: Intel Corp. I/O Controller Hub USB2
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 185, pci mem f8818c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usbcore: registered new driver usbkbd
drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Console: switching to colour frame buffer device 80x30
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
inserting floppy driver for 2.6.8-2-386
FDC 0 is a post-1991 82077
ICH6: IDE controller at PCI slot 0000:00:1f.1
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: HL-DT-STDVD-ROM GDR8163B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 52X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sda: drive cache: write back
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdb: drive cache: write back
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
r8169 Gigabit Ethernet driver 1.2 loaded
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf89a3c00, 00:11:09:d8:ba:66, IRQ 177
eth0: Auto-negotiation Enabled.
eth0: 100Mbps Full-duplex operation.
md: raid0 personality registered as nr 2
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4732.000 MB/sec
raid5: using function: pIII_sse (4732.000 MB/sec)
md: raid5 personality registered as nr 4
md: md0 stopped.
md: bind<sdb1>
md: bind<sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Unable to find swap-space signature
Adding 979956k swap on /dev/sdb2.  Priority:-1 extents:1
EXT3 FS on md0, internal journal
Generic RTC Driver v1.07
Capability LSM initialized
md: md1 stopped.
md: bind<sdb3>
md: bind<sda3>
raid1: raid set md1 active with 2 out of 2 mirrors
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Unable to find swap-space signature
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 915G Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
hw_random: RNG not detected
input: PC Speaker
irda_init()
NET: Registered protocol family 23
parport: PnPBIOS parport detected.
parport0: PC-style at 0x3bc, irq 7 [PCSPP,TRISTATE]

--+pHx0qQiF2pBVqBT--
