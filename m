Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129361AbRBUN6D>; Wed, 21 Feb 2001 08:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129715AbRBUN5y>; Wed, 21 Feb 2001 08:57:54 -0500
Received: from [200.43.18.234] ([200.43.18.234]:25872 "EHLO
	radius.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S129361AbRBUN5i>; Wed, 21 Feb 2001 08:57:38 -0500
To: linux-kernel@vger.kernel.org
Subject: "Unable to handle kernel paging request" x 3
Message-ID: <982763791.3a93c90f0c35c@webmail.telpin.com.ar>
Date: Wed, 21 Feb 2001 10:56:31 -0300 (ARST)
From: Alberto Bertogli <albertogli@telpin.com.ar>
Cc: soporte@telpin.com.ar
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ982763791bfa0ba65fda4f2f91895ed5062ec399f"
User-Agent: IMP/PHP IMAP webmail program 2.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ982763791bfa0ba65fda4f2f91895ed5062ec399f
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

This is the 3rd day in a row i got an oops.
The only difference this time was the machine had one postgresql running, with 
mailsnarf, vmstat, apache and inetd; without any load.

The oops (passed through ksymoops 2.4) is attached, with the dmesg.

Linux sol 2.4.1 #3 SMP Wed Feb 14 18:14:33 ARST 2001 i686 unknown
The only module loaded is the megaraid.

Please ask if you need any other info.

Thanks,
        Alberto
---MOQ982763791bfa0ba65fda4f2f91895ed5062ec399f
Content-Type: text/plain; name="oops.ksymoops.txt"; name="oops.ksymoops.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="oops.ksymoops.txt"


ksymoops 2.3.7 on i686 2.4.1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address 00009fac
*pde = 00000000
CPU:    1
EIP:    0010:[<c01071ec>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000  ebx: c01071c0  ecx: c1228000  edx: c1228000
esi: c1228000  edi: c01071c0  ebp: 00000000  esp: c1229bf0
ds: 0018  es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c1229000)
Stack: c010724e 00000000 00000000 00000000 c037d886 0000002b 00000000 c024126d
       00000000 00000006 00000007 00000000 00000000 c03e8a40 0000c000 c01e771e
       c1223000 00000001 00000000 00000000
Call trace: [<c010724e>] [<c024126d>] [<c01e771e>]
Code: c3 8d 76 00 fb c3 89 f6 fb ba 00 e0 ff ff 21 e2 b8 ff ff ff

>>EIP; c01071ec <default_idle+2c/34>   <=====
Trace; c010724e <cpu_idle+3a/50>
Trace; c024126d <vgacon_cursor+1e9/1f4>
Trace; c01e771e <set_cursor+6e/84>
Code;  c01071ec <default_idle+2c/34>
00000000 <_EIP>:
Code;  c01071ec <default_idle+2c/34>   <=====
   0:   c3                        ret       <=====
Code;  c01071ed <default_idle+2d/34>
   1:   8d 76 00                  leal   0x0(%esi),%esi
Code;  c01071f0 <default_idle+30/34>
   4:   fb                        sti    
Code;  c01071f1 <default_idle+31/34>
   5:   c3                        ret    
Code;  c01071f2 <default_idle+32/34>
   6:   89 f6                     movl   %esi,%esi
Code;  c01071f4 <poll_idle+0/20>
   8:   fb                        sti    
Code;  c01071f5 <poll_idle+1/20>
   9:   ba 00 e0 ff ff            movl   $0xffffe000,%edx
Code;  c01071fa <poll_idle+6/20>
   e:   21 e2                     andl   %esp,%edx
Code;  c01071fc <poll_idle+8/20>
  10:   b8 ff ff ff 00            movl   $0xffffff,%eax

Kernel panic: Attemped to kill the idle task!

---MOQ982763791bfa0ba65fda4f2f91895ed5062ec399f
Content-Type: text/plain; name="dmesg.txt"; name="dmesg.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline; filename="dmesg.txt"


Linux version 2.4.1 (root@sol) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 SMP Wed Feb 14 18:14:33 ARST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000007f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000080000 @ 00000000fff80000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fdba0
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
hm, page 0009f000 reserved twice.
hm, page 000a0000 reserved twice.
On node 0 totalpages: 32768
zone(0): 4096 pages.
zone(1): 28672 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: POWEREDGE    APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
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
Bus #0 is PCI   
Bus #1 is PCI   
Bus #2 is EISA  
I/O APIC #1 Version 17 at 0xFEC00000.
Int: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID 1, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 1, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 1, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 1, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 1, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 1, APIC INT 05
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 1, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 1, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 1, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 1, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 1, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 2, IRQ 0b, APIC ID 1, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 1, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 1, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 1, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 1, APIC INT 0f
Lint: type 3, pol 1, trig 1, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: BOOT_IMAGE=linux ro root=801
Initializing CPU#0
Detected 199.438 MHz processor.
Console: colour VGA+ 132x44
Calibrating delay loop... 397.31 BogoMIPS
Memory: 125404k/131072k available (1865k kernel code, 5280k reserved, 649k data, 212k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
CPU0: Intel Pentium Pro stepping 07
per-CPU timeslice cutoff: 1460.32 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 3000000
Getting ID: c000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 9
Booting processor 1/0 eip 2000
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
CPU#1 (phys ID: 0) waiting for CALLOUT
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
Calibrating delay loop... 398.13 BogoMIPS
Stack at about c1229fbc
CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
CPU: After generic, caps: 0000fbff 00000000 00000000 00000000
CPU: Common caps: 0000fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium Pro stepping 07
CPU has booted.
Before bogomips.
Total of 2 processors activated (795.44 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 1 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 1-0 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 16.
number of IO-APIC #1 registers: 16.
testing the IO APIC.......................

IO APIC #1......
.... register #00: 01000000
.......    : physical APIC id: 01
.... register #01: 000F0011
.......     : max redirection entries: 000F
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
 09 003 03  0    0    0   0   0    1    1    71
 0a 003 03  0    0    0   0   0    1    1    79
 0b 003 03  1    1    0   0   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 003 03  1    1    0   0   0    1    1    91
 0f 003 03  1    1    0   0   0    1    1    99
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
..... CPU clock speed is 199.4369 MHz.
..... host bus clock speed is 66.4787 MHz.
cpu: 0, clocks: 664787, slice: 221595
CPU0<T0:664784,T1:443184,D:5,S:221595,C:664787>
cpu: 1, clocks: 664787, slice: 221595
CPU1<T0:664784,T1:221584,D:10,S:221595,C:664787>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xf814d, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 83208kB/27736kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
divert: not allocating divert_blk for non-ethernet device teql0
early initialization of device teql0 is deferred
NET4: Frame Diverter 0.46
Coda Kernel/Venus communications, v5.3.9, coda@cs.cmu.edu
NTFS version 000607
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
divert: allocating divert_blk for eth0
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:2D:E5:16, IRQ 14.
  Board assembly 352509-003, Physical connectors present: RJ45
  Primary interface chip DP83840 PHY #1.
  DP83840 specific setup, setting register 23 to 8462.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x49caa8d6).
  Receiver lock-up workaround activated.
divert: not allocating divert_blk for non-ethernet device shaper0
divert: not allocating divert_blk for non-ethernet device dummy0
divert: not allocating divert_blk for non-ethernet device bond0
Universal TUN/TAP device driver 1.3 (C)1999-2000 Maxim Krasnyansky
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 1/10/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
(scsi1) <Adaptec AIC-7860 Ultra SCSI host adapter> found at PCI 1/11/0
(scsi1) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi1) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7880 Ultra SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7860 Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 20.0 Mbyte/sec, offset 8.
  Vendor: QUANTUM   Model: ATLAS IV 18 WLS   Rev: 0909
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi1:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: NEC       Model: CD-ROM DRIVE:462  Rev: 1.14
  Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi1:0:5:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: SONY      Model: TSL-9000          Rev: L006
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: SONY      Model: TSL-9000          Rev: L006
  Type:   Medium Changer                     ANSI SCSI revision: 02
Detected scsi tape st0 at scsi1, channel 0, id 5, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
Partition check:
 sda: sda1 sda2
Detected scsi CD-ROM sr0 at scsi1, channel 0, id 3, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
Detected scsi generic sg3 at scsi1, channel 0, id 5, lun 1, type 8
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IPv4 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device tunl0
GRE over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device gre0
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
ip6_tables: (c)2000 Netfilter core team
registreing ipv6 mark target
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 212k freed
Adding Swap: 666688k swap-space (priority -1)
megaraid: v107 (December 22, 1999)
megaraid: found 0x101e:0x9010: in 01:0d.0
scsi2 : Found a MegaRAID controller at 0xe090, IRQ: 15
megaraid: Couldn't register I/O range!
megaraid: v107 (December 22, 1999)
megaraid: found 0x101e:0x9010: in 01:0d.0
scsi2 : Found a MegaRAID controller at 0xe090, IRQ: 15
megaraid: [U.75:1.44] detected 1 logical drives
scsi2 : AMI MegaRAID U.75 254 commands 16 targs 2 chans 8 luns
scsi2: scanning channel 1 for devices.
  Vendor: DELL      Model: 6UW BACKPLANE     Rev: 7   
  Type:   Processor                          ANSI SCSI revision: 02
Detected scsi generic sg4 at scsi2, channel 0, id 6, lun 0, type 3
scsi2: scanning channel 2 for devices.
scsi2: scanning virtual channel for logical drives.
  Vendor: MegaRAID  Model: LD0 RAID5  8176R  Rev: U.75
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi2, channel 2, id 0, lun 0
SCSI device sdb: 16744448 512-byte hdwr sectors (8573 MB)
 sdb: sdb1
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
eth0: no IPv6 routers present
mailsnarf uses obsolete (PF_INET,SOCK_PACKET)
device eth0 entered promiscuous mode

---MOQ982763791bfa0ba65fda4f2f91895ed5062ec399f--
