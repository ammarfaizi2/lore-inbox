Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131150AbQLYQI6>; Mon, 25 Dec 2000 11:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131559AbQLYQIt>; Mon, 25 Dec 2000 11:08:49 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:54492 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131150AbQLYQIj>; Mon, 25 Dec 2000 11:08:39 -0500
Message-ID: <3A4769AC.F38B372C@rcn.com>
Date: Mon, 25 Dec 2000 10:37:16 -0500
From: Marvin Stodolsky <stodolsk@rcn.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.4.0-test12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, mj@suse.cz
CC: Jacques.Goldberg@cern.ch, Mark Spieth <mark@digivation.com.au>,
        Sean Walbran <sean@walbran.org>
Subject: BIOS problem, pro Microsoft, anti other OS
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To Maintainer:
PCI SUBSYSTEM
P:	Martin Mares
M:	mj@suse.cz
L:	linux-kernel@vger.kernel.org
S:	Supported

This alert should probably be forwarded to Others, but appropriate
subTask persons in the kernel-source Maintainers list were not obvious.

Briefly, documented below is the fact/complications that some PC BIOS
chips are now coming with a default Microsoft setting, which makes them
hostile to some functionalities of other OS.  If particular under Linux,
a PCI Winmodem did NOT function with the Win98 BIOS setting, but did
fine  with BIOS choice "Other OS".  Possible, other PCI devices under
Linux OS might be simmilarly afflicated.

This indicates a need for Linux install software to be equipped with a
utility to probe the BIOS and report back "Linux hostile" BIOS
settings.  Today most Newbies are getting new PC boxes equipped with
WinModems.  Hostile BIOS settings will block their capability to get
on-line.  Unfortunately, I do not have the technical capablity to
directly contribute.  Thus please forward this alert to however may be
capable and concerned with dealing with the problem.

MarvS, co-maintainer: http://walbran.org/sean/linux/linmodem-howto.html

===========================================
Subject:  Device or resource busy : SUCCESS !
     Date: Sun, 24 Dec 2000 14:46:04 +0200 (IST)
    From: Jacques Goldberg <goldberg@phep2.technion.ac.il>
 Reply-To:  Jacques Goldberg <Jacques.Goldberg@cern.ch>
       To: discuss@linmodems.org

 Well, my very sincere thanks to all of you. It works.

DETAILS:
I purchased a Gateway Solo 2550 in September, comes with ActionTec PCI
56k
modem (Lucent chip vendor 11c1, device 448).
I tried the 568 ltmodem: device or resource busy,could not guess why.
cat /pro/pci would show no interrupt
Then ltmodem 578  was made available: same problem.
But then the PnP issue at boot came again last week.
I had tried several times to discover the option in my BIOS setup.
This morning I found: in the "advanced" page there is an "Operating
System" option, to be set to "the most frequently used OS". I had left
it
as Win98/2000 (as I received the machine). 
I just selected OTHER.
Lo and behold, ltmodem.o loads without a flaw, I then had a short dumb
terminal session with minicom, and am now connected at my first attempt
with ppp, having already used X11, ssh, and Netscape.

So, again my deepest thanks to all of you on this list, and the bottom
line for newcomers:

 IF (Device.or.resource busy) CHECK YOUR BIOS.

By the way I am running RH-6.1, kernel 2.2.12-20 (CERN "official" Linux
distribution). They are on vacations now, I cannot check at this time if
their version of ppp is "generic" or reworked.

                                Jacques J. Goldberg
                                Jacques.Goldberg@cern.ch
                                >>>> Currently at TECHNION <<<<
                                PHONE: Technion=+(972)(0)(4)829.36.63
                                           CERN=+(41)(22)767.84.72
 -------- Original Message --------
Subject: Crippling BIOSes
Date: Sun, 24 Dec 2000 14:55:36 -0500
From: Marvin Stodolsky <stodolsk@rcn.com>
To: LinModems <discuss@linmodems.org>

Folks,
        Given Jacques report, it would be good to set up a
diagnostic for BIOS which have such Microsoft/Other choices.  
Mine does not.
For those of you who have such BIOSes, please 
1) Do  boots under both choices
2) Under microsoft do:
  dmesg > ms.txt
3) Under other
   dmesg > other.txt
4) diff ms.txt other.txt
and report the differences to the List with the name of the BIOS.
If would clearly be desirable to equip future Linux kernels/software to
give a warning about the crippling microsoft option, 
which may hamper other PCI harware under Linux as well.

MarvS   

-------- Original Message --------
Subject:   Re: dmesg detection??
     Date:   Mon, 25 Dec 2000 09:29:20 +0200 (IST)
    From:    Jacques Goldberg <goldberg@phep2.technion.ac.il>
 Reply-To:   Jacques Goldberg <Jacques.Goldberg@cern.ch>
       To:   Marvin Stodolsky <stodolsk@rcn.com>
      CC:    discuss@linmodem.org

 Gateway Solo 2150
 Phoenix BIOS version 17.50
 BIOS Page "Advanced"
 BIOS Field "Installed O/S" may be "Other" "Win98/Win2000" or "Win95"
 Did not try "Win95"
 Default was Win98/Win2000, dmesg file attached is  ms.txt
 Changed to "Other" , dmesg file atached is  other.txt

 Linux kernel 2.2.12-20
 
 SOUND:
  CONFIG_SOUND set to "m"
  Using OSS driver (ES-1371 not supported by RH-6.1  2.2.12-20
distribution)
  Using PPP version 2.3.10-3

 Everything works fine (ppp sessions with sound) once BIOS O/S choice
set
to OTHER.
 
 I repeat what my problem was:
 -could not load ltmodem : "Device or resource busy"
 -cat /pro/pci did not show IRQ, not even the word IRQ, for Lucent modem
 -setting BIOS to OTHER instantly made everything work.

                                Jacques J. Goldberg
                                Jacques.Goldberg@cern.ch


-------- dmesg > ms.txt (Win98 BIOS setting)------------

Linux version 2.2.12-20 (root@porky.devel.redhat.com) (gcc version
egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Mon Sep 27 10:40:35 EDT 1999
Detected 601381815 Hz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 599.65 BogoMIPS
Memory: 62720k/65472k available (1008k kernel code, 412k reserved, 988k
data, 64k init)
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
Pentium-III serial number disabled.
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfd9be
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.9)
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1050-0x1057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1058-0x105f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK1214GAP, ATA DISK drive
hdc: CRN-8241B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: TOSHIBA MK1214GAP, 11513MB w/0kB Cache, CHS=1559/240/63
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CDROM driver Revision: 2.56
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :  1338.072 MB/sec
   p5_mmx    :  1405.509 MB/sec
   8regs     :  1032.891 MB/sec
   32regs    :   579.120 MB/sec
using fastest function: p5_mmx (1405.509 MB/sec)
scsi : 0 hosts.
scsi : detected total.
md.c: sizeof(mdp_super_t) = 4096
Partition check:
 hda: [PTBL] [1467/255/63] hda1 hda2 < hda5 hda6 hda7 >
RAMDISK: Compressed image found at block 0
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem).
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=1
Trying to unmount old root ... okay
Freeing unused kernel memory: 64k freed
Adding Swap: 200772k swap-space (priority -1)
Linux PCMCIA Card Services 3.0.14
  kernel build: 2.2.12-20 #1 Mon Sep 27 10:40:35 EDT 1999
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: 
  TI 1225 PCI-to-CardBus at bus 0 slot 8, mem 0x68000000, 2 sockets
    host opts [0]: [ring] [pwr save] [serial pci & irq] [no pci irq]
[lat 168/176] [bus 32/34]
    host opts [1]: [ring] [pwr save] [serial pci & irq] [no pci irq]
[lat 168/176] [bus 35/37]
    ISA irqs (scanned) = 4,7,10,11 polling interval = 1000 ms
cs: IO port probe 0x1000-0x17ff: excluding 0x1000-0x10e7 0x1400-0x14ff
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds,
becker@cesdis.gsfc.nasa.gov.
eth0: Megahertz 574B at io 0x300, irq 10, hw_addr 00:50:DA:E4:5F:B9.
  ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect MII interface.
eth0: found link beat
eth0: link partner did not autonegotiate


------------dmesg > other.txt (Other BIOS setting) -----------------

Linux version 2.2.12-20 (root@porky.devel.redhat.com) (gcc version
egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Mon Sep 27 10:40:35 EDT 1999
Detected 601374658 Hz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 599.65 BogoMIPS
Memory: 62720k/65472k available (1008k kernel code, 412k reserved, 988k
data, 64k init)
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
Pentium-III serial number disabled.
CPU: Intel Pentium III (Coppermine) stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfd9be
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Enabling I/O for device 00:3a
PCI: Enabling I/O for device 00:50
PCI: Enabling memory for device 00:50
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.9)
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1050-0x1057, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1058-0x105f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK1214GAP, ATA DISK drive
hdc: CRN-8241B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: TOSHIBA MK1214GAP, 11513MB w/0kB Cache, CHS=1559/240/63
hdc: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CDROM driver Revision: 2.56
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :  1338.072 MB/sec
   p5_mmx    :  1405.509 MB/sec
   8regs     :  1032.891 MB/sec
   32regs    :   578.739 MB/sec
using fastest function: p5_mmx (1405.509 MB/sec)
scsi : 0 hosts.
scsi : detected total.
md.c: sizeof(mdp_super_t) = 4096
Partition check:
 hda: [PTBL] [1467/255/63] hda1 hda2 < hda5 hda6 hda7 >
RAMDISK: Compressed image found at block 0
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem).
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=1
Trying to unmount old root ... okay
Freeing unused kernel memory: 64k freed
Adding Swap: 200772k swap-space (priority -1)
Linux PCMCIA Card Services 3.0.14
  kernel build: 2.2.12-20 #1 Mon Sep 27 10:40:35 EDT 1999
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: 
  TI 1225 PCI-to-CardBus at bus 0 slot 8, mem 0x68000000, 2 sockets
    host opts [0]: [ring] [pwr save] [serial pci & irq] [no pci irq]
[lat 168/176] [bus 32/34]
    host opts [1]: [ring] [pwr save] [serial pci & irq] [no pci irq]
[lat 168/176] [bus 35/37]
    ISA irqs (scanned) = 3,4,7,10,11 polling interval = 1000 ms
cs: IO port probe 0x1000-0x17ff: excluding 0x1000-0x10a7 0x10c0-0x10ff
0x1400-0x14ff
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds,
becker@cesdis.gsfc.nasa.gov.
eth0: Megahertz 574B at io 0x300, irq 10, hw_addr 00:50:DA:E4:5F:B9.
  ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect MII interface.
eth0: found link beat
eth0: link partner did not autonegotiate


----------diff ms.txt other.txt-------------------------------

2c2
< Detected 601381815 Hz processor.
---
> Detected 601374658 Hz processor.
18a19,21
> PCI: Enabling I/O for device 00:3a
> PCI: Enabling I/O for device 00:50
> PCI: Enabling memory for device 00:50
53c56
<    32regs    :   579.120 MB/sec
---
>    32regs    :   578.739 MB/sec
80,81c83,84
<     ISA irqs (scanned) = 4,7,10,11 polling interval = 1000 ms
< cs: IO port probe 0x1000-0x17ff: excluding 0x1000-0x10e7 0x1400-0x14ff
---
>     ISA irqs (scanned) = 3,4,7,10,11 polling interval = 1000 ms
> cs: IO port probe 0x1000-0x17ff: excluding 0x1000-0x10a7 0x10c0-0x10ff 0x1400-0x14ff
===================================================
Unfortunately, there is nothing obvious (at least to me) in the above
diagnostics, that would serve to signal the Linux Hostile, Win98 BIOS
setting.

MarvS
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
