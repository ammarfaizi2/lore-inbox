Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317355AbSHBAWb>; Thu, 1 Aug 2002 20:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSHBAWb>; Thu, 1 Aug 2002 20:22:31 -0400
Received: from [202.139.62.110] ([202.139.62.110]:1222 "EHLO
	almail.alchemia.com.au") by vger.kernel.org with ESMTP
	id <S317355AbSHBAW2> convert rfc822-to-8bit; Thu, 1 Aug 2002 20:22:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Dual Xeon Freezes with 2.4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 2 Aug 2002 10:28:06 +1000
Message-ID: <98E24C4993E01F41B3005C0C206CBE4D047F75@almail.alchemia.com.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dual Xeon Freezes with 2.4
Thread-Index: AcI5u3iQcR/BW31OQRqZ81w5kdlsvg==
From: "Johannes Zuegg" <jzuegg@alchemia.com.au>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have a Dual Xeon box with Intel SE7500CW2 Server Board (eepro100 onboard) and a Promise SuperTrak 6000 RAID card,
and on running 2.4, the box freezes every now and then.

I am running thereby 2.4.18 (from Debian distribution) with I2O block driver to access the Raid-Card disks. It works fine, I can even boot from the Raid-disk, but as reported by others, the system freezes every now and then (only cold-reboot possible, resulting in a lot of disk errors)

[Q] Did somebody manage to run a stable 2.4 system on a similar Xeon Box, and if yes what compile or boot option did you use?

On running kernel 2.2.19 (from Debian distribution) , I have problems with the Raid-disks. Even though the I2O drivers recognize the Raid-Card it complains about not finding disks on block 50, and the boot stops by not finding the root. 

VFS: Cannot open root device 50:01

Interestingly I2O under 2.4 maps the drives onto block 80 !!

[Q] Is there a difference in the I2O drivers between 2.2 and 2.4 ?
[Q] Are there option to map the I2O onto block 80 rather then block 50 ?

Promise has a source code for the SuperTrak 6000 card but I get a lot of compiling errors, that's why I use the I2O drivers.

On compiling 2.5.29 I get errors in several  i2o*.c source-files. like 

"#error Please convert me to Documentation/DMA_mappings.txt

and I am not Linux-experience enough to hack around in the source code. The documentation says something about DMA stuff (of course) but I am not sure what is required to enter in the sourec code.

[Q] Did anybody compile the 2.5 kernel with the I2O drivers, and if yes what should I change or enter in the corresponding I2O source files ?

[Q] Did somebody run the 2.5 kernel on a Xeon box and is it (more) stable ?

I appreciate any help and suggestion

!!!! As I am not subscribed to the list, so please CC any reply to my address as well, Thanks !!!!

Thanks & Cheers
Johannes


DMesg of 2.4.18 Kernel
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d400 (usable)
 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003feff000 (ACPI data)
 BIOS-e820: 000000003feff000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
found SMP MP-table at 000f66c0
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: SE7500CW2 APIC at: 0xFEE00000
Processor #0 Unknown CPU [15:2] APIC version 20
Processor #6 Unknown CPU [15:2] APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80400.
Processors: 2
Kernel command line: BOOT_IMAGE=Test ro root=5001 noapic
Initializing CPU#0
Detected 1993.585 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3971.48 BogoMIPS
Memory: 900444k/917504k available (1249k kernel code, 16664k reserved, 381k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU0: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
per-CPU timeslice cutoff: 1462.63 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/6 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3984.58 BogoMIPS
CPU: Before vendor init, caps: 3febfbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
CPU: After vendor init, caps: 3febfbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Total of 2 processors activated (7956.07 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1993.4443 MHz.
..... host bus clock speed is 99.6721 MHz.
cpu: 0, clocks: 996721, slice: 332240
CPU0<T0:996720,T1:664480,D:0,S:332240,C:996721>
cpu: 1, clocks: 996721, slice: 332240
CPU1<T0:996720,T1:332240,D:0,S:332240,C:996721>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd921, last bus=5
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router default [8086/2480] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS not found.
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=248b
PCI: Device 00:1f.1 not available because of resource collisions
PCI_IDE: chipset revision 2
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x6c60-0x6c67, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x6c68-0x6c6f, BIOS settings: hdc:pio, hdd:pio
hdc: HL-DT-ST GCE-8320B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Loading I2O Core - (c) Copyright 1999 Red Hat Software
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
i2o: I2O controller on bus 4 at 17.
i2o: PCI I2O controller at 0xFE400000 size=4194304
I2O: Promise workarounds activated.
i2o/iop0: Installed at IRQ5
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: Reset rejected, trying to clear
i2o/iop0: LCT has 11 entries.
i2o/iop0: Configuration dialog desired.
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2ob: Installing tid 16 device at unit 0
i2o/hda: Max segments 12, queue depth 32, byte limit 6144.
i2o/hda: Type 104: 38146MB, 512 byte sectors.
i2o/hda: Maximum sectors/read set to 256.
Partition check:
 i2o/hda: i2o/hda1 i2o/hda2
i2ob: Installing tid 17 device at unit 16
i2o/hdb: Max segments 12, queue depth 32, byte limit 6144.
i2o/hdb: Type 104: 228881MB, 512 byte sectors.
i2o/hdb: Maximum sectors/read set to 256.
 i2o/hdb: i2o/hdb1
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:B0:A4:22, IRQ 11.
  Board assembly ffffff-255, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:02:B3:B0:A6:63, IRQ 11.
  Board assembly ffffff-255, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
PCI: Setting latency timer of device 00:1d.0 to 64
uhci.c: USB UHCI at I/O 0x6c00, IRQ 10
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Setting latency timer of device 00:1d.1 to 64
uhci.c: USB UHCI at I/O 0x6c20, IRQ 5
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected

