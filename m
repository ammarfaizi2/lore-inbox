Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbTIYAnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 20:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbTIYAnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 20:43:04 -0400
Received: from h139-142-214-162.gtcust.grouptelecom.net ([139.142.214.162]:40966
	"EHLO smtp.atrium.ca") by vger.kernel.org with ESMTP
	id S261622AbTIYAmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 20:42:51 -0400
Message-id: <fc.0086957300614929008695730061456b.61494d@atrium.ca>
Date: Wed, 24 Sep 2003 19:45:01 -0500
Subject: Re: 2.6.0-test5-mm3 Promise SuperTrak SX6000 unrecognized
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org
From: "Dave Poirier" <dave.poirier@atrium.ca>
References: <fc.008695730061456b008695730061456b.6145b2@atrium.ca>
 <3F722C0C.1050901@rackable.com>
In-Reply-To: <3F722C0C.1050901@rackable.com>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="--=_--0061494d.00614929.bb97a4bd"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

----=_--0061494d.00614929.bb97a4bd
Content-type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Samuel Flory <sflory@rackable.com> writes:
>Dave Poirier wrote:
>(snip)
>
>   Have you tried the generic i2o driver?  'Modprobe i2o_scsi'
(snip)

Yes, without positive result.  I took the liberty of attaching `dmesg`
output.  I have SCSI disk and cdrom support, i2o (all selected, block,
scsi, pci, etc), with both selected and unselected Promise 20276 support.

The BIOS of the controller is set to "Other OS" and configured with one
RAID 1 array of 2 identical 80GB drives.

As you will be able to see in the dmesg output, i2o scsi did not find any
controller.

-Dave



----=_--0061494d.00614929.bb97a4bd
Content-Type: text/plain; name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.6.0-test5-mm3 (root=40clr) (gcc version 2.95.4 20011002 (De=
bian prerelease)) =238 SMP Wed Sep 24 14:14:21 CDT 2003
Video mode to be used for restore is f00
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff30000 (usable)
 BIOS-e820: 000000007ff30000 - 000000007ff40000 (ACPI data)
 BIOS-e820: 000000007ff40000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v002 ACPIAM                                    ) =40 0x000f9fb0=

ACPI: XSDT (v001 A M I  OEMXSDT  0x06000311 MSFT 0x00000097) =40 0x7ff30100=

ACPI: FADT (v003 A M I  OEMFACP  0x06000311 MSFT 0x00000097) =40 0x7ff30290=

ACPI: MADT (v001 A M I  OEMAPIC  0x06000311 MSFT 0x00000097) =40 0x7ff30390=

ACPI: OEMB (v001 A M I  OEMBIOS  0x06000311 MSFT 0x00000097) =40 0x7ff40040=

ACPI: DSDT (v001  P4P81 P4P81072 0x00000072 INTL 0x02002026) =40 0x00000000=

ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id=5B0x01=5D lapic_id=5B0x00=5D enabled)
Processor =230 15:2 APIC version 20
ACPI: LAPIC (acpi_id=5B0x02=5D lapic_id=5B0x01=5D enabled)
Processor =231 15:2 APIC version 20
ACPI: IOAPIC (id=5B0x02=5D address=5B0xfec00000=5D global_irq_base=5B0x0=
=5D)
IOAPIC=5B0=5D: Assigned apic_id 2
IOAPIC=5B0=5D: apic_id 2, version 32, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus=5B0=5D irq=5B0x0=5D global_irq=5B0x2=5D polarity=5B0=
x0=5D trigger=5B0x0=5D)
ACPI: INT_SRC_OVR (bus=5B0=5D irq=5B0x9=5D global_irq=5B0x9=5D polarity=5B0=
x1=5D trigger=5B0x3=5D)
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D303
current: c0420900
current->thread_info: c0484000
Initializing CPU=230
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2406.115 MHz processor.
Console: colour VGA+ 80x25
Memory: 903136k/917504k available (2556k kernel code, 13588k reserved, 1041=
k data, 328k init, 0k highmem)
Calibrating delay loop... 4751.36 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU=230.
CPU=230: Intel P4/Xeon Extended MCE MSRs (12) available
CPU=230: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
per-CPU timeslice cutoff: 1462.47 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU=230
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU=231
masked ExtINT on CPU=231
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 4800.51 BogoMIPS
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU=231.
CPU=231: Intel P4/Xeon Extended MCE MSRs (12) available
CPU=231: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 09
Total of 2 processors activated (9551.87 BogoMIPS).
cpu_sibling_map=5B0=5D =3D 1
cpu_sibling_map=5B1=5D =3D 0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
number of MP IRQ sources: 15.
number of IO-APIC =232 registers: 24.
testing the IO APIC.......................
IO APIC =232......
.... register =2300: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register =2301: 00178020
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0020
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  1    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2405.0166 MHz.
..... host bus clock speed is 200.0430 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP=21
Starting migration thread for cpu 1
CPUS done 8
zapping low mappings.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20030916
IOAPIC=5B0=5D: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:0)=

ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge =5BPCI0=5D (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0._PRT=5D
ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.P0P4._PRT=5D
ACPI: PCI Interrupt Link =5BLNKA=5D (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link =5BLNKB=5D (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link =5BLNKC=5D (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link =5BLNKD=5D (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link =5BLNKE=5D (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link =5BLNKF=5D (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link =5BLNKG=5D (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link =5BLNKH=5D (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
IOAPIC=5B0=5D: Set PCI routing entry (2-18 -> 0xa9 -> IRQ 18 Mode:1 Active:=
1)
00:00:1f=5BA=5D -> 2-18 -> IRQ 18
IOAPIC=5B0=5D: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:=
1)
00:00:1f=5BB=5D -> 2-17 -> IRQ 17
IOAPIC=5B0=5D: Set PCI routing entry (2-16 -> 0xb9 -> IRQ 16 Mode:1 Active:=
1)
00:00:1d=5BA=5D -> 2-16 -> IRQ 16
IOAPIC=5B0=5D: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:=
1)
00:00:1d=5BB=5D -> 2-19 -> IRQ 19
Pin 2-18 already programmed
IOAPIC=5B0=5D: Set PCI routing entry (2-23 -> 0xc9 -> IRQ 23 Mode:1 Active:=
1)
00:00:1d=5BD=5D -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
IOAPIC=5B0=5D: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:=
1)
00:02:08=5BA=5D -> 2-20 -> IRQ 20
IOAPIC=5B0=5D: Set PCI routing entry (2-21 -> 0xd9 -> IRQ 21 Mode:1 Active:=
1)
00:02:09=5BA=5D -> 2-21 -> IRQ 21
IOAPIC=5B0=5D: Set PCI routing entry (2-22 -> 0xe1 -> IRQ 22 Mode:1 Active:=
1)
00:02:09=5BB=5D -> 2-22 -> IRQ 22
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-20 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-21 already programmed
Pin 2-22 already programmed
Pin 2-23 already programmed
Pin 2-20 already programmed
Pin 2-22 already programmed
Pin 2-20 already programmed
Pin 2-23 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
radeonfb_pci_register BEGIN
radeonfb: ref_clk=3D2700, ref_div=3D60, xclk=3D14300 from BIOS
radeonfb: probed DDR SGRAM 65536k videoram
radeon_get_moninfo: bios 4 scratch =3D 2000002
radeonfb: ATI Radeon VE QY DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port CRT monitor connected
radeonfb_pci_register END
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.11 <tigran=40veritas.com>
Starting balanced_irq
VFS: Disk quotas dquot_6.5.1
Installing knfsd (copyright (C) 1996 okir=40monad.swb.de).
NTFS driver 2.1.4 =5BFlags: R/O=5D.
udf: registering filesystem
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M =40 0xf8000000
=5Bdrm=5D Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver =24Revision: 1.90 =24 IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
sk98lin: Network Device Driver v6.14
(C)Copyright 1999-2003 Marvell(R).
eth0: 3Com Gigabit LOM (3C940)
      PrefPort:A  RlmtMode:Check Link State
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
hda: ST380011A, ATA DISK drive
hdc: Pioneer DVD-ROM ATAPIModel DVD-115 0108, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=3D16383/255/63
 hda: hda1 hda2 hda3
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PIONEER   Model: DVD-ROM DVD-115   Rev: 1.08
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 5
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem fc83fc00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: enabled 64bit PCI DMA
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 8 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
uhci-hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci-hcd 0000:00:1d.0: irq 16, io base 0000ef00
uhci-hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci-hcd 0000:00:1d.1: irq 19, io base 0000ef20
uhci-hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
uhci-hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci-hcd 0000:00:1d.2: irq 18, io base 0000ef40
uhci-hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
uhci-hcd 0000:00:1d.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci-hcd 0000:00:1d.3: irq 16, io base 0000ef80
uhci-hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:0: USB hub found
hub 5-0:0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 22
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2o_scsi.c: Version 0.1.2
  chain_pool: 0 bytes =40 f7c29560
  (512 byte buffers X 4 can_queue X 0 i2o controllers)
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 328k freed
Adding 393584k swap on /dev/hda2.  Priority:-1 extents:1
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?

----=_--0061494d.00614929.bb97a4bd--
