Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbRF2IPk>; Fri, 29 Jun 2001 04:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265756AbRF2IPb>; Fri, 29 Jun 2001 04:15:31 -0400
Received: from hermes.netfonds.no ([195.204.10.138]:39997 "EHLO
	hermes.netfonds.no") by vger.kernel.org with ESMTP
	id <S265754AbRF2IPM>; Fri, 29 Jun 2001 04:15:12 -0400
To: linux-kernel@vger.kernel.org
Subject: "Trying to free nonexistent swap-page" error message.
From: Johan Simon Seland <johans@netfonds.no>
Date: 29 Jun 2001 10:15:10 +0200
Message-ID: <la8zibpur5.fsf@glass.netfonds.no>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hello,

I have searched the archives for this error message before, but no one
seems to have given a good answer. (Though the question has been
posted before.) I am not sure if this is a kernel problem, a hardware
problem or a Oracle problem. (Or a combination of them.)

One one of our Linux Oracle servers the following messages has started
to appear : 

Jun 29 07:16:32 blanco kernel: swap_free: Trying to free nonexistent swap-page
Jun 29 07:16:32 blanco kernel: swap_free: Trying to free nonexistent swap-page

They seem to always come in pairs, and usually with about three hours
between them. 

The database had to be restored from backup because of massive table
corruption recently, but these messages also appeared before we had to
restore it. (But we believe they might have caused the corruption.)

I also find some of these:

Jun 29 06:25:01 blanco kernel: EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len %% 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115
Jun 29 06:25:32 blanco kernel: EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len %% 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115

Machine is a 2x933MhZ P3 with 2GB of memory. Kernel version is now
2.2.19, but the same problem appeared with 2.2.18 as well. The
database is in moderate to heavy use 24/7 and with a lot (~ 500 - 3000)
processes during business hours.

The machine has only 128MB of swap, is this to little since it has a
full 2GB of memory?


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=blanco.dmesg
Content-Description: dmesg output from machine

emory: 2009512k/2031616k available (1196k kernel code, 420k reserved, 20416k data, 72k init)
Dentry hash table entries: 262144 (order 9, 2048k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 524288 (order 9, 2048k)
CPU serial number disabled.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
per-CPU timeslice cutoff: 49.99 usecs.
CPU0: Intel Pentium III (Coppermine) stepping 03
calibrating APIC timer ... 
..... CPU clock speed is 935.4725 MHz.
..... system bus clock speed is 133.6387 MHz.
Booting processor 1 eip 2000
Calibrating delay loop... 1867.77 BogoMIPS
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3728.99 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
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
 01 000 00  0    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  0    0    0   0   0    1    1    71
 07 000 00  0    0    0   0   0    1    1    79
 08 000 00  0    0    0   0   0    1    1    81
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    91
 0f 000 00  0    0    0   0   0    1    1    99
 10 0FF 0F  1    1    0   1   0    1    1    A1
 11 0FF 0F  1    1    0   1   0    1    1    A9
 12 0FF 0F  1    1    0   1   0    1    1    B1
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
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfb2d0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P2) -> 18
PCI->APIC IRQ transform: (B0,I12,P0) -> 18
PCI->APIC IRQ transform: (B0,I15,P0) -> 17
PCI->APIC IRQ transform: (B0,I15,P1) -> 18
PCI->APIC IRQ transform: (B0,I17,P0) -> 19
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb000-0xb007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xb008-0xb00f, BIOS settings: hdc:pio, hdd:pio
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
(scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 0/15/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 396 instructions downloaded
(scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 0/15/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 396 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi : 2 hosts.
  Vendor: IBM       Model: DDYS-T09170N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 6, lun 0
(scsi0:0:6:1) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T09170N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdb at scsi0, channel 0, id 10, lun 0
(scsi0:0:10:1) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T09170N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdc at scsi1, channel 0, id 6, lun 0
(scsi1:0:6:1) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T09170N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdd at scsi1, channel 0, id 10, lun 0
(scsi1:0:10:1) Synchronous at 160.0 Mbyte/sec, offset 63.
scsi : detected 4 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7 GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7 GB]
SCSI device sdd: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7 GB]
3c59x.c 18Feb01 Donald Becker and others http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905C Tornado at 0xe800,  00:01:02:df:f9:6a, IRQ 19
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
Partition check:
 sda: sda1 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 >
 sdb: sdb1
 sdc: sdc1
 sdd: sdd1
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 72k freed
Adding Swap: 120452k swap-space (priority -1)
eth0: Initial media type Autonegotiate.
eth0: MII #24 status 782d, link partner capability 41e1, setting full-duplex.
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page
EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len % 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115
EXT2-fs error (device sd(8,10)): ext2_readdir: bad entry in directory #172258: rec_len % 4 != 0 - offset=192, inode=812610409, rec_len=11833, name_len=115
swap_free: Trying to free nonexistent swap-page
swap_free: Trying to free nonexistent swap-page


--=-=-=


The kernel is stock 2.2.19 with the following patch applied:

--- include/linux/tasks.h~	Wed Jan 17 14:45:54 2001
+++ include/linux/tasks.h	Wed Jan 17 14:46:39 2001
@@ -11,7 +11,7 @@
 #define NR_CPUS 1
 #endif
 
-#define NR_TASKS	512	/* On x86 Max about 4000 */
+#define NR_TASKS	4000	/* On x86 Max about 4000 */
 
 #define MAX_TASKS_PER_USER (NR_TASKS/2)
 #define MIN_TASKS_LEFT_FOR_ROOT 4

--
Regards
Johan Seland
Programmer
Net Fonds ASA

--=-=-=--
