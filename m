Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135650AbRARNZr>; Thu, 18 Jan 2001 08:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135554AbRARNZh>; Thu, 18 Jan 2001 08:25:37 -0500
Received: from hogthrob.ic.uva.nl ([145.18.240.233]:54793 "EHLO
	hogthrob.ic.uva.nl") by vger.kernel.org with ESMTP
	id <S135650AbRARNZZ>; Thu, 18 Jan 2001 08:25:25 -0500
From: "J.W. Hoogervorst" <jeroenho@ic.uva.nl>
To: <linux-kernel@vger.kernel.org>
Subject: IRQ routing problem - SMP related?
Date: Thu, 18 Jan 2001 14:25:22 +0100
Message-ID: <000c01c08152$1bcdfe00$bbf01291@JHOPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, all!

I am having some problems with de delivery of the USB irq.
Without the kernel-option "noapic", it seems, they just never make it to the
kernel.
I tried running with mps=1.1, mps=1.4, PNP OS=y/n, but that doesn't help...

I am also running windoze 2000 on this machine, and that sets up the USB irq
to 9...

Can anyone shed some light on this problem?
I'd be happy to try patches or give more info.

The following are the startup log, and /proc/interrupts for both apic and
noapic modes.
The board is an Rioworks SDVIA
(http://www.rioworks.com/product/VIA/sdvia.htm)
with a VIA VT82C694X / VT82C596B chipset.

Thanks in advance,
Jeroen Hoogervorst

----------8<---------8<---------8<---------8<---------8<---------8<---------
8<---------
Linux version 2.4.0.ac9.jwh1-PIII-SMP (root@animal.muppets.hnet.nl) (gcc
version 2.95.3 19991030 (prerelease)) #1 SMP Mon Jan 15 21:03:54 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5c30
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
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
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    SEP present.
    MTRR  present.
    PGE  present.
    MCA  present.
    CMOV  present.
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 1f, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 24, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 0, IRQ 30, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 34, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 0, IRQ 34, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 0, IRQ 38, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 40, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 44, APIC ID 2, APIC INT 10
Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Int: type 2, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: mem=262080K  root=/dev/sda5 apm=off
Initializing CPU#0
Detected 736.016 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1468.00 BogoMIPS
Memory: 254988k/262080k available (1244k kernel code, 6704k reserved, 481k
data, 264k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
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
per-CPU timeslice cutoff: 730.66 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1471.28 BogoMIPS
Stack at about c1449fbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (2939.28 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not
connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......: physical APIC id: 02
.... register #01: 00170011
.......: max redirection entries: 0017
.......: IO APIC version: 0011
.... register #02: 00000000
.......: arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 000 00  1    0    0   0   0    0    0    00
 06 003 03  0    0    0   0   0    1    1    51
 07 003 03  0    0    0   0   0    1    1    59
 08 003 03  0    0    0   0   0    1    1    61
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    69
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    71
 0f 003 03  0    0    0   0   0    1    1    79
 10 003 03  1    1    0   1   0    1    1    81
 11 003 03  1    1    0   1   0    1    1    89
 12 003 03  1    1    0   1   0    1    1    91
 13 003 03  1    1    0   1   0    1    1    99
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 735.9936 MHz.
..... host bus clock speed is 133.8169 MHz.
cpu: 0, clocks: 1338169, slice: 446056
CPU0<T0:1338160,T1:892096,D:8,S:446056,C:1338169>
cpu: 1, clocks: 1338169, slice: 446056
CPU1<T0:1338160,T1:446048,D:0,S:446056,C:1338169>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: BIOS32 Service Directory structure at 0xc00fae30
PCI: BIOS32 Service Directory entry at 0xfb2a0
PCI: BIOS probe returned s=00 hw=11 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfb2d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
Unknown bridge resource 0: assuming transparent
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdba0
00:0d slot=01 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:0e slot=02 0:02/deb8 1:03/deb8 2:05/deb8 3:01/deb8
00:0f slot=03 0:03/deb8 1:05/deb8 2:01/deb8 3:02/deb8
00:11 slot=04 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:09 slot=05 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:08 slot=06 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:10 slot=07 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:0c slot=08 0:05/deb8 1:01/deb8 2:02/deb8 3:03/deb8
00:01 slot=00 0:01/deb8 1:02/deb8 2:03/deb8 3:05/deb8
00:07 slot=00 0:00/deb8 1:00/deb8 2:03/deb8 3:05/deb8
PCI: Using IRQ router VIA [1106/0596] at 00:07.0
PCI: IRQ fixup
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 16
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I13,P0) -> 16
PCI->APIC IRQ transform: (B0,I13,P0) -> 16
PCI->APIC IRQ transform: (B0,I14,P0) -> 17
PCI->APIC IRQ transform: (B0,I15,P0) -> 18
PCI->APIC IRQ transform: (B0,I16,P0) -> 19
PCI->APIC IRQ transform: (B0,I17,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Allocating resources
PCI: Resource d0000000-d7ffffff (f=1208, d=0, p=0)
PCI: Resource 0000c000-0000c00f (f=101, d=0, p=0)
PCI: Resource 0000c400-0000c41f (f=101, d=0, p=0)
PCI: Resource 0000c800-0000c807 (f=101, d=0, p=0)
PCI: Resource 0000cc00-0000cc03 (f=101, d=0, p=0)
PCI: Resource 0000d000-0000d007 (f=101, d=0, p=0)
PCI: Resource 0000d400-0000d403 (f=101, d=0, p=0)
PCI: Resource 0000d800-0000d80f (f=101, d=0, p=0)
PCI: Resource 0000dc00-0000dcff (f=101, d=0, p=0)
PCI: Resource e7203000-e72030ff (f=200, d=0, p=0)
PCI: Resource e7205000-e7205fff (f=200, d=0, p=0)
PCI: Resource 0000e000-0000e0ff (f=101, d=0, p=0)
PCI: Resource e7200000-e72000ff (f=200, d=0, p=0)
PCI: Resource e7201000-e7201fff (f=200, d=0, p=0)
PCI: Resource e7202000-e7202fff (f=1208, d=0, p=0)
PCI: Resource e7000000-e70fffff (f=200, d=0, p=0)
PCI: Resource e7204000-e7204fff (f=200, d=0, p=0)
PCI: Resource 0000e400-0000e43f (f=101, d=0, p=0)
PCI: Resource e7100000-e71fffff (f=200, d=0, p=0)
PCI: Resource 0000e800-0000e81f (f=101, d=0, p=0)
PCI: Resource 0000ec00-0000ec07 (f=101, d=0, p=0)
PCI: Resource e4000000-e4ffffff (f=200, d=0, p=0)
PCI: Resource d8000000-dfffffff (f=1208, d=0, p=0)
PCI: Resource e0000000-e3ffffff (f=200, d=1, p=1)
PCI: Sorting device list...
Activating ISA DMA hang workarounds.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.3 present.
31 structures occupying 940 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Modular BIOS
BIOS Version: 6.00 PG
BIOS Release: 11/22/2000
System Vendor: Arima Computer Corp.                    Bios by Award
Software, Inc.
Product Name: SDVIA Series.
Version  .
Serial Number  .
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
apm: disabled on user request.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169341kB/38269kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596b IDE UDMA66 controller on pci0:7.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
CMD649: IDE controller on PCI bus 00 dev 60
CMD649: chipset revision 1
CMD649: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xd800-0xd807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd808-0xd80f, BIOS settings: hdg:pio, hdh:pio
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Real Time Clock Driver v1.10d
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 13, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c876 detected with Symbios NVRAM
sym53c8xx: at PCI bus 0, device 13, function 1
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c876 detected with Symbios NVRAM
sym53c876-0: rev 0x14 on pci bus 0 device 13 function 1 irq 16
sym53c876-0: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c876-0: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/4e/80/01/00/24
sym53c876-0: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/46/80/00/08/24
sym53c876-0: on-chip RAM at 0xe7201000
sym53c876-0: resetting, command processing suspended for 2 seconds
sym53c876-0: restart (scsi reset).
sym53c876-0: enabling clock multiplier
sym53c876-0: Downloading SCSI SCRIPTS.
sym53c876-1: rev 0x14 on pci bus 0 device 13 function 0 irq 16
sym53c876-1: Symbios format NVRAM, ID 7, Fast-20, Parity Checking
sym53c876-1: initial SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/4e/80/01/00/24
sym53c876-1: final   SCNTL3/DMODE/DCNTL/CTEST3/4/5 = (hex) 05/46/80/00/08/24
sym53c876-1: on-chip RAM at 0xe7205000
sym53c876-1: resetting, command processing suspended for 2 seconds
sym53c876-1: restart (scsi reset).
sym53c876-1: enabling clock multiplier
sym53c876-1: Downloading SCSI SCRIPTS.
scsi0: sym53c8xx - version 1.6b
scsi1: sym53c8xx - version 1.6b
sym53c876-0: command processing resumed
  Vendor: IBM       Model: DDYS-T18350N      Rev: S93E
  Type:   Direct-Access                      ANSI SCSI revision: 03
sym53c876-1: command processing resumed
  Vendor: TOSHIBA   Model: DVD-ROM SD-M1201  Rev: 1R08
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
sym53c876-0-<0,0>: tagged command queue depth set to 8
  Vendor: IBM       Model: DPES-31080        Rev: S31K
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: MK537FB           Rev: 6261
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: ARCHIVE   Model: Python 04106-XXX  Rev: 7230
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: FUJITSU   Model: M2513A            Rev: 1700
  Type:   Optical Device                     ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.02
  Type:   Direct-Access                      ANSI SCSI revision: 02
sym53c876-1-<0,0>: tagged command queue depth set to 8
ncr53c8xx: at PCI bus 0, device 13, function 0
ncr53c8xx: IO region 0xdc00[0..127] is in use
ncr53c8xx: at PCI bus 0, device 13, function 1
ncr53c8xx: IO region 0xe000[0..127] is in use
DC395x (TRM-S1040) SCSI driver 1.32, 2000-12-02
DC395x (TRM-S1040): 0 adapters found
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 0, lun 0
Detected scsi disk sdc at scsi1, channel 0, id 1, lun 0
Detected scsi removable disk sdd at scsi1, channel 0, id 3, lun 0
Detected scsi removable disk sde at scsi1, channel 0, id 5, lun 0
sym53c876-0-<0,0>: wide msgout: 1-2-3-1.
sym53c876-0-<0,0>: wide msgin: 1-2-3-1.
sym53c876-0-<0,0>: wide: wide=1 chg=0.
sym53c876-0-<0,*>: WIDE SCSI (16 bit) enabled.
sym53c876-0-<0,0>: wide msgout: 1-2-3-1.
sym53c876-0-<0,0>: wide msgin: 1-2-3-1.
sym53c876-0-<0,0>: wide: wide=1 chg=0.
sym53c876-0-<0,0>: sync msgout: 1-3-1-c-10.
sym53c876-0-<0,0>: sync msg in: 1-3-1-c-10.
sym53c876-0-<0,0>: sync: per=12 scntl3=0x90 scntl4=0x0 ofs=16 fak=0 chg=0.
sym53c876-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 >
sym53c876-1-<0,0>: sync msgout: 1-3-1-c-10.
sym53c876-1-<0,0>: sync msg in: 1-3-1-19-f.
sym53c876-1-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
sym53c876-1-<0,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 15)
sym53c876-1-<0,0>: sync msgout: 1-3-1-c-10.
sym53c876-1-<0,0>: sync msg in: 1-3-1-19-f.
sym53c876-1-<0,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=15 fak=0 chg=0.
SCSI device sdb: 2118144 512-byte hdwr sectors (1084 MB)
 /dev/scsi/host1/bus0/target0/lun0: p1
sym53c876-1-<1,0>: sync msgout: 1-3-1-c-10.
sym53c876-1-<1,0>: sync msg in: 1-3-1-19-10.
sym53c876-1-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=16 fak=0 chg=0.
sym53c876-1-<1,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 16)
sym53c876-1-<1,0>: sync msgout: 1-3-1-c-10.
sym53c876-1-<1,0>: sync msg in: 1-3-1-19-10.
sym53c876-1-<1,0>: sync: per=25 scntl3=0x30 scntl4=0x0 ofs=16 fak=0 chg=0.
SCSI device sdc: 2076758 512-byte hdwr sectors (1063 MB)
 /dev/scsi/host1/bus0/target1/lun0: p1
sym53c876-1-<3,0>: sync msgout: 1-3-1-c-10.
sym53c876-1-<3,0>: sync msg in: 1-3-1-32-a.
sym53c876-1-<3,0>: sync: per=50 scntl3=0x50 scntl4=0x0 ofs=10 fak=0 chg=0.
sym53c876-1-<3,*>: FAST-5 SCSI 5.0 MB/s (200 ns, offset 10)
sym53c876-1-<3,0>: sync msgout: 1-3-1-c-10.
sym53c876-1-<3,0>: sync msg in: 1-3-1-32-a.
sym53c876-1-<3,0>: sync: per=50 scntl3=0x50 scntl4=0x0 ofs=10 fak=0 chg=0.
SCSI device sdd: 310352 2048-byte hdwr sectors (636 MB)
sdd: Write Protect is off
 /dev/scsi/host1/bus0/target3/lun0: unknown partition table
sym53c876-1-<5,*>: target did not report SYNC.
sym53c876-1-<5,*>: target did not report SYNC.
SCSI device sde: 196608 512-byte hdwr sectors (101 MB)
sde: Write Protect is off
 /dev/scsi/host1/bus0/target5/lun0: p4
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 21:05:56 Jan 15 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 19
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: System description tables found
ACPI: System description tables loaded
ACPI: Subsystem enabled
ACPI: System firmware supports: S0 S1 S5
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 264k freed
hub.c: USB new device connect on bus1/1, assigned device number 2
Adding Swap: 249832k swap-space (priority -1)
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error=-110)
hub.c: USB new device connect on bus1/1, assigned device number 3
Linux video capture interface: v1.00
i2c-core.o: i2c core module
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.50 loaded
bttv: using 2 buffers with 2080k (4160k total) for capture
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 00:0e.0, irq: 17, latency: 32, memory: 0xe7202000
bttv0: model: BT848A( *** UNKNOWN *** ) [autodetected]
i2c-core.o: adapter bt848 #0 registered as adapter 0.
bttv0: i2c: checking for MSP34xx @ 0x80... found
i2c-core.o: driver i2c msp3400 driver registered.
msp34xx: init: chip=MSP3400C-C6
msp3400: daemon started
bttv0: i2c attach [MSP3400C-C6]
i2c-core.o: client [MSP3400C-C6] registered to adapter [bt848 #0](pos. 0).
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
i2c-core.o: driver i2c TV tuner driver registered.
tuner: chip found @ 0x61
bttv0: i2c attach [(unset)]
i2c-core.o: client [(unset)] registered to adapter [bt848 #0](pos. 1).
NTFS version 000607
Warning! NTFS volume version is Win2k+: Mounting read-only
Detected scsi tape st0 at scsi1, channel 0, id 2, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error=-110)
hub.c: USB new device connect on bus1/2, assigned device number 4
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=4 (error=-110)
hub.c: USB new device connect on bus1/2, assigned device number 5
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=5 (error=-110)
Creative EMU10K1 PCI Audio Driver, version 0.12, 21:09:57 Jan 15 2001
emu10k1: EMU10K1 rev 7 model 0x8061 found, IO at 0xe800-0xe81f, IRQ 16
ac97_codec: AC97 Audio codec, id: 0x8384:0x7608 (SigmaTel STAC9708)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
----------8<---------8<---------8<---------8<---------8<---------8<---------
8<---------
/proc/interrupts:

           CPU0       CPU1
  0:      50518      48910    IO-APIC-edge  timer
  1:        184        233    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0          XT-PIC  acpi
 16:       1835       1870   IO-APIC-level  sym53c8xx, sym53c8xx, EMU10K1
 17:          0          0   IO-APIC-level  bttv
 19:       3341       3323   IO-APIC-level  usb-uhci, eth0
NMI:      99336      99361
LOC:      99317      99342
ERR:          0
----------8<---------8<---------8<---------8<---------8<---------8<---------
8<---------
/proc/interrupts (in noapic mode):

           CPU0
  0:      28729          XT-PIC  timer
  1:          7          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  bttv
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:        971          XT-PIC  usb-uhci, eth0
 11:       3490          XT-PIC  sym53c8xx, sym53c8xx, EMU10K1
NMI:          0
ERR:          0

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
