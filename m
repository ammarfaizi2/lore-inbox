Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129951AbRBULok>; Wed, 21 Feb 2001 06:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130009AbRBULob>; Wed, 21 Feb 2001 06:44:31 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:58923 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129951AbRBULoV>; Wed, 21 Feb 2001 06:44:21 -0500
Message-ID: <3A939D21.2A04DE01@mindspring.com>
Date: Wed, 21 Feb 2001 03:49:05 -0700
From: Tres Melton <tres@mindspring.com>
X-Mailer: Mozilla 4.51 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Bug Report: System Crash - Memory Subsystem Problem.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To:		Memory management people.
Subject:	System Crash
Stats:		Dual PII 400MHz
		Supermicro P6DBE MoBo
	http://www.supermicro.com/PRODUCT/MotherBoards/440BX/p6dbe.htm
		256MB ECC SDRAM 100MHz FSB
		530136k Swap on SCSI
		31 days uptime
		2.4.0 Kernel SMP stock from www.kernel.org
		Redhat 6.(1 or 2) w/ lots of manual upgrades
		No overclocking or anything that's unstable done.
		Assembled by me April 20, 1999  - Never crashed before.

	I have a single machine that I need to keep up and running so I
haven't been able to track this down, not that it would be an easy one! 
My
system crashed - locked up hard - no BSOD no nothin'!  The system had
been
up for aprox. 30 days with many text terminals, 2 X sessions (with many
desktops each) probably 50 Netscape windows under 4 different users a
couple
of seti@homes and a load of other crap.  The system started totally
thrashing
on the drives. When I started to investigate and found that 0k of swap
was
available, about 4096k of physical, and had about 20M buffered, I can't
remember what the cache was.  It was recovering memory, according to top
(an already running process) and seemed to be recovering when the mouse
quit
responding.

	That was it. No response from the keyboard (I forgot to use the alt
when trying the sysrq key stuff) or the mouse.  I didn't have another
machine
from which to try and SSH in - this has worked when X has crashed
before.

	It is worth noting that the system had run out of RAM twice during
the 30 days and gracefully (I think?) handled it by killing my
girlfriend's
X session.  I don't believe that X is the only thing that crashed since
I
have a script to autodial the Internet when the modem is turned on (it
makes
it easy on my girlfriend) and it neither turned on nor lit the ARQ light
on the external modem (which happens about 1/2 second after it is turned
on).

	Sorry the logs have rotated out the boot messages from the boot that
crashed.  I have included the DMESG and the /var/log/messages of the
current
boot - with the only change being the addition of /dev/hda8 514040k of
swap.
I can include anything else that you may think is relevent.

	This is not a show stopper for me as I crudly worked around it but
we all want Linux to enterprise ready.

Thanks to all for the great OS!!!

Tres Melton
tres@mindspring.com

----->   CURRENT DMESG (After adding /dev/hda8 as swap):

00000 00000000 00000000
OK.
CPU1: Intel Pentium II (Deschutes) stepping 02
CPU has booted.
Before bogomips.
Total of 2 processors activated (1600.71 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-11, 2-15, 2-16, 2-20, 2-21, 2-22, 2-23
not co
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 17.
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
 01 003 03  0    0    0   0   0    1    1    39   
 02 003 03  0    0    0   0   0    1    1    31   
 03 003 03  0    0    0   0   0    1    1    41   
 04 003 03  0    0    0   0   0    1    1    49   
 05 003 03  0    0    0   0   0    1    1    51   
 06 003 03  0    0    0   0   0    1    1    59   
 07 003 03  0    0    0   0   0    1    1    61   
 08 003 03  0    0    0   0   0    1    1    69   
 09 000 00  1    0    0   0   0    0    0    00   
 0a 003 03  0    0    0   0   0    1    1    71   
 0b 000 00  1    0    0   0   0    0    0    00   
 0c 003 03  0    0    0   0   0    1    1    79   
 0d 000 00  1    0    0   0   0    0    0    00   
 0e 003 03  0    0    0   0   0    1    1    81   
 0f 000 00  1    0    0   0   0    0    0    00   
 10 000 00  1    0    0   0   0    0    0    00   
 11 003 03  1    1    0   1   0    1    1    89   
 12 003 03  1    1    0   1   0    1    1    91   
 13 003 03  1    1    0   1   0    1    1    99   
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
IRQ9 -> 19
IRQ10 -> 10
IRQ11 -> 17
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 18
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 400.9350 MHz.
..... host bus clock speed is 100.2336 MHz.
cpu: 0, clocks: 1002336, slice: 334112
CPU0<T0:1002336,T1:668224,D:0,S:334112,C:1002336>
cpu: 1, clocks: 1002336, slice: 334112
CPU1<T0:1002336,T1:334112,D:0,S:334112,C:1002336>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.1 present.
32 structures occupying 990 bytes.
DMI table at 0x000F0770.
BIOS Vendor: American Megatrends Inc.
BIOS Version: 063100
BIOS Release: 01/15/99
System Vendor: To be Filled.
Product Name: To be Filled. 
Version To be Filled.
Serial Number 00000000.
Board Vendor: Supermicro Inc..
Board Name: Intel 440BX/440GX.
Board Version: Rev. 1.
Asset Tag: 000000.
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling). 
loop: enabling 8 loop devices  
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
hda: WDC WD307AA, ATA DISK drive
hdb: GCD-R542B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 60074784 sectors (30758 MB) w/2048KiB Cache, CHS=3739/255/63,
UDMA(33)
hdb: ATAPI 4X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12   
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 hda9 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077   
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 20 18 63 b4 01
eth0: NE2000 found at 0x300, using IRQ 10.
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
SCSI subsystem driver Revision: 1.00  
(scsi0) <Adaptec AHA-294X Ultra SCSI host adapter> found at PCI 0/16/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Cables present (Int-50 NO, Int-68 YES, Ext-68 YES)
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AHA-294X Ultra SCSI host adapter>
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: SEAGATE   Model: ST39173WC         Rev: 6244
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:3:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030 
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IOMEGA    Model: ZIP 100           Rev: J.03
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi removable disk sdb at scsi0, channel 0, id 5, lun 0
SCSI device sda: 17783240 512-byte hdwr sectors (9105 MB)
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sdb : READ CAPACITY failed.
sdb : status = 1, message = 00, host = 0, driver = 28
sdb : extended sense code = 2 
sdb : block size assumed to be 512 bytes, disk size 1GB.
 sdb: I/O error: dev 08:10, sector 0
 unable to read partition table
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: I/O, IRQ, and DMA are mandatory
uart6850: irq and io must be set.  
YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft
1993-1996
es1370: version v0.34 time 19:39:50 Jan 11 2001
es1370: found adapter at io 0xee80 irq 15
es1370: features: joystick off, line in, mic impedance 0
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xef80, IRQ 9
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c14494e0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: ef80
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub  
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c14494e0
usb.c: call_policy add, num 1 -- no FS yet  
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
Adding Swap: 530136k swap-space (priority 2)
Adding Swap: 514040k swap-space (priority 1)
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered




----->   CURRENT /var/log/messages:

Feb 21 09:15:50 ares syslogd 1.3-0: restart.
Feb 21 02:15:50 ares syslog: syslogd startup failed
Feb 21 02:15:50 ares kernel: klogd 1.3-3, log source = /proc/kmsg
started.
Feb 21 02:15:50 ares syslog: klogd startup succeeded
Feb 21 02:15:50 ares kernel: Inspecting /boot/System.map
Feb 21 02:15:50 ares atd: atd startup succeeded
Feb 21 02:15:50 ares kernel: Loaded 16059 symbols from /boot/System.map.
Feb 21 02:15:50 ares kernel: Symbols match kernel version 2.4.0.
Feb 21 02:15:50 ares kernel: No module symbols loaded.
Feb 21 02:15:50 ares kernel: Linux version 2.4.0 (root@ares.tres.org)
(gcc vers
Feb 21 02:15:50 ares kernel: BIOS-provided physical RAM map: 
Feb 21 02:15:50 ares kernel:  BIOS-e820: 000000000009fc00 @
0000000000000000 (u
Feb 21 02:15:50 ares kernel:  BIOS-e820: 0000000000000400 @
000000000009fc00 (r
Feb 21 02:15:50 ares kernel:  BIOS-e820: 0000000000020000 @
00000000000e0000 (r
Feb 21 02:15:50 ares kernel:  BIOS-e820: 000000000ff00000 @
0000000000100000 (u
Feb 21 02:15:50 ares kernel:  BIOS-e820: 0000000000001000 @
00000000fec00000 (r
Feb 21 02:15:50 ares kernel:  BIOS-e820: 0000000000001000 @
00000000fee00000 (r
Feb 21 02:15:50 ares kernel:  BIOS-e820: 0000000000040000 @
00000000fffc0000 (r
Feb 21 02:15:50 ares kernel: Scan SMP from c0000000 for 1024 bytes. 
Feb 21 02:15:50 ares kernel: Scan SMP from c009fc00 for 1024 bytes. 
Feb 21 02:15:50 ares kernel: Scan SMP from c00f0000 for 65536 bytes.
Feb 21 02:15:50 ares kernel: found SMP MP-table at 000fb4f0 
Feb 21 02:15:50 ares kernel: hm, page 000fb000 reserved twice.
Feb 21 02:15:50 ares kernel: hm, page 000fc000 reserved twice.
Feb 21 02:15:50 ares kernel: hm, page 000f2000 reserved twice.
Feb 21 02:15:50 ares kernel: hm, page 000f3000 reserved twice.
Feb 21 02:15:50 ares kernel: On node 0 totalpages: 65536 
Feb 21 02:15:50 ares kernel: zone(0): 4096 pages. 
Feb 21 02:15:50 ares kernel: zone(1): 61440 pages.
Feb 21 02:15:50 ares kernel: zone(2): 0 pages.    
Feb 21 02:15:50 ares kernel: Intel MultiProcessor Specification v1.4
Feb 21 02:15:50 ares kernel:     Virtual Wire compatibility mode.   
Feb 21 02:15:50 ares kernel: OEM ID: INTEL    Product ID: 440BX       
APIC at:
Feb 21 02:15:50 ares kernel: Processor #0 Pentium(tm) Pro APIC version
17 
Feb 21 02:15:50 ares kernel:     Floating point unit present. 
Feb 21 02:15:50 ares kernel:     Machine Exception supported. 
Feb 21 02:15:50 ares kernel:     64 bit compare & exchange supported.
Feb 21 02:15:50 ares kernel:     Internal APIC present. 
Feb 21 02:15:50 ares kernel:     SEP present. 
Feb 21 02:15:50 ares kernel:     MTRR  present.
Feb 21 02:15:50 ares kernel:     PGE  present. 
Feb 21 02:15:50 ares kernel:     MCA  present. 
Feb 21 02:15:50 ares kernel:     CMOV  present.
Feb 21 02:15:50 ares kernel:     PAT  present. 
Feb 21 02:15:50 ares kernel:     PSE  present. 
Feb 21 02:15:50 ares kernel:     MMX  present. 
Feb 21 02:15:50 ares kernel:     FXSR  present.
Feb 21 02:15:50 ares kernel:     Bootup CPU    
Feb 21 02:15:50 ares kernel: Processor #1 Pentium(tm) Pro APIC version
17
Feb 21 02:15:50 ares kernel:     Floating point unit present. 
Feb 21 02:15:50 ares kernel:     Machine Exception supported. 
Feb 21 02:15:50 ares kernel:     64 bit compare & exchange supported.
Feb 21 02:15:50 ares kernel:     Internal APIC present. 
Feb 21 02:15:50 ares kernel:     SEP present. 
Feb 21 02:15:50 ares kernel:     MTRR  present.
Feb 21 02:15:50 ares kernel:     PGE  present. 
Feb 21 02:15:50 ares kernel:     MCA  present. 
Feb 21 02:15:50 ares kernel:     CMOV  present.
Feb 21 02:15:50 ares kernel:     PAT  present. 
Feb 21 02:15:50 ares kernel:     PSE  present. 
Feb 21 02:15:50 ares kernel:     MMX  present. 
Feb 21 02:15:50 ares kernel:     FXSR  present.
Feb 21 02:15:50 ares kernel: Bus #0 is PCI     
Feb 21 02:15:50 ares kernel: Bus #1 is PCI     
Feb 21 02:15:50 ares kernel: Bus #2 is ISA     
Feb 21 02:15:50 ares kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Feb 21 02:15:50 ares kernel: Int: type 3, pol 0, trig 0, bus 2, IRQ 00,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 01,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 00,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 03,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 04,
APIC ID
Feb 21 02:15:51 ares crond: crond startup succeeded
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 05,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 06,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 07,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 08,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0a,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0c,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0d,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 0, trig 0, bus 2, IRQ 0e,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 0b,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 0f,
APIC ID
Feb 21 02:15:50 ares kernel: Int: type 0, pol 3, trig 3, bus 2, IRQ 09,
APIC ID
Feb 20 19:15:43 ares rc.sysinit: Loading default keymap succeeded 
Feb 20 19:15:43 ares rc.sysinit: Setting default font succeeded   
Feb 20 19:15:43 ares rc.sysinit: Activating swap partitions succeeded
Feb 20 19:15:43 ares rc.sysinit: Setting hostname ares.tres.org
succeeded
Feb 20 19:15:43 ares fsck: /dev/sda5: clean, 138712/1050624 files,
3223561/4200
Feb 20 19:15:43 ares rc.sysinit: Checking root filesystem succeeded 
Feb 20 19:15:43 ares rc.sysinit: Remounting root filesystem in
read-write mode
Feb 20 19:15:43 ares rc.sysinit: Finding module dependencies succeeded 
Feb 20 19:15:43 ares fsck: /dev/sda2: clean, 41/26208 files,
13951/104422 block
Feb 20 19:15:43 ares fsck: /dev/sda6: clean, 12788/489472 files,
897494/1951866
Feb 20 19:15:43 ares rc.sysinit: Checking filesystems succeeded 
Feb 20 19:15:43 ares rc.sysinit: Mounting local filesystems succeeded
Feb 20 19:15:43 ares rc.sysinit: Turning on user and group quotas for
local fil
Feb 21 02:15:50 ares kernel: Int: type 2, pol 0, trig 0, bus 2, IRQ 00,
APIC ID
Feb 21 02:15:50 ares kernel: Lint: type 3, pol 0, trig 0, bus 0, IRQ 00,
APIC I
Feb 21 02:15:50 ares kernel: Lint: type 1, pol 0, trig 0, bus 0, IRQ 00,
APIC I
Feb 21 02:15:50 ares kernel: Processors: 2 
Feb 21 02:15:50 ares kernel: mapped APIC to ffffe000 (fee00000)
Feb 21 02:15:50 ares kernel: mapped IOAPIC to ffffd000 (fec00000)
Feb 21 02:15:50 ares kernel: Kernel command line: auto BOOT_IMAGE=x ro
root=805
Feb 21 02:15:50 ares kernel: Initializing CPU#0 
Feb 21 02:15:50 ares kernel: Detected 400.913 MHz processor.
Feb 21 02:15:50 ares kernel: Console: colour VGA+ 80x25 
Feb 21 02:15:50 ares kernel: Calibrating delay loop... 799.53 BogoMIPS
Feb 21 02:15:50 ares kernel: Memory: 254924k/262144k available (1393k
kernel co
Feb 21 02:15:50 ares kernel: Dentry-cache hash table entries: 32768
(order: 6, 
Feb 21 02:15:52 ares inet: inetd startup succeeded
Feb 21 02:15:46 ares date: Wed Feb 21 02:15:46 MST 2001
Feb 21 02:15:46 ares rc.sysinit: Setting clock : Wed Feb 21 02:15:46 MST
2001 s
Feb 21 02:15:46 ares rc.sysinit: Enabling swap space succeeded 
Feb 21 02:15:46 ares init: Entering runlevel: 5 
Feb 21 02:15:49 ares network: Bringing up interface lo succeeded
Feb 21 02:15:49 ares network: Bringing up interface eth0 succeeded
Feb 21 02:15:49 ares portmap: portmap startup succeeded 
Feb 21 02:15:50 ares netfs: Mounting other filesystems succeeded
Feb 21 02:15:50 ares random: Initializing random number generator
succeeded
Feb 21 02:15:50 ares kernel: Buffer-cache hash table entries: 16384
(order: 4,
Feb 21 02:15:50 ares kernel: Page-cache hash table entries: 65536
(order: 6, 26
Feb 21 02:15:50 ares kernel: Inode-cache hash table entries: 16384
(order: 5, 1
Feb 21 02:15:51 ares kernel: CPU: Before vendor init, caps: 0183fbff
00000000 0
Feb 21 02:15:51 ares kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Feb 21 02:15:51 ares kernel: CPU: L2 cache: 512K 
Feb 21 02:15:51 ares kernel: Intel machine check architecture supported.
Feb 21 02:15:51 ares kernel: Intel machine check reporting enabled on
CPU#0.
Feb 21 02:15:51 ares kernel: CPU: After vendor init, caps: 0183fbff
00000000 00
Feb 21 02:15:51 ares kernel: CPU: After generic, caps: 0183fbff 00000000
000000
Feb 21 02:15:51 ares kernel: CPU: Common caps: 0183fbff 00000000
00000000 00000
Feb 21 02:15:51 ares kernel: Checking 'hlt' instruction... OK. 
Feb 21 02:15:51 ares kernel: POSIX conformance testing by UNIFIX
Feb 21 02:15:52 ares inetd[354]: dtalk/tcp: unknown service
Feb 21 02:15:51 ares kernel: mtrr: v1.37 (20001109) Richard Gooch
(rgooch@atnf.
Feb 21 02:15:51 ares kernel: mtrr: detected mtrr type: Intel 
Feb 21 02:15:51 ares kernel: CPU: Before vendor init, caps: 0183fbff
00000000 0
Feb 21 02:15:51 ares kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Feb 21 02:15:51 ares kernel: CPU: L2 cache: 512K 
Feb 21 02:15:51 ares kernel: Intel machine check reporting enabled on
CPU#0.
Feb 21 02:15:51 ares kernel: CPU: After vendor init, caps: 0183fbff
00000000 00
Feb 21 02:15:51 ares kernel: CPU: After generic, caps: 0183fbff 00000000
000000
Feb 21 02:15:51 ares kernel: CPU: Common caps: 0183fbff 00000000
00000000 00000
Feb 21 02:15:51 ares kernel: CPU0: Intel Pentium II (Deschutes) stepping
02    
Feb 21 02:15:51 ares kernel: per-CPU timeslice cutoff: 1464.26 usecs. 
Feb 21 02:15:51 ares kernel: Getting VERSION: 40011 
Feb 21 02:15:51 ares kernel: Getting VERSION: 40011 
Feb 21 02:15:51 ares kernel: Getting ID: 0 
Feb 21 02:15:51 ares kernel: Getting ID: f000000
Feb 21 02:15:52 ares snmpd: snmpd startup succeeded
Feb 21 02:15:51 ares kernel: Getting LVT0: 700 
Feb 21 02:15:51 ares kernel: Getting LVT1: 400 
Feb 21 02:15:51 ares kernel: enabled ExtINT on CPU#0
Feb 21 02:15:51 ares kernel: ESR value before enabling vector: 00000004
Feb 21 02:15:51 ares kernel: ESR value after enabling vector: 00000000 
Feb 21 02:15:51 ares kernel: CPU present map: 3 
Feb 21 02:15:51 ares kernel: Booting processor 1/1 eip 2000
Feb 21 02:15:51 ares kernel: Setting warm reset code and vector.
Feb 21 02:15:51 ares kernel: 1. 
Feb 21 02:15:51 ares kernel: 2. 
Feb 21 02:15:51 ares kernel: 3. 
Feb 21 02:15:51 ares kernel: Asserting INIT.
Feb 21 02:15:51 ares kernel: Waiting for send to finish...
Feb 21 02:15:51 ares kernel: +Deasserting INIT. 
Feb 21 02:15:51 ares kernel: Waiting for send to finish...
Feb 21 02:15:51 ares kernel: +#startup loops: 2. 
Feb 21 02:15:51 ares kernel: Sending STARTUP #1. 
Feb 21 02:15:51 ares kernel: After apic_write.   
Feb 21 02:15:51 ares kernel: Initializing CPU#1  
Feb 21 02:15:51 ares kernel: CPU#1 (phys ID: 1) waiting for CALLOUT
Feb 21 02:15:51 ares kernel: Startup point 1. 
Feb 21 02:15:53 ares named[379]: starting.  named 8.2.2-P3 Wed Jul 19
03:27:47
Feb 21 02:15:53 ares named[379]: hint zone "" (IN) loaded (serial 0)
Feb 21 02:15:53 ares named[379]: Zone "0.0.127.in-addr.arpa" (file
named.local)
Feb 21 02:15:53 ares named[379]: master zone "0.0.127.in-addr.arpa" (IN)
loaded
Feb 21 02:15:53 ares named[379]: listening on [127.0.0.1].53 (lo)
Feb 21 02:15:53 ares named[379]: listening on [209.94.85.70].53 (eth0)
Feb 21 02:15:53 ares named[379]: Forwarding source address is
[0.0.0.0].32768
Feb 21 02:15:51 ares kernel: Waiting for send to finish... 
Feb 21 02:15:51 ares kernel: +Sending STARTUP #2. 
Feb 21 02:15:51 ares kernel: After apic_write.    
Feb 21 02:15:51 ares kernel: Startup point 1.     
Feb 21 02:15:51 ares kernel: Waiting for send to finish...
Feb 21 02:15:51 ares kernel: +After Startup. 
Feb 21 02:15:51 ares kernel: Before Callout 1.
Feb 21 02:15:51 ares kernel: After Callout 1. 
Feb 21 02:15:51 ares kernel: CALLIN, before setup_local_APIC().
Feb 21 02:15:51 ares kernel: masked ExtINT on CPU#1 
Feb 21 02:15:51 ares kernel: ESR value before enabling vector: 00000000
Feb 21 02:15:51 ares kernel: ESR value after enabling vector: 00000000 
Feb 21 02:15:51 ares kernel: Calibrating delay loop... 801.17 BogoMIPS 
Feb 21 02:15:51 ares kernel: Stack at about c15fffbc 
Feb 21 02:15:51 ares kernel: CPU: Before vendor init, caps: 0183fbff
00000000 0
Feb 21 02:15:51 ares kernel: CPU: L1 I cache: 16K, L1 D cache: 16K 
Feb 21 02:15:51 ares kernel: CPU: L2 cache: 512K 
Feb 21 02:15:53 ares named: named startup succeeded
Feb 21 02:15:53 ares named[380]: Ready to answer queries.
Feb 21 02:15:53 ares named[380]: sysquery: sendto([192.112.36.4].53):
Network i
Feb 21 02:15:51 ares kernel: Intel machine check reporting enabled on
CPU#1.   
Feb 21 02:15:51 ares kernel: CPU: After vendor init, caps: 0183fbff
00000000 00
Feb 21 02:15:51 ares kernel: CPU: After generic, caps: 0183fbff 00000000
000000
Feb 21 02:15:51 ares kernel: CPU: Common caps: 0183fbff 00000000
00000000 00000
Feb 21 02:15:51 ares kernel: OK. 
Feb 21 02:15:51 ares kernel: CPU1: Intel Pentium II (Deschutes) stepping
02
Feb 21 02:15:51 ares kernel: CPU has booted. 
Feb 21 02:15:51 ares kernel: Before bogomips.
Feb 21 02:15:51 ares kernel: Total of 2 processors activated (1600.71
BogoMIPS)
Feb 21 02:15:51 ares kernel: Before bogocount - setting activated=1. 
Feb 21 02:15:51 ares kernel: Boot done. 
Feb 21 02:15:51 ares kernel: ENABLING IO-APIC IRQs
Feb 21 02:15:51 ares kernel: ...changing IO-APIC physical APIC ID to 2
... ok.
Feb 21 02:15:51 ares kernel: Synchronizing Arb IDs. 
Feb 21 02:15:54 ares xntpd[393]: xntpd 3-5.93e Wed Apr 14 20:23:29 EDT
1999 (1)
Feb 21 02:15:54 ares xntpd[393]: tickadj = 5, tick = 10000, tvu_maxslew
= 495, 
Feb 21 02:15:54 ares xntpd[393]: precision = 11 usec
Feb 21 02:15:54 ares xntpd[393]: read drift of -135.737 from
/etc/ntp/drift
Feb 21 02:15:55 ares xntpd[393]: sendto(209.94.95.3): Network is
unreachable
Feb 21 02:15:51 ares kernel: ..TIMER: vector=49 pin1=2 pin2=0 
Feb 21 02:15:51 ares kernel: activating NMI Watchdog ... done.
Feb 21 02:15:51 ares kernel: testing the IO APIC.......................
Feb 21 02:15:51 ares kernel:  
Feb 21 02:15:54 ares xntpd: xntpd startup succeeded
Feb 21 02:15:54 ares lpd: lpd startup succeeded
Feb 21 02:15:55 ares nfs: Starting NFS services:  succeeded
Feb 21 02:15:51 ares kernel: .................................... done.
Feb 21 02:15:51 ares kernel: calibrating APIC timer ... 
Feb 21 02:15:51 ares kernel: ..... CPU clock speed is 400.9350 MHz.
Feb 21 02:15:51 ares kernel: ..... host bus clock speed is 100.2336 MHz.
Feb 21 02:15:51 ares kernel: cpu: 0, clocks: 1002336, slice: 334112 
Feb 21 02:15:51 ares kernel:
CPU0<T0:1002336,T1:668224,D:0,S:334112,C:1002336>
Feb 21 02:15:51 ares kernel: cpu: 1, clocks: 1002336, slice: 334112 
Feb 21 02:15:51 ares kernel:
CPU1<T0:1002336,T1:334112,D:0,S:334112,C:1002336>
Feb 21 02:15:51 ares kernel: checking TSC synchronization across CPUs:
passed.
Feb 21 02:15:51 ares kernel: Setting commenced=1, go go go 
Feb 21 02:15:55 ares nfs: rpc.statd startup succeeded
Feb 21 02:15:51 ares kernel: PCI: PCI BIOS revision 2.10 entry at
0xfdb81, last
Feb 21 02:15:51 ares kernel: PCI: Using configuration type 1 
Feb 21 02:15:51 ares kernel: PCI: Probing PCI hardware 
Feb 21 02:15:51 ares kernel: Limiting direct PCI/PCI transfers.
Feb 21 02:15:51 ares kernel: Linux NET4.0 for Linux 2.4 
Feb 21 02:15:51 ares kernel: Based upon Swansea University Computer
Society NET
Feb 21 02:15:51 ares kernel: DMI 2.1 present. 
Feb 21 02:15:51 ares kernel: 32 structures occupying 990 bytes.
Feb 21 02:15:51 ares kernel: DMI table at 0x000F0770. 
Feb 21 02:15:51 ares kernel: BIOS Vendor: American Megatrends Inc.
Feb 21 02:15:51 ares kernel: BIOS Version: 063100 
Feb 21 02:15:51 ares kernel: BIOS Release: 01/15/99
Feb 21 02:15:51 ares kernel: System Vendor: To be Filled.
Feb 21 02:15:51 ares kernel: Product Name: To be Filled. 
Feb 21 02:15:51 ares kernel: Version To be Filled. 
Feb 21 02:15:51 ares kernel: Serial Number 00000000.
Feb 21 02:15:51 ares kernel: Board Vendor: Supermicro Inc..
Feb 21 02:15:56 ares nfs: rpc.rquotad startup succeeded
Feb 21 02:15:51 ares kernel: Board Name: Intel 440BX/440GX.
Feb 21 02:15:51 ares kernel: Board Version: Rev. 1. 
Feb 21 02:15:51 ares kernel: Asset Tag: 000000.     
Feb 21 02:15:51 ares kernel: Starting kswapd v1.8   
Feb 21 02:15:51 ares kernel: parport0: PC-style at 0x378 [PCSPP(,...)]
Feb 21 02:15:51 ares kernel: pty: 256 Unix98 ptys configured 
Feb 21 02:15:51 ares kernel: lp0: using parport0 (polling).  
Feb 21 02:15:51 ares kernel: loop: enabling 8 loop devices   
Feb 21 02:15:51 ares kernel: Uniform Multi-Platform E-IDE driver
Revision: 6.31
Feb 21 02:15:51 ares kernel: ide: Assuming 33MHz system bus speed for
PIO modes
Feb 21 02:15:51 ares kernel: PIIX4: IDE controller on PCI bus 00 dev 39 
Feb 21 02:15:51 ares kernel: PIIX4: chipset revision 1 
Feb 21 02:15:51 ares kernel: PIIX4: not 100% native mode: will probe
irqs later
Feb 21 02:15:51 ares kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS
settings: 
Feb 21 02:15:51 ares kernel: hda: WDC WD307AA, ATA DISK drive 
Feb 21 02:15:56 ares nfs: rpc.mountd startup succeeded
Feb 21 02:15:51 ares kernel: hdb: GCD-R542B, ATAPI CDROM drive
Feb 21 02:15:51 ares kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 21 02:15:51 ares kernel: hda: 60074784 sectors (30758 MB) w/2048KiB
Cache,
Feb 21 02:15:51 ares kernel: hdb: ATAPI 4X CD-ROM drive, 256kB Cache 
Feb 21 02:15:51 ares kernel: Uniform CD-ROM driver Revision: 3.12    
Feb 21 02:15:51 ares kernel: Partition check: 
Feb 21 02:15:51 ares kernel:  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8
hda9 >
Feb 21 02:15:51 ares kernel: Floppy drive(s): fd0 is 1.44M 
Feb 21 02:15:51 ares kernel: FDC 0 is a post-1991 82077    
Feb 21 02:15:51 ares kernel: ne.c:v1.10 9/23/94 Donald Becker
(becker@scyld.com
Feb 21 02:15:51 ares kernel: Last modified Nov 1, 2000 by Paul Gortmaker 
Feb 21 02:15:51 ares kernel: NE*000 ethercard probe at 0x300: 00 20 18
63 b4 01
Feb 21 02:15:51 ares kernel: eth0: NE2000 found at 0x300, using IRQ 10. 
Feb 21 02:15:51 ares kernel: Serial driver version 5.02 (2000-08-09)
with MANY_
Feb 21 02:15:56 ares rpc.nfsd: nfssvc: Function not implemented
Feb 21 02:15:51 ares kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Feb 21 02:15:51 ares kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Feb 21 02:15:51 ares kernel: SCSI subsystem driver Revision: 1.00  
Feb 21 02:15:51 ares kernel: (scsi0) <Adaptec AHA-294X Ultra SCSI host
adapter>
Feb 21 02:15:51 ares kernel: (scsi0) Wide Channel, SCSI ID=7, 16/255
SCBs 
Feb 21 02:15:51 ares kernel: (scsi0) Cables present (Int-50 NO, Int-68
YES, Ext
Feb 21 02:15:51 ares kernel: (scsi0) Downloading sequencer code... 422
instruct
Feb 21 02:15:51 ares kernel: scsi0 : Adaptec AHA274x/284x/294x
(EISA/VLB/PCI-Fa
Feb 21 02:15:51 ares kernel:        <Adaptec AHA-294X Ultra SCSI host
adapter> 
Feb 21 02:15:51 ares kernel: (scsi0:0:0:0) Synchronous at 40.0
Mbyte/sec, offse
Feb 21 02:15:51 ares kernel:   Vendor: SEAGATE   Model:
ST39173WC         Rev: 
Feb 21 02:15:51 ares kernel:   Type:  
Direct-Access                      ANSI 
Feb 21 02:15:56 ares kernel: (scsi0:0:3:0) Synchronous at 10.0
Mbyte/sec, offse
Feb 21 02:15:56 ares nfs: rpc.nfsd startup failed
Feb 21 02:15:56 ares kernel:   Vendor: TOSHIBA   Model: CD-ROM
XM-6201TA  Rev:
Feb 21 02:15:56 ares kernel:   Type:  
CD-ROM                             ANSI
Feb 21 02:15:56 ares kernel:   Vendor: IOMEGA    Model: ZIP
100           Rev:
Feb 21 02:15:56 ares kernel:   Type:  
Direct-Access                      ANSI
Feb 21 02:15:56 ares kernel: Detected scsi disk sda at scsi0, channel 0,
id 0,
Feb 21 02:15:56 ares kernel: Detected scsi removable disk sdb at scsi0,
channel
Feb 21 02:15:56 ares kernel: SCSI device sda: 17783240 512-byte hdwr
sectors (9
Feb 21 02:15:56 ares kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 > 
Feb 21 02:15:56 ares kernel: sdb : READ CAPACITY failed. 
Feb 21 02:15:56 ares kernel: sdb : status = 1, message = 00, host = 0,
driver =
Feb 21 02:15:56 ares kernel: sdb : extended sense code = 2  
Feb 21 02:15:56 ares kernel: sdb : block size assumed to be 512 bytes,
disk siz
Feb 21 02:15:56 ares keytable: Loading keymap: 
Feb 21 02:15:56 ares kernel:  sdb: I/O error: dev 08:10, sector 0
Feb 21 02:15:56 ares kernel:  unable to read partition table 
Feb 21 02:15:56 ares kernel: Detected scsi CD-ROM sr0 at scsi0, channel
0, id 3
Feb 21 02:15:56 ares kernel: Soundblaster audio driver Copyright (C) by
Hannu S
Feb 21 02:15:56 ares kernel: sb: I/O, IRQ, and DMA are mandatory 
Feb 21 02:15:56 ares kernel: uart6850: irq and io must be set.   
Feb 21 02:15:56 ares kernel: YM3812 and OPL-3 driver Copyright (C) by
Hannu Sav
Feb 21 02:15:56 ares kernel: es1370: version v0.34 time 19:39:50 Jan 11
2001   
Feb 21 02:15:56 ares kernel: es1370: found adapter at io 0xee80 irq 15 
Feb 21 02:15:56 ares kernel: es1370: features: joystick off, line in,
mic imped
Feb 21 02:15:56 ares kernel: usb.c: registered new driver hub 
Feb 21 02:15:56 ares kernel: uhci.c: USB UHCI at I/O 0xef80, IRQ 9
Feb 21 02:15:56 ares kernel: uhci.c: detected 2 ports 
Feb 21 02:15:56 ares kernel: usb.c: new USB bus registered, assigned bus
number
Feb 21 02:15:56 ares kernel: Product: USB UHCI-alt Root Hub 
Feb 21 02:15:56 ares kernel: SerialNumber: ef80 
Feb 21 02:15:56 ares kernel: hub.c: USB hub found
Feb 21 02:15:56 ares kernel: hub.c: 2 ports detected
Feb 21 02:15:56 ares kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 21 02:15:56 ares kernel: IP Protocols: ICMP, UDP, TCP 
Feb 21 02:15:56 ares kernel: IP: routing cache hash table of 2048
buckets, 16Kb
Feb 21 02:15:56 ares kernel: TCP: Hash tables configured (established
16384 bin
Feb 21 02:15:56 ares kernel: NET4: Unix domain sockets 1.0/SMP for Linux
NET4.0
Feb 21 02:15:56 ares kernel: VFS: Mounted root (ext2 filesystem)
readonly. 
Feb 21 02:15:56 ares kernel: Freeing unused kernel memory: 200k freed 
Feb 21 02:15:56 ares kernel: Adding Swap: 530136k swap-space (priority
2)
Feb 21 02:15:56 ares kernel: Adding Swap: 514040k swap-space (priority
1)
Feb 21 02:15:59 ares keytable: Loading
/usr/lib/kbd/keymaps/i386/qwerty/us.kmap
Feb 21 02:15:59 ares keytable: Loading system font: 
Feb 21 02:15:59 ares rc: Starting keytable succeeded
Feb 21 02:15:59 ares gpm: gpm startup succeeded
Feb 21 02:16:00 ares httpd: httpd startup succeeded
Feb 21 02:16:00 ares sound: Starting sound configuration:
Feb 21 02:16:00 ares sound: sound
Feb 21 02:16:00 ares sound: 
Feb 21 02:16:00 ares rc: Starting sound succeeded
Feb 21 02:16:01 ares kernel: CSLIP: code copyright 1989 Regents of the
Universi
Feb 21 02:16:01 ares kernel: PPP generic driver version 2.4.1 
Feb 21 02:16:01 ares pppd[532]: pppd 2.3.11 started by root, uid 0
Feb 21 02:16:01 ares PAM_pwdb[530]: (su) session opened for user xfs by
(uid=0)
Feb 21 02:16:01 ares PAM_pwdb[530]: (su) session closed for user xfs
Feb 21 02:16:01 ares xfs: xfs startup succeeded
Feb 21 02:16:01 ares linuxconf: Linuxconf final setup
Feb 21 02:16:01 ares rc: Starting linuxconf succeeded
Feb 21 02:16:02 ares local: Starting Secure Shell 2  
Feb 21 02:16:02 ares local: Qmail
Feb 21 02:16:03 ares local:     2.4
Feb 21 02:16:03 ares local: Using
/lib/modules/2.4.0/kernel/drivers/net/dummy.o
Feb 21 02:16:03 ares kernel: PPP Deflate Compression module registered 
Feb 21 02:16:03 ares local: insmod: a module named slhc already exists 
Feb 21 02:16:03 ares kernel: PPP BSD Compression module registered     
Feb 21 02:16:03 ares local: Using
/lib/modules/2.4.0/kernel/drivers/net/slhc.o
Feb 21 02:16:03 ares local: insmod: a module named ppp_generic already
exists 
Feb 21 02:16:03 ares local: Using
/lib/modules/2.4.0/kernel/drivers/net/ppp_gen
Feb 21 02:16:03 ares local: Using
/lib/modules/2.4.0/kernel/drivers/net/ppp_asy
Feb 21 02:16:03 ares local: Using
/lib/modules/2.4.0/kernel/drivers/net/ppp_def
Feb 21 02:16:03 ares local: Using
/lib/modules/2.4.0/kernel/drivers/net/bsd_com
Feb 21 02:16:03 ares local: hi 2.4
Feb 21 02:16:03 ares rc: Starting local succeeded
Feb 21 02:16:04 ares gdm[604]: gdm_auth_secure_display: Could not unlink
/var/g



Thanx for your time and a kick-ass OS  
Tres
tres@mindspring.com
