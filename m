Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129508AbRBCLmF>; Sat, 3 Feb 2001 06:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129736AbRBCLlz>; Sat, 3 Feb 2001 06:41:55 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:18438 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129508AbRBCLln>;
	Sat, 3 Feb 2001 06:41:43 -0500
Date: Sat, 3 Feb 2001 11:36:04 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Frank de Lange <frank@unternet.org>, linux-kernel@vger.kernel.org
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Message-ID: <20010203113604.A625@grobbebol.xs4all.nl>
In-Reply-To: <20010202145504.A607@grobbebol.xs4all.nl> <Pine.GSO.3.96.1010202213824.19076D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010202213824.19076D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Feb 02, 2001 at 09:42:30PM +0100
X-OS: Linux grobbebol 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 09:42:30PM +0100, Maciej W. Rozycki wrote:
>  Could you please apply the following patch, wait for a lockup, then hit
> SysRq+A (you need to have CONFIG_MAGIC_SYSRQ enabled) and send me the
> resulting output?  You need to include debug messages, so I recommend to
> use `dmesg' for getting the log.
> 
>  I'd like to know if the conditions are the same as previously.

ok. the conditions are this :


2.4.1 with your APIC patch & the sysrq-a addition.

the system doesn't lock up anymore with your patch as mentioned before.
what does happen is that the ne2k doesn't react anymore (eth0 dead).

I have sysrq'd twice. the first one is the one where it works, then,
after a floodping of only 5 seconds, eth0 stops working. the floodping
is generated from outside towards this machine. then again I sysrq'd/
here are the results. I glued dmesg from begin to end so that all
messages are visible from boot time. pls explain what you find :-)


Linux version 2.4.1 (root@grobbebol) (gcc version 2.95.2 19991024 (release)) #5 SMP Sat Feb 3 11:02:44 GMT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000ff00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5ae0
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
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
Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 1, trig 1, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 1f, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 24, APIC ID 2, APIC INT 13
Int: type 0, pol 3, trig 3, bus 0, IRQ 2c, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 4c, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 4d, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 1, IRQ 00, APIC ID 2, APIC INT 10
Int: type 2, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=linux ro root=302
Initializing CPU#0
Detected 467.732 MHz processor.
Console: colour VGA+ 132x43
Calibrating delay loop... 933.88 BogoMIPS
Memory: 255540k/262144k available (939k kernel code, 6216k reserved, 391k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Celeron (Mendocino) stepping 05
per-CPU timeslice cutoff: 365.67 usecs.
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
Calibrating delay loop... 933.88 BogoMIPS
Stack at about c15fffbc
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
OK.
CPU1: Intel Celeron (Mendocino) stepping 05
CPU has booted.
Before bogomips.
Total of 2 processors activated (1867.77 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-12, 2-17, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
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
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  0    0    0   0   0    1    1    71
 0b 003 03  0    0    0   0   0    1    1    79
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 003 03  1    1    0   1   0    1    1    99
 13 003 03  1    1    0   1   0    1    1    A1
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
IRQ10 -> 10
IRQ11 -> 11
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 467.7620 MHz.
..... host bus clock speed is 66.8228 MHz.
cpu: 0, clocks: 668228, slice: 222742
CPU0<T0:668224,T1:445472,D:10,S:222742,C:668228>
cpu: 1, clocks: 668228, slice: 222742
CPU1<T0:668224,T1:222736,D:4,S:222742,C:668228>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb5c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I9,P0) -> 19
PCI->APIC IRQ transform: (B0,I11,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P0) -> 18
PCI->APIC IRQ transform: (B0,I19,P1) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.2 present.
41 structures occupying 1111 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 04/20/00
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 169730kB/56576kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI bus 00 dev 98
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI bus 00 dev 99
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0xe000-0xe007, BIOS settings: hdg:pio, hdh:pio
hda: ST313021A, ATA DISK drive
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 25434228 sectors (13022 MB) w/512KiB Cache, CHS=25232/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS03 at 0x02e8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
SCSI subsystem driver Revision: 1.00
scsi: ***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
scsi: Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
scsi0: Configuring BusLogic Model BT-930 PCI Ultra SCSI Host Adapter
scsi0:   Firmware Version: 5.02, I/O Address: 0xC800, IRQ Channel: 18/Level
scsi0:   PCI Bus: 0, Device: 11, Address: 0xD8000000, Host Adapter SCSI ID: 7
scsi0:   Parity Checking: Enabled, Extended Translation: Enabled
scsi0:   Synchronous Negotiation: Fast, Wide Negotiation: Disabled
scsi0:   Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
scsi0:   Driver Queue Depth: 255, Scatter/Gather Limit: 128 segments
scsi0:   Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
scsi0:   Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
scsi0:   SCSI Bus Termination: Enabled, SCAM: Disabled
scsi0: *** BusLogic BT-930 Initialized Successfully ***
scsi0 : BusLogic BT-930
  Vendor: COMPAQ    Model: ST15150N          Rev: 5217
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi0: Target 0: Queue Depth 28, Synchronous at 10.0 MB/sec, offset 15
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 8386000 512-byte hdwr sectors (4294 MB)
 sda: sda1
reiserfs: checking transaction log (device 08:01) ...
Using tea hash to sort names
reiserfs: using 3.5.x disk format
ReiserFS version 3.6.25
i2c-core.o: i2c core module
i2c-isa.o version 2.5.4 (20001012)
i2c-core.o: adapter ISA main adapter registered as adapter 0.
i2c-isa.o: ISA bus access for i2c modules initialized.
sensors.o version 2.5.4 (20001012)
w83781d.o version 2.5.4 (20001012)
i2c-core.o: driver W83781D sensor driver registered.
i2c-core.o: client [W83782D chip] registered to adapter [ISA main adapter](pos. 0).
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: HP        Model: CD-Writer+ 9100   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 02
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0xc400, IRQ 19, 00:20:18:54:6F:35.
Adding Swap: 51192k swap-space (priority -1)
SysRq: 
print_PIC()

printing PIC contents
... PIC  IMR: fffa
... PIC  IRR: 0000
... PIC  ISR: 0000
... PIC ELCR: 1200
print_IO_APIC()
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
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
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  0    0    0   0   0    1    1    71
 0b 003 03  0    0    0   0   0    1    1    79
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 003 03  0    1    0   1   0    1    1    99
 13 003 03  0    1    0   1   0    1    1    A1
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
IRQ10 -> 10
IRQ11 -> 11
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
print_all_local_APICs()

printing local APIC contents on CPU#0/0:
... APIC ID:      00000000 (0)
... APIC VERSION: 00040011
... APIC TASKPRI: 00000000 (00)
... APIC ARBPRI: 00000000 (00)
... APIC PROCPRI: 00000000
... APIC EOI: 00000000
... APIC LDR: 01000000
... APIC DFR: ffffffff
... APIC SPIV: 000001ff
... APIC ISR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC TMR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000001000000
01000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC IRR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000010000000000000000
... APIC ESR: 00000000
... APIC ICR: 000008fc
... APIC ICR2: 02000000
... APIC LVTT: 000200ef
... APIC LVTPC: 00010000
... APIC LVT0: 00000400
... APIC LVT1: 00000400
... APIC LVTERR: 000000fe
... APIC TMICT: 0000a324
... APIC TMCCT: 000090ee
... APIC TDCR: 00000003


printing local APIC contents on CPU#1/1:
... APIC ID:      01000000 (1)
... APIC VERSION: 00040011
... APIC TASKPRI: 00000000 (00)
... APIC ARBPRI: 000000f0 (f0)
... APIC PROCPRI: 00000000
... APIC EOI: 00000000
... APIC LDR: 02000000
... APIC DFR: ffffffff
... APIC SPIV: 000001ff
... APIC ISR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC TMR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000001000000
01000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC IRR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000010000000000001000
... APIC ESR: 00000000
... APIC ICR: 000c08fb
... APIC ICR2: 01000000
... APIC LVTT: 000200ef
... APIC LVTPC: 00010000
... APIC LVT0: 00000400
... APIC LVT1: 00010400
... APIC LVTERR: 000000fe
... APIC TMICT: 0000a324
... APIC TMCCT: 00007339
... APIC TDCR: 00000003

SysRq: 
print_PIC()

printing PIC contents
... PIC  IMR: fffa
... PIC  IRR: 0200
... PIC  ISR: 0000
... PIC ELCR: 1200
print_IO_APIC()
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
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
 09 000 00  1    0    0   0   0    0    0    00
 0a 003 03  0    0    0   0   0    1    1    71
 0b 003 03  0    0    0   0   0    1    1    79
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 000 00  1    0    0   0   0    0    0    00
 12 003 03  0    1    0   1   0    1    1    99
 13 003 03  0    1    1   1   1    1    1    A1
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
IRQ10 -> 10
IRQ11 -> 11
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
print_all_local_APICs()

printing local APIC contents on CPU#1/1:
... APIC ID:      01000000 (1)
... APIC VERSION: 00040011
... APIC TASKPRI: 00000000 (00)
... APIC ARBPRI: 00000000 (00)
... APIC PROCPRI: 00000000
... APIC EOI: 00000000
... APIC LDR: 02000000
... APIC DFR: ffffffff
... APIC SPIV: 000001ff
... APIC ISR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC TMR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000001000000
01000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC IRR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC ESR: 00000000
... APIC ICR: 000008fc
... APIC ICR2: 01000000
... APIC LVTT: 000200ef
... APIC LVTPC: 00010000
... APIC LVT0: 00000400
... APIC LVT1: 00010400
... APIC LVTERR: 000000fe
... APIC TMICT: 0000a324
... APIC TMCCT: 00001e10
... APIC TDCR: 00000003


printing local APIC contents on CPU#0/0:
... APIC ID:      00000000 (0)
... APIC VERSION: 00040011
... APIC TASKPRI: 00000000 (00)
... APIC ARBPRI: 000000e0 (e0)
... APIC PROCPRI: 00000000
... APIC EOI: 00000000
... APIC LDR: 01000000
... APIC DFR: ffffffff
... APIC SPIV: 000001ff
... APIC ISR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC TMR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000001000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
... APIC IRR field:
0123456789abcdef0123456789abcdef
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000000000000000000000
00000000000000010000000000000000
... APIC ESR: 00000000
... APIC ICR: 000c08fb
... APIC ICR2: 02000000
... APIC LVTT: 000200ef
... APIC LVTPC: 00010000
... APIC LVT0: 00000400
... APIC LVT1: 00000400
... APIC LVTERR: 000000fe
... APIC TMICT: 0000a324
... APIC TMCCT: 00007b18
... APIC TDCR: 00000003


-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
