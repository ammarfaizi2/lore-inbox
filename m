Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130649AbQLEN4Q>; Tue, 5 Dec 2000 08:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131017AbQLEN4G>; Tue, 5 Dec 2000 08:56:06 -0500
Received: from mail.sun.ac.za ([146.232.128.1]:38409 "EHLO mail.sun.ac.za")
	by vger.kernel.org with ESMTP id <S130649AbQLENz6>;
	Tue, 5 Dec 2000 08:55:58 -0500
Date: Tue, 5 Dec 2000 15:26:01 +0200 (SAST)
From: Gerhard Esterhuizen <goof@dsp.sun.ac.za>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Machine Check Exception - bluesmoke.c dump in 2.2.17
Message-ID: <Pine.LNX.4.21.0012051500040.4276-100000@pamela.dsp.sun.ac.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I noticed some MCE dumps getting mailed to the list in September. From
Alan Cox's comments I gathered that he was looking for similar dumps [at
least then]. My workstation produced one yesterday and I hope this is
still relevant info. This machine has seen some moderate to heavy use for
a few months now and this is the first time this [MCE] has happened. We
have, however, experienced two spontaneous and unexplained reboots.

I am not subscribed to the list, so send me a personal mail if you require
more information [ I'll check the list regularly though ]. The kernel is
an out-of-the-box 2.2.17. I also note that the other people normally
include register dumps. Mine didn't produce any of that, just the MCE
line.

Thanks,
	gerhard


Here are the details:

    --  from /var/log/messages [and also sprayed all over the terms]

Dec  4 13:33:15 pamela kernel: CPU 0: Machine Check Exception: 0000000400000000<0>Bank 4: b200000000040151general protection fault: 0000 
Dec  4 13:33:15 pamela kernel: CPU:    0

   -- /var/log/dmesg

Linux version 2.2.17 (root@pamela.dsp.sun.ac.za) (gcc version 2.95.2
19991024 (release)) #4 SMP Fri Nov 3 17:47:06 SAST 2000
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 698141 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1392.64 BogoMIPS
Memory: 517128k/524224k available (1176k kernel code, 420k reserved, 5444k
data, 56k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU serial number disabled.
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
per-CPU timeslice cutoff: 49.95 usecs.
CPU0: Intel Pentium III (Coppermine) stepping 03
calibrating APIC timer ...
..... CPU clock speed is 698.1326 MHz.
..... system bus clock speed is 99.7331 MHz.
Booting processor 1 eip 2000
Calibrating delay loop... 1395.92 BogoMIPS
CPU serial number disabled.
Intel machine check reporting enabled on CPU#1.
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2788.56 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
number of MP IRQ sources: 25.
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
 0a 000 00  0    0    0   0   0    1    1    99
 0b 000 00  0    0    0   0   0    1    1    A1
 0c 000 00  0    0    0   0   0    1    1    A9
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    B1
 0f 000 00  0    0    0   0   0    1    1    B9
 10 0FF 0F  1    1    0   1   0    1    1    C1
 11 0FF 0F  1    1    0   1   0    1    1    C9
 12 0FF 0F  1    1    0   1   0    1    1    D1
 13 0FF 0F  1    1    0   1   0    1    1    D9
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
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
checking TSC synchronization across CPUs: passed.
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb150
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B0,I12,P0) -> 16
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
RAM disk driver initialized:  16 RAM disks of 4096K size
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hdd: ATAPI CDROM 52X, ATAPI CDROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdd: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi : 2 hosts.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 31.
  Vendor: SEAGATE   Model: ST318436LW        Rev: 0010
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 35885168 [17522 MB]
[17.5 GB]
rtl8139.c:v1.07 5/6/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/rtl8139.html
eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xd800, IRQ 19,
00:10:b5:54:2a:1c.
Partition check:
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14
sda15 > sda3
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
Adding Swap: 128480k swap-space (priority -1)
Adding Swap: 128480k swap-space (priority -2)
Adding Swap: 128480k swap-space (priority -3)
Adding Swap: 128480k swap-space (priority -4)
Adding Swap: 128480k swap-space (priority -5)
Adding Swap: 128480k swap-space (priority -6)
Adding Swap: 128480k swap-space (priority -7)
Adding Swap: 128480k swap-space (priority -8)
es1371: version v0.22 time 17:50:35 Nov  3 2000
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
es1371: found es1371 rev 8 at io 0xd400 irq 17
es1371: features: joystick 0x0
es1371: codec vendor CRY (0x435259) revision 19 (0x13)
es1371: codec features Headphone out 20bit DAC 18bit ADC
es1371: stereo enhancement: Crystal Semiconductor 3D Stereo Enhancement



-- 



Gerhard Esterhuizen                     

Digital Signal Processing Group
Department of Electrical & Electronic Engineering
University of Stellenbosch
South Africa

Tel.: +27 21 808 4315 
Fax:  +27 21 808 4981
Home: +27 21 887 4962 
mailto:gesterhuizen@bigfoot.com
http://www.flatfoot.co.za/gerhard

"You will never be happy if you continue to search for what happiness
consists of. 
You will never live if you are looking for the
meaning of life."
                    --Albert Camus
                          (1913 - 1960)

"What do you despise? By this are you truly known."
		    --from "Manual of Muad'Dib" by the Princess Irulan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
