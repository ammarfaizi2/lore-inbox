Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268239AbTB1XIe>; Fri, 28 Feb 2003 18:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268245AbTB1XIe>; Fri, 28 Feb 2003 18:08:34 -0500
Received: from f07a-11-5.d1.club-internet.fr ([212.194.154.5]:12293 "EHLO
	a2000") by vger.kernel.org with ESMTP id <S268239AbTB1XIa>;
	Fri, 28 Feb 2003 18:08:30 -0500
Subject: Bug in APIC on 2.4.20 kernel
From: "JP Pozzi izzop.org" <jp.pozzi@izzop.org>
Reply-To: jp.pozzi@izzop.org
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-FD2KAw5OxXtZ67fbo8gC"
Organization: 
Message-Id: <1046474326.1558.16.camel@k400.jpp.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 01 Mar 2003 00:18:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FD2KAw5OxXtZ67fbo8gC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I found a problem with the APIC management in the 2.4.20 kernel.

My system is (was) a bi-processor one :

MSI K7D Master (BIOS V 1.1) with 2 ATHLON MP 1800+

The facts :

1) The 2.4.20 kernel was OK on my system with the 2 processors and a
home made SMP kernel.

2) One processor was broken/defective.

3) No boot was possible with only on processor on the card with a loop
while booting saying endlessly : "APIC 04(04)"

I try to recompile the 2.4.20 kernel with no SMP support the problem was
the same, I try gcc2.95 and gcc3 without any success.

4) The system runs fine with a 2.2.22 home made kernel, the APIC works
well with my lonely processor ... (cf attachment dmesg.2.2.22).

As the system does not run with 2.4.20 kernel I made "ver_linux" under
the current (2.2.22) kernel (cf attachment ver_linux.txt).


Regards 

linux-kernel@vger.kernel.org
-- 
JP Pozzi izzop.org <jp.pozzi@izzop.org>

--=-FD2KAw5OxXtZ67fbo8gC
Content-Disposition: attachment; filename=dmesg.2.2.22
Content-Type: text/plain; name=dmesg.2.2.22; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.2.22 (root@k400.jpp.fr) (gcc version 2.95.4 20011002 (Debian prerelease)) #14 SMP Wed Feb 19 12:28:42 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 1fef0000 @ 00100000 (usable)
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 1
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 1533403 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3060.53 BogoMIPS
Memory: 517168k/524224k available (1076k kernel code, 424k reserved, 5468k data, 88k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
per-CPU timeslice cutoff: 49.99 usecs.
CPU0: AMD Athlon(tm) MP 1800+ stepping 02
calibrating APIC timer ... 
..... CPU clock speed is 1533.4236 MHz.
..... system bus clock speed is 266.6824 MHz.
Error: only one processor found.
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-11, 2-14, 2-20, 2-21, 2-22, 2-23 not connected.
number of MP IRQ sources: 18.
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
 01 0FF 0F  1    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 0FF 0F  1    0    0   0   0    1    1    61
 04 0FF 0F  1    0    0   0   0    1    1    69
 05 000 00  1    0    0   0   0    0    0    00
 06 0FF 0F  1    0    0   0   0    1    1    71
 07 0FF 0F  1    0    0   0   0    1    1    79
 08 0FF 0F  1    0    0   0   0    1    1    81
 09 0FF 0F  1    0    0   0   0    1    1    89
 0a 0FF 0F  1    0    0   0   0    1    1    91
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  1    0    0   0   0    1    1    99
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 0FF 0F  1    0    0   0   0    1    1    A1
 10 0FF 0F  1    1    0   1   0    1    1    A9
 11 0FF 0F  1    1    0   1   0    1    1    B1
 12 0FF 0F  1    1    0   1   0    1    1    B9
 13 0FF 0F  1    1    0   1   0    1    1    C1
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
IRQ9 -> 9
IRQ10 -> 10
IRQ12 -> 12
IRQ13 -> 13
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
PCI: PCI BIOS revision 2.10 entry at 0xfb130
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Enabling I/O for device 00:00
PCI->APIC IRQ transform: (B0,I7,P1) -> 17
PCI->APIC IRQ transform: (B1,I5,P0) -> 17
PCI->APIC IRQ transform: (B2,I0,P3) -> 19
PCI->APIC IRQ transform: (B2,I4,P0) -> 16
PCI->APIC IRQ transform: (B2,I6,P0) -> 18
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
PCI_IDE: unknown IDE controller on PCI bus 00 device 39, VID=1022, DID=7441
PCI_IDE: not 100% native mode: will probe irqs later
PCI_IDE: simplex device:  DMA disabled
ide0: PCI_IDE Bus-Master DMA disabled (BIOS)
PCI_IDE: simplex device:  DMA disabled
ide1: PCI_IDE Bus-Master DMA disabled (BIOS)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
sym53c8xx: at PCI bus 2, device 4, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875 detected with Tekram NVRAM
sym53c875-0: rev 0x3 on pci bus 2 device 4 function 0 irq 16
sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, NO Parity
scsi0 : sym53c8xx-1.7.1-20000726
scsi : 1 host.
  Vendor: IBM       Model: DDRS-34560W       Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0d
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.10
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: QUANTUM   Model: ATLAS_V__9_WLS    Rev: 0230
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdb at scsi0, channel 0, id 4, lun 0
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi0, channel 0, id 8, lun 0
  Vendor: IBM       Model: DDRS-34560D       Rev: DC1B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdd at scsi0, channel 0, id 9, lun 0
scsi : detected 4 SCSI disks total.
sym53c875-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
SCSI device sda: hdwr sector= 512 bytes. Sectors= 8925000 [4357 MB] [4.4 GB]
sym53c875-0-<4,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 17930694 [8755 MB] [8.8 GB]
sym53c875-0-<8,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 8925000 [4357 MB] [4.4 GB]
sym53c875-0-<9,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 15)
SCSI device sdd: hdwr sector= 512 bytes. Sectors= 8925000 [4357 MB] [4.4 GB]
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Lite-On 82c168 PNIC rev 32 at 0xd400, 00:A0:CC:5B:E9:63, IRQ 18.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2
 sdc: sdc1
 sdd: sdd1
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 88k freed
Adding Swap: 358412k swap-space (priority -1)
Coda Kernel/Venus communications (module), v5.3.8, coda@cs.cmu.edu.
parport0: PC-style at 0x378 [SPP,PS2]
lp0: using parport0 (polling).
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver usbscanner
scanner.c: USB Scanner support registered.
scanner.c: open_scanner(0): Unable to access minor data
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
nvidia: loading NVIDIA NVdriver Kernel Module  1.0-2960  Tue May 14 07:41:42 PDT 2002

--=-FD2KAw5OxXtZ67fbo8gC
Content-Disposition: attachment; filename=ver_linux.txt
Content-Type: text/plain; name=ver_linux.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux k400.jpp.fr 2.2.22 #14 SMP Wed Feb 19 12:28:42 CET 2003 i686 unknown unknown GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.21
e2fsprogs              1.32
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.15
Modules Loaded         NVdriver usb-storage scanner usbcore parport_pc lp parport coda

--=-FD2KAw5OxXtZ67fbo8gC--

