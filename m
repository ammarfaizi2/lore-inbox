Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbRCFU1J>; Tue, 6 Mar 2001 15:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129635AbRCFU1C>; Tue, 6 Mar 2001 15:27:02 -0500
Received: from eschelon.gamesquad.net ([216.115.239.45]:38669 "HELO
	eschelon.gamesquad.net") by vger.kernel.org with SMTP
	id <S129602AbRCFU0q>; Tue, 6 Mar 2001 15:26:46 -0500
From: "Vibol Hou" <vhou@khmer.cc>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Cc: <andrewm@uow.edu.au>, <balbir@reflexnet.net>,
        <hahn@coffee.psychology.mcmaster.ca>
Subject: System slowdown on 2.4.2-ac5 (recurring from 2.4.1-ac20 and 2.4.0)
Date: Tue, 6 Mar 2001 12:26:03 -0800
Message-ID: <NDBBKKONDOBLNCIOPCGHAEAEFDAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002A_01C0A638.9C7ED0F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002A_01C0A638.9C7ED0F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

This is a follow up report on a server I run which is now using 2.4.2-ac5.
It was suggested that the problem might be a NIC driver issue, but that
seems unlikely at this point.

You can find my previous posts at the following links to get a better idea
of what I am encountering:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0470.html
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0102.3/0401.html

The problem still persists with the new 2.4.2-ac5 kernel, and I have a
feeling it has to do with the VM subsystem.  The system runs Apache, MySQL,
and Sendmail.  It has ~900MB RAM.  The first lockup in 2.4.2-ac5 occured
right after I transferred a large and busy MySQL DB to the server.  I took
down services before the big transfer, and after the DB was switched over
and sevices turned on, it began receiving the regular ~80 queries/second.
The key_buffer for MySQL is set to 256M, which is shared amongst the MySQL
threads.  Everything ran fine until 5 minutes later at which time the system
started crawling again.  Load was normal ~1's across the board.  I was not
able to get much useful information from this failure as SSH stopped
responding before I could get commands entered.  Getty on the serial console
wasn't responding (sysrq was).  The system was only up for 1 day at the
time.

The second time it occured was a few hours ago, 3 days after the last system
reboot (last failure).  I grabbed all the SysRQ information I could before
restarting the system.  I have that info attached.  It includes memory
readings and process lists before and after killing/terminating processes.
I don't really know how to interpret the information given, so I am hoping
someone can help sift through the information.  There was little I could
retrieve from the SSH shell I was in when the system slowed down.

A note, the serial console does function with SysRQ, so it seems getty is
also affected by the slowdown.

I would appreciate any guidance you can provide on this issue.

Thanks,
Vibol Hou
KhmerConnection

------=_NextPart_000_002A_01C0A638.9C7ED0F0
Content-Type: text/plain;
	name="dmesg.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

LILO Loading linux..............
Linux version 2.4.2-ac5 (root@omega) (gcc version 2.95.2 20000220 =
(Debian GNU/Linux)) #2 SMP Tue Feb 27 01:20:24 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000037f00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000f5810
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
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
Bus #0 is PCI  =20
Bus #1 is PCI  =20
Bus #2 is ISA  =20
I/O APIC #2 Version 17 at 0xFEC00000.
Int: type 3, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 00
Int: type 0, pol 0, trig 0, bus 2, IRQ 01, APIC ID 2, APIC INT 01
Int: type 0, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 02
Int: type 0, pol 0, trig 0, bus 2, IRQ 03, APIC ID 2, APIC INT 03
Int: type 0, pol 0, trig 0, bus 2, IRQ 04, APIC ID 2, APIC INT 04
Int: type 0, pol 0, trig 0, bus 2, IRQ 05, APIC ID 2, APIC INT 05
Int: type 0, pol 0, trig 0, bus 2, IRQ 06, APIC ID 2, APIC INT 06
Int: type 0, pol 0, trig 0, bus 2, IRQ 07, APIC ID 2, APIC INT 07
Int: type 0, pol 0, trig 0, bus 2, IRQ 08, APIC ID 2, APIC INT 08
Int: type 0, pol 0, trig 0, bus 2, IRQ 09, APIC ID 2, APIC INT 09
Int: type 0, pol 0, trig 0, bus 2, IRQ 0c, APIC ID 2, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 2, IRQ 0e, APIC ID 2, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 2, IRQ 0f, APIC ID 2, APIC INT 0f
Int: type 0, pol 3, trig 3, bus 0, IRQ 20, APIC ID 2, APIC INT 11
Int: type 0, pol 3, trig 3, bus 0, IRQ 28, APIC ID 2, APIC INT 12
Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, APIC ID 2, APIC INT 13
Int: type 2, pol 0, trig 0, bus 2, IRQ 00, APIC ID 2, APIC INT 17
Lint: type 3, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 00
Lint: type 1, pol 1, trig 1, bus 0, IRQ 00, APIC ID ff, APIC LINT 01
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D801 =
BOOT_FILE=3D/vmlinuz console=3Dtty0 console=3DttyS0,38400
Initializing CPU#0
Detected 400.918 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 899900k/917504k available (1035k kernel code, 17216k reserved, =
320k data, 192k init, 0k highmem)
Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU0: Intel Pentium II (Deschutes) stepping 02
per-CPU timeslice cutoff: 1464.26 usecs.
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
Startup point 1.
CPU#1 (phys ID: 1) waiting for CALLOUT
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
Calibrating delay loop... 801.17 BogoMIPS
Stack at about c1efdfbc
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor =3D 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium II (Deschutes) stepping 02
CPU has booted.
Before bogomips.
Total of 2 processors activated (1600.71 BogoMIPS).
Before bogocount - setting activated=3D1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
..TIMER: vector=3D49 pin1=3D2 pin2=3D0
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
testing the IO APIC.......................

.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 400.9157 MHz.
..... host bus clock speed is 100.2288 MHz.
cpu: 0, clocks: 1002288, slice: 334096
CPU0<T0:1002288,T1:668192,D:0,S:334096,C:1002288>
cpu: 1, clocks: 1002288, slice: 334096
CPU1<T0:1002288,T1:334096,D:0,S:334096,C:1002288>
checking TSC synchronization across CPUs: passed.
Setting commenced=3D1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3c0, last bus=3D1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I8,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 597898kB/466826kB, 1792 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
keyboard: Timeout - AT keyboard not present?
hdc: CREATIVE CD5230E, ATAPI CD/DVD-ROM drive
keyboard: Timeout - AT keyboard not present?
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Real Time Clock Driver v1.10d
Software Watchdog Timer: 0.05, timer margin: 60 sec
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AHA-294X Ultra2 SCSI host adapter> found at PCI 0/10/0
(scsi0) Wide Channel, SCSI ID=3D7, 32/255 SCBs
(scsi0) Downloading sequencer code... 398 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.3/5.2.0
       <Adaptec AHA-294X Ultra2 SCSI host adapter>
  Vendor: WDIGTL    Model: WDE18300 ULTRA2   Rev: 1.30
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:1:0) Synchronous at 40.0 Mbyte/sec, offset 15.
  Vendor: IBM       Model: DGHS09U           Rev: 0350
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:0:2:0) Synchronous at 40.0 Mbyte/sec, offset 15.
  Vendor: IBM       Model: DGHS09U           Rev: 0350
  Type:   Direct-Access                      ANSI SCSI revision: 03
  Vendor: ECRIX     Model: VXA-1             Rev: 2848
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: bufsize 32768, wrt 30720, max init. buffers 4, s/g segs 16.
Attached scsi tape st0 at scsi0, channel 0, id 5, lun 0
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
(scsi0:0:0:0) Synchronous at 40.0 Mbyte/sec, offset 31.
SCSI device sda: 35761710 512-byte hdwr sectors (18310 MB)
Partition check:
 sda: sda1 sda2 sda3
SCSI device sdb: 17916240 512-byte hdwr sectors (9173 MB)
 sdb: sdb1
SCSI device sdc: 17916240 512-byte hdwr sectors (9173 MB)
 sdc: sdc1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 192k freed
INIT: version 2.78 booting
Loading /etc/kbd/default.kmap.gz
Give root password for maintenance
(or type Control-D for normal startup):=20
Activating swap...
Adding Swap: 1052248k swap-space (priority -1)
Checking root file system...
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sda1: clean, 190430/1001920 files, 1250584/2000084 blocks
Calculating module dependencies... done.
Loading modules: 3c59x 3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and =
others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
eth0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe400,  00:50:04:af:5d:2e, =
IRQ 17
  product code 544a rev 00.12 date 06-05-99
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
eth0: scatter/gather disabled. h/w checksums enabled

Checking all file systems...
Parallelizing fsck version 1.19 (13-Jul-2000)
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/sdc1: clean, 1458/1121664 files, 107733/2239051 blocks
/dev/sdb1: clean, 165801/1121664 files, 1537360/2239051 blocks
/dev/sda3: clean, 40915/1105408 files, 857665/2206929 blocks
Setting kernel variables.
Loading the saved-state of the serial devices...=20
Mounting local filesystems...
/dev/sda3 on /home/vhosts/b type ext2 (rw,errors=3Dremount-ro,usrquota)
/dev/sdb1 on /home/vhosts/a type ext2 (rw,errors=3Dremount-ro,usrquota)
/dev/sdc1 on /www-logs type ext2 (rw,errors=3Dremount-ro)
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces: eth0: using NWAY device table, not 8
done.

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Tue Mar  6 10:17:25 PST 2001

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd klogd.
Starting watchdog daemon: watchdog.
Checking quotas...done.
Turning on quotas.
Starting domain name service: named.
Starting internet superserver: inetd.
Starting MySQL database server: mysqld.
Starting mail transport agent: <zero: /var/spool/mqueue/qfBAA13644> =
<zero: /var/spool/mqueue/qfBAA13671> <zero: =
/var/spool/mqueue/qfKAA15667> <zero: /var/spool/mqueue/qfOAA03779> =
<zero: /var/spool/mqueue/qfXAA06720> <incomplete: =
/var/spool/mqueue/dfBAA13644> <incomplete: /var/spool/mqueue/dfBAA13671> =
<incomplete: /var/spool/mqueue/dfOAA03779> <incomplete: =
/var/spool/mqueue/dfXAA06720> <panic: /var/spool/mqueue/DfBAA05157> =
<panic: /var/spool/mqueue/DfBAA13644> <panic: =
/var/spool/mqueue/DfBAA13671> <panic: /var/spool/mqueue/DfJAA30563> =
<panic: /var/spool/mqueue/DfOAA03779> <panic: =
/var/spool/mqueue/DfXAA06720> sendmail.
Starting network management services: snmpd snmptrapd.
Starting OpenBSD Secure Shell server: sshd.
Starting pop daemon: cucipop.
Starting professional ftp daemon: proftpd.
Starting tuning kernel: systune.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.
Starting web server: apache.
/usr/sbin/apachectl start: httpd started
------=_NextPart_000_002A_01C0A638.9C7ED0F0
Content-Type: text/plain;
	name="sysrq.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sysrq.txt"

SysRq: Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll =
killalL
SysRq: Show Memory
Mem-info:
Free pages:       11156kB (     0kB HighMem)
( Active: 134122, inactive_dirty: 1690, inactive_clean: 661, free: 2789 =
(383 766 1149) )
57*4kB 11*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB =
0*2048kB =3D 844kB)
1582*4kB 378*8kB 0*16kB 4*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB =
0*2048kB =3D 10312kB)
=3D 0kB)
Swap cache: add 59864, delete 57206, find 26653919/26669781
Free swap:       1016064kB
229376 pages of RAM
0 pages of HIGHMEM
4353 reserved pages
182181 pages shared
2658 pages swap cached
0 pages in page table cache
Buffer memory:    32964kB
    CLEAN: 3273 buffers, 13092 kbyte, 0 used (last=3D0), 0 locked, 0 =
protected, 0 dirty
   LOCKED: 22890 buffers, 91560 kbyte, 33 used (last=3D22724), 0 locked, =
0 protected, 0 dirty
    DIRTY: 820 buffers, 3280 kbyte, 39 used (last=3D810), 0 locked, 0 =
protected, 820 dirty
SysRq: Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init      S C1EF9F28  4180     1      0 15438  (NOTLB)       =20
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c013af14>] [<c0108ecb>]=20
keventd   S F7FB2650  6336     2      1        (L-TLB)       3
Call Trace: [<c0122535>] [<c01074a4>]=20
kswapd    S F7FA5FAC  5128     3      1        (L-TLB)       4     2
Call Trace: [<c011473a>] [<c0114664>] [<c0114f82>] [<c012d719>] =
[<c01074a4>]=20
kreclaimd  S 00000286  5456     4      1        (L-TLB)       5     3
Call Trace: [<c0114f12>] [<c012d7cb>] [<c01074a4>]=20
bdflush   S F7FA0000  5196     5      1        (L-TLB)       6     4
Call Trace: [<c011b1fc>] [<c01373ae>] [<c01074a4>]=20
kupdate   S F7F9FFC8  5044     6      1        (L-TLB)     142     5
Call Trace: [<c011473a>] [<c0114664>] [<c0137444>] [<c01074a4>]=20
syslogd   R 7FFFFFFF  3952   142      1        (NOTLB)     144     6
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>]=20
klogd     R 0000000B  5200   144      1        (L-TLB)     148   142
Call Trace: [<c0108d90>] [<c0113bf8>] [<c01fde52>] [<c01527b5>] =
[<c01330a3>] [<c0108ffc>] [<c0108f1c>]=20
       [<c011473a>] [<c011473a>]=20
watchdog  S CE7D9F88  5040   148      1        (NOTLB)     161   144
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>] =
[<c010002b>]=20
named     S CBE25F28  4656   161      1        (NOTLB)     166   148
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
inetd     S 7FFFFFFF  3108   166      1        (NOTLB)     253   161
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>]=20
snmpd     S 7FFFFFFF  5028   253      1        (NOTLB)     255   166
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>]=20
snmptrapd  S 7FFFFFFF  5892   255      1        (NOTLB)     262   253
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>]=20
sshd      S 7FFFFFFF  3936   262      1 15630  (NOTLB)     265   255
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>]=20
cucipop   S 7FFFFFFF  4880   265      1 15688  (NOTLB)     270   262
Call Trace: [<c01146d7>] [<c01fb826>] [<c01dcf32>] [<c01dd06d>] =
[<c0123f2a>] [<c01f2d78>] [<c01c4ba6>]=20
       [<c0113d3c>] [<c0113bf8>] [<c013d81d>] [<c013e230>] [<c0145a09>] =
[<c01c55cc>] [<c0108ecb>] [<c010002b>]=20
proftpd   S CB125F28  5220   270      1        (NOTLB)     321   265
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
atd       S CB0E3F88     0   321      1        (NOTLB)     324   270
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
cron      S CB0C7F88  2432   324      1  1238  (NOTLB)     337   321
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
xdm       S 7FFFFFFF  5804   337      1        (NOTLB)     338   324
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>]=20
getty     S 7FFFFFFF  5016   338      1        (NOTLB)     340   337
Call Trace: [<c01146d7>] [<c01703a0>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
getty     S 7FFFFFFF  2432   340      1        (NOTLB)     341   338
Call Trace: [<c01146d7>] [<c01703a0>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
getty     S 7FFFFFFF    12   341      1        (NOTLB)     342   340
Call Trace: [<c01146d7>] [<c01703a0>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
getty     S 7FFFFFFF     0   342      1        (NOTLB)     343   341
Call Trace: [<c01146d7>] [<c01703a0>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
getty     S 7FFFFFFF     0   343      1        (NOTLB)     344   342
Call Trace: [<c01146d7>] [<c01703a0>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
getty     S 7FFFFFFF  2436   344      1        (NOTLB)     345   343
Call Trace: [<c01146d7>] [<c01703a0>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
getty     S 7FFFFFFF  5240   345      1        (NOTLB)     713   344
Call Trace: [<c017d0bf>] [<c01146d7>] [<c011b0f1>] [<c016fe3e>] =
[<c016bd2a>] [<c0133076>] [<c0108ecb>]=20
screen    S 7FFFFFFF     0   713      1  5334  (NOTLB)   14147   345
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>] =
[<c010002b>]=20
bash      S 00000000     0   714    713   724  (NOTLB)    3824
Call Trace: [<c011a215>] [<c0108ecb>]=20
bash      S 7FFFFFFF     0   724    714        (NOTLB)       =20
Call Trace: [<c01146d7>] [<c0108dab>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
bash      S 00000000     0  3824    713  4552  (NOTLB)    5334   714
Call Trace: [<c011a215>] [<c0108ecb>]=20
safe_mysqld  S 00000000     0 14147      1 14160  (NOTLB)    1684   713
Call Trace: [<c011a215>] [<c0108ecb>]=20
mysqld    S 7FFFFFFF     8 14160  14147 14162  (NOTLB)       =20
Call Trace: [<c01146d7>] [<c014276e>] [<c0142b12>] [<c0108ecb>]=20
mysqld    S E4CF1F30     0 14162  14160 15709  (NOTLB)       =20
Call Trace: [<c013cf26>] [<c011473a>] [<c0114664>] [<c0142d8f>] =
[<c0142f83>] [<c0108ecb>]=20
mysqld    S CBEC3FB0     4 14163  14162        (NOTLB)   15462
Call Trace: [<c0108092>] [<c0108ecb>]=20
bash      S 7FFFFFFF     4  4552   3824        (NOTLB)       =20
Call Trace: [<c01146d7>] [<c016fe3e>] [<c016bd2a>] [<c0133076>] =
[<c0108ecb>]=20
bash      S 00000000     0  5334    713  5390  (NOTLB)          3824
Call Trace: [<c011a215>] [<c0108ecb>]=20
bash      S 7FFFFFFF     0  5390   5334        (NOTLB)       =20
Call Trace: [<c01146d7>] [<c0108dab>] [<c016fe3e>] [<c016bd2a>] =
[<c0133076>] [<c0108ecb>]=20
httpd     S C46DFF28     0  1684      1 15576  (NOTLB)   15606 14147
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>] [<c010002b>]=20
cron      S DDD52000     0 13434    324 13644  (NOTLB)   13413
Call Trace: [<c0113bf8>] [<c013c9bd>] [<c013caaa>] [<c0133076>] =
[<c0108ecb>]=20
sh        S 00000000     0 13438  13434 13439  (NOTLB)   13644
Call Trace: [<c011a215>] [<c0108ecb>]=20
run-parts  S 7FFFFFFF  1116 13439  13438 14121  (NOTLB)       =20
Call Trace: [<c01146d7>] [<c01425dc>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
sendmail  S E9F6A000     0 13644  13434        (NOTLB)         13438
Call Trace: [<c013c9bd>] [<c013caaa>] [<c0133076>] [<c0108ecb>]=20
suidmanager  Z EE630BE0  4284 14121  13439        (L-TLB)       =20
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
eggdrop   S D685DF28     0 15606      1        (NOTLB)   20157  1684
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c010a716>] [<c0108ecb>] [<c010002b>]=20
cron      S E16CE000  1956 13413    324 13671  (NOTLB)    1238 13434
Call Trace: [<c0113bf8>] [<c013c9bd>] [<c013caaa>] [<c0133076>] =
[<c0108ecb>]=20
sh        S 00000000     0 13417  13413 13418  (NOTLB)   13671
Call Trace: [<c011a215>] [<c0108ecb>]=20
run-parts  S 7FFFFFFF     0 13418  13417 13730  (NOTLB)       =20
Call Trace: [<c01146d7>] [<c01425dc>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
sendmail  S CC586000     0 13671  13413        (NOTLB)         13417
Call Trace: [<c013c9bd>] [<c013caaa>] [<c0133076>] [<c0108ecb>]=20
sendmail  Z CCA78EA0  1096 13730  13418        (L-TLB)       =20
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
sendmail  S E90A1F28     0 20157      1 15665  (NOTLB)   15438 15606
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
cron      S C466A000   180  1238    324  1241  (NOTLB)         13413
Call Trace: [<c012597f>] [<c013c9bd>] [<c013caaa>] [<c0133076>] =
[<c0108ecb>]=20
sh        S 00000000  2432  1241   1238  1244  (NOTLB)       =20
Call Trace: [<c011a215>] [<c0108ecb>]=20
run-parts  S 7FFFFFFF     0  1244   1241  1260  (NOTLB)       =20
Call Trace: [<c01146d7>] [<c01425dc>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
find      Z F4845160     0  1260   1244        (L-TLB)       =20
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     4  2107   1684        (NOTLB)    6012
Call Trace: [<c01146d7>] [<c0163c72>] [<c01d992d>] [<c01db1ad>] =
[<c01262cb>] [<c012c123>] [<c01f2fa6>]=20
       [<c01c3f55>] [<c01c417e>] [<c013313b>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     0  6012   1684        (NOTLB)   10258  2107
Call Trace: [<c01146d7>] [<c012b2b0>] [<c01d992d>] [<c01db1ad>] =
[<c0113bf8>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c0133435>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     0 10258   1684        (NOTLB)   12719  6012
Call Trace: [<c01146d7>] [<c01d992d>] [<c01db1ad>] [<c01f2fa6>] =
[<c01c3f55>] [<c01c417e>] [<c013313b>]=20
       [<c0108ecb>]=20
httpd     S 7FFFFFFF     0 12719   1684        (NOTLB)   13308 10258
Call Trace: [<c012dfe0>] [<c01146d7>] [<c012b21a>] [<c01d992d>] =
[<c01db1ad>] [<c0113bf8>] [<c01f2fa6>]=20
       [<c01c3f55>] [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c0133435>] =
[<c0108ecb>] [<c010002b>]=20
httpd     Z CCA78420     0 13308   1684        (L-TLB)   13578 12719
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     8 13578   1684        (NOTLB)   13824 13308
Call Trace: [<c01146d7>] [<c0108ffc>] [<c01d992d>] [<c01db1ad>] =
[<c01e3dca>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c010e42f>] [<c0133435>] =
[<c0108ecb>] [<c010002b>]=20
httpd     S E1699F28     0 13824   1684        (NOTLB)   13936 13578
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>] [<c010002b>]=20
httpd     S 7FFFFFFF     0 13936   1684        (NOTLB)   13955 13824
Call Trace: [<c01146d7>] [<c01c6db7>] [<c01fb826>] [<c01db8f6>] =
[<c01dbe70>] [<c01f2f55>] [<c01c3fb1>]=20
       [<c01c40be>] [<c0133076>] [<c0108ecb>] [<c010002b>]=20
httpd     Z ED9AC760     4 13955   1684        (L-TLB)   14022 13936
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     S 7FFFFFFF     0 14022   1684        (NOTLB)   14173 13955
Call Trace: [<c01146d7>] [<c012b21a>] [<c01d992d>] [<c01db1ad>] =
[<c0113bf8>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c010a716>] [<c010a736>] =
[<c0133435>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     0 14173   1684        (NOTLB)   14306 14022
Call Trace: [<c01146d7>] [<c0108ffc>] [<c01d992d>] [<c01db1ad>] =
[<c01f2fa6>] [<c01c3f55>] [<c01c417e>]=20
       [<c013313b>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     4 14306   1684        (NOTLB)   14423 14173
Call Trace: [<c01146d7>] [<c0108ffc>] [<c01d992d>] [<c01db1ad>] =
[<c01c438d>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c417e>] [<c013313b>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     0 14423   1684        (NOTLB)   14427 14306
Call Trace: [<c012dfe0>] [<c01146d7>] [<c012b21a>] [<c01d992d>] =
[<c01db1ad>] [<c01258ac>] [<c01273b8>]=20
       [<c01f2fa6>] [<c01c3f55>] [<c01c438d>] [<c01c440b>] [<c01332d3>] =
[<c011e38c>] [<c0133435>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     4 14427   1684        (NOTLB)   14487 14423
Call Trace: [<c01146d7>] [<c01c6db7>] [<c01fb826>] [<c01db8f6>] =
[<c01dbe70>] [<c01f2f55>] [<c01c3fb1>]=20
       [<c01c40be>] [<c0133076>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     8 14487   1684        (NOTLB)   14498 14427
Call Trace: [<c01146d7>] [<c012b21a>] [<c01d992d>] [<c01db1ad>] =
[<c01f2fa6>] [<c01c3f55>] [<c01c438d>]=20
       [<c01c440b>] [<c01332d3>] [<c010e42f>] [<c0133435>] [<c0108ecb>]=20
httpd     S EF289F88     4 14498   1684        (NOTLB)   14561 14487
Call Trace: [<c01c40be>] [<c011473a>] [<c0114664>] [<c011e958>] =
[<c0108ecb>]=20
httpd     S 7FFFFFFF     8 14561   1684        (NOTLB)   14587 14498
Call Trace: [<c01146d7>] [<c0108f8c>] [<c01d992d>] [<c01db1ad>] =
[<c01c438d>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c417e>] [<c013313b>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     0 14587   1684        (NOTLB)   14642 14561
Call Trace: [<c01146d7>] [<c01e8a2b>] [<c01fb826>] [<c01db8f6>] =
[<c01dbe70>] [<c01f2f55>] [<c01c3fb1>]=20
       [<c01c40be>] [<c0133076>] [<c0108ecb>] [<c010002b>]=20
httpd     S 7FFFFFFF     0 14642   1684 15620  (NOTLB)   14679 14587
Call Trace: [<c012dfc3>] [<c01146d7>] [<c012b21a>] [<c01d992d>] =
[<c01db1ad>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c417e>] [<c013313b>] [<c0108ecb>]=20
httpd     S F3E4DF28   108 14679   1684        (NOTLB)   14703 14642
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
httpd     Z CCA78260     0 14703   1684        (L-TLB)   14715 14679
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     S C2959F28     0 14715   1684        (NOTLB)   14723 14703
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
httpd     S 7FFFFFFF     0 14723   1684        (NOTLB)   14745 14715
Call Trace: [<c01146d7>] [<c012b21a>] [<c01d992d>] [<c01db1ad>] =
[<c0113bf8>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c0133435>] [<c0108ecb>]=20
sendmail  S 7FFFFFFF  1008 14743  20157        (NOTLB)   15665
Call Trace: [<c01146d7>] [<c01e81e3>] [<c01f2a7e>] [<c01f2c5b>] =
[<c01c4c97>] [<c01c3cc5>] [<c01c4910>]=20
       [<c01c55a4>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     0 14745   1684        (NOTLB)   14761 14723
Call Trace: [<c01146d7>] [<c01e3dca>] [<c01d992d>] [<c01db1ad>] =
[<c0113bf8>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c0132c77>] [<c0133435>] =
[<c0108ecb>] [<c010002b>]=20
httpd     S 7FFFFFFF     4 14761   1684        (NOTLB)   14766 14745
Call Trace: [<c01146d7>] [<c0108ffc>] [<c01d992d>] [<c01db1ad>] =
[<c01c438d>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c417e>] [<c013313b>] [<c0108ecb>] [<c010002b>]=20
httpd     Z F4845820  2432 14766   1684        (L-TLB)   14813 14761
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     S 7FFFFFFF     4 14813   1684        (NOTLB)   14817 14766
Call Trace: [<c01146d7>] [<c0108ffc>] [<c01d992d>] [<c01db1ad>] =
[<c01e9907>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c417e>] [<c013313b>] [<c0108ecb>] [<c010002b>]=20
httpd     S 7FFFFFFF     0 14817   1684        (NOTLB)   14838 14813
Call Trace: [<c01146d7>] [<c01d992d>] [<c01db1ad>] [<c0113bf8>] =
[<c01f2fa6>] [<c01c3f55>] [<c01c438d>]=20
       [<c01c440b>] [<c01332d3>] [<c0133435>] [<c0108ecb>]=20
httpd     S DF1C1F28     0 14838   1684        (NOTLB)   14850 14817
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
httpd     S F1C57F28     0 14850   1684        (NOTLB)   14853 14838
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>] [<c010002b>]=20
httpd     S 7FFFFFFF     0 14853   1684        (NOTLB)   14855 14850
Call Trace: [<c01146d7>] [<c0108ffc>] [<c01d992d>] [<c01db1ad>] =
[<c01f2fa6>] [<c01c3f55>] [<c01c438d>]=20
       [<c01c440b>] [<c01332d3>] [<c010e42f>] [<c0133435>] [<c0108ecb>]=20
httpd     Z F7A7F160  1408 14855   1684        (L-TLB)   14870 14853
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     S C9979F28     4 14870   1684        (NOTLB)   14881 14855
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
httpd     Z ED9AC3E0  2432 14881   1684        (L-TLB)   14908 14870
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     S 7FFFFFFF   488 14908   1684        (NOTLB)   14915 14881
Call Trace: [<c01146d7>] [<c01e3dca>] [<c01d992d>] [<c01db1ad>] =
[<c0113bf8>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c0133cf1>] [<c0132c77>] =
[<c0133435>] [<c0108ecb>] [<c010002b>]=20
httpd     S C2AA7F28     0 14915   1684        (NOTLB)   14957 14908
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
httpd     Z F4845CE0     0 14957   1684        (L-TLB)   14959 14915
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     Z C98B7AA0     0 14959   1684        (L-TLB)   14974 14957
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     S DBA99F28   180 14974   1684        (NOTLB)   14976 14959
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
httpd     S 7FFFFFFF   212 14976   1684        (NOTLB)   14980 14974
Call Trace: [<c01146d7>] [<c01c6db7>] [<c01fb826>] [<c01db8f6>] =
[<c01dbe70>] [<c01f2f55>] [<c01c3fb1>]=20
       [<c01c40be>] [<c0133076>] [<c0108ecb>]=20
httpd     S C8EE3F28     0 14980   1684        (NOTLB)   14989 14976
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>] [<c010002b>]=20
httpd     Z F7A7F1E0     4 14989   1684        (L-TLB)   15024 14980
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     S 7FFFFFFF   320 15024   1684        (NOTLB)   15045 14989
Call Trace: [<c012dfc3>] [<c01146d7>] [<c012b21a>] [<c01d992d>] =
[<c01db1ad>] [<c0113bf8>] [<c01f2fa6>]=20
       [<c01c3f55>] [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c0133435>] =
[<c0108ecb>] [<c010002b>]=20
httpd     S CF4F1F28     0 15045   1684        (NOTLB)   15055 15024
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>] [<c010002b>]=20
httpd     S 7FFFFFFF     0 15055   1684        (NOTLB)   15058 15045
Call Trace: [<c01146d7>] [<c0108ffc>] [<c01d992d>] [<c01db1ad>] =
[<c01f2fa6>] [<c01c3f55>] [<c01c438d>]=20
       [<c01c440b>] [<c01332d3>] [<c010e42f>] [<c0133435>] [<c0108ecb>]=20
httpd     S 7FFFFFFF  3700 15058   1684        (NOTLB)   15061 15055
Call Trace: [<IN MWaI tcWahtdochg do[] <ce01ted9c9t2edd> L] OC[K<UPc0 =
o1ndb 1CPadU0>],  re[<gic0st1e1r3bsf:
8>] C[<c<c001f1f2f2afa66>>]]  [ <  c0 01c013f05:[5<>]c 010[<7ec0411>c4]3
8d>EF] LA
GS:  0  00  00 0 8[7
<c0 eac0x:2 8ac042208a[>]<c 0 13 e32bxd3: >]ce 8[4a<c00010 26  e6ec0>x:] =
 f7[<94ce0013803 43  5>ed]x : [0<0c00010008e00c
b>] e
i:dht  tp  d   0 0     Se dDi:7 A4ce3F8428a0 00       0eb 1p:5 0c601 28 =
a 412680 4    es  p:    ce8 (4NbeOTfLc
B) ds: 0018   es: 0018   ss: 0018
  15066Process klogd (pid: 144, stackpage=3Dce84b000) 15058

Stack: Call Trace: c01fe062 [<c011473a>] f7a7fda0 [<c0114664>] ce84a000 =
[<c014276e>] 0000000b [<c0142b12>] ce84bfc4 [<c0108ecb>] c0119e52=20
0000000b httpd     0000000b S
        E7BDDF28 ce84a000   324 15066   1684 c0108d90 15602 0000000b  =
(NOTLB) ce84a000   1507600000004  15061
c0113bf8 Call Trace: bffffcc0 [<c011473a>] ce84bf40 [<c0114664>]=20
       [<c014276e>] ce84a640 [<c0142b12>] 0000000b [<c0108ecb>] 00000000 =

00030001 httpd     00000004 Z00000018  ED9ACCE0 00000018  4516 15076   =
1684 00000000      =20
 (L-TLB) Call Trace:   15082[<c01fe062>]  15066
[<c0119e52>] Call Trace: [<c0108d90>] [<c0119b01>] [<c0113bf8>] =
[<c0119e57>] [<c01fde52>] [<c0119e8a>] [<c01527b5>] [<c0108ecb>] =
[<c01330a3>]=20

       httpd     [<c0108ffc>] S[<c0108f1c>]  E57C5F28 [<c011473a>]     0 =
15082   1684 [<c011473a>]      =20
 (NOTLB)=20
Code:   1509875  15076
f8 Call Trace: f0 [<c011473a>] 81 [<c0114664>] 28 [<c014276e>] 00 =
[<c0142b12>] 00 [<c0108ecb>] 00 [<c010002b>] 01=20
75 httpd     e8 Sc3  7FFFFFFF 8d  1408 15098   1684 76       00  (NOTLB) =
f0   15103ff  15082
00 Call Trace: 83 [<c01146d7>] 38 [<c012b21a>]=20
[<c01d992d>] console shuts up ...
SysRq: Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll =
killalL
SysRq: Log level set to 8
SysRq: Show Regs

EIP: 0010:[<c01eb08f>] CPU: 1 EFLAGS: 00000206
EAX: f7c26ac0 EBX: c96cd420 ECX: f7c26ac0 EDX: 00000000
ESI: c02a2ba0 EDI: 20cf950b EBP: c02d17c4 DS: 0018 ES: 0018
CR0: 8005003b CR2: bfffd8d8 CR3: 23bba000 CR4: 00000290
Call Trace: [<c01eb7ea>] [<c011af5b>] [<c011ae7c>] [<c010a755>] =
[<c0108f8c>]=20
SysRq: Terminate All Tasks
ucd-snmp[253]: Received TERM or STOP signal...  shutting down...

snmptrapd[255]: Stopping snmptrapd
SysRq: Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init      S C1EF9F28  4180     1      0 15744  (NOTLB)       =20
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c013af14>] [<c0108ecb>]=20
keventd   S F7FB2650  6336     2      1        (L-TLB)       3
Call Trace: [<c0122535>] [<c01074a4>]=20
kswapd    S F7FA5FAC  5128     3      1        (L-TLB)       4     2
Call Trace: [<c011473a>] [<c0114664>] [<c0114f82>] [<c012d719>] =
[<c01074a4>]=20
kreclaimd  S 00000286  5456     4      1        (L-TLB)       5     3
Call Trace: [<c0114f12>] [<c012d7cb>] [<c01074a4>]=20
bdflush   S F7FA0000  5196     5      1        (L-TLB)       6     4
Call Trace: [<c011b1fc>] [<c01373ae>] [<c01074a4>]=20
kupdate   S F7F9FFC8  5044     6      1        (L-TLB)     148     5
Call Trace: [<c011473a>] [<c0114664>] [<c0137444>] [<c01074a4>]=20
watchdog  S CE7D9F88  5040   148      1        (NOTLB)    1684     6
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
mysqld    S E34AFFB0     8 14160      1 14162  (NOTLB)   15738 15606
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E4CF1F30     0 14162  14160 15737  (NOTLB)       =20
Call Trace: [<c013cf26>] [<c011473a>] [<c0114664>] [<c0142d8f>] =
[<c0142f83>] [<c0108ecb>]=20
mysqld    S CBEC3FB0     4 14163  14162        (NOTLB)   15574
Call Trace: [<c0108092>] [<c0108ecb>]=20
httpd     S C46DFF28     0  1684      1 15736  (NOTLB)   15606   148
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
eggdrop   S D685DF28     0 15606      1        (NOTLB)   14160  1684
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
httpd     Z ED9AC7E0     4  2107   1684        (L-TLB)    6012
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F4845A20     0  6012   1684        (L-TLB)   10258  2107
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACB20     0 10258   1684        (L-TLB)   12719  6012
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACA20     0 12719   1684        (L-TLB)   13308 10258
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78420     0 13308   1684        (L-TLB)   13578 12719
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z EE6309A0     8 13578   1684        (L-TLB)   13824 13308
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB1E0     0 13824   1684        (L-TLB)   13936 13578
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F4845460     0 13936   1684        (L-TLB)   13955 13824
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC760     4 13955   1684        (L-TLB)   14022 13936
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     Z ED9AC220     0 14022   1684        (L-TLB)   14173 13955
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB360     0 14173   1684        (L-TLB)   14306 14022
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B79E0     4 14306   1684        (L-TLB)   14423 14173
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA789A0     0 14423   1684        (L-TLB)   14427 14306
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACDA0     4 14427   1684        (L-TLB)   14487 14423
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F7A0     8 14487   1684        (L-TLB)   14498 14427
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7560     4 14498   1684        (L-TLB)   14561 14487
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B76E0     8 14561   1684        (L-TLB)   14587 14498
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78BA0     0 14587   1684        (L-TLB)   14642 14561
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B75A0     0 14642   1684        (L-TLB)   14679 14587
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFBEA0   108 14679   1684        (L-TLB)   14703 14642
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78260     0 14703   1684        (L-TLB)   14715 14679
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     Z C98B78A0     0 14715   1684        (L-TLB)   14723 14703
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B72A0     0 14723   1684        (L-TLB)   14745 14715
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB2A0     0 14745   1684        (L-TLB)   14761 14723
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F4845720     4 14761   1684        (L-TLB)   14766 14745
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F4845820  2432 14766   1684        (L-TLB)   14813 14761
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     Z CAD87720     4 14813   1684        (L-TLB)   14817 14766
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7EA0     0 14817   1684        (L-TLB)   14838 14813
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA788E0     0 14838   1684        (L-TLB)   14850 14817
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F220     0 14850   1684        (L-TLB)   14853 14838
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F48459A0     0 14853   1684        (L-TLB)   14855 14850
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F160  1408 14855   1684        (L-TLB)   14870 14853
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7B20     4 14870   1684        (L-TLB)   14881 14855
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC3E0  2432 14881   1684        (L-TLB)   14908 14870
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     Z CCA789E0   488 14908   1684        (L-TLB)   14915 14881
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z EE630560     0 14915   1684        (L-TLB)   14957 14908
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F4845CE0     0 14957   1684        (L-TLB)   14959 14915
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     Z C98B7AA0     0 14959   1684        (L-TLB)   14974 14957
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>] =
[<c010002b>]=20
httpd     Z ED9AC1A0   180 14974   1684        (L-TLB)   14976 14959
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACAA0   212 14976   1684        (L-TLB)   14980 14974
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFBAE0     0 14980   1684        (L-TLB)   14989 14976
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F1E0     4 14989   1684        (L-TLB)   15024 14980
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7A20   320 15024   1684        (L-TLB)   15045 14989
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F48456A0     0 15045   1684        (L-TLB)   15055 15024
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F960     0 15055   1684        (L-TLB)   15058 15045
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F48453E0  3700 15058   1684        (L-TLB)   15061 15055
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7460     0 15061   1684        (L-TLB)   15066 15058
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F420   324 15066   1684        (L-TLB)   15076 15061
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACCE0  4516 15076   1684        (L-TLB)   15082 15066
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78860     0 15082   1684        (L-TLB)   15098 15076
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC2A0  1408 15098   1684        (L-TLB)   15103 15082
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FB20   488 15103   1684        (L-TLB)   15105 15098
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F760  1008 15105   1684        (L-TLB)   15106 15103
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FAA0     0 15106   1684        (L-TLB)   15107 15105
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD87C60     0 15107   1684        (L-TLB)   15113 15106
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD87760     0 15113   1684        (L-TLB)   15124 15107
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC6E0     4 15124   1684        (L-TLB)   15127 15113
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7EE0     0 15127   1684        (L-TLB)   15145 15124
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7660     8 15145   1684        (L-TLB)   15151 15127
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC4A0    52 15151   1684        (L-TLB)   15154 15145
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F48457E0     0 15154   1684        (L-TLB)   15156 15151
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B74A0     0 15156   1684        (L-TLB)   15165 15154
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F48458E0     0 15165   1684        (L-TLB)   15170 15156
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7320    12 15170   1684        (L-TLB)   15172 15165
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB8E0     0 15172   1684        (L-TLB)   15179 15170
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA784A0     0 15179   1684        (L-TLB)   15180 15172
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z EE630F20     0 15180   1684        (L-TLB)   15181 15179
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACB60     0 15181   1684        (L-TLB)   15191 15180
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FDE0     0 15191   1684        (L-TLB)   15194 15181
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACC60     4 15194   1684        (L-TLB)   15204 15191
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F9A0     4 15204   1684        (L-TLB)   15206 15194
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC860     4 15206   1684        (L-TLB)   15207 15204
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B77A0     0 15207   1684        (L-TLB)   15208 15206
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7960   500 15208   1684        (L-TLB)   15209 15207
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB5E0     4 15209   1684        (L-TLB)   15231 15208
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD87960     0 15231   1684        (L-TLB)   15241 15209
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD87260     0 15241   1684        (L-TLB)   15246 15231
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7D20     0 15246   1684        (L-TLB)   15247 15241
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC660     0 15247   1684        (L-TLB)   15254 15246
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F2A0     0 15254   1684        (L-TLB)   15259 15247
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78B60     0 15259   1684        (L-TLB)   15262 15254
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB6E0  1652 15262   1684        (L-TLB)   15268 15259
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F260     0 15268   1684        (L-TLB)   15269 15262
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACA60     0 15269   1684        (L-TLB)   15272 15268
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FA60     0 15272   1684        (L-TLB)   15291 15269
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F920     0 15291   1684        (L-TLB)   15295 15272
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC7A0     0 15295   1684        (L-TLB)   15297 15291
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD87BA0  1796 15297   1684        (L-TLB)   15301 15295
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F860     0 15301   1684        (L-TLB)   15309 15297
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD872A0     0 15309   1684        (L-TLB)   15321 15301
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F720     0 15321   1684        (L-TLB)   15322 15309
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FAE0     0 15322   1684        (L-TLB)   15342 15321
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7D60     0 15342   1684        (L-TLB)   15348 15322
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F3A0  1228 15348   1684        (L-TLB)   15353 15342
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACAE0     0 15353   1684        (L-TLB)   15359 15348
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB560     0 15359   1684        (L-TLB)   15369 15353
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD877E0     0 15369   1684        (L-TLB)   15377 15359
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7160     0 15377   1684        (L-TLB)   15380 15369
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F120     0 15380   1684        (L-TLB)   15385 15377
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F6E0     0 15385   1684        (L-TLB)   15397 15380
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFBA60     0 15397   1684        (L-TLB)   15398 15385
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F3E0     0 15398   1684        (L-TLB)   15399 15397
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78B20   196 15399   1684        (L-TLB)   15406 15398
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78920   796 15406   1684        (L-TLB)   15409 15399
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F4845EA0     0 15409   1684        (L-TLB)   15412 15406
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F8E0     0 15412   1684        (L-TLB)   15418 15409
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACF20     0 15418   1684        (L-TLB)   15425 15412
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78CA0     0 15425   1684        (L-TLB)   15430 15418
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78760     0 15430   1684        (L-TLB)   15451 15425
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78FA0     0 15451   1684        (L-TLB)   15454 15430
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC9A0     0 15454   1684        (L-TLB)   15457 15451
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C1EFB9A0     0 15457   1684        (L-TLB)   15460 15454
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F8A0     0 15460   1684        (L-TLB)   15489 15457
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FE20     0 15489   1684        (L-TLB)   15492 15460
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FB60  2432 15492   1684        (L-TLB)   15494 15489
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC2E0  5280 15494   1684        (L-TLB)   15500 15492
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7F820  4960 15500   1684        (L-TLB)   15515 15494
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7E60     0 15515   1684        (L-TLB)   15536 15500
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC820     0 15536   1684        (L-TLB)   15549 15515
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9ACD20   824 15549   1684        (L-TLB)   15551 15536
Call Trace: [<c0119b70>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z ED9AC560  1316 15551   1684        (L-TLB)   15552 15549
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F7A7FC60  2440 15552   1684        (L-TLB)   15555 15551
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z C98B7360     0 15555   1684        (L-TLB)   15564 15552
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CCA78BE0  2180 15564   1684        (L-TLB)   15565 15555
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z CAD87FA0     0 15565   1684        (L-TLB)   15566 15564
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
httpd     Z F4845BA0     8 15566   1684        (L-TLB)   15576 15565
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
mysqld    R current      0 15574  14162        (NOTLB)   15612 14163
Call Trace: [<c011ae7c>] [<c010a755>] [<c0108f8c>]=20
httpd     Z CAD87860     0 15576   1684        (L-TLB)   15736 15566
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
mysqld    S F12A9FB0     0 15612  14162        (NOTLB)   15619 15574
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CEFFBFB0     8 15619  14162        (NOTLB)   15621 15612
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E0541FB0    16 15621  14162        (NOTLB)   15623 15619
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D19E1FB0     0 15623  14162        (NOTLB)   15625 15621
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D75EFFB0     0 15625  14162        (NOTLB)   15628 15623
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2A7BFB0     0 15628  14162        (NOTLB)   15638 15625
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F52D1FB0     0 15638  14162        (NOTLB)   15640 15628
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F271DFB0     0 15640  14162        (NOTLB)   15643 15638
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D8F75FB0    12 15643  14162        (NOTLB)   15648 15640
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CEABFFB0  3764 15648  14162        (NOTLB)   15650 15643
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DBDFB0     0 15650  14162        (NOTLB)   15651 15648
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DBBFB0     0 15651  14162        (NOTLB)   15652 15650
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DB9FB0     0 15652  14162        (NOTLB)   15657 15651
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CC0A5FB0  2432 15657  14162        (NOTLB)   15658 15652
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CA917FB0     0 15658  14162        (NOTLB)   15662 15657
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EE3B1FB0     0 15662  14162        (NOTLB)   15664 15658
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CE99BFB0     0 15664  14162        (NOTLB)   15666 15662
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C8B23FB0     8 15666  14162        (NOTLB)   15668 15664
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2EFFFB0    60 15668  14162        (NOTLB)   15671 15666
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F449FFB0     0 15671  14162        (NOTLB)   15672 15668
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E2D67FB0     0 15672  14162        (NOTLB)   15685 15671
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E382BFB0     8 15685  14162        (NOTLB)   15695 15672
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CA849FB0     4 15695  14162        (NOTLB)   15696 15685
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2805FB0     8 15696  14162        (NOTLB)   15698 15695
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D2BD1FB0     0 15698  14162        (NOTLB)   15699 15696
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F0DA5FB0  1140 15699  14162        (NOTLB)   15700 15698
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E0989FB0     0 15700  14162        (NOTLB)   15704 15699
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D6CD9FB0     0 15704  14162        (NOTLB)   15705 15700
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EA5A3FB0     0 15705  14162        (NOTLB)   15706 15704
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F65A3FB0     0 15706  14162        (NOTLB)   15709 15705
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S DE9EFFB0  5188 15709  14162        (NOTLB)   15711 15706
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C6C4BFB0  5172 15711  14162        (NOTLB)   15713 15709
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EE0CFFB0  5140 15713  14162        (NOTLB)   15717 15711
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EDA29FB0  5016 15717  14162        (NOTLB)   15719 15713
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D98FBFB0    20 15719  14162        (NOTLB)   15721 15717
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C7087FB0     0 15721  14162        (NOTLB)   15726 15719
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D1E41FB0     0 15726  14162        (NOTLB)   15731 15721
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S DB70BFB0     0 15731  14162        (NOTLB)   15737 15726
Call Trace: [<c0108092>] [<c0108ecb>]=20
httpd     S 7FFFFFFF     0 15736   1684        (NOTLB)         15576
Call Trace: [<c01146d7>] [<c01d992d>] [<c01db1ad>] [<c0113bf8>] =
[<c01273b8>] [<c01f2fa6>] [<c01c3f55>]=20
       [<c01c438d>] [<c01c440b>] [<c01332d3>] [<c0126e60>] [<c0133435>] =
[<c0108ecb>]=20
mysqld    S EB3DDF88     0 15737  14162        (NOTLB)         15731
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S F7A85F88  2436 15738      1        (NOTLB)   15739 14160
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S CB21BF88  5220 15739      1        (NOTLB)   15740 15738
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S F6421F88     0 15740      1        (NOTLB)   15741 15739
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S C466BF88   180 15741      1        (NOTLB)   15742 15740
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S E16CFF88  1956 15742      1        (NOTLB)   15743 15741
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S DDD53F88     0 15743      1        (NOTLB)   15744 15742
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S D7DC3F88  2432 15744      1        (NOTLB)         15743
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
SysRq: Show Memory
Mem-info:
Free pages:      278224kB (     0kB HighMem)
( Active: 134278, inactive_dirty: 1763, inactive_clean: 661, free: 69556 =
(383 766 1149) )
514*4kB 313*8kB 113*16kB 8*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB =
0*2048kB =3D 7136kB)
40080*4kB 11596*8kB 1031*16kB 19*32kB 2*64kB 0*128kB 1*256kB 1*512kB =
0*1024kB 0*2048kB =3D 271088kB)
=3D 0kB)
Swap cache: add 60202, delete 57651, find 26657021/26673824
Free swap:       1021764kB
229376 pages of RAM
0 pages of HIGHMEM
4353 reserved pages
126593 pages shared
2551 pages swap cached
0 pages in page table cache
Buffer memory:    33060kB
    CLEAN: 3281 buffers, 13124 kbyte, 0 used (last=3D0), 0 locked, 0 =
protected, 0 dirty
   LOCKED: 22859 buffers, 91436 kbyte, 28 used (last=3D22586), 0 locked, =
0 protected, 0 dirty
    DIRTY: 946 buffers, 3784 kbyte, 44 used (last=3D946), 0 locked, 0 =
protected, 946 dirty
SysRq: Terminate All Tasks
SysRq: Show Regs

EIP: 0010:[<c01eb08f>] CPU: 1 EFLAGS: 00000206
EAX: f7c26ac0 EBX: c96cd420 ECX: f7c26ac0 EDX: 00000000
ESI: c02a2ba0 EDI: 298d26ce EBP: c02d17c4 DS: 0018 ES: 0018
CR0: 8005003b CR2: bfffd8d8 CR3: 23bba000 CR4: 00000290
Call Trace: [<c01eb7ea>] [<c011af5b>] [<c011ae7c>] [<c010a755>] =
[<c0108f8c>]=20
SysRq: Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll =
killalL
SysRq: Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init      S C1EF9F28  4180     1      0 15751  (NOTLB)       =20
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c013af14>] [<c0108ecb>]=20
keventd   S F7FB2650  6336     2      1        (L-TLB)       3
Call Trace: [<c0122535>] [<c01074a4>]=20
kswapd    S F7FA5FAC  5128     3      1        (L-TLB)       4     2
Call Trace: [<c011473a>] [<c0114664>] [<c0114f82>] [<c012d719>] =
[<c01074a4>]=20
kreclaimd  S 00000286  5456     4      1        (L-TLB)       5     3
Call Trace: [<c0114f12>] [<c012d7cb>] [<c01074a4>]=20
bdflush   S F7FA0000  5196     5      1        (L-TLB)       6     4
Call Trace: [<c011b1fc>] [<c01373ae>] [<c01074a4>]=20
kupdate   S F7F9FFC8  5044     6      1        (L-TLB)     148     5
Call Trace: [<c011473a>] [<c0114664>] [<c0137444>] [<c01074a4>]=20
watchdog  S CE7D9F88  5040   148      1        (NOTLB)    1684     6
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
mysqld    S E34AFFB0     8 14160      1 14162  (NOTLB)   15745 15606
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E4CF1F30     0 14162  14160 15737  (NOTLB)       =20
Call Trace: [<c013cf26>] [<c011473a>] [<c0114664>] [<c0142d8f>] =
[<c0142f83>] [<c0108ecb>]=20
mysqld    S CBEC3FB0     4 14163  14162        (NOTLB)   15574
Call Trace: [<c0108092>] [<c0108ecb>]=20
httpd     S C46DFF28     0  1684      1 15736  (NOTLB)   15606   148
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
eggdrop   S D685DF28     0 15606      1        (NOTLB)   14160  1684
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
mysqld    R current      0 15574  14162        (NOTLB)   15612 14163
Call Trace: [<c011ae7c>] [<c010a755>] [<c0108f8c>]=20
mysqld    S F12A9FB0     0 15612  14162        (NOTLB)   15619 15574
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CEFFBFB0     8 15619  14162        (NOTLB)   15621 15612
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E0541FB0    16 15621  14162        (NOTLB)   15623 15619
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D19E1FB0     0 15623  14162        (NOTLB)   15625 15621
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D75EFFB0     0 15625  14162        (NOTLB)   15628 15623
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2A7BFB0     0 15628  14162        (NOTLB)   15638 15625
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F52D1FB0     0 15638  14162        (NOTLB)   15640 15628
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F271DFB0     0 15640  14162        (NOTLB)   15643 15638
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D8F75FB0    12 15643  14162        (NOTLB)   15648 15640
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CEABFFB0  3764 15648  14162        (NOTLB)   15650 15643
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DBDFB0     0 15650  14162        (NOTLB)   15651 15648
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DBBFB0     0 15651  14162        (NOTLB)   15652 15650
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DB9FB0     0 15652  14162        (NOTLB)   15657 15651
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CC0A5FB0  2432 15657  14162        (NOTLB)   15658 15652
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CA917FB0     0 15658  14162        (NOTLB)   15662 15657
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EE3B1FB0     0 15662  14162        (NOTLB)   15664 15658
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CE99BFB0     0 15664  14162        (NOTLB)   15666 15662
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C8B23FB0     8 15666  14162        (NOTLB)   15668 15664
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2EFFFB0    60 15668  14162        (NOTLB)   15671 15666
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F449FFB0     0 15671  14162        (NOTLB)   15672 15668
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E2D67FB0     0 15672  14162        (NOTLB)   15685 15671
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E382BFB0     8 15685  14162        (NOTLB)   15695 15672
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CA849FB0     4 15695  14162        (NOTLB)   15696 15685
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2805FB0     8 15696  14162        (NOTLB)   15698 15695
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D2BD1FB0     0 15698  14162        (NOTLB)   15699 15696
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F0DA5FB0  1140 15699  14162        (NOTLB)   15700 15698
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E0989FB0     0 15700  14162        (NOTLB)   15704 15699
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D6CD9FB0     0 15704  14162        (NOTLB)   15705 15700
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EA5A3FB0     0 15705  14162        (NOTLB)   15706 15704
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F65A3FB0     0 15706  14162        (NOTLB)   15709 15705
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S DE9EFFB0  5188 15709  14162        (NOTLB)   15711 15706
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C6C4BFB0  5172 15711  14162        (NOTLB)   15713 15709
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EE0CFFB0  5140 15713  14162        (NOTLB)   15717 15711
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EDA29FB0  5016 15717  14162        (NOTLB)   15719 15713
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D98FBFB0    20 15719  14162        (NOTLB)   15721 15717
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C7087FB0     0 15721  14162        (NOTLB)   15726 15719
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D1E41FB0     0 15726  14162        (NOTLB)   15731 15721
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S DB70BFB0     0 15731  14162        (NOTLB)   15737 15726
Call Trace: [<c0108092>] [<c0108ecb>]=20
httpd     Z EE6304E0     0 15736   1684        (L-TLB)       =20
Call Trace: [<c0119b01>] [<c0119e57>] [<c0119e8a>] [<c0108ecb>]=20
mysqld    S EB3DDFB0     0 15737  14162        (NOTLB)         15731
Call Trace: [<c0108092>] [<c0108ecb>]=20
getty     S F7A85F88  2436 15745      1        (NOTLB)   15746 14160
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S F6421F88     0 15746      1        (NOTLB)   15747 15745
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S CB21BF88  5220 15747      1        (NOTLB)   15748 15746
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S E16CFF88  1956 15748      1        (NOTLB)   15749 15747
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S C466BF88   180 15749      1        (NOTLB)   15750 15748
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S DDD53F88     0 15750      1        (NOTLB)   15751 15749
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S D7DC3F88  2432 15751      1        (NOTLB)         15750
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
SysRq: Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll =
killalL
SysRq: Terminate All Tasks
SysRq: Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll =
killalL
SysRq: Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init      S C1EF9F28  4180     1      0 15758  (NOTLB)       =20
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c013af14>] [<c0108ecb>]=20
keventd   S F7FB2650  6336     2      1        (L-TLB)       3
Call Trace: [<c0122535>] [<c01074a4>]=20
kswapd    S F7FA5FAC  5128     3      1        (L-TLB)       4     2
Call Trace: [<c011473a>] [<c0114664>] [<c0114f82>] [<c012d719>] =
[<c01074a4>]=20
kreclaimd  S 00000286  5456     4      1        (L-TLB)       5     3
Call Trace: [<c0114f12>] [<c012d7cb>] [<c01074a4>]=20
bdflush   S F7FA0000  5196     5      1        (L-TLB)       6     4
Call Trace: [<c011b1fc>] [<c01373ae>] [<c01074a4>]=20
kupdate   S F7F9FFC8  5044     6      1        (L-TLB)     148     5
Call Trace: [<c011473a>] [<c0114664>] [<c0137444>] [<c01074a4>]=20
watchdog  S CE7D9F88  5040   148      1        (NOTLB)   15606     6
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
mysqld    S E34AFFB0     8 14160      1 14162  (NOTLB)   15752 15606
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E4CF1F30     0 14162  14160 15737  (NOTLB)       =20
Call Trace: [<c013cf26>] [<c011473a>] [<c0114664>] [<c0142d8f>] =
[<c0142f83>] [<c01083da>] [<c0108ecb>]=20
mysqld    S CBEC3FB0     4 14163  14162        (NOTLB)   15574
Call Trace: [<c0108092>] [<c0108ecb>]=20
eggdrop   S D685DF28     0 15606      1        (NOTLB)   14160   148
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c0108ecb>]=20
mysqld    R C011AE7C     0 15574  14162        (NOTLB)   15612 14163
Call Trace: [<c011ae7c>] [<c010a755>] [<c0108f8c>]=20
mysqld    S F12A9FB0     0 15612  14162        (NOTLB)   15619 15574
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CEFFBFB0     8 15619  14162        (NOTLB)   15621 15612
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E0541FB0    16 15621  14162        (NOTLB)   15623 15619
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D19E1FB0     0 15623  14162        (NOTLB)   15625 15621
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D75EFFB0     0 15625  14162        (NOTLB)   15628 15623
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2A7BFB0     0 15628  14162        (NOTLB)   15638 15625
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F52D1FB0     0 15638  14162        (NOTLB)   15640 15628
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F271DFB0     0 15640  14162        (NOTLB)   15643 15638
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D8F75FB0    12 15643  14162        (NOTLB)   15648 15640
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CEABFFB0  3764 15648  14162        (NOTLB)   15650 15643
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DBDFB0     0 15650  14162        (NOTLB)   15651 15648
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DBBFB0     0 15651  14162        (NOTLB)   15652 15650
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E3DB9FB0     0 15652  14162        (NOTLB)   15657 15651
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CC0A5FB0  2432 15657  14162        (NOTLB)   15658 15652
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CA917FB0     0 15658  14162        (NOTLB)   15662 15657
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EE3B1FB0     0 15662  14162        (NOTLB)   15664 15658
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CE99BFB0     0 15664  14162        (NOTLB)   15666 15662
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C8B23FB0     8 15666  14162        (NOTLB)   15668 15664
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2EFFFB0    60 15668  14162        (NOTLB)   15671 15666
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F449FFB0     0 15671  14162        (NOTLB)   15672 15668
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E2D67FB0     0 15672  14162        (NOTLB)   15685 15671
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E382BFB0     8 15685  14162        (NOTLB)   15695 15672
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S CA849FB0     4 15695  14162        (NOTLB)   15696 15685
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F2805FB0     8 15696  14162        (NOTLB)   15698 15695
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D2BD1FB0     0 15698  14162        (NOTLB)   15699 15696
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F0DA5FB0  1140 15699  14162        (NOTLB)   15700 15698
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S E0989FB0     0 15700  14162        (NOTLB)   15704 15699
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D6CD9FB0     0 15704  14162        (NOTLB)   15705 15700
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EA5A3FB0     0 15705  14162        (NOTLB)   15706 15704
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S F65A3FB0     0 15706  14162        (NOTLB)   15709 15705
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S DE9EFFB0  5188 15709  14162        (NOTLB)   15711 15706
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C6C4BFB0  5172 15711  14162        (NOTLB)   15713 15709
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EE0CFFB0  5140 15713  14162        (NOTLB)   15717 15711
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EDA29FB0  5016 15717  14162        (NOTLB)   15719 15713
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D98FBFB0    20 15719  14162        (NOTLB)   15721 15717
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S C7087FB0     0 15721  14162        (NOTLB)   15726 15719
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S D1E41FB0     0 15726  14162        (NOTLB)   15731 15721
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S DB70BFB0     0 15731  14162        (NOTLB)   15737 15726
Call Trace: [<c0108092>] [<c0108ecb>]=20
mysqld    S EB3DDFB0     0 15737  14162        (NOTLB)         15731
Call Trace: [<c0108092>] [<c0108ecb>]=20
getty     S F7A85F88  2436 15752      1        (NOTLB)   15753 14160
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S F6421F88     0 15753      1        (NOTLB)   15754 15752
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S CB21BF88  5220 15754      1        (NOTLB)   15755 15753
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S E16CFF88  1956 15755      1        (NOTLB)   15756 15754
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S C466BF88   180 15756      1        (NOTLB)   15757 15755
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S DDD53F88     0 15757      1        (NOTLB)   15758 15756
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S D7DC3F88  2432 15758      1        (NOTLB)         15757
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
SysRq: Kill All Tasks
SysRq: Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init      S C1EF9F28  4180     1      0 15765  (NOTLB)       =20
Call Trace: [<c011473a>] [<c0114664>] [<c014276e>] [<c0142b12>] =
[<c013af14>] [<c0108ecb>]=20
keventd   S F7FB2650  6336     2      1        (L-TLB)       3
Call Trace: [<c0122535>] [<c01074a4>]=20
kswapd    S F7FA5FAC  5128     3      1        (L-TLB)       4     2
Call Trace: [<c011473a>] [<c0114664>] [<c0114f82>] [<c012d719>] =
[<c01074a4>]=20
kreclaimd  S 00000286  5456     4      1        (L-TLB)       5     3
Call Trace: [<c0114f12>] [<c012d7cb>] [<c01074a4>]=20
bdflush   S F7FA0000  5196     5      1        (L-TLB)       6     4
Call Trace: [<c011b1fc>] [<c01373ae>] [<c01074a4>]=20
kupdate   S F7F9FFC8  5044     6      1        (L-TLB)   15574     5
Call Trace: [<c011473a>] [<c0114664>] [<c0137444>] [<c01074a4>]=20
mysqld    R C011AE7C     0 15574      1        (NOTLB)   15759     6
Call Trace: [<c011ae7c>] [<c010a755>] [<c0108f8c>]=20
getty     S CE7D9F88  5040 15759      1        (NOTLB)   15760 15574
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S E34AFF88     8 15760      1        (NOTLB)   15761 15759
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S F7A85F88  2436 15761      1        (NOTLB)   15762 15760
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S F6421F88     0 15762      1        (NOTLB)   15763 15761
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S CB21BF88  5220 15763      1        (NOTLB)   15764 15762
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S E16CFF88  1956 15764      1        (NOTLB)   15765 15763
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
getty     S C466BF88   180 15765      1        (NOTLB)         15764
Call Trace: [<c011473a>] [<c0114664>] [<c011e958>] [<c0108ecb>]=20
SysRq: Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll =
killalL
SysRq: Emergency Sync
Syncing device 08:01 ... OK
Syncing device 08:03 ... OK
Syncing device 08:11 ... OK
Syncing device 08:21 ... OK
Done.
SysRq: Emergency Remount R/O
Remounting device 08:01 ... OK
Remounting device 08:03 ... OK
Remounting device 08:11 ... OK
Remounting device 08:21 ... OK
Done.
SysRq: Resetting
------=_NextPart_000_002A_01C0A638.9C7ED0F0--

