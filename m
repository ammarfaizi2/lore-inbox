Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130825AbRCFOzf>; Tue, 6 Mar 2001 09:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRCFOz1>; Tue, 6 Mar 2001 09:55:27 -0500
Received: from mirza.iland.net ([204.87.167.69]:10771 "EHLO GROOVY.ORG")
	by vger.kernel.org with ESMTP id <S130825AbRCFOzM>;
	Tue, 6 Mar 2001 09:55:12 -0500
Date: Tue, 6 Mar 2001 08:55:00 -0600
From: Chris Kennedy <ckennedy@GROOVY.ORG>
To: linux-kernel@vger.kernel.org
Cc: dledford@redhat.com
Subject: 2.2.19pre15 SCSI errors with AIC-7xxx driver
Message-ID: <20010306085500.A25054@GROOVY.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 2.2.19pre15 running on a SMP machine, it is showing
scsi errors which have not caused problems but look very concerning.
I am wondering how bad these are if they are not showing any
noticable problems, we have 2 machines doing this
with the exact same hardware, while 3 others with aic-7xxx
scsi that don't do this at all which are newer.  We also 
ran RedHat version 2.2.16-3 fine for many months, I have
attached a full dmesg of the machine here, and can send
other data like the dmesg's from the machines that show no
errors or anything else.  I am not on the kernel mailing list
so please CC me on all responses.

Machine 1:

Linux version 2.2.19pre15 (root@lewey) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #1 SMP Tue Feb 27 13:48:15 CST 2001
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 0ff00000 @ 00100000 (usable)
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: 440BX        APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 400915 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 257548k/262144k available (1268k kernel code, 424k reserved, 2852k data, 52k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
512K L2 cache (4 way)
CPU: L2 Cache: 512K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
per-CPU timeslice cutoff: 100.09 usecs.
CPU0: Intel Pentium II (Deschutes) stepping 02
calibrating APIC timer ...
..... CPU clock speed is 400.9172 MHz.
..... system bus clock speed is 100.2291 MHz.
Booting processor 1 eip 2000
Calibrating delay loop... 801.17 BogoMIPS
Intel machine check reporting enabled on CPU#1.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
OK.
CPU1: Intel Pentium II (Deschutes) stepping 02
Total of 2 processors activated (1600.71 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
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
 01 000 00  0    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  0    0    0   0   0    1    1    71
 06 000 00  0    0    0   0   0    1    1    79
 07 000 00  0    0    0   0   0    1    1    81
 08 000 00  0    0    0   0   0    1    1    89
 09 000 00  0    0    0   0   0    1    1    91
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    99
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    A1
 0f 000 00  0    0    0   0   0    1    1    A9
 10 0FF 0F  1    1    0   1   0    1    1    B1
 11 0FF 0F  1    1    0   1   0    1    1    B9
 12 000 00  1    0    0   0   0    0    0    00
 13 0FF 0F  1    1    0   1   0    1    1    B9
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
IRQ10 -> 16
IRQ11 -> 17-> 19
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfdb81
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Enabling I/O for device 00:3a
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
early initialization of device sit0 is deferred
Initializing RT netlink socket
Starting kswapd v 1.5
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
Floppy drive(s): fd0 is 1.44M
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
FDC 0 is a post-1991 82077
(scsi0) <Adaptec AIC-7890/1 Ultra2 SCSI host adapter> found at PCI 0/14/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 398 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7890/1 Ultra2 SCSI host adapter>
scsi : 1 host.
  Vendor: QUANTUM   Model: QM39100TD-SW      Rev: N491
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: QUANTUM   Model: QM39100TD-SW      Rev: N491
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
scsi : detected 2 SCSI generics 2 SCSI disks total.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17783250 [8683 MB] [8.7 GB]
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 17783250 [8683 MB] [8.7 GB]
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:90:27:87:86:05, IRQ 11.
  Board assembly 721383-006, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
 sdb: sdb1
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 52k freed
Adding Swap: 128512k swap-space (priority -1)
Adding Swap: 128512k swap-space (priority -2)
eth0: no IPv6 routers present
scsi : aborting command due to timeout : pid 776183, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d5 71 00 00 02 00
scsi : aborting command due to timeout : pid 776184, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d5 79 00 00 0a 00
scsi : aborting command due to timeout : pid 776185, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d5 85 00 00 02 00
scsi : aborting command due to timeout : pid 776186, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d5 c7 00 00 02 00
scsi : aborting command due to timeout : pid 776187, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d5 cb 00 00 02 00
scsi : aborting command due to timeout : pid 776189, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d6 5b 00 00 04 00
scsi : aborting command due to timeout : pid 776214, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d6 6d 00 00 0e 00
scsi : aborting command due to timeout : pid 776215, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a d6 eb 00 00 02 00
scsi : aborting command due to timeout : pid 776216, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e bf 00 00 02 00
scsi : aborting command due to timeout : pid 776217, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e c1 00 00 02 00
scsi : aborting command due to timeout : pid 776218, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e c3 00 00 02 00
scsi : aborting command due to timeout : pid 776219, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e c5 00 00 02 00
scsi : aborting command due to timeout : pid 776220, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e c7 00 00 02 00
scsi : aborting command due to timeout : pid 776221, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e c9 00 00 02 00
scsi : aborting command due to timeout : pid 776222, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e cb 00 00 02 00
scsi : aborting command due to timeout : pid 776223, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 77 5e cd 00 00 02 00
SCSI host 0 abort (pid 776183) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
nmap uses obsolete (PF_INET,SOCK_PACKET)
scsi : aborting command due to timeout : pid 2176452, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a 31 eb 00 00 14 00
scsi : aborting command due to timeout : pid 2176453, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a 41 bd 00 00 02 00
scsi : aborting command due to timeout : pid 2176454, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a 63 9b 00 00 14 00
SCSI host 0 abort (pid 2176452) timed out - resetting
SCSI bus is being reset for host 0 channel 0.

wait_on_bh, CPU 0:
irq:  0 [0 0]
bh:   1 [0 1]
<[c010b961]> <[c019fd04]> <[c019dab7]> <[c01a1ceb]> <[c014ee26]> <[c01a1fb8]> <[c014f0c0]> <[c0163d43]> <6>(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
scsi : aborting command due to timeout : pid 2186021, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 21 02 61 00 00 60 00
(scsi0:0:0:0) SCSISIGI 0xe6, SEQADDR 0x95, SSTAT0 0x2, SSTAT1 0x13
(scsi0:0:0:0) SG_CACHEPTR 0x6, SSTAT2 0x40, STCNT 0xa00
scsi : aborting command due to timeout : pid 2186022, scsi0, channel 0, id 1, lun 0 Write (10) 00 00 20 00 d1 00 00 02 00
SCSI host 0 abort (pid 2186021) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
scsi : aborting command due to timeout : pid 3160071, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 5a 63 0d 00 00 1c 00
(scsi0:0:0:0) SCSISIGI 0xe6, SEQADDR 0x95, SSTAT0 0x2, SSTAT1 0x13
(scsi0:0:0:0) SG_CACHEPTR 0xc, SSTAT2 0x40, STCNT 0xa00
SCSI host 0 abort (pid 3160071) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.


Machine 2: (same dmesg before scsi errors)

scsi : aborting command due to timeout : pid 82857, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 8f 2d 89 00 00 48 00
(scsi0:0:1:0) SCSISIGI 0xe6, SEQADDR 0x95, SSTAT0 0x2, SSTAT1 0x13
(scsi0:0:1:0) SG_CACHEPTR 0x10, SSTAT2 0x40, STCNT 0xa00
scsi : aborting command due to timeout : pid 82858, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 8f 2d d1 00 00 80 00
scsi : aborting command due to timeout : pid 82859, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 8f 2e 51 00 00 80 00
SCSI host 0 abort (pid 82857) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
scsi : aborting command due to timeout : pid 1348962, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 12 2d 00 00 10 00
scsi : aborting command due to timeout : pid 1348974, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 18 3d 00 00 10 00
scsi : aborting command due to timeout : pid 1348975, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 18 cd 00 00 10 00
scsi : aborting command due to timeout : pid 1348977, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 19 4d 00 00 10 00
scsi : aborting command due to timeout : pid 1348984, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 19 fd 00 00 10 00
scsi : aborting command due to timeout : pid 1348985, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 1a 3d 00 00 10 00
scsi : aborting command due to timeout : pid 1348986, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 1a bd 00 00 10 00
scsi : aborting command due to timeout : pid 1348987, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 95 1b 6d 00 00 10 00
scsi : aborting command due to timeout : pid 1348988, scsi0, channel 0, id 0, lun 0 Write (10) 00 00 36 b7 7f 00 00 02 00
SCSI host 0 abort (pid 1348962) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
[valid=0] Info fld=0x0, Current sd08:02: sense key Illegal Request
Additional sense indicates Invalid command operation code
scsidisk I/O error: dev 08:02, sector 3522592
EXT2-fs error (device sd(8,2)): ext2_write_inode: unable to read inode block - inode=440340, block=1761296
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
scsi : aborting command due to timeout : pid 1620074, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 90 9a a5 00 00 80 00
(scsi0:0:1:0) SCSISIGI 0xe6, SEQADDR 0x95, SSTAT0 0x2, SSTAT1 0x13
(scsi0:0:1:0) SG_CACHEPTR 0x8, SSTAT2 0x40, STCNT 0x600
scsi : aborting command due to timeout : pid 1620075, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 90 9b 25 00 00 80 00
SCSI host 0 abort (pid 1620074) timed out - resetting
SCSI bus is being reset for host 0 channel 0.

wait_on_bh, CPU 0:
irq:  0 [0 0]
bh:   1 [0 1]
<[c010b961]> <[c019fef8]> <[c01a2505]> <[c01a1f5e]> <[c01a20dc]> <[c01a2c61]> <[c01087ef]> SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
[valid=0] Info fld=0x0, Current sd08:02: sense key Illegal Request
Additional sense indicates Invalid command operation code
scsidisk I/O error: dev 08:02, sector 227296
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
scsi : aborting command due to timeout : pid 2874567, scsi0, channel 0, id 1, lun 0 Read (10) 00 00 91 aa 71 00 00 38 00
(scsi0:0:1:0) SCSISIGI 0xe6, SEQADDR 0x95, SSTAT0 0x2, SSTAT1 0x13
(scsi0:0:1:0) SG_CACHEPTR 0xc, SSTAT2 0x40, STCNT 0x600
SCSI host 0 abort (pid 2874567) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
[valid=0] Info fld=0x0, Current sd08:02: sense key Illegal Request
Additional sense indicates Invalid command operation code
scsidisk I/O error: dev 08:02, sector 163868
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
(scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec, offset 31.



Thanks,
Chris K  
-- 
Chris Kennedy / ckennedy@groovy.org
I-Land Internet Services / Network Operations Center
     \|/ ____ \|/
     "@'/ .. \`@"   
     /_| \__/ |_\
        \__U_/ -Linux SPARC Kernel Oops
