Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265329AbRFVEJp>; Fri, 22 Jun 2001 00:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265328AbRFVEJf>; Fri, 22 Jun 2001 00:09:35 -0400
Received: from eschelon.gamesquad.net ([216.115.239.45]:1030 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S265327AbRFVEJY>; Fri, 22 Jun 2001 00:09:24 -0400
Message-ID: <20010622040923.79106.qmail@eschelon.gamesquad.net>
From: "Vibol Hou" <vhou@khmer.cc>
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Jun 2001 04:09:23 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I noticed a 'Please email this to lkml', so here's the dmesg for a 
system whose IO-APIC was unexpected.  It is a dual-1GHz cumine machine using 
a MSI 694D Pro motherboard (VIA694X chipset) with 1GB ram. 

As reference for those who care, this system hard locks consistently when I 
perform a 'myisamchk -o database.MYI' on a small DB table (~100MB).  It is a 
test system, so I can try some patches if needed. 

 --
Vibol Hou
http://khmer.cc 

 ---- 

Linux version 2.4.5 (root@localhost) (gcc version 2.96 20000731 (Red Hat 
Linux 7.1 2.96-81)) #2 SMP Tue Jun 19 08:16:59 PDT 2001
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
128MB HIGHMEM available.
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5e30
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 262144
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 32768 pages.
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
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0a, APIC ID 2, APIC INT 0a
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0d, APIC ID 2, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 3, trig 3, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 2, IRQ 0b, APIC ID 2, APIC INT 0b
Lint: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 0, trig 0, bus 2, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=linux245 ro root=808 
BOOT_FILE=/boot/vmlinuz-2.4.5
Initializing CPU#0
Detected 1002.283 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1998.84 BogoMIPS
Memory: 1028324k/1048576k available (1399k kernel code, 19864k reserved, 
482k data, 200k init, 131072k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 731.04 usecs.
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
Calibrating delay loop... 1998.84 BogoMIPS
Stack at about c2119fb8
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Coppermine) stepping 06
CPU has booted.
Before bogomips.
Total of 2 processors activated (3997.69 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=49 pin1=2 pin2=0
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
0b 003 03  1    1    0   1   0    1    1    81
0c 003 03  0    0    0   0   0    1    1    89
0d 003 03  0    0    0   0   0    1    1    91
0e 003 03  0    0    0   0   0    1    1    99
0f 003 03  1    1    0   1   0    1    1    A1
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
..... CPU clock speed is 1002.2613 MHz.
..... host bus clock speed is 133.6348 MHz.
cpu: 0, clocks: 1336348, slice: 445449
CPU0<T0:1336336,T1:890880,D:7,S:445449,C:1336348>
cpu: 1, clocks: 1336348, slice: 445449
CPU1<T0:1336336,T1:445424,D:14,S:445449,C:1336348>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
allocated 32 pages and 32 bhs reserved for the highmem bounces
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05a (2001-03-20) with MANY_PORTS SHARE_IRQ 
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 683437kB/552365kB, 2048 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: neither IDE port enabled (BIOS)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:A0:C9:96:DD:46, IRQ 15.
 Receiver lock-up bug exists -- enabling work-around.
 Board assembly 668081-004, Physical connectors present: RJ45
 Primary interface chip i82555 PHY #1.
 General self-test: passed.
 Serial sub-system self-test: passed.
 Internal registers self-test: passed.
 ROM checksum self-test: passed (0x3c15c8f1).
 Receiver lock-up workaround activated.
eth1: Intel Corporation 82557 [Ethernet Pro 100] (#2), 00:90:27:22:EB:B1, 
IRQ 11.
 Receiver lock-up bug exists -- enabling work-around.
 Board assembly 689661-004, Physical connectors present: RJ45
 Primary interface chip i82555 PHY #1.
 General self-test: passed.
 Serial sub-system self-test: passed.
 Internal registers self-test: passed.
 ROM checksum self-test: passed (0x24c9f043).
 Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13
       <Adaptec 29160 Ultra160 SCSI adapter>
       aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/255 SCBs 

 Vendor: SEAGATE   Model: ST39102LCSUN9.0G  Rev: 0828
 Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:A:0): 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
 Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1037
 Type:   CD-ROM                             ANSI SCSI revision: 02
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 16)
 Vendor: ECRIX     Model: VXA-1             Rev: 2848
 Type:   Sequential-Access                  ANSI SCSI revision: 02
(scsi0:A:5): 80.000MB/s transfers (40.000MHz, offset 32, 16bit)
 Vendor: IBM       Model: DDYS-T18350N      Rev: S80D
 Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:A:8): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
scsi0:0:0:0: Tagged Queuing enabled.  Depth 253
scsi0:0:8:0: Tagged Queuing enabled.  Depth 253
Detected scsi tape st0 at scsi0, channel 0, id 5, lun 0
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 8, lun 0
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
Partition check:
sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
sdb: sdb1
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.12
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding Swap: 265032k swap-space (priority -1)
