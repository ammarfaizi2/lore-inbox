Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIFuu>; Tue, 9 Jan 2001 00:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAIFuk>; Tue, 9 Jan 2001 00:50:40 -0500
Received: from tstonramp.com ([206.55.129.9]:52145 "EHLO mail.tstonramp.com")
	by vger.kernel.org with ESMTP id <S129324AbRAIFuV>;
	Tue, 9 Jan 2001 00:50:21 -0500
From: "David Joyce" <djoyce@dew-drop.com>
To: <linux-kernel@vger.kernel.org>
Subject: Sorry about the email. .  (re: 2.4.0-ac4)
Date: Mon, 8 Jan 2001 21:50:14 -0800
Message-ID: <LFEALFDOBFIEPJIEBJHAKEFICFAA.djoyce@dew-drop.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C079BC.FB40BBB0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C079BC.FB40BBB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

  I'm sure this isn't the address to send this to, but I
don't know where to send this.

I just upgraded from 2.4.0-test12 to 2.4.0, and I got a
kernel panac after about 6 hours.  Then updated to 2.4.0-ac4
and got a massive amount of scsi errors.  The server was again
up for about 6 hours.  This was in the syslog:

-----------------------------------------------------------------
Jan  8 16:51:34 kenny kernel: (scsi0:-1:-1:-1) Referenced SCB 12 not valid
during SELTO.
Jan  8 16:51:34 kenny kernel:         SCSISEQ = 0x5a SEQADDR = 0x8 SSTAT0 =
0x10 SSTAT1 = 0x88
Jan  8 16:51:34 kenny kernel: (scsi0:-1:-1:-1) Referenced SCB 12 not valid
during SELTO.
Jan  8 16:51:34 kenny kernel:         SCSISEQ = 0x5a SEQADDR = 0x8 SSTAT0 =
0x10 SSTAT1 = 0x88
Jan  8 16:51:34 kenny kernel: (scsi0:-1:-1:-1) Referenced SCB 12 not valid
during SELTO.
Jan  8 16:51:34 kenny kernel:         SCSISEQ = 0x5a SEQADDR = 0x8 SSTAT0 =
0x10 SSTAT1 = 0x88
Jan  8 16:51:34 kenny kernel: (scsi0:-1:-1:-1) Referenced SCB 12 not valid
during SELTO.
Jan  8 16:51:34 kenny kernel:         SCSISEQ = 0x5a SEQADDR = 0x8 SSTAT0 =
0x10 SSTAT1 = 0x88
Jan  8 16:51:34 kenny kernel: (scsi0:0:1:0) Synchronous at 80.0 Mbyte/sec,
offset 63.
Jan  8 16:51:34 kenny kernel: (scsi0:0:3:0) Synchronous at 80.0 Mbyte/sec,
offset 63.
Jan  8 16:51:56 kenny kernel: SCSI host 0 abort (pid 0) timed out -
resetting
Jan  8 16:51:56 kenny kernel: SCSI bus is being reset for host 0 channel 0.
Jan  8 16:51:57 kenny kernel: SCSI host 0 channel 0 reset (pid 0) timed
out - trying harder
Jan  8 16:51:57 kenny kernel: SCSI bus is being reset for host 0 channel 0.
Jan  8 16:51:57 kenny kernel: SCSI host 0 reset (pid 0) timed out again -
Jan  8 16:51:57 kenny kernel: probably an unrecoverable SCSI bus or device
hang.
Jan  8 16:52:04 kenny kernel: scsi : aborting command due to timeout : pid
0, scsi0, channel 0, id 2, lun 0 0x2a 00 00
 1b 00 5c 00 00 08 00
Jan  8 16:52:04 kenny kernel: scsi : aborting command due to timeout : pid
0, scsi0, channel 0, id 2, lun 0 0x2a 00 00
 1b 00 68 00 00 08 00
Jan  8 16:52:04 kenny kernel: scsi : aborting command due to timeout : pid
0, scsi0, channel 0, id 2, lun 0 0x2a 00 00
 1b 00 84 00 00 04 00
----------------------------------------------------------------------

The server board is an Intel STL2, with one P3-800.  I will atach my current
dmesg.
Thanks for any help

Dave Joyce
ProbeTalk.com server admin

------=_NextPart_000_0000_01C079BC.FB40BBB0
Content-Type: text/plain;
	name="syslog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="syslog.txt"

Jan  8 21:00:06 kenny syslogd 1.3-3#33.1: restart.
Jan  8 21:00:06 kenny kernel: klogd 1.3-3#33.1, log source =3D =
/proc/kmsg started.
Jan  8 21:00:06 kenny kernel: Inspecting /System.map
Jan  8 21:00:06 kenny kernel: Loaded 11761 symbols from /System.map.
Jan  8 21:00:06 kenny kernel: Symbols match kernel version 2.4.0.
Jan  8 21:00:06 kenny kernel: No module symbols loaded - kernel modules =
not enabled.=20
Jan  8 21:00:06 kenny kernel: de 0 totalpages: 65520
Jan  8 21:00:06 kenny kernel: zone(0): 4096 pages.
Jan  8 21:00:06 kenny kernel: zone(1): 61424 pages.
Jan  8 21:00:06 kenny kernel: zone(2): 0 pages.
Jan  8 21:00:06 kenny kernel: Intel MultiProcessor Specification v1.4
Jan  8 21:00:06 kenny kernel:     Virtual Wire compatibility mode.
Jan  8 21:00:06 kenny kernel: OEM ID: INTEL    Product ID: STL2         =
APIC at: 0xFEE00000
Jan  8 21:00:06 kenny kernel: Processor #0 Pentium(tm) Pro APIC version =
17
Jan  8 21:00:06 kenny kernel:     Floating point unit present.
Jan  8 21:00:06 kenny kernel:     Machine Exception supported.
Jan  8 21:00:06 kenny kernel:     64 bit compare & exchange supported.
Jan  8 21:00:06 kenny kernel:     Internal APIC present.
Jan  8 21:00:06 kenny kernel:     SEP present.
Jan  8 21:00:06 kenny kernel:     MTRR  present.
Jan  8 21:00:06 kenny kernel:     PGE  present.
Jan  8 21:00:06 kenny kernel:     MCA  present.
Jan  8 21:00:06 kenny kernel:     CMOV  present.
Jan  8 21:00:06 kenny kernel:     PAT  present.
Jan  8 21:00:06 kenny kernel:     PSE  present.
Jan  8 21:00:06 kenny kernel:     PSN  present.
Jan  8 21:00:06 kenny kernel:     MMX  present.
Jan  8 21:00:06 kenny kernel:     FXSR  present.
Jan  8 21:00:06 kenny kernel:     XMM  present.
Jan  8 21:00:06 kenny kernel:     Bootup CPU
Jan  8 21:00:06 kenny kernel: Bus #0 is PCI  =20
Jan  8 21:00:06 kenny kernel: Bus #1 is PCI  =20
Jan  8 21:00:06 kenny kernel: Bus #2 is ISA  =20
Jan  8 21:00:06 kenny kernel: I/O APIC #4 Version 17 at 0xFEC00000.
Jan  8 21:00:06 kenny kernel: I/O APIC #5 Version 17 at 0xFEC01000.
Jan  8 21:00:06 kenny kernel: Int: type 3, pol 1, trig 1, bus 2, IRQ 00, =
APIC ID 4, APIC INT 00
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 01, =
APIC ID 4, APIC INT 01
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 00, =
APIC ID 4, APIC INT 02
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 03, =
APIC ID 4, APIC INT 03
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 04, =
APIC ID 4, APIC INT 04
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 3, trig 3, bus 1, IRQ 11, =
APIC ID 5, APIC INT 01
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 06, =
APIC ID 4, APIC INT 06
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 07, =
APIC ID 4, APIC INT 07
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 08, =
APIC ID 4, APIC INT 08
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 3c, =
APIC ID 5, APIC INT 00
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 0c, =
APIC ID 5, APIC INT 02
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 3, trig 3, bus 0, IRQ 08, =
APIC ID 5, APIC INT 03
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 0c, =
APIC ID 4, APIC INT 0c
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 0d, =
APIC ID 4, APIC INT 0d
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 0e, =
APIC ID 4, APIC INT 0e
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 1, trig 1, bus 2, IRQ 0f, =
APIC ID 4, APIC INT 0f
Jan  8 21:00:06 kenny kernel: Int: type 0, pol 3, trig 3, bus 1, IRQ 10, =
APIC ID 5, APIC INT 00
Jan  8 21:00:06 kenny kernel: Lint: type 3, pol 1, trig 1, bus 2, IRQ =
00, APIC ID ff, APIC LINT 00
Jan  8 21:00:06 kenny kernel: Lint: type 1, pol 1, trig 1, bus 0, IRQ =
00, APIC ID ff, APIC LINT 01
Jan  8 21:00:06 kenny kernel: Processors: 1
Jan  8 21:00:06 kenny kernel: mapped APIC to ffffe000 (fee00000)
Jan  8 21:00:06 kenny kernel: mapped IOAPIC to ffffd000 (fec00000)
Jan  8 21:00:06 kenny kernel: mapped IOAPIC to ffffc000 (fec01000)
Jan  8 21:00:06 kenny kernel: Kernel command line: auto =
BOOT_IMAGE=3DLinux ro root=3D801 BOOT_FILE=3D/vmlinuz
Jan  8 21:00:06 kenny kernel: Initializing CPU#0
Jan  8 21:00:06 kenny kernel: Detected 799.828 MHz processor.
Jan  8 21:00:06 kenny kernel: Console: colour VGA+ 80x25
Jan  8 21:00:06 kenny kernel: Calibrating delay loop... 1595.80 BogoMIPS
Jan  8 21:00:06 kenny kernel: Memory: 255368k/262080k available (1364k =
kernel code, 6324k reserved, 91k data, 188k init, 0k highmem)
Jan  8 21:00:06 kenny kernel: Dentry-cache hash table entries: 32768 =
(order: 6, 262144 bytes)
Jan  8 21:00:06 kenny kernel: Buffer-cache hash table entries: 16384 =
(order: 4, 65536 bytes)
Jan  8 21:00:06 kenny kernel: Page-cache hash table entries: 65536 =
(order: 6, 262144 bytes)
Jan  8 21:00:06 kenny kernel: Inode-cache hash table entries: 16384 =
(order: 5, 131072 bytes)
Jan  8 21:00:06 kenny kernel: CPU: Before vendor init, caps: 0387fbff =
00000000 00000000, vendor =3D 0
Jan  8 21:00:06 kenny kernel: CPU: L2 cache: 256K
Jan  8 21:00:06 kenny kernel: Intel machine check architecture =
supported.
Jan  8 21:00:06 kenny kernel: Intel machine check reporting enabled on =
CPU#0.
Jan  8 21:00:06 kenny kernel: CPU: After vendor init, caps: 0387fbff =
00000000 00000000 00000000
Jan  8 21:00:06 kenny kernel: CPU serial number disabled.
Jan  8 21:00:06 kenny kernel: CPU: After generic, caps: 0383fbff =
00000000 00000000 00000000
Jan  8 21:00:06 kenny kernel: CPU: Common caps: 0383fbff 00000000 =
00000000 00000000
Jan  8 21:00:06 kenny kernel: Enabling fast FPU save and restore... =
done.
Jan  8 21:00:06 kenny kernel: Enabling unmasked SIMD FPU exception =
support... done.
Jan  8 21:00:06 kenny kernel: Checking 'hlt' instruction... OK.
Jan  8 21:00:06 kenny kernel: POSIX conformance testing by UNIFIX
Jan  8 21:00:06 kenny kernel: mtrr: v1.37 (20001109) Richard Gooch =
(rgooch@atnf.csiro.au)
Jan  8 21:00:06 kenny kernel: mtrr: detected mtrr type: Intel
Jan  8 21:00:06 kenny kernel: CPU: Before vendor init, caps: 0383fbff =
00000000 00000000, vendor =3D 0
Jan  8 21:00:06 kenny kernel: CPU: L2 cache: 256K
Jan  8 21:00:06 kenny kernel: Intel machine check reporting enabled on =
CPU#0.
Jan  8 21:00:06 kenny kernel: CPU: After vendor init, caps: 0383fbff =
00000000 00000000 00000000
Jan  8 21:00:06 kenny kernel: CPU: After generic, caps: 0383fbff =
00000000 00000000 00000000
Jan  8 21:00:06 kenny kernel: CPU: Common caps: 0383fbff 00000000 =
00000000 00000000
Jan  8 21:00:06 kenny kernel: CPU0: Intel Pentium III (Coppermine) =
stepping 03
Jan  8 21:00:06 kenny kernel: per-CPU timeslice cutoff: 732.10 usecs.
Jan  8 21:00:06 kenny kernel: Getting VERSION: 40011
Jan  8 21:00:06 kenny kernel: Getting VERSION: 40011
Jan  8 21:00:06 kenny kernel: Getting ID: 0
Jan  8 21:00:06 kenny kernel: Getting ID: f000000
Jan  8 21:00:06 kenny kernel: Getting LVT0: 700
Jan  8 21:00:06 kenny kernel: Getting LVT1: 400
Jan  8 21:00:06 kenny kernel: enabled ExtINT on CPU#0
Jan  8 21:00:06 kenny kernel: ESR value before enabling vector: 00000000
Jan  8 21:00:06 kenny kernel: ESR value after enabling vector: 00000000
Jan  8 21:00:06 kenny kernel: CPU present map: 1
Jan  8 21:00:06 kenny kernel: Before bogomips.
Jan  8 21:00:06 kenny kernel: Boot done.
Jan  8 21:00:06 kenny kernel: ENABLING IO-APIC IRQs
Jan  8 21:00:06 kenny kernel: ...changing IO-APIC physical APIC ID to 4 =
... ok.
Jan  8 21:00:06 kenny kernel: ...changing IO-APIC physical APIC ID to 5 =
... ok.
Jan  8 21:00:06 kenny kernel: Synchronizing Arb IDs.
Jan  8 21:00:06 kenny kernel: ..TIMER: vector=3D49 pin1=3D2 pin2=3D0
Jan  8 21:00:06 kenny kernel: ...trying to set up timer (IRQ0) through =
the 8259A ...=20
Jan  8 21:00:06 kenny kernel: ..... (found pin 0) ...works.
Jan  8 21:00:06 kenny kernel: activating NMI Watchdog ... done.
Jan  8 21:00:06 kenny kernel: testing the IO APIC.......................
Jan  8 21:00:06 kenny kernel:=20
Jan  8 21:00:06 kenny kernel:=20
Jan  8 21:00:06 kenny kernel: .................................... done.
Jan  8 21:00:06 kenny kernel: calibrating APIC timer ...
Jan  8 21:00:06 kenny kernel: ..... CPU clock speed is 799.7610 MHz.
Jan  8 21:00:06 kenny kernel: ..... host bus clock speed is 133.2932 =
MHz.
Jan  8 21:00:06 kenny kernel: cpu: 0, clocks: 1332932, slice: 666466
Jan  8 21:00:06 kenny kernel: =
CPU0<T0:1332928,T1:666448,D:14,S:666466,C:1332932>
Jan  8 21:00:06 kenny kernel: Setting commenced=3D1, go go go
Jan  8 21:00:06 kenny kernel: PCI: PCI BIOS revision 2.10 entry at =
0xfdb57, last bus=3D1
Jan  8 21:00:06 kenny kernel: PCI: Using configuration type 1
Jan  8 21:00:06 kenny kernel: PCI: Probing PCI hardware
Jan  8 21:00:06 kenny kernel: PCI: ServerWorks host bridge: secondary =
bus 00
Jan  8 21:00:06 kenny kernel: PCI: ServerWorks host bridge: secondary =
bus 01
Jan  8 21:00:06 kenny kernel: PCI->APIC IRQ transform: (B1,I4,P0) -> 16
Jan  8 21:00:06 kenny kernel: PCI->APIC IRQ transform: (B1,I4,P1) -> 17
Jan  8 21:00:06 kenny kernel: PCI->APIC IRQ transform: (B0,I2,P0) -> 19
Jan  8 21:00:06 kenny kernel: PCI->APIC IRQ transform: (B0,I3,P0) -> 18
Jan  8 21:00:06 kenny kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 16
Jan  8 21:00:06 kenny kernel: Linux NET4.0 for Linux 2.4
Jan  8 21:00:06 kenny kernel: Based upon Swansea University Computer =
Society NET3.039
Jan  8 21:00:06 kenny kernel: P6 Microcode Update Driver v1.07
Jan  8 21:00:06 kenny kernel: Starting kswapd v1.8
Jan  8 21:00:06 kenny kernel: i2c-core.o: i2c core module
Jan  8 21:00:06 kenny kernel: i2c-dev.o: i2c /dev entries driver module
Jan  8 21:00:06 kenny kernel: i2c-core.o: driver i2c-dev dummy driver =
registered.
Jan  8 21:00:06 kenny kernel: pty: 256 Unix98 ptys configured
Jan  8 21:00:06 kenny kernel: loop: enabling 8 loop devices
Jan  8 21:00:06 kenny kernel: Uniform Multi-Platform E-IDE driver =
Revision: 6.31
Jan  8 21:00:06 kenny kernel: ide: Assuming 33MHz system bus speed for =
PIO modes; override with idebus=3Dxx
Jan  8 21:00:06 kenny kernel: ServerWorks OSB4: IDE controller on PCI =
bus 00 dev 79
Jan  8 21:00:06 kenny kernel: ServerWorks OSB4: chipset revision 0
Jan  8 21:00:06 kenny kernel: ServerWorks OSB4: not 100%% native mode: =
will probe irqs later
Jan  8 21:00:06 kenny kernel:     ide0: BM-DMA at 0x5440-0x5447, BIOS =
settings: hda:DMA, hdb:DMA
Jan  8 21:00:06 kenny kernel:     ide1: BM-DMA at 0x5448-0x544f, BIOS =
settings: hdc:DMA, hdd:DMA
Jan  8 21:00:06 kenny kernel: hda: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY =
drive
Jan  8 21:00:06 kenny kernel: hdb: SONY CD-ROM CDU4821, ATAPI CDROM =
drive
Jan  8 21:00:06 kenny kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jan  8 21:00:06 kenny kernel: hdb: ATAPI 48X CD-ROM drive, 128kB Cache, =
UDMA(33)
Jan  8 21:00:06 kenny kernel: Uniform CD-ROM driver Revision: 3.11
Jan  8 21:00:06 kenny kernel: hda: 244766kB, 489532 blocks, 512 sector =
size, =20
Jan  8 21:00:06 kenny kernel: hda: 244736kB, 239/64/32 CHS, 4096 kBps, =
512 sector size, 2941 rpm
Jan  8 21:00:06 kenny kernel: hda: The disk reports a capacity of =
250640384 bytes, but the drive only handles 250609664
Jan  8 21:00:06 kenny kernel: Partition check:
Jan  8 21:00:06 kenny kernel:  hda: hda1
Jan  8 21:00:06 kenny kernel: Serial driver version 5.02 (2000-08-09) =
with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Jan  8 21:00:06 kenny kernel: ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
Jan  8 21:00:06 kenny kernel: ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Jan  8 21:00:06 kenny kernel: Real Time Clock Driver v1.10d
Jan  8 21:00:06 kenny kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker =
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Jan  8 21:00:06 kenny kernel: eepro100.c: $Revision: 1.33 $ 2000/05/24 =
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jan  8 21:00:06 kenny kernel: eth0: OEM i82557/i82558 10/100 Ethernet, =
00:D0:B7:B6:56:7C, IRQ 18.
Jan  8 21:00:06 kenny kernel:   Receiver lock-up bug exists -- enabling =
work-around.
Jan  8 21:00:06 kenny kernel:   Board assembly 000000-000, Physical =
connectors present: RJ45
Jan  8 21:00:06 kenny kernel:   Primary interface chip i82555 PHY #1.
Jan  8 21:00:06 kenny kernel:   General self-test: passed.
Jan  8 21:00:06 kenny kernel:   Serial sub-system self-test: passed.
Jan  8 21:00:06 kenny kernel:   Internal registers self-test: passed.
Jan  8 21:00:06 kenny kernel:   ROM checksum self-test: passed =
(0x04f4518b).
Jan  8 21:00:06 kenny kernel: SCSI subsystem driver Revision: 1.00
Jan  8 21:00:06 kenny kernel: (scsi0) <Adaptec AIC-7899 Ultra 160/m SCSI =
host adapter> found at PCI 1/4/0
Jan  8 21:00:06 kenny kernel: (scsi0) Wide Channel A, SCSI ID=3D7, =
32/255 SCBs
Jan  8 21:00:06 kenny kernel: (scsi0) Downloading sequencer code... 392 =
instructions downloaded
Jan  8 21:00:06 kenny kernel: (scsi1) <Adaptec AIC-7899 Ultra 160/m SCSI =
host adapter> found at PCI 1/4/1
Jan  8 21:00:06 kenny kernel: (scsi1) Wide Channel B, SCSI ID=3D7, =
32/255 SCBs
Jan  8 21:00:06 kenny kernel: (scsi1) Downloading sequencer code... 392 =
instructions downloaded
Jan  8 21:00:06 kenny kernel: scsi0 : Adaptec AHA274x/284x/294x =
(EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
Jan  8 21:00:06 kenny kernel:        <Adaptec AIC-7899 Ultra 160/m SCSI =
host adapter>
Jan  8 21:00:06 kenny kernel: scsi1 : Adaptec AHA274x/284x/294x =
(EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
Jan  8 21:00:06 kenny kernel:        <Adaptec AIC-7899 Ultra 160/m SCSI =
host adapter>
Jan  8 21:00:06 kenny kernel: (scsi0:0:1:0) Synchronous at 80.0 =
Mbyte/sec, offset 63.
Jan  8 21:00:06 kenny kernel:   Vendor: QUANTUM   Model: ATLAS_V__9_SCA  =
  Rev: 0230
Jan  8 21:00:06 kenny kernel:   Type:   Direct-Access                    =
  ANSI SCSI revision: 03
Jan  8 21:00:06 kenny kernel: (scsi0:0:2:0) Synchronous at 80.0 =
Mbyte/sec, offset 63.
Jan  8 21:00:06 kenny kernel:   Vendor: QUANTUM   Model: ATLAS_V__9_SCA  =
  Rev: 0230
Jan  8 21:00:06 kenny kernel:   Type:   Direct-Access                    =
  ANSI SCSI revision: 03
Jan  8 21:00:06 kenny kernel: (scsi0:0:3:0) Synchronous at 80.0 =
Mbyte/sec, offset 63.
Jan  8 21:00:06 kenny kernel:   Vendor: QUANTUM   Model: ATLAS_V__9_SCA  =
  Rev: 0230
Jan  8 21:00:06 kenny kernel:   Type:   Direct-Access                    =
  ANSI SCSI revision: 03
Jan  8 21:00:06 kenny kernel: Detected scsi disk sda at scsi0, channel =
0, id 1, lun 0
Jan  8 21:00:06 kenny kernel: Detected scsi disk sdb at scsi0, channel =
0, id 2, lun 0
Jan  8 21:00:06 kenny kernel: Detected scsi disk sdc at scsi0, channel =
0, id 3, lun 0
Jan  8 21:00:06 kenny kernel: SCSI device sda: 17930694 512-byte hdwr =
sectors (9181 MB)
Jan  8 21:00:06 kenny kernel:  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 =
>
Jan  8 21:00:06 kenny kernel: SCSI device sdb: 17930694 512-byte hdwr =
sectors (9181 MB)
Jan  8 21:00:06 kenny kernel:  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 =
>
Jan  8 21:00:06 kenny kernel: SCSI device sdc: 17930694 512-byte hdwr =
sectors (9181 MB)
Jan  8 21:00:06 kenny kernel:  sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 =
>
Jan  8 21:00:06 kenny kernel: md driver 0.90.0 MAX_MD_DEVS=3D256, =
MAX_REAL=3D12
Jan  8 21:00:06 kenny kernel: raid0 personality registered
Jan  8 21:00:06 kenny kernel: raid5 personality registered
Jan  8 21:00:06 kenny kernel: md.c: sizeof(mdp_super_t) =3D 4096
Jan  8 21:00:06 kenny kernel: raid5: measuring checksumming speed
Jan  8 21:00:06 kenny kernel:    8regs     :  1349.883 MB/sec
Jan  8 21:00:06 kenny kernel:    32regs    :   997.839 MB/sec
Jan  8 21:00:06 kenny kernel:    pIII_sse  :  1698.498 MB/sec
Jan  8 21:00:06 kenny kernel:    pII_mmx   :  1850.517 MB/sec
Jan  8 21:00:06 kenny kernel:    p5_mmx    :  1930.146 MB/sec
Jan  8 21:00:06 kenny kernel: raid5: using function: pIII_sse (1698.498 =
MB/sec)
Jan  8 21:00:06 kenny kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jan  8 21:00:06 kenny kernel: IP Protocols: ICMP, UDP, TCP
Jan  8 21:00:06 kenny kernel: IP: routing cache hash table of 2048 =
buckets, 16Kbytes
Jan  8 21:00:06 kenny kernel: TCP: Hash tables configured (established =
16384 bind 16384)
Jan  8 21:00:06 kenny kernel: NET4: Unix domain sockets 1.0/SMP for =
Linux NET4.0.
Jan  8 21:00:06 kenny kernel: VFS: Mounted root (ext2 filesystem) =
readonly.
Jan  8 21:00:06 kenny kernel: Freeing unused kernel memory: 188k freed
Jan  8 21:00:06 kenny kernel: Adding Swap: 128516k swap-space (priority =
1)
Jan  8 21:00:06 kenny last message repeated 2 times
Jan  8 21:00:06 kenny kernel: (read) sda6's sb offset: 64128 [events: =
0000002c]
Jan  8 21:00:06 kenny kernel: (read) sdb6's sb offset: 64128 [events: =
0000002c]
Jan  8 21:00:06 kenny kernel: (read) sdc6's sb offset: 64128 [events: =
0000002c]
Jan  8 21:00:06 kenny kernel: autorun ...
Jan  8 21:00:06 kenny kernel: considering sdc6 ...
Jan  8 21:00:06 kenny kernel:   adding sdc6 ...
Jan  8 21:00:06 kenny kernel:   adding sdb6 ...
Jan  8 21:00:06 kenny kernel:   adding sda6 ...
Jan  8 21:00:06 kenny kernel: created md0
Jan  8 21:00:06 kenny kernel: bind<sda6,1>
Jan  8 21:00:06 kenny kernel: bind<sdb6,2>
Jan  8 21:00:06 kenny kernel: bind<sdc6,3>
Jan  8 21:00:06 kenny kernel: running: <sdc6><sdb6><sda6>
Jan  8 21:00:06 kenny kernel: now!
Jan  8 21:00:06 kenny kernel: sdc6's event counter: 0000002c
Jan  8 21:00:06 kenny kernel: sdb6's event counter: 0000002c
Jan  8 21:00:06 kenny kernel: sda6's event counter: 0000002c
Jan  8 21:00:06 kenny kernel: md0: max total readahead window set to =
744k
Jan  8 21:00:06 kenny kernel: md0: 3 data-disks, max readahead per =
data-disk: 248k
Jan  8 21:00:06 kenny kernel: raid0: looking at sda6
Jan  8 21:00:06 kenny kernel: raid0:   comparing sda6(64128) with =
sda6(64128)
Jan  8 21:00:06 kenny kernel: raid0:   END
Jan  8 21:00:06 kenny kernel: raid0:   =3D=3D> UNIQUE
Jan  8 21:00:06 kenny kernel: raid0: 1 zones
Jan  8 21:00:06 kenny kernel: raid0: looking at sdb6
Jan  8 21:00:06 kenny kernel: raid0:   comparing sdb6(64128) with =
sda6(64128)
Jan  8 21:00:06 kenny kernel: raid0:   EQUAL
Jan  8 21:00:06 kenny kernel: raid0: looking at sdc6
Jan  8 21:00:06 kenny kernel: raid0:   comparing sdc6(64128) with =
sda6(64128)
Jan  8 21:00:06 kenny kernel: raid0:   EQUAL
Jan  8 21:00:06 kenny kernel: raid0: FINAL 1 zones
Jan  8 21:00:06 kenny kernel: zone 0
Jan  8 21:00:06 kenny kernel:  checking sda6 ... contained as device 0
Jan  8 21:00:06 kenny kernel:   (64128) is smallest!.
Jan  8 21:00:06 kenny kernel:  checking sdb6 ... contained as device 1
Jan  8 21:00:06 kenny kernel:  checking sdc6 ... contained as device 2
Jan  8 21:00:06 kenny kernel:  zone->nb_dev: 3, size: 192384
Jan  8 21:00:06 kenny kernel: current zone offset: 64128
Jan  8 21:00:06 kenny kernel: done.
Jan  8 21:00:06 kenny kernel: raid0 : md_size is 192384 blocks.
Jan  8 21:00:06 kenny kernel: raid0 : conf->smallest->size is 192384 =
blocks.
Jan  8 21:00:06 kenny kernel: raid0 : nb_zone is 1.
Jan  8 21:00:06 kenny kernel: raid0 : Allocating 8 bytes for hash.
Jan  8 21:00:06 kenny kernel: md: updating md0 RAID superblock on device
Jan  8 21:00:06 kenny kernel: sdc6 [events: 0000002d](write) sdc6's sb =
offset: 64128
Jan  8 21:00:06 kenny kernel: sdb6 [events: 0000002d](write) sdb6's sb =
offset: 64128
Jan  8 21:00:06 kenny kernel: sda6 [events: 0000002d](write) sda6's sb =
offset: 64128
Jan  8 21:00:06 kenny kernel: .
Jan  8 21:00:06 kenny kernel: ... autorun DONE.
Jan  8 21:00:06 kenny kernel: (read) sda7's sb offset: 8088576 [events: =
00000021]
Jan  8 21:00:06 kenny kernel: (read) sdb7's sb offset: 8088576 [events: =
00000021]
Jan  8 21:00:06 kenny kernel: (read) sdc7's sb offset: 8088576 [events: =
00000021]
Jan  8 21:00:06 kenny kernel: autorun ...
Jan  8 21:00:06 kenny kernel: considering sdc7 ...
Jan  8 21:00:06 kenny kernel:   adding sdc7 ...
Jan  8 21:00:06 kenny kernel:   adding sdb7 ...
Jan  8 21:00:06 kenny kernel:   adding sda7 ...
Jan  8 21:00:06 kenny kernel: created md1
Jan  8 21:00:06 kenny kernel: bind<sda7,1>
Jan  8 21:00:06 kenny kernel: bind<sdb7,2>
Jan  8 21:00:06 kenny kernel: bind<sdc7,3>
Jan  8 21:00:06 kenny kernel: running: <sdc7><sdb7><sda7>
Jan  8 21:00:06 kenny kernel: now!
Jan  8 21:00:06 kenny kernel: sdc7's event counter: 00000021
Jan  8 21:00:06 kenny kernel: sdb7's event counter: 00000021
Jan  8 21:00:06 kenny kernel: sda7's event counter: 00000021
Jan  8 21:00:06 kenny kernel: md1: max total readahead window set to =
744k
Jan  8 21:00:06 kenny kernel: md1: 3 data-disks, max readahead per =
data-disk: 248k
Jan  8 21:00:06 kenny kernel: raid0: looking at sda7
Jan  8 21:00:06 kenny kernel: raid0:   comparing sda7(8088576) with =
sda7(8088576)
Jan  8 21:00:06 kenny kernel: raid0:   END
Jan  8 21:00:06 kenny kernel: raid0:   =3D=3D> UNIQUE
Jan  8 21:00:06 kenny kernel: raid0: 1 zones
Jan  8 21:00:06 kenny kernel: raid0: looking at sdb7
Jan  8 21:00:06 kenny kernel: raid0:   comparing sdb7(8088576) with =
sda7(8088576)
Jan  8 21:00:06 kenny kernel: raid0:   EQUAL
Jan  8 21:00:06 kenny kernel: raid0: looking at sdc7
Jan  8 21:00:06 kenny kernel: raid0:   comparing sdc7(8088576) with =
sda7(8088576)
Jan  8 21:00:06 kenny kernel: raid0:   EQUAL
Jan  8 21:00:06 kenny kernel: raid0: FINAL 1 zones
Jan  8 21:00:06 kenny kernel: zone 0
Jan  8 21:00:06 kenny kernel:  checking sda7 ... contained as device 0
Jan  8 21:00:06 kenny kernel:   (8088576) is smallest!.
Jan  8 21:00:06 kenny kernel:  checking sdb7 ... contained as device 1
Jan  8 21:00:06 kenny kernel:  checking sdc7 ... contained as device 2
Jan  8 21:00:06 kenny kernel:  zone->nb_dev: 3, size: 24265728
Jan  8 21:00:06 kenny kernel: current zone offset: 8088576
Jan  8 21:00:06 kenny kernel: done.
Jan  8 21:00:06 kenny kernel: raid0 : md_size is 24265728 blocks.
Jan  8 21:00:06 kenny kernel: raid0 : conf->smallest->size is 24265728 =
blocks.
Jan  8 21:00:06 kenny kernel: raid0 : nb_zone is 1.
Jan  8 21:00:06 kenny kernel: raid0 : Allocating 8 bytes for hash.
Jan  8 21:00:06 kenny kernel: md: updating md1 RAID superblock on device
Jan  8 21:00:06 kenny kernel: sdc7 [events: 00000022](write) sdc7's sb =
offset: 8088576
Jan  8 21:00:06 kenny kernel: sdb7 [events: 00000022](write) sdb7's sb =
offset: 8088576
Jan  8 21:00:06 kenny kernel: sda7 [events: 00000022](write) sda7's sb =
offset: 8088576
Jan  8 21:00:06 kenny kernel: .
Jan  8 21:00:06 kenny kernel: ... autorun DONE.
Jan  8 21:00:06 kenny kernel: EXT2-fs warning: mounting unchecked fs, =
running e2fsck is recommended
Jan  8 21:00:06 kenny kernel: EXT2-fs warning: mounting unchecked fs, =
running e2fsck is recommended
Jan  8 21:00:07 kenny kernel: arpwatch uses obsolete =
(PF_INET,SOCK_PACKET)00 
------=_NextPart_000_0000_01C079BC.FB40BBB0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
