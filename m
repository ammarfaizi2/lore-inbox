Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315166AbSD2Thq>; Mon, 29 Apr 2002 15:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSD2Thp>; Mon, 29 Apr 2002 15:37:45 -0400
Received: from mx.webfountain.com ([63.161.54.39]:41399 "HELO
	mx.webfountain.com") by vger.kernel.org with SMTP
	id <S315166AbSD2Thn>; Mon, 29 Apr 2002 15:37:43 -0400
Subject: vesafb scrolling problem
From: Yoel Inbar <yoel@digitalfountain.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Apr 2002 12:37:10 -0700
Message-Id: <1020109030.9135.56.camel@ricci>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to get the VESA framebuffer console working with an onboard
ATI video controller (lspci reports it as an "ATI Technologies Inc 3D
Rage IIC 215IIC [Mach64GT IIC] (rev 7a)"). It mostly works (whereas
atyfb didn't work at all) except for one rather odd problem: scrolling
doesn't work properly. That is, once the screen fills up, new text is
displayed on the last line only and the old text doesn't scroll off the
top of the screen as it should. However, if I switch virtual consoles,
everthing works fine (that is, I switch from VC 1 to VC 2 and back
again). Or if I run a full-screen app such as vi, that also fixes
things. This is kernel version 2.4.12; dmesg follows. Please cc replies
to me, as I am not on the list.

Thanks,

Yoel

Linux version 2.4.12 (root@ricci) (gcc version 2.95.4 20010902 (Debian
prerelease)) #7 SMP Mon Apr 29 11:49:50 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027ffc000 (usable)
 BIOS-e820: 0000000027ffc000 - 0000000028000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
found SMP MP-table at 000f4ff0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 163836
zone(0): 4096 pages.
zone(1): 159740 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
    OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
    Processor #1 Pentium(tm) Pro APIC version 16
    Processor #0 Pentium(tm) Pro APIC version 16
    I/O APIC #8 Version 17 at 0xFEC00000.
    Processors: 2
    Kernel command line: auto BOOT_IMAGE=Linux ro root=806
console=ttyS0,9600 console=tty0
    Initializing CPU#0
    Detected 996.896 MHz processor.
    Console: colour dummy device 80x25
    Calibrating delay loop... 1985.74 BogoMIPS
    Memory: 642284k/655344k available (1103k kernel code, 12672k
reserved, 340k data, 540k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.68 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1992.29 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3978.03 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 996.9110 MHz.
..... host bus clock speed is 132.9214 MHz.
cpu: 0, clocks: 1329214, slice: 443071
CPU0<T0:1329200,T1:886128,D:1,S:443071,C:1329214>
cpu: 1, clocks: 1329214, slice: 443071
CPU1<T0:1329200,T1:443056,D:2,S:443071,C:1329214>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0084, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 03
PCI: Device 00:00 not found by BIOS
PCI: Device 00:01 not found by BIOS
PCI: Device 00:78 not found by BIOS
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
vesafb: framebuffer at 0xc2000000, mapped to 0xe8800000, size 4096k
vesafb: mode is 640x480x8, linelength=640, pages=11
vesafb: protected mode interface info at c000:48f5
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 80x30
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
hda: Compaq CRN-8241B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
yoel@ricci% cat dmesg
Linux version 2.4.12 (root@ricci) (gcc version 2.95.4 20010902 (Debian
prerelease)) #7 SMP Mon Apr 29 11:49:50 PDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027ffc000 (usable)
 BIOS-e820: 0000000027ffc000 - 0000000028000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
found SMP MP-table at 000f4ff0
hm, page 000f4000 reserved twice.
hm, page 000f5000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 163836
zone(0): 4096 pages.
zone(1): 159740 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
    OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
    Processor #1 Pentium(tm) Pro APIC version 16
    Processor #0 Pentium(tm) Pro APIC version 16
    I/O APIC #8 Version 17 at 0xFEC00000.
    Processors: 2
    Kernel command line: auto BOOT_IMAGE=Linux ro root=806
console=ttyS0,9600 console=tty0
    Initializing CPU#0
    Detected 996.896 MHz processor.
    Console: colour dummy device 80x25
    Calibrating delay loop... 1985.74 BogoMIPS
    Memory: 642284k/655344k available (1103k kernel code, 12672k
reserved, 340k data, 540k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.68 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1992.29 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3978.03 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 8 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 8 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...
..... (found pin 0) ...works.
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 996.9110 MHz.
..... host bus clock speed is 132.9214 MHz.
cpu: 0, clocks: 1329214, slice: 443071
CPU0<T0:1329200,T1:886128,D:1,S:443071,C:1329214>
cpu: 1, clocks: 1329214, slice: 443071
CPU1<T0:1329200,T1:443056,D:2,S:443071,C:1329214>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map = 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xf0084, last bus=3
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered peer bus 03
PCI: Device 00:00 not found by BIOS
PCI: Device 00:01 not found by BIOS
PCI: Device 00:78 not found by BIOS
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
vesafb: framebuffer at 0xc2000000, mapped to 0xe8800000, size 4096k
vesafb: mode is 640x480x8, linelength=640, pages=11
vesafb: protected mode interface info at c000:48f5
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 80x30
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later
hda: Compaq CRN-8241B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M





