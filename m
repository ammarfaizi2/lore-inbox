Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272994AbTHFAsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273002AbTHFAse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:48:34 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:1231 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S272994AbTHFAsU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:48:20 -0400
Message-ID: <3F304EF6.5090908@rackable.com>
Date: Tue, 05 Aug 2003 17:42:30 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More 2.4.22pre10 ACPI breakage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Aug 2003 00:48:18.0742 (UTC) FILETIME=[6D97ED60:01C35BB4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  It appears that the intel Se7501BR mother is also having issues with 
ACPI.  When ACPI support is enable the e1000 controller stops working 
printing "<6>NETDEV WATCHDOG: eth0: transmit timed out".  Full kernel 
output is inline:

inux version 2.4.22-pre10 (root@grendel) (gcc version 3.2.2 20030222 
(Red Hat Linux 3.2.2-5)
) #2 SMP Fri Aug 1 07:39:59 PDT 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099c00 (usable)
 BIOS-e820: 0000000000099c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
ACPI: RSDP (v000 INTEL                      ) @ 0x000ffdc0
ACPI: RSDT (v001 INTEL  SBR20    00000.00001) @ 0x7fff0000
ACPI: FADT (v001 INTEL  SBR20    00000.00001) @ 0x7fff0030
ACPI: MADT (v001 INTEL  SBR20    00000.00001) @ 0x7fff00b0
ACPI: OEMR (v001 INTEL  SBR20    00000.00001) @ 0x7fff0140
ACPI: DSDT (v001  INTEL    SBR20 00000.00256) @ 0x00000000
ACPI: BIOS passes blacklist
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 Pentium 4(tm) XEON(tm) APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x3] lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x3] lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 8
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, IRQ 0-23
ACPI: IOAPIC (id[0x09] address[0xfec81000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 9
IOAPIC[1]: apic_id 9, version 32, address 0xfec81000, IRQ 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec81400] global_irq_base[0x30])
IOAPIC[2]: Assigned apic_id 10
IOAPIC[2]: apic_id 10, version 32, address 0xfec81400, IRQ 48-71
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] 
trigger[0x0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x1] 
trigger[0x3])
Using ACPI (MADT) for SMP configuration information
Kernel command line: root=/dev/nfs ip=::::::dhcp 
nfsroot=10.10.1.3:/vol0/nfs/root/current co
nsole=tty0 console=ttyS0,9600 BOOT_IMAGE=/vmlinuz-2.4.22-pre10
Initializing CPU#0
Detected 3056.885 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 6094.84 BogoMIPS
Memory: 2066420k/2097088k available (3314k kernel code, 30256k reserved, 
1171k data, 380k in
it, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#0.
CPU0: Intel(R) Xeon(TM) CPU 3.06GHz stepping 07
per-CPU timeslice cutoff: 1463.16 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 6107.95 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Xeon(TM) CPU 3.06GHz stepping 07
Booting processor 2/6 eip 3000
Initializing CPU#2
masked ExtINT on CPU#2
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 6107.95 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#2.
CPU2: Intel(R) Xeon(TM) CPU 3.06GHz stepping 07
Booting processor 3/7 eip 3000
Initializing CPU#3
masked ExtINT on CPU#3
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 6107.95 BogoMIPS
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 3
Intel machine check reporting enabled on CPU#3.
CPU3: Intel(R) Xeon(TM) CPU 3.06GHz stepping 07
Total of 4 processors activated (24418.71 BogoMIPS).
cpu_sibling_map[0] = 1
cpu_sibling_map[1] = 0
cpu_sibling_map[2] = 3
cpu_sibling_map[3] = 2
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................



.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 3056.9088 MHz.
..... host bus clock speed is 132.9089 MHz.
cpu: 0, clocks: 1329089, slice: 265817
CPU0<T0:1329088,T1:1063264,D:7,S:265817,C:1329089>
cpu: 1, clocks: 1329089, slice: 265817
cpu: 3, clocks: 1329089, slice: 265817
cpu: 2, clocks: 1329089, slice: 265817
CPU3<T0:1329088,T1:265648,D:172,S:265817,C:1329089>
CPU2<T0:1329088,T1:531632,D:5,S:265817,C:1329089>
CPU1<T0:1329088,T1:797440,D:14,S:265817,C:1329089>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0xe)
All processors have done init_idle
ACPI: Subsystem revision 20030619
PCI: PCI BIOS revision 2.10 entry at 0xfdb65, last bus=4
PCI: Using configuration type 1
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
 dswload-0552: *** Warning: Type override - [DEB_] had invalid type 
(Integer) for Scope oper
ator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [MLIB] had invalid type 
(Integer) for Scope oper
ator, changed to (Scope)
 dswload-0552: *** Warning: Type override - [DATA] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [SIO_] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [LEDP] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [GPEN] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [GPST] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [GP1N] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [WUES] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [WUSE] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [SBID] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [SWCE] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
 dswload-0552: *** Warning: Type override - [CMS2] had invalid type 
(String) for Scope opera
tor, changed to (Scope)
Parsing all Control 
Methods:................................................................
..............................................................
Table [DSDT](id F004) - 416 Objects with 34 Devices 126 Methods 27 Regions
ACPI Namespace successfully loaded at root c0613fdc
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode 
successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 
0000000000000428 on
 int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 47 [_GPE] 4 regs at 
0000000000000548 on
 int 9
 int 9
evregion-0249 [22] ev_address_space_dispa: no handler for 
region(c287f408) [SystemIO]
 exfldio-0269 [21] ex_access_region      : Region SystemIO(1) has no handler
 dswexec-0422 [14] ds_exec_end_op        : [LLess]: Could not resolve 
operands, AE_NOT_EXIST
 psparse-1121: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_._REG] (Node c287aa68
), AE_NOT_EXIST
ACPI: Unable to initialize ACPI objects
evxfevnt-0139 [06] acpi_disable          : ACPI mode disabled
 utalloc-0986 [05] ut_dump_allocations   : No outstanding allocations.
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
PCI: Unable to handle 64-bit address space for
PCI: Unable to handle 64-bit address space for
Transparent bridge - Intel Corp. 82801BA/CA/DB/EB PCI Bridge
PCI: Using IRQ router PIIX [8086/2480] at 00:1f.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 3!
PCI BIOS passed nonexistent PCI bus 2!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 1!
PCI BIOS passed nonexistent PCI bus 0!
PCI: Device 00:ea not found by BIOS
PCI: Device 00:fb not found by BIOS
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
  utmisc-0745 [02] ut_acquire_mutex      : Thread 1 could not acquire 
Mutex [ACPI_MTX_Memory
] AE_BAD_PARAMETER
Detected PS/2 Mouse Port.
pty: 2048 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT 
SHARE_IRQ SERIAL_PCI enab
led
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
FDC 0 is a National Semiconductor PC87306
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 5.1.13-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg>
 and others
eth1: OEM i82557/i82558 10/100 Ethernet, 00:03:47:30:BE:54, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0xb874c1d3).
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH3: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH3: chipset revision 2
ICH3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x03a0-0x03a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x03a8-0x03af, BIOS settings: hdc:DMA, hdd:pio
hda: ST380021A, ATA DISK drive
blk: queue c06420a0, I/O limit 4095Mb (mask 0xffffffff)
hdc: ST380021A, ATA DISK drive
blk: queue c0642510, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63, 
UDMA(100)
hdc: attached ide-disk driver.
hdc: host protected area => 1
hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, 
UDMA(100)
Partition check:
 hda: hda1 hda2 hda3
 hdc: hdc1 hdc2 hdc3
SCSI subsystem driver Revision: 1.00
Loading Adaptec I2O RAID: Version 2.4 Build 5
Detecting Adaptec I2O RAID controllers...
Red Hat/Adaptec aacraid driver (1.1.2 Aug  1 2003 07:40:57)
scsi0 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.10
        <Adaptec AIC7901A Ultra320 SCSI adapter>
        aic7901A: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 
512 SCBs

blk: queue f7b40e18, I/O limit 4095Mb (mask 0xffffffff)
megaraid: v1.18f (Release Date: Tue Dec 10 09:54:39 EST 2002)
megaraid: no BIOS enabled.
3ware Storage Controller device driver for Linux v1.02.00.036.
3w-xxxx: No cards found.
Fusion MPT base driver 2.05.05+
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: 0 MPT adapters found, 0 installed.
Fusion MPT SCSI Host driver 2.05.05+
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 07:41:56 Aug  1 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0x3040, IRQ 11
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0x3020, IRQ 5
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0x3000, IRQ 10
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Keyspan - (without firmware)
usbserial.c: USB Serial support registered for Keyspan 1 port adapter
usbserial.c: USB Serial support registered for Keyspan 2 port adapter
usbserial.c: USB Serial support registered for Keyspan 4 port adapter
keyspan.c: v1.1.4:Keyspan USB to Serial Converter Driver
usbserial.c: USB Serial support registered for PL-2303
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  3566.000 MB/sec
   32regs    :  2220.400 MB/sec
   pIII_sse  :  4018.400 MB/sec
   pII_mmx   :  3608.400 MB/sec
   p5_mmx    :  3541.600 MB/sec
raid5: using function: pIII_sse (4018.400 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.5+(22/07/2002)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
Sending DHCP requests ...<6>NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
.<6>NETDEV WATCHDOG: eth0: transmit timed out

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


