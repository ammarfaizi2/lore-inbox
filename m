Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129343AbRBAATC>; Wed, 31 Jan 2001 19:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129614AbRBAASn>; Wed, 31 Jan 2001 19:18:43 -0500
Received: from shell.chaven.com ([207.238.162.18]:31911 "EHLO shell.chaven.com")
	by vger.kernel.org with ESMTP id <S129343AbRBAASk>;
	Wed, 31 Jan 2001 19:18:40 -0500
Message-ID: <02c301c08be4$51a8b870$160912ac@stcostlnds2zxj>
From: "List User" <lists@chaven.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0101311823580.7800-100000@cr753963-a.glph1.on.wave.home.com>
Subject: Kernel (v2.4.1) APIC Error on Tyan S2505 MB?
Date: Wed, 31 Jan 2001 18:17:05 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running kernel v2.4.1 (gcc2.95.2/glibc-2.1.3) and have been getting
the following errors sent to the console.  I saw reference to this to a BP6
MB
but nothing about the Tyan S2505 (Tiger 200) MB.  I've tried two different
MB's so far and both exhibit the same problem?

APIC error on CPU0: 00(01)
APIC error on CPU0: 01(01)
APIC error on CPU0: 01(01)
APIC error on CPU0: 01(02)
APIC error on CPU0: 02(01)

I've attached my dmesg output as well as what I've got compiled into the
kernel.
I run the kernel monolithic, bios is set for MP v1.1 spec (I've also tried
v1.4).

-----> dmesg <-----------
news:/usr/src/linux/Documentation# dmesg
00000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000002fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000002fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000002fff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5c90
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 196592
zone(0): 4096 pages.
zone(1): 192496 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
    Bootup CPU
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is PCI
Bus #3 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 3, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 3, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 3, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 3, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 3, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 3, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 3, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 3, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 3, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 3, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 3, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 3, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 3, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 3, trig 3, bus 3, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 3, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 3, trig 3, bus 3, IRQ 0a, APIC ID 2, APIC INT 0a
Lint: type 3, pol 0, trig 0, bus 3, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 3, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 1
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=801 ramdisk=0 devfs=mount
Initializing CPU#0
Detected 933.044 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 1861.22 BogoMIPS
Memory: 770772k/786368k available (1154k kernel code, 15208k reserved, 410k
data, 216k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 731.32 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
CPU present map: 1
Before bogomips.
Error: only one processor found.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23
not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  1    1    0   1   0    1    1    79
 0b 001 01  1    1    0   1   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  1    1    0   1   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 932.9929 MHz.
..... host bus clock speed is 133.2846 MHz.
cpu: 0, clocks: 1332846, slice: 666423
CPU0<T0:1332832,T1:666400,D:9,S:666423,C:1332846>
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb390, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.2 present.
44 structures occupying 1200 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.00 PG
BIOS Release: 11/15/2000
System Vendor: VIA Technologies, Inc..
Product Name: VT82C694X.
Version  .
Serial Number  .
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 511829kB/380757kB, 1536 slots per queue
loop: enabling 8 loop devices
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
DAC960: ***** DAC960 RAID Driver Version 2.4.9 of 7 September 2000 *****
DAC960: Copyright 1998-2000 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: Configuring Mylex AcceleRAID 170 PCI RAID Controller
DAC960#0:   Firmware Version: 6.00-03, Channels: 1, Memory Size: 64MB
DAC960#0:   PCI Bus: 0, Device: 15, Function: 1, I/O Address: Unassigned
DAC960#0:   PCI Address: 0xD4200000 mapped at 0xF0800000, IRQ Channel: 11
DAC960#0:   Controller Queue Depth: 512, Maximum Blocks per Command: 2048
DAC960#0:   Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257
Segments
DAC960#0:   Physical Devices:
DAC960#0:     0:1  Vendor: SEAGATE   Model: ST318404LSUN18G   Revision: 4207
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number: 3BT10DPR000021087MPE
DAC960#0:          Disk Status: Online, 35155968 blocks
DAC960#0:     0:2  Vendor: SEAGATE   Model: ST318404LSUN18G   Revision: 4207
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number: 3BT10QYA000021087C92
DAC960#0:          Disk Status: Online, 35155968 blocks
DAC960#0:     0:3  Vendor: SEAGATE   Model: ST318203LW        Revision: 0001

DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number: LR06138700001941212E
DAC960#0:          Disk Status: Online, 35155968 blocks
DAC960#0:     0:4  Vendor: SEAGATE   Model: ST318203LW        Revision: 0001
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number: LR08692400001945HKWJ
DAC960#0:          Disk Status: Online, 35155968 blocks
DAC960#0:     0:5  Vendor: SEAGATE   Model: ST318203LW        Revision: 0001
DAC960#0:          Wide Synchronous at 40 MB/sec
DAC960#0:          Serial Number: LR0573480000194120XE
DAC960#0:          Disk Status: Online, 35155968 blocks
DAC960#0:     0:7  Vendor: MYLEX     Model: AcceleRAID 170    Revision: 0600
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:
DAC960#0:   Logical Drives:
DAC960#0:     /dev/rd/c0d0: RAID-1, Online, 35143680 blocks
DAC960#0:                   Logical Device Initialized, BIOS Geometry:
255/63
DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
DAC960#0:                   Read Cache Disabled, Write Cache Enabled
DAC960#0:     /dev/rd/c0d1: RAID-5, Online, 70287360 blocks
DAC960#0:                   Logical Device Initialized, BIOS Geometry:
255/63
DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
DAC960#0:                   Read Cache Disabled, Write Cache Enabled
Partition check:
 rd/c0d0: p1 p2
 rd/c0d1: p1
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:E0:81:01:F2:CD, IRQ 11.
  Board assembly 123456-120, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eth1: OEM i82557/i82558 10/100 Ethernet, 00:E0:81:01:F2:CE, IRQ 10.
  Board assembly 123456-120, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
scsi: ***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.06J, I/O Address: 0xE800, IRQ Channel: 15/Level
scsi0:   PCI Bus: 0, Device: 18, Address: 0xD4205000, Host Adapter SCSI ID:
7
scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
scsi0:   Synchronous Negotiation: Ultra, Wide Negotiation: Enabled
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
scsi0:   Driver Queue Depth: 211, Host Adapter Queue Depth: 192
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
scsi0:   SCSI Bus Termination: Both Disabled, SCAM: Disabled
scsi0: *** BusLogic BT-958 Initialized Successfully ***
scsi0 : BusLogic BT-958
  Vendor: SEAGATE   Model: ST336704LSUN36G   Rev: 032C
  Type:   Direct-Access                      ANSI SCSI revision: 03
DAC960#0: Physical Device 0:1 Found
DAC960#0: Physical Device 0:2 Found
DAC960#0: Physical Device 0:3 Found
DAC960#0: Physical Device 0:4 Found
DAC960#0: Physical Device 0:5 Found
DAC960#0: Physical Device 0:1 Online
DAC960#0: Physical Device 0:2 Online
DAC960#0: Physical Device 0:3 Online
DAC960#0: Physical Device 0:4 Online
DAC960#0: Physical Device 0:5 Online
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Found
DAC960#0: Logical Drive 0 (/dev/rd/c0d0) Online
DAC960#0: Logical Drive 1 (/dev/rd/c0d1) Found
DAC960#0: Logical Drive 1 (/dev/rd/c0d1) Online
scsi0: Target 0: Queue Depth 28, Wide Synchronous at 40.0 MB/sec, offset 15
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1
raid0 personality registered
raid1 personality registered
raid5 personality registered
raid5: measuring checksumming speed
   8regs     :  1546.400 MB/sec
   32regs    :  1144.800 MB/sec
   pIII_sse  :  1911.600 MB/sec
   pII_mmx   :  2092.800 MB/sec
   p5_mmx    :  2205.200 MB/sec
raid5: using function: pIII_sse (1911.600 MB/sec)
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
scsi0: Tagged Queuing now active for Target 0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 216k freed
portmap: server localhost not responding, timed out
portmap: server localhost not responding, timed out
lockd_up: makesock failed, error=-5
portmap: server localhost not responding, timed out
devfs: devfs_register(): device already registered: "group"
Adding Swap: 1048568k swap-space (priority -1)
APIC error on CPU0: 00(01)
APIC error on CPU0: 01(01)
APIC error on CPU0: 01(01)
APIC error on CPU0: 01(02)
APIC error on CPU0: 02(01)
------------------> dmesg <---------------------

------------------> .config <--------------------
news:/usr/src/linux# cat t
CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_DAC960=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
CONFIG_BLK_DEV_LVM=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=y
CONFIG_BLK_DEV_SR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_BUSLOGIC=y
CONFIG_SCSI_OMIT_FLASHPOINT=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_DE4X5=y
CONFIG_EEPRO100=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_QUOTA=y
CONFIG_ISO9660_FS=y
CONFIG_MINIX_FS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_MSDOS_PARTITION=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
------------------------> .config <--------------------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
