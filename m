Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131612AbRCZPEv>; Mon, 26 Mar 2001 10:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130661AbRCZPEc>; Mon, 26 Mar 2001 10:04:32 -0500
Received: from ns.snowman.net ([63.80.4.34]:65295 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S131612AbRCZPEV>;
	Mon, 26 Mar 2001 10:04:21 -0500
Date: Mon, 26 Mar 2001 10:03:25 -0500
From: Stephen Frost <sfrost@snowman.net>
To: linux-kernel@vger.kernel.org
Subject: 'spurious APIC interrupt' - Dell PowerEdge 1400
Message-ID: <20010326100325.C11136@ns>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ImlueIRSpq8lZ71A"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 9:56am  up 221 days, 13:33, 18 users,  load average: 2.06, 2.02, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ImlueIRSpq8lZ71A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Running into a problem with one of our Dell PowerEdge 1400 servers.
We see these messages very rarely, but after they show up the machine
goes into a really odd state:

Mar 26 09:37:27 maul kernel: spurious APIC interrupt on CPU#1, should never=
 happen.
Mar 26 09:37:27 maul kernel: unexpected IRQ vector 216 on CPU#1!

Basically things seem to only kinda work.  My guess is that possibly one of
the CPUs has been shut down or similar and so half the processes are getting
kind of 'stuck'.

Any thoughts?  dmesg follows, more information availible upon request,
thanks!


		Stephen

-----------------------------------------------------------
=3D=3D=3D# dmesg
Linux version 2.2.18-raid-mosix (bma@black) (gcc version 2.95.2 20000220 (D=
ebian GNU/Linux)) #2 SMP Tue Jan 2 12:40:13 EST 2001
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: POWEREDGE CE APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
mapped IOAPIC to ffffc000 (fec01000)
Detected 794719 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1585.97 BogoMIPS
Memory: 1034844k/1048512k available (1512k kernel code, 424k reserved, 1167=
6k data, 56k init)
Dentry hash table entries: 131072 (order 8, 1024k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 262144 (order 8, 1024k)
256K L2 cache (8 way)
CPU: L2 Cache: 256K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
per-CPU timeslice cutoff: 50.03 usecs.
CPU1: Intel Pentium III (Coppermine) stepping 06
calibrating APIC timer ...=20
=2E.... CPU clock speed is 794.6271 MHz.
=2E.... system bus clock speed is 132.4377 MHz.
Booting processor 0 eip 2000
Calibrating delay loop... 1585.97 BogoMIPS
Intel machine check reporting enabled on CPU#0.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
OK.
CPU0: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3171.94 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
=2E..changing IO-APIC physical APIC ID to 2
=2E..changing IO-APIC physical APIC ID to 3
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-2, 2-5, 2-11, 2-13WARNING: ASSIGN_IRQ_VECTOR w=
rapped back to 52
, 3-13 not connected.
=2E..trying to set up timer as ExtINT... .. (found pin 0) ... works.
number of MP IRQ sources: 39.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
testing the IO APIC.......................

IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E... register #01: 000F0011
=2E......     : max redirection entries: 000F
=2E......     : IO APIC version: 0011
=2E... register #02: 00000000
=2E......     : arbitration: 00
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 001 01  0    0    0   0   0    0    7    51
 01 000 00  0    0    0   0   0    1    1    59
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  0    0    0   0   0    1    1    71
 07 000 00  0    0    0   0   0    1    1    79
 08 000 00  0    0    0   0   0    1    1    81
 09 000 00  0    0    0   0   0    1    1    89
 0a 0FF 0F  1    1    0   1   0    1    1    91
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    99
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    A1
 0f 000 00  0    0    0   0   0    1    1    A9

IO APIC #3......
=2E... register #00: 03000000
=2E......    : physical APIC id: 03
=2E... register #01: 000F0011
=2E......     : max redirection entries: 000F
=2E......     : IO APIC version: 0011
=2E... register #02: 0E000000
=2E......     : arbitration: 0E
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 0FF 0F  1    1    0   1   0    1    1    B1
 01 0FF 0F  1    1    0   1   0    1    1    B9
 02 0FF 0F  1    1    0   1   0    1    1    C1
 03 0FF 0F  1    1    0   1   0    1    1    C9
 04 0FF 0F  1    1    0   1   0    1    1    D1
 05 0FF 0F  1    1    0   1   0    1    1    D9
 06 0FF 0F  1    1    0   1   0    1    1    E1
 07 0FF 0F  1    1    0   1   0    1    1    E9
 08 0FF 0F  1    1    0   1   0    1    1    F1
 09 0FF 0F  1    1    0   1   0    1    1    F9
 0a 0FF 0F  1    1    0   1   0    1    1    52
 0b 0FF 0F  1    1    0   1   0    1    1    5A
 0c 0FF 0F  1    1    0   1   0    1    1    62
 0d 000 00  1    0    0   0   0    0    0    00
 0e 0FF 0F  1    1    0   1   0    1    1    6A
 0f 0FF 0F  1    1    0   1   0    1    1    72
IRQ to pin mappings:
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ12 -> 12
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 0
IRQ17 -> 1
IRQ18 -> 2
IRQ19 -> 3
IRQ20 -> 4
IRQ21 -> 5
IRQ22 -> 6
IRQ23 -> 7
IRQ24 -> 8
IRQ25 -> 9
IRQ26 -> 10
IRQ27 -> 11
IRQ28 -> 12
IRQ30 -> 14
IRQ31 -> 15
=2E................................... done.
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfc7de
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:00 [1166/0009]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/00
PCI: 00:01 [1166/0009]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/01
PCI->APIC IRQ transform: (B0,I2,P0) -> 16
PCI->APIC IRQ transform: (B1,I2,P0) -> 30
PCI->APIC IRQ transform: (B1,I2,P1) -> 31
PCI->APIC IRQ transform: (B1,I10,P0) -> 24
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Starting kswapd v 1.5=20
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
PCI_IDE: unknown IDE controller on PCI bus 00 device 79, VID=3D1166, DID=3D=
0211
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x08b0-0x08b7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x08b8-0x08bf, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG CD-ROM SC-148F, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 48X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
md driver 0.90.0 MAX_MD_DEVS=3D256, MAX_REAL=3D12
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :  1798.701 MB/sec
   p5_mmx    :  1832.610 MB/sec
   8regs     :  1380.744 MB/sec
   32regs    :   800.100 MB/sec
using fastest function: p5_mmx (1832.610 MB/sec)
(scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/2/0
(scsi0) Wide Channel A, SCSI ID=3D7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI host adapter> found at PCI 1/2/1
(scsi1) Wide Channel B, SCSI ID=3D7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
megaraid: v1.11 (Aug 23, 2000)
megaraid: found 0x8086:0x1960:idx 0:bus 1:slot 10:func 1
scsi2 : Found a MegaRAID controller at 0xc0004000, IRQ: 24
megaraid: [1.01:1p00] detected 0 logical drives
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AIC-7899 Ultra 160/m SCSI host adapter>
scsi2 : AMI MegaRAID 1.01 254 commands 16 targs 2 chans 8 luns
scsi : 3 hosts.
(scsi0:0:0:0) Synchronous at 80.0 Mbyte/sec, offset 63.
  Vendor: QUANTUM   Model: ATLAS V  9 WLS    Rev: 0201
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi2: scanning channel 1 for devices.
scsi2: scanning channel 2 for devices.
scsi2: scanning virtual channel for logical drives.
scsi : detected 1 SCSI generic 1 SCSI disk total.
SCSI device sda: hdwr sector=3D 512 bytes. Sectors=3D 17783249 [8683 MB] [8=
.7 GB]
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux=
/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochk=
in <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11=
/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:B0:D0:AB:2A:25, IRQ 16.
  Board assembly 07195d-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux=
/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochk=
in <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11=
/15
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
md.c: sizeof(mdp_super_t) =3D 4096
autodetecting RAID arrays
autorun ...
=2E.. autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 56k freed
Adding Swap: 996020k swap-space (priority -1)
parport0: PC-style at 0x378 (0x778) [SPP,ECP,ECPPS2]
lp0: using parport0 (polling).
-----------------------------------------------------------

--ImlueIRSpq8lZ71A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6v1o9rzgMPqB3kigRAqwhAJ9UXadpdSoj1WV/OWe/8YtBsRWOFQCeLXLv
5OhiMW6E2RdCi1tKMrjSJLM=
=qLui
-----END PGP SIGNATURE-----

--ImlueIRSpq8lZ71A--
