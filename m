Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbTLFOTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 09:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbTLFOTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 09:19:44 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:34060 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S265169AbTLFOTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 09:19:31 -0500
Message-ID: <3FD1E570.3070707@dcrdev.demon.co.uk>
Date: Sat, 06 Dec 2003 14:19:28 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i8042 problem on -test11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a problem during boot with -test11 concerning keyboard/mouse.  
This problem doesn't occur on -test9.

In -test11, whilst it boots okay, the keyboard and mouse are not active 
at the console.  The problem appears to be related to:

mice: PS/2 mouse device common for all mice
i8042.c: Can't read CTR while initializing i8042.

One more thing, if anyone has the time, I'd be interested to hear what 
you think about the APIC configuration being detected.  Linux appears to 
think there are 3 APICs whilst lspci shows only 2:

00:00.0 Host bridge: Intel Corp. E7505 Memory Controller Hub (rev 03)
00:00.1 Class ff00: Intel Corp. E7000 Series RAS Controller (rev 03)
00:01.0 PCI bridge: Intel Corp. E7000 Series Processor to AGP Controller 
(rev 03)
00:02.0 PCI bridge: Intel Corp. E7000 Series Hub Interface B PCI-to-PCI 
Bridge (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller 
(rev 02)00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 
5200] (rev a1)
02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
03:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI (rev 07)
03:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI (rev 07)
05:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link)
05:03.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet 
Controller (rev 02)

Is this a problem?

Cheers,

Dan.

Boot output for -test9:

Linux version 2.6.0-test9 (root@rogue.dcrdev.demon.co.uk) (gcc version 
3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #22 SMP Tue Nov 18 12:19:11 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff7c000 (ACPI data)
 BIOS-e820: 000000007ff7c000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6940
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 524144
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294768 pages, LIFO batch:16
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6880
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7ff78d20
ACPI: FADT (v001 INTEL  PLACER   0x06040000 PTL  0x00000008) @ 0x7ff7bee4
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 
0x7ff7bf58ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 
0x7ff7bfd8
ACPI: DSDT (v001   TYAN    S2665 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: PLACER CRB   APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80100.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: ro root=/dev/sda2 elevator=deadline console=tty0 
console=ttyS0,9600n8 nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2666.022 MHz processor.
Console: colour VGA+ 80x25
Memory: 2071212k/2096576k available (1818k kernel code, 24224k reserved, 
654k data, 436k init, 1179072k highmem)
Calibrating delay loop... 5259.26 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 2.66GHz stepping 05
per-CPU timeslice cutoff: 1462.56 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/6 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5324.80 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Intel(R) Xeon(TM) CPU 2.66GHz stepping 05
Total of 2 processors activated (10584.06 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2665.0581 MHz.
..... host bus clock speed is 133.0279 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 8
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d5, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX [8086/24c0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 17
PCI->APIC IRQ transform: (B3,I3,P0) -> 24
PCI->APIC IRQ transform: (B3,I3,P1) -> 25
PCI->APIC IRQ transform: (B5,I2,P0) -> 17
PCI->APIC IRQ transform: (B5,I3,P0) -> 16
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting balanced_irq
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel E7505 Chipset.
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: AGP aperture is 128M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using deadline io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18a0-0x18a7, BIOS settings: hda:DMA, hdb:pio
hda: HL-DT-STDVD-ROM GDR8161B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
GDT: Storage RAID Controller Driver. Version: 2.08
GDT: Found 0 PCI Storage RAID Controllers
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Fusion MPT base driver 2.05.00.03
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
mptbase: 2 MPT adapters found, 2 installed.
Fusion MPT SCSI Host driver 2.05.00.03
scsi0 : ioc0: LSI53C1030, FwRev=01000000h, Ports=1, MaxQ=255, IRQ=24
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
scsi1 : ioc1: LSI53C1030, FwRev=01000000h, Ports=1, MaxQ=255, IRQ=25
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 1, lun 0,  type 0
mice: PS/2 mouse device common for all mice
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 436k freed
INIT: version 2.85 booting




Boot output for -test11:

Linux version 2.6.0-test11 (root@rogue.dcrdev.demon.co.uk) (gcc version 
3.3.2 20031022 (Red Hat Linux 3.3.2-1)) #1 SMP Sat Dec 6 13:08:11 GMT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009ec00 (usable)
 BIOS-e820: 000000000009ec00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 00000000000d8000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff70000 (usable)
 BIOS-e820: 000000007ff70000 - 000000007ff7c000 (ACPI data)
 BIOS-e820: 000000007ff7c000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6940
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 524144
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 294768 pages, LIFO batch:16
DMI present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6880
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x7ff78d20
ACPI: FADT (v001 INTEL  PLACER   0x06040000 PTL  0x00000008) @ 0x7ff7bee4
ACPI: MADT (v001 PTLTD           APIC   0x06040000  LTP 0x00000000) @ 
0x7ff7bf58ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 
0x7ff7bfd8
ACPI: DSDT (v001   TYAN    S2665 0x06040000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:   Product ID: PLACER CRB   APIC at: 0xFEE00000
I/O APIC #2 Version 32 at 0xFEC00000.
I/O APIC #3 Version 32 at 0xFEC80000.
I/O APIC #4 Version 32 at 0xFEC80100.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Processors: 2
Building zonelist for node : 0
Kernel command line: ro root=/dev/sda2 elevator=deadline console=tty0 
console=ttyS0,9600n8 nmi_watchdog=1
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2667.204 MHz processor.
Console: colour VGA+ 80x25
Memory: 2069172k/2096576k available (1821k kernel code, 26264k reserved, 
651k data, 436k init, 1179072k highmem)
Calibrating delay loop... 5259.26 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel(R) Xeon(TM) CPU 2.66GHz stepping 05
per-CPU timeslice cutoff: 1462.58 usecs.
task migration cache decay timeout: 2 msecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/6 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 5324.80 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 6
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU#1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU#1: Thermal monitoring enabled
CPU1: Intel(R) Xeon(TM) CPU 2.66GHz stepping 05
Total of 2 processors activated (10584.06 BogoMIPS).
WARNING: No sibling found for CPU 0.
WARNING: No sibling found for CPU 1.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
Setting 3 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 3 ... ok.
Setting 4 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 4 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
testing the IO APIC.......................
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 2665.0318 MHz.
..... host bus clock speed is 133.0265 MHz.
checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
CPUS done 8
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d5, last bus=5
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24c0] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 16
PCI->APIC IRQ transform: (B0,I29,P1) -> 19
PCI->APIC IRQ transform: (B0,I29,P2) -> 18
PCI->APIC IRQ transform: (B0,I29,P3) -> 23
PCI->APIC IRQ transform: (B0,I31,P0) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B0,I31,P1) -> 17
PCI->APIC IRQ transform: (B1,I0,P0) -> 17
PCI->APIC IRQ transform: (B3,I3,P0) -> 24
PCI->APIC IRQ transform: (B3,I3,P1) -> 25
PCI->APIC IRQ transform: (B5,I2,P0) -> 17
PCI->APIC IRQ transform: (B5,I3,P0) -> 16
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Starting balanced_irq
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.12
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel E7505 Chipset.
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: AGP aperture is 128M @ 0xe0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Using deadline io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
ICH4: chipset revision 2
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18a0-0x18a7, BIOS settings: hda:DMA, hdb:pio
hda: HL-DT-STDVD-ROM GDR8161B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide-floppy driver 0.99.newide
GDT: Storage RAID Controller Driver. Version: 2.08
GDT: Found 0 PCI Storage RAID Controllers
st: Version 20030811, fixed bufsize 32768, s/g segs 256
Fusion MPT base driver 2.05.00.03
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: Initiating ioc0 bringup
ioc0: 53C1030: Capabilities={Initiator}
mptbase: Initiating ioc1 bringup
ioc1: 53C1030: Capabilities={Initiator}
mptbase: 2 MPT adapters found, 2 installed.
Fusion MPT SCSI Host driver 2.05.00.03
scsi0 : ioc0: LSI53C1030, FwRev=01000000h, Ports=1, MaxQ=255, IRQ=24
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
scsi1 : ioc1: LSI53C1030, FwRev=01000000h, Ports=1, MaxQ=255, IRQ=25
  Vendor: SEAGATE   Model: ST336607LW        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 71132960 512-byte hdwr sectors (36420 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 1, lun 0,  type 0
mice: PS/2 mouse device common for all mice
i8042.c: Can't read CTR while initializing i8042.
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
EISA: Probing bus 0 at eisa0
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 436k freed
INIT: version 2.85 booting


