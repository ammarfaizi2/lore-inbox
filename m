Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276729AbRJKS5y>; Thu, 11 Oct 2001 14:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276720AbRJKS5q>; Thu, 11 Oct 2001 14:57:46 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:55793 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S276708AbRJKS5d>;
	Thu, 11 Oct 2001 14:57:33 -0400
Message-ID: <001901c15286$c4e34ad0$6401000a@it0>
From: "Tommy Faasen" <faasen@xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Subject: SMP debugging
Date: Thu, 11 Oct 2001 20:58:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an intel LX SMP board with a 233 and a 350 mhz proc both running at
233.
Kernel 2.2.19pre7 runs fine
Kernel 2.4.0 runs fine

Tested kernels that didn't work
2.4.1, 2.4.5, 2.4.6, 2.4.7, 2.4.8 ,2.4.9, 2.4.9-acx, 2.4.9-prex, 2.4.10-ac11

So I asume something changed between 2.4.0 and 2.4.1, so I tried copying
back smp.c and smpboot.c and then make clean dep bzImage etc
Which didn't work.

I always get the output below, I also include /proc/cpuinfo.
I am not able to find the pre patches between 2.4.0 and 2.4.1 to narrow it
further down.
The way I look at the output is that the kernel only looks what the specs of
the first cpu are and asumes that the second is the same.
But what do I know. I cannot change procs since the second one's cooler is
too big.
Also running uniprocessor works ok with the latest kernels.

I would really appreciate some help on getting any further on this.


Linux version 2.4.10-ac11 (root@minion) (gcc version 2.95.3 20010315
(release))
#2 SMP Thu Oct 11 14:39:20 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000 (usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f6e30
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: BOOT_IMAGE=dual-2.4.1 ro root=803 ether=11,0x300,eth1
conso
le=ttyS0,9600 console=tty0
Initializing CPU#0
Detected 233.866 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 254784k/262132k available (1506k kernel code, 6960k reserved, 427k
data,
 216k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU0: Intel Pentium II (Klamath) stepping 04
per-CPU timeslice cutoff: 1465.81 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/0 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 466.94 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium II (Deschutes) stepping 01
Total of 2 processors activated (933.88 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
..TIMER: vector=0x31 pin1=2 pin2=0
testing the IO APIC.......................

.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 233.8710 MHz.
..... host bus clock speed is 66.8200 MHz.
cpu: 0, clocks: 668200, slice: 222733
CPU0<T0:668192,T1:445456,D:3,S:222733,C:668200>
cpu: 1, clocks: 668200, slice: 222733
CPU1<T0:668192,T1:222720,D:6,S:222733,C:668200>
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xf0730, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Simple Boot Flag extension found and enabled.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10e
block: queued sectors max/low 169194kB/56398kB, 512 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 21
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
hda: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdb: CRD-8322B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: ATAPI 32X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
hda: No disk in drive
hda: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
floppy0: no floppy controllers found
eth0: 3c5x9 at 0x300, 10baseT port, address  00 20 af f2 51 7a, IRQ 11.
3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html
loop: loaded (max 8 devices)
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0b.0: 3Com PCI 3c905C Tornado at 0xb000. Vers LK1.1.16
PCI: Setting latency timer of device 00:0b.0 to 64
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440LX chipset
agpgart: AGP aperture is 64M @ 0xe4000000
ide-floppy driver 0.97.sv
SCSI subsystem driver Revision: 1.00
PCI: Setting latency timer of device 00:06.0 to 64
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.1
        <Adaptec aic7880 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/255 SCBs

  Vendor: IBM       Model: DNES-309170Y      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: MATSHITA  Model: CD-R   CW-7501    Rev: 2.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DNES-309170W      Rev: SAH0
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
scsi0:0:1:0: Tagged Queuing enabled.  Depth 253
scsi0:0:6:0: Tagged Queuing enabled.  Depth 253
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 6, lun 0
(scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
Partition check:
 sda: sda1 sda2 sda3
(scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb: sdb1
(scsi0:A:6): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
SCSI device sdc: 17916240 512-byte hdwr sectors (9173 MB)
 sdc: sdc1
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 5, lun 0
sr0: scsi-1 drive
sr0: scsi-1 drive
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
invalid operand: 0000
CPU:    0
EIP:    0010:[<c010c784>]    Not tainted
EFLAGS: 00010206
eax: 0183fbff   ebx: c02e4350   ecx: cfe4fee0   edx: c145c000
esi: c145c000   edi: 00000000   ebp: c02e4000   esp: c02e5f5c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02e5000)
Stack: c0105862 c145c000 c145c000 00000000 c145c000 c145de68 c031c800
c145c350
       c0113253 c02e5fc4 c02e4000 cfe4fee0 c01051b0 c02e4000 c01051b0
c02e4000
       c02c9e20 c145c000 00000000 0008e000 cfe4fee0 cfe4fee0 00000001
0000002a
Call Trace: [<c0105862>] [<c0113253>] [<c01051b0>] [<c01051b0>] [<c010524e>]
   [<c0105000>] [<c0105047>]

Code: 0f ae 82 90 03 00 00 db e2 eb 08 90 dd b2 90 03 00 00 9b 0f
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

/proc/cpuinfo
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model  : 5
model name : Pentium II (Deschutes)
stepping : 1
cpu MHz  : 233.866
cache size : 512 KB
fdiv_bug : no
hlt_bug  : no
sep_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 2
wp  : yes
flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips : 466.94

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model  : 3
model name : Pentium II (Klamath)
stepping : 4
cpu MHz  : 233.866
cache size : 512 KB
fdiv_bug : no
hlt_bug  : no
sep_bug  : no
f00f_bug : no
coma_bug : no
fpu  : yes
fpu_exception : yes
cpuid level : 2
wp  : yes
flags  : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov mmx
bogomips : 466.94

