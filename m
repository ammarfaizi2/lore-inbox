Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTIGWiO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 18:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbTIGWiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 18:38:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38312 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S261649AbTIGWhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 18:37:51 -0400
Date: Sun, 07 Sep 2003 18:37:48 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: PROBLEM: APIC on a Pentium Classic SMP,
 kernel 2.4.21-pre5 to 2.4.23-pre3
To: linux-kernel@vger.kernel.org, mingo@redhat.com
Message-id: <20030907223748.GA1517@Krystal>
X-Info: http://krystal.dyndns.org
MIME-version: 1.0
Content-type: multipart/signed; boundary="=_Krystal-1723-1062974269-0001-2";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Editor: vi
X-Operating-System: Linux/2.4.20 (i586)
X-Uptime: 18:30:24 up 23 min,  1 user,  load average: 0.23, 0.06, 0.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-1723-1062974269-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Here is the detailed description of an APIC problem I ran into in the
lastest stable releases of the Linux kernel.


Summary

IRQ problems with APIC enabled on a Neptune chipset, Pentium 90 SMP.

Description

Since kernel 2.4.21-pre2, IRQ problems are present on my Pentium 90 SMP, wi=
th
APIC enabled. It works well with 2.4.20 with APIC enabled, or with newer
kernels with "noapic" kernel option.

This computer has a Neptune chipset.

The following bug report is similar to this one :
http://lkml.org/lkml/2003/8/8/193

On kernel 2.4.21-pre2, there is a kernel oops before this, with a
"Dereferencing NULL pointer".
On kernel 2.4.21-pre4, just after the floppy probing, there is a
"keyboard: AT keyboard not present?(ed)"

Since 2.4.21-pre5, the floppy interrupt problem appears. It can be
reproduced all the time. The system hangs during SCSI cards probing.

Keywords : APIC, SMP, IRQ, Neptune chipset

Kernel version
Kernels between 2.4.21-pre5 and 2.4.23-pre3 do have this problem.


---------------------------------------------------------------------------=
----
Here is the console log of the 2.4.23-pre3 bootup :

Linux version 2.4.23-pre3 (compudj@compubox) (gcc version 3.2.3 (Debian)) #=
11 SMP Sun Sep 7 17:25:10 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000006000000 (usable)
96MB LOWMEM available.
found SMP MP-table at 000f5e40
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
DMI not present.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
Default MP configuration #6
Processor #0 Pentium(tm) APIC version 16
Processor #1 Pentium(tm) APIC version 16
I/O APIC #2 Version 16 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=3D2.4.23-pre3 ro root=3D802 panic=3D60 cons=
ole=3Dtty0 console=3DttyS3,9600n8
Initializing CPU#0
Detected 89.938 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 178.99 BogoMIPS
Memory: 94100k/98304k available (1717k kernel code, 3816k reserved, 440k da=
ta, 296k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
CPU0: Intel Pentium 75 - 200 stepping 04
per-CPU timeslice cutoff: 160.15 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 179.81 BogoMIPS
CPU1: Intel Pentium 75 - 200 stepping 04
Total of 2 processors activated (358.80 BogoMIPS).
WARNING: SMP operation may be unreliable with B stepping processors.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
=2E.TIMER: vector=3D0x31 pin1=3D-1 pin2=3D-1
=2E..trying to set up timer (IRQ0) through the 8259A ...  failed.
=2E..trying to set up timer as Virtual Wire IRQ... works.
testing the IO APIC.......................

=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 89.9374 MHz.
=2E.... host bus clock speed is 59.9580 MHz.
cpu: 0, clocks: 599580, slice: 199860
CPU0<T0:599568,T1:399696,D:12,S:199860,C:599580>
cpu: 1, clocks: 599580, slice: 199860
CPU1<T0:599568,T1:199840,D:8,S:199860,C:599580>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map =3D 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.00 entry at 0xfdb83, last bus=3D0
PCI: Using configuration type 2
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: fixing NCR 53C810 class code for 00:01.0
PCI: fixing NCR 53C810 class code for 00:03.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 [PCSPP(,...)]
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS02 at 0x03e8 (irq =3D 4) is a 16550A
ttyS03 at 0x02e8 (irq =3D 3) is a 16550A
lp0: using parport0 (polling).
lp0: console ready
Real Time Clock Driver v1.10e
Software Watchdog Timer: 0.05, timer margin: 60 sec
Floppy drive(s): fd0 is 1.44M
floppy0: timeout handler died: normal interrupt end
floppy0: no floppy controllers found
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256) (6 bit en=
capsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ide2: ports already in use, skipping probe
SCSI subsystem driver Revision: 1.00
sym.0.1.0: setting PCI_COMMAND_PARITY...
sym.0.3.0: setting PCI_COMMAND_PARITY...
sym0: <810> rev 0x1 on pci bus 0 device 1 function 0 irq 9
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.

---------------------------------------------------------------------------=
----

Environment information :

Information available running kernel 2.4.20.

If you want more complete information, I can send it upon request.

---------------------------------------------------------------------------=
----
/proc/cpuinfo :

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 4
cpu MHz		: 89.937
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic
bogomips	: 178.99

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 4
cpu MHz		: 89.937
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 apic
bogomips	: 179.81
---------------------------------------------------------------------------=
----
/proc/interrupts :

           CPU0       CPU1      =20
  0:      15165      15080    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          2          4    IO-APIC-edge  serial
  4:         12         12    IO-APIC-edge  serial
  5:      12031      12782    IO-APIC-edge  eth0
  8:          2          2    IO-APIC-edge  rtc
  9:       3334       3337   IO-APIC-level  sym53c8xx
 10:         20         18   IO-APIC-level  sym53c8xx
 11:        211        233   IO-APIC-level  eth1
NMI:          0          0=20
LOC:      30167      30206=20
ERR:          0
MIS:          0
---------------------------------------------------------------------------=
----
Output from lspci -vvv

00:00.0 Host bridge: Intel Corp. 82434LX [Mercury/Neptune] (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort- <TAbort- =
<MAbort+ >SERR- <PERR-
	Latency: 32

00:01.0 Non-VGA unclassified device: LSI Logic / Symbios Logic 53c810 (rev =
01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 96
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at f800 [size=3D256]
	Region 1: Memory at 06000000 (32-bit, non-prefetchable) [size=3D256]

00:02.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 248

00:03.0 Non-VGA unclassified device: LSI Logic / Symbios Logic 53c810 (rev =
01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 96
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f400 [size=3D256]
	Region 1: Memory at 06200000 (32-bit, non-prefetchable) [size=3D256]

00:04.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
	Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 96 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 0900 [size=3D256]
	Region 1: Memory at 06100000 (32-bit, non-prefetchable) [size=3D256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1+,D2+,D3hot+,D3col=
d-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

---------------------------------------------------------------------------=
----
dmesg output from 2.4.20 (working kernel):

Linux version 2.4.20 (compudj@compubox) (gcc version 3.2.3 (Debian)) #13 SM=
P Sun Aug 31 17:16:43 EDT 2003
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000006000000 (usable)
96MB LOWMEM available.
found SMP MP-table at 000f5e40
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
Default MP configuration #6
Processor #0 Pentium(tm) APIC version 16
Processor #1 Pentium(tm) APIC version 16
I/O APIC #2 Version 16 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=3D2.4.20smp-6 ro root=3D802 panic=3D60
Initializing CPU#0
Detected 89.939 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 178.99 BogoMIPS
Memory: 94132k/98304k available (1590k kernel code, 3784k reserved, 412k da=
ta, 272k init, 0k highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Intel Pentium with F0 0F bug - workaround enabled.
CPU:     After generic, caps: 000007bf 00000000 00000000 00000000
CPU:             Common caps: 000007bf 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
CPU:     After generic, caps: 000007bf 00000000 00000000 00000000
CPU:             Common caps: 000007bf 00000000 00000000 00000000
CPU0: Intel Pentium 75 - 200 stepping 04
per-CPU timeslice cutoff: 160.15 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 179.81 BogoMIPS
CPU:     After generic, caps: 000007bf 00000000 00000000 00000000
CPU:             Common caps: 000007bf 00000000 00000000 00000000
CPU1: Intel Pentium 75 - 200 stepping 04
Total of 2 processors activated (358.80 BogoMIPS).
WARNING: SMP operation may be unreliable with B stepping processors.
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
=2E..changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0 not connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 16.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E... register #01: 000F0011
=2E......     : max redirection entries: 000F
=2E......     : PRQ implemented: 0
=2E......     : IO APIC version: 0011
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   0   0    1    1    71
 0a 003 03  1    1    0   0   0    1    1    79
 0b 003 03  1    1    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
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
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 89.9387 MHz.
=2E.... host bus clock speed is 59.9588 MHz.
cpu: 0, clocks: 599588, slice: 199862
CPU0<T0:599584,T1:399712,D:10,S:199862,C:599588>
cpu: 1, clocks: 599588, slice: 199862
CPU1<T0:599584,T1:199856,D:4,S:199862,C:599588>
checking TSC synchronization across CPUs: passed.
Waiting on wait_init_idle (map =3D 0x2)
All processors have done init_idle
PCI: PCI BIOS revision 2.00 entry at 0xfdb83, last bus=3D0
PCI: Using configuration type 2
PCI: Probing PCI hardware
PCI: fixing NCR 53C810 class code for 00:01.0
PCI: fixing NCR 53C810 class code for 00:03.0
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
PCI BIOS passed nonexistent PCI bus 0!
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
parport0: PC-style at 0x378 [PCSPP(,...)]
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_P=
CI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS02 at 0x03e8 (irq =3D 4) is a 16550A
ttyS03 at 0x02e8 (irq =3D 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Software Watchdog Timer: 0.05, timer margin: 60 sec
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=3D256) (6 bit en=
capsulation enabled).
CSLIP: code copyright 1989 Regents of the University of California.
SLIP linefill/keepalive option.
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
SCSI subsystem driver Revision: 1.00
sym.0.1.0: setting PCI_COMMAND_PARITY...
sym.0.3.0: setting PCI_COMMAND_PARITY...
sym0: <810> rev 0x1 on pci bus 0 device 1 function 0 irq 9
sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
sym0: SCSI BUS has been reset.
sym1: <810> rev 0x1 on pci bus 0 device 3 function 0 irq 10
sym1: No NVRAM, ID 7, Fast-10, SE, parity checking
sym1: SCSI BUS has been reset.
scsi0 : sym-2.1.17a
scsi1 : sym-2.1.17a
blk: queue c119ce18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST32430N          Rev: HP05
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c119ca18, I/O limit 4095Mb (mask 0xffffffff)
sym0:3: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
  Vendor: HP        Model: D2645             Rev: bHbH
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c119c418, I/O limit 4095Mb (mask 0xffffffff)
sym0:4: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
  Vendor: IBM       Model: DMVS18D           Rev: 0077
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c119c018, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SEAGATE   Model: ST31200N          Rev: 8008
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c118ec18, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: DEC       Model: RZ26L    (C) DEC  Rev: 440C
  Type:   Direct-Access                      ANSI SCSI revision: 02
blk: queue c118e818, I/O limit 4095Mb (mask 0xffffffff)
sym0:1:0: tagged command queuing enabled, command queue depth 16.
sym0:3:0: tagged command queuing enabled, command queue depth 16.
sym0:4:0: tagged command queuing enabled, command queue depth 16.
sym0:5:0: tagged command queuing enabled, command queue depth 16.
sym0:6:0: tagged command queuing enabled, command queue depth 16.
  Vendor: MICROP    Model: 1684-07MB1057403  Rev: HSP4
  Type:   Direct-Access                      ANSI SCSI revision: 01 CCS
blk: queue c118e218, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: SONY      Model: CD-ROM CDU-55S    Rev: 1.0t
  Type:   CD-ROM                             ANSI SCSI revision: 02
blk: queue c1183818, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 5, lun 0
Attached scsi disk sde at scsi0, channel 0, id 6, lun 0
Attached scsi disk sdf at scsi1, channel 0, id 1, lun 0
sym0:1: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
SCSI device sda: 4194685 512-byte hdwr sectors (2148 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 2039283 512-byte hdwr sectors (1044 MB)
 sdb: sdb1
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
 sdc: sdc1
sym0:5: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
SCSI device sdd: 2061108 512-byte hdwr sectors (1055 MB)
 sdd: sdd1
sym0:6: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
SCSI device sde: 2050860 512-byte hdwr sectors (1050 MB)
 sde: sde1
sym1:1: FAST-5 SCSI 3.9 MB/s ST (256.0 ns, offset 8)
SCSI device sdf: 663476 512-byte hdwr sectors (340 MB)
 sdf: sdf1
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 5, lun 0
sym1:5: FAST-5 SCSI 4.0 MB/s ST (248.0 ns, offset 8)
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
md: linear personality registered as nr 1
[SNIP]
md: ... autorun DONE.
[SNIP : networking and fs stuff]
---------------------------------------------------------------------------=
---



OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-1723-1062974269-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/W7M8PyWo/juummgRAvCcAKCenOe2L8LBJx1VS2ImNT/IBoyePQCfVfJg
erkQ2XDOBB1QRhSmc3Myh9c=
=AjxT
-----END PGP SIGNATURE-----

--=_Krystal-1723-1062974269-0001-2--
