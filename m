Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUKVAWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUKVAWi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUKVAWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 19:22:38 -0500
Received: from tantale.fifi.org ([216.27.190.146]:49033 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261857AbUKVAVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 19:21:35 -0500
To: linux-smp@vger.kernel.org
Cc: linux@vger.kernel.org
Subject: Unexpected I/O APIC on i386 2.4.28 / Tyan Thunder K8W (S2885)
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 21 Nov 2004 16:19:41 -0800
Message-ID: <87actaohuq.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on the replies]

This is seen on a dual-242 set-up with 2 GB of RAM running a i386
kernel (not x86_64).
2.4.27 also showed the problem.

Enclosed is the dmesg log and the lspci -vvv output.

Configuration available upon request (if it makes a difference).

Phil.

Linux version 2.4.28 (root@ceramic) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Thu Nov 18 15:39:58 PST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000fa000 reserved twice.
hm, page 000fb000 reserved twice.
On node 0 totalpages: 524272
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 294896 pages.
ACPI: RSDP (v002 ACPIAM                                    ) @ 0x000f6a50
ACPI: XSDT (v001 A M I  OEMXSDT  0x09000423 MSFT 0x00000097) @ 0x7fff0100
ACPI: FADT (v001 A M I  OEMFACP  0x09000423 MSFT 0x00000097) @ 0x7fff0281
ACPI: MADT (v001 A M I  OEMAPIC  0x09000423 MSFT 0x00000097) @ 0x7fff0380
ACPI: OEMB (v001 A M I  OEMBIOS  0x09000423 MSFT 0x00000097) @ 0x7ffff040
ACPI: SRAT (v001 A M I  OEMSRAT  0x09000423 MSFT 0x00000097) @ 0x7fff3be0
ACPI: HPET (v001 A M I  OEMHPET  0x09000423 MSFT 0x00000097) @ 0x7fff3cd0
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x7fff3d10
ACPI: DSDT (v001  0AAAA 0AAAA001 0x00000001 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 Unknown CPU [15:5] APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 Unknown CPU [15:5] APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
ACPI: IOAPIC (id[0x03] address[0xff4fe000] global_irq_base[0x18])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xff4fe000, IRQ 24-27
ACPI: IOAPIC (id[0x04] address[0xff4ff000] global_irq_base[0x1c])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xff4ff000, IRQ 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Kernel command line: vga=0xfffe ramdisk=0 root=/dev/discs/disc0/part1 ro single
Initializing CPU#0
Detected 1594.002 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 3178.49 BogoMIPS
Memory: 2069536k/2097088k available (1329k kernel code, 27164k reserved, 572k data, 112k init, 1179584k highmem)
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
CPU0: AMD Opteron(tm) Processor 242 stepping 08
per-CPU timeslice cutoff: 2924.51 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 3000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 3185.04 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
CPU1: AMD Opteron(tm) Processor 242 stepping 08
Total of 2 processors activated (6363.54 BogoMIPS).
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 4-0, 4-1, 4-2, 4-3 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1593.9340 MHz.
..... host bus clock speed is 199.2417 MHz.
cpu: 0, clocks: 1992417, slice: 664139
CPU0<T0:1992416,T1:1328272,D:5,S:664139,C:1992417>
cpu: 1, clocks: 1992417, slice: 664139
CPU1<T0:1992416,T1:664128,D:10,S:664139,C:1992417>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
ACPI: Subsystem revision 20040326
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: System [ACPI] (supports S0 S1 S4 S5)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
ACPI: PCI Root Bridge [PCIB] (00:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.PCIB.PBP2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
PCI: Probing PCI hardware
00:00:07[A] -> 2-16 -> IRQ 16 level low
00:00:07[B] -> 2-17 -> IRQ 17 level low
00:00:07[C] -> 2-18 -> IRQ 18 level low
00:00:07[D] -> 2-19 -> IRQ 19 level low
00:02:03[A] -> 3-0 -> IRQ 24 level low
00:02:03[B] -> 3-1 -> IRQ 25 level low
00:02:03[C] -> 3-2 -> IRQ 26 level low
00:02:03[D] -> 3-3 -> IRQ 27 level low
00:01:01[A] -> 4-0 -> IRQ 28 level low
00:01:01[B] -> 4-1 -> IRQ 29 level low
00:01:01[C] -> 4-2 -> IRQ 30 level low
00:01:01[D] -> 4-3 -> IRQ 31 level low
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
number of IO-APIC #3 registers: 4.
number of IO-APIC #4 registers: 4.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 02000000
.......     : arbitration: 02
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  0    1    0   1   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  0    0    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00030011
.......     : max redirection entries: 0003
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    C9
 01 003 03  1    1    0   1   0    1    1    D1
 02 003 03  1    1    0   1   0    1    1    D9
 03 003 03  1    1    0   1   0    1    1    E1

IO APIC #4......
.... register #00: 04000000
.......    : physical APIC id: 04
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00030011
.......     : max redirection entries: 0003
An unexpected IO-APIC was found. If this kernel release is less than
three months old please report this to linux-smp@vger.kernel.org
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  1    1    0   1   0    1    1    E9
 01 003 03  1    1    0   1   0    1    1    32
 02 003 03  1    1    0   1   0    1    1    3A
 03 003 03  1    1    0   1   0    1    1    42
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ24 -> 1:0
IRQ25 -> 1:1
IRQ26 -> 1:2
IRQ27 -> 1:3
IRQ28 -> 2:0
IRQ29 -> 2:1
IRQ30 -> 2:2
IRQ31 -> 2:3
.................................... done.
PCI: Using ACPI for IRQ routing
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10f
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

blk: queue f7bbfc18, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
(scsi0:A:2): 80.000MB/s transfers (40.000MHz, offset 14, 16bit)
(scsi0:A:4): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
  Vendor: YAMAHA    Model: CRW-F1S           Rev: 1.0g
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7bbfa18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: PLEXTOR   Model: CD-ROM PX-40TW    Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7baf418, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: PIONEER   Model: DVD-RW  DVR-107D  Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue f7bae618, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST373453LW        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7baea18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue f7baf018, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:4:0: Tagged Queuing enabled.  Depth 32
Attached scsi disk sda at scsi0, channel 0, id 4, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 6, lun 0
SCSI device sda: 143374744 512-byte hdwr sectors (73408 MB)
Partition check:
 /dev/scsi/host0/bus0/target4/lun0: p1 p2
sdb: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:10, sector 0
 I/O error: dev 08:10, sector 0
 unable to read partition table
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 112k freed
EXT3 FS 2.4-0.9.19, 19 August 2002 on sd(8,1), internal journal
tg3.c:v3.14 (November 15, 2004)
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:2b:ba:da
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[0] 
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 44x/44x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi-1 drive
sr2: scsi3-mmc drive: 62x/62x writer cd/rw xa/form2 cdda tray
inserting floppy driver for 2.4.28
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Software Watchdog Timer: 0.05, timer margin: 60 sec
Creative EMU10K1 PCI Audio Driver, version 0.20, 15:47:58 Nov 18 2004
emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xa800-0xa81f, IRQ 16
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 1919M
agpgart: Detected AMD On-CPU GART chipset
agpgart: AGP aperture is 128M @ 0xf0000000
[drm] Initialized radeon 1.10.0 20020828 on minor 0: ATI Radeon RV280 9200
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-isa.o version 2.6.3 (20020322)
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.6.1 (20010830)
mtp008.o version 2.6.3 (20020322)
i2c-core.o: driver MTP008 sensor driver registered.
eeprom.o version 2.6.3 (20020322)
i2c-core.o: driver EEPROM READER registered.
udf: registering filesystem
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
LVM version 1.0.8(17/11/2003) module loaded
sdb: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.  
sdb: Write Protect is off
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:10, sector 0
 I/O error: dev 08:10, sector 0
 unable to read partition table
Device not ready.  Make sure there is a disc in the drive.
sdb: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.  
sdb: Write Protect is off
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:10, sector 0
 I/O error: dev 08:10, sector 0
 unable to read partition table
Device not ready.  Make sure there is a disc in the drive.
 I/O error: dev 08:10, sector 0
sdb: Unit Not Ready, sense:
Current 00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 08 
Current sd00:00: sense key Not Ready
Additional sense indicates Medium not present
sdb : block size assumed to be 512 bytes, disk size 1GB.  
sdb: Write Protect is off
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:10, sector 0
 I/O error: dev 08:10, sector 0
 unable to read partition table
Device not ready.  Make sure there is a disc in the drive.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,9), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 2097136k swap-space (priority 2)
Adding Swap: 2097136k swap-space (priority 1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xf8b91000, IRQ 19
usb-ohci.c: usb-03:00.0, Advanced Micro Devices [AMD] AMD-8111 USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 3 ports detected
usb-ohci.c: USB OHCI at membase 0xf8b93000, IRQ 19
usb-ohci.c: usb-03:00.1, Advanced Micro Devices [AMD] AMD-8111 USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 3 ports detected
usb-uhci.c: $Revision: 1.275 $ time 15:48:17 Nov 18 2004
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
uhci.c: USB Universal Host Controller Interface driver v1.1
mice: PS/2 mouse device common for all mice
hub.c: new USB device 03:00.1-1, assigned address 2
usb.c: USB device 2 (vend/prod 0x46d/0xc501) is not claimed by any active driver.
usb.c: registered new driver hiddev
usb.c: registered new driver hid
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:2.0
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers

----------------------------------------------------------------------

00:06.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7460 (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=128
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: ff300000-ff3fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [c0] #08 [0086]
	Capabilities: [f0] #08 [8000]

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7468 (rev 05)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7468
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7469 (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7469
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 4: I/O ports at ffa0 [disabled] [size=16]

00:07.2 SMBus: Advanced Micro Devices [AMD]: Unknown device 746a (rev 02)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 746a
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 19
	Region 0: I/O ports at b400 [size=32]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 746b (rev 05)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 746b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD]: Unknown device 746d (rev 03)
	Subsystem: Tyan Computer: Unknown device 2885
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at b800 [size=256]
	Region 1: I/O ports at bc00 [size=64]

00:0a.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7450 (rev 12) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ff200000-ff2fffff
	Prefetchable memory behind bridge: 00000000ce900000-00000000ce900000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] #07 [0083]
	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [004a]

00:0a.1 PIC: Advanced Micro Devices [AMD]: Unknown device 7451 (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at ff4fe000 (64-bit, non-prefetchable) [size=4K]

00:0b.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7450 (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=128
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: ff100000-ff1fffff
	Prefetchable memory behind bridge: 00000000ce800000-00000000ce800000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] #07 [0003]
	Capabilities: [b8] #08 [8000]

00:0b.1 PIC: Advanced Micro Devices [AMD]: Unknown device 7451 (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at ff4ff000 (64-bit, non-prefetchable) [size=4K]

00:18.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1100
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1101
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1102
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1103
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1100
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:19.1 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1101
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.2 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1102
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:19.3 Host bridge: Advanced Micro Devices [AMD]: Unknown device 1103
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:06.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device e2a0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (10000ns min, 6250ns max), cache line size 10
	Interrupt: pin A routed to IRQ 29
	BIST result: 00
	Region 0: I/O ports at 9800 [disabled] [size=256]
	Region 1: Memory at ff1ff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at ff1c0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: BROADCOM Corporation: Unknown device 16a7 (rev 02)
	Subsystem: Tyan Computer: Unknown device 2885
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at ff2f0000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at ff2e0000 [disabled] [size=64K]
	Capabilities: [40] #07 [0008]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: a064504002a02608  Data: 0080

03:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7464 (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7464
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at ff3f5000 (32-bit, non-prefetchable) [size=4K]

03:00.1 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7464 (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7464
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at ff3f6000 (32-bit, non-prefetchable) [size=4K]

03:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at a800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Region 0: I/O ports at ac00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:0c.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8023 (prog-if 10 [OHCI])
	Subsystem: Tyan Computer: Unknown device 2885
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (500ns min, 1000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at ff3ff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at ff3f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 7454 (rev 13)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7454
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=31 SBA+ 64bit+ FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit+ FW- Rate=x2
	Capabilities: [c0] #08 [0060]

04:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7455 (rev 13) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=128
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff500000-ff5fffff
	Prefetchable memory behind bridge: ceb00000-eeafffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

05:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5961 (rev 01) (prog-if 00 [VGA])
	Subsystem: VISIONTEK: Unknown device 7c13
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c800 [size=256]
	Region 2: Memory at ff5f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ff5c0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=255 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:00.1 Display controller: ATI Technologies Inc: Unknown device 5941 (rev 01)
	Subsystem: VISIONTEK: Unknown device 7c12
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (2000ns min), cache line size 10
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at ff5e0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

