Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317102AbSHTTLZ>; Tue, 20 Aug 2002 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSHTTLY>; Tue, 20 Aug 2002 15:11:24 -0400
Received: from taco.vianet.on.ca ([209.91.128.11]:35524 "HELO smtp.vianet.ca")
	by vger.kernel.org with SMTP id <S317102AbSHTTLO>;
	Tue, 20 Aug 2002 15:11:14 -0400
Message-ID: <3D629547.5090600@thirddimension.net>
Date: Tue, 20 Aug 2002 15:15:19 -0400
From: Reid Sutherland <reid-lkml@thirddimension.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Interrupt issue with 2.4.19 vs 2.4.18.
References: <3D5D527E.5030607@thirddimension.net>
Content-Type: multipart/mixed;
 boundary="------------080006090807000408030906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080006090807000408030906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This issue has been fixed in 2.4.20-pre1.  I don't know exactly what 
patch fixed it, but I suspect it could be Alan's massive patch.

o fix aic7xxx build when PCI=n

It's really hard for me to tell where it was fixed, all I know is it 
working now!

So if you had the problem attached to this email, it looks like it's 
sovled in 2.4.20pre1.  Or you can revert to 2.4.18.

Hope this helps someone.


-reid



Reid Sutherland wrote:
> Hi everyone,
> 
> I have a problem with the aic7xxx constantly retrying to initialize my 
> LVD SCSI drives.  I'm repeatedly getting a "Command already completed" 
> message.  It was mentioned to me that this might be an interrupt related 
> problem (thank you Justin!).
> 
> My board has a Intel 440GX chipset.  From my understanding these are a 
> bitch to deal with and are littered with bugs.  I've also read that by 
> enabling SMP or IO-APIC, it should solve this issue.  Well, neither does 
> it for me.
> 
> Does anyone know what could have changed between .18 and .19 that would 
> cause something like this to happen?
> 
> Any insight would be appreciated!
> 
> Thanks,
> 
> -reid
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



--------------080006090807000408030906
Content-Type: text/plain;
 name="2.4.19-aic7xxx.output.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="2.4.19-aic7xxx.output.txt"

Linux version 2.4.19 (root@victim) (gcc version 2.95.4 20011002 (Debian p=
rerelease)) #4 Fri Aug 16 10:21:41 EDT 2002

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)

 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)

 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)

 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)

 BIOS-e820: 000000000fff0000 - 000000000ffffc00 (ACPI data)

 BIOS-e820: 000000000ffffc00 - 0000000010000000 (ACPI NVS)

 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)

 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)

 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)

255MB LOWMEM available.

found SMP MP-table at 000f6b40

hm, page 000f6000 reserved twice.

hm, page 000f7000 reserved twice.

hm, page 0009f000 reserved twice.

hm, page 000a0000 reserved twice.

On node 0 totalpages: 65520

zone(0): 4096 pages.

zone(1): 61424 pages.

zone(2): 0 pages.

Intel MultiProcessor Specification v1.4

    Virtual Wire compatibility mode.

OEM ID: INTEL    Product ID: Lancewood    APIC at: 0xFEE00000

Processor #1 Pentium(tm) Pro APIC version 17

I/O APIC #0 Version 17 at 0xFEC00000.

Processors: 1

Kernel command line: BOOT_IMAGE=3DLinux ro root=3D802 console=3DttyS0,tty=
0

Initializing CPU#0

Detected 596.923 MHz processor.

Console: colour VGA+ 80x25

Calibrating delay loop... 1189.47 BogoMIPS

Memory: 256488k/262080k available (1090k kernel code, 5204k reserved, 318=
k data, 224k init, 0k highmem)

Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)

Inode cache hash table entries: 16384 (order: 5, 131072 bytes)

Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)

Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)

Page-cache hash table entries: 65536 (order: 6, 262144 bytes)

CPU: L1 I cache: 16K, L1 D cache: 16K

CPU: L2 cache: 256K

CPU serial number disabled.

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: Intel Pentium III (Coppermine) stepping 01

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

enabled ExtINT on CPU#0

ESR value before enabling vector: 00000000

ESR value after enabling vector: 00000000

Using local APIC timer interrupts.

calibrating APIC timer ...

=2E.... CPU clock speed is 596.9264 MHz.

=2E.... host bus clock speed is 99.4876 MHz.

cpu: 0, clocks: 994876, slice: 497438

CPU0<T0:994864,T1:497424,D:2,S:497438,C:994876>

mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)

mtrr: detected mtrr type: Intel

PCI: PCI BIOS revision 2.10 entry at 0xfdab0, last bus=3D2

PCI: Using configuration type 1

PCI: Probing PCI hardware

Unknown bridge resource 0: assuming transparent

Unknown bridge resource 1: assuming transparent

Unknown bridge resource 2: assuming transparent

Unknown bridge resource 0: assuming transparent

Unknown bridge resource 1: assuming transparent

Unknown bridge resource 2: assuming transparent

PCI: Discovered primary peer bus ff [IRQ]

PCI: Using IRQ router PIIX [8086/7110] at 00:12.0

isapnp: Scanning for PnP cards...

isapnp: No Plug & Play device found

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

apm: BIOS not found.

Starting kswapd

VFS: Diskquotas version dquot_6.4.0 initialized

Journalled Block Device driver loaded

ACPI: Core Subsystem version [20011018]

ACPI: Subsystem enabled

pty: 256 Unix98 ptys configured

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL=
_PCI ISAPNP enabled

ttyS00 at 0x03f8 (irq =3D 4) is a 16550A

ttyS01 at 0x02f8 (irq =3D 3) is a 16550A

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/ee=
pro100.html

eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin =
<saw@saw.sw.com.sg> and others

PCI: Assigned IRQ 11 for device 00:09.0

PCI: Sharing IRQ 11 with 00:0c.0

PCI: Sharing IRQ 11 with 00:0c.1

eth0: Intel Corp. 82557/8/9 [Ethernet Pro 100], 00:D0:B7:85:C0:4B, IRQ 11=
=2E

  Board assembly 729757-006, Physical connectors present: RJ45

  Primary interface chip i82555 PHY #1.

  General self-test: passed.

  Serial sub-system self-test: passed.

  Internal registers self-test: passed.

  ROM checksum self-test: passed (0x04f4518b).

PCI: Assigned IRQ 10 for device 00:0e.0

PCI: Sharing IRQ 10 with 00:12.2

eth1: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2), 00:D0:B7:65:CD:AF, I=
RQ 10.

  Board assembly 000000-000, Physical connectors present: RJ45

  Primary interface chip i82555 PHY #1.

  General self-test: passed.

  Serial sub-system self-test: passed.

  Internal registers self-test: passed.

  ROM checksum self-test: passed (0x04f4518b).

SCSI subsystem driver Revision: 1.00

PCI: Found IRQ 11 for device 00:0c.0

PCI: Sharing IRQ 11 with 00:09.0

PCI: Sharing IRQ 11 with 00:0c.1

PCI: Found IRQ 11 for device 00:0c.1

PCI: Sharing IRQ 11 with 00:09.0

PCI: Sharing IRQ 11 with 00:0c.0

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8

        <Adaptec aic7896/97 Ultra2 SCSI adapter>

        aic7896/97: Ultra2 Wide Channel A, SCSI Id=3D7, 32/253 SCBs


scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8

        <Adaptec aic7896/97 Ultra2 SCSI adapter>

        aic7896/97: Ultra2 Wide Channel B, SCSI Id=3D7, 32/253 SCBs


scsi0:0:0:0: Attempting to queue an ABORT message

scsi0: Dumping Card State while idle, at SEQADDR 0x8

ACCUM =3D 0x0, SINDEX =3D 0x3, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80

SSTAT0 =3D 0x0, SSTAT1 =3D 0xa

STACK =3D=3D 0x3, 0x107, 0x15f, 0x0

SCB count =3D 4

Kernel NEXTQSCB =3D 2

Card NEXTQSCB =3D 2

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0xff) 1(c 0x0, s 0xff, l 255,=
 t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) =
4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, =
s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l=
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t =
0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 1=
3(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0=
, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xf=
f, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 25=
5, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0x=
ff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(=
c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, =
s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff,=
 l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255,=
 t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list:=20

Kernel Free SCB list: 3 1 0=20

DevQ(0:0:0): 0 waiting

scsi0:0:0:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:0:0: Attempting to queue an ABORT message

scsi0: Dumping Card State in Message-out phase, at SEQADDR 0xe7

ACCUM =3D 0xa0, SINDEX =3D 0x61, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0xa0, SCSISIGI =3D 0xb6, SXFRCTL0 =3D 0x88

SSTAT0 =3D 0x2, SSTAT1 =3D 0x3

STACK =3D=3D 0xe6, 0x175, 0x15f, 0x0

SCB count =3D 4

Kernel NEXTQSCB =3D 3

Card NEXTQSCB =3D 3

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 =
20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0x2) 1(c 0x0, s 0xff, l 255, =
t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) 4=
(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, s=
 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l =
255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t 0=
xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 13=
(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0,=
 s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xff=
, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 255=
, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0xf=
f) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(c=
 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, s=
 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff, =
l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255, =
t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list: 2(c 0x40, s 0x7, l 0)

Kernel Free SCB list: 1 0=20

Untagged Q(0): 2=20

DevQ(0:0:0): 0 waiting

scsi0:0:0:0: Device is active, asserting ATN

Recovery code sleeping

Recovery code awake

Timer Expired

aic7xxx_abort returns 0x2003

scsi0:0:0:0: Attempting to queue a TARGET RESET message

aic7xxx_dev_reset returns 0x2003

Recovery SCB completes

scsi0:0:0:0: Attempting to queue an ABORT message

ahc_intr: HOST_MSG_LOOP bad phase 0x0

scsi0: Dumping Card State while idle, at SEQADDR 0x46

ACCUM =3D 0xa0, SINDEX =3D 0x61, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x88

SSTAT0 =3D 0x0, SSTAT1 =3D 0x0

STACK =3D=3D 0x15f, 0x0, 0xe5, 0x3

SCB count =3D 4

Kernel NEXTQSCB =3D 2

Card NEXTQSCB =3D 3

QINFIFO entries: 3=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x40, s 0x7, l 0, t 0xff) 1(c 0x0, s 0xff, l 255,=
 t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) =
4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, =
s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l=
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t =
0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 1=
3(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0=
, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xf=
f, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 25=
5, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0x=
ff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(=
c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, =
s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff,=
 l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255,=
 t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list: 3(c 0x50, s 0x7, l 0)

Kernel Free SCB list: 1 0=20

Untagged Q(0): 3=20

DevQ(0:0:0): 0 waiting

scsi0:0:0:0: Cmd aborted from QINFIFO

aic7xxx_abort returns 0x2002

scsi: device set offline - not ready or command retry failed after bus re=
set: host 0 channel 0 id 0 lun 0

scsi0:0:1:0: Attempting to queue an ABORT message

scsi0: Dumping Card State while idle, at SEQADDR 0x9

ACCUM =3D 0x0, SINDEX =3D 0x2, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80

SSTAT0 =3D 0x0, SSTAT1 =3D 0xa

STACK =3D=3D 0x3, 0x107, 0x15f, 0xe5

SCB count =3D 4

Kernel NEXTQSCB =3D 3

Card NEXTQSCB =3D 3

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x40, s 0x17, l 0, t 0xff) 1(c 0x0, s 0xff, l 255=
, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff)=
 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0,=
 s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, =
l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t=
 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) =
13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x=
0, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0x=
ff, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 2=
55, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0=
xff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24=
(c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0,=
 s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff=
, l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255=
, t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list:=20

Kernel Free SCB list: 2 1 0=20

DevQ(0:0:0): 0 waiting

DevQ(0:1:0): 0 waiting

scsi0:0:1:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:1:0: Attempting to queue an ABORT message

scsi0: Dumping Card State in Message-out phase, at SEQADDR 0x167

ACCUM =3D 0xa0, SINDEX =3D 0x61, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0xa0, SCSISIGI =3D 0xb6, SXFRCTL0 =3D 0x88

SSTAT0 =3D 0x2, SSTAT1 =3D 0x3

STACK =3D=3D 0x175, 0x15f, 0xe5, 0xe6

SCB count =3D 4

Kernel NEXTQSCB =3D 2

Card NEXTQSCB =3D 2

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 =
20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x40, s 0x17, l 0, t 0x3) 1(c 0x0, s 0xff, l 255,=
 t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) =
4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, =
s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l=
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t =
0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 1=
3(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0=
, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xf=
f, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 25=
5, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0x=
ff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(=
c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, =
s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff,=
 l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255,=
 t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list: 3(c 0x40, s 0x17, l 0)

Kernel Free SCB list: 1 0=20

Untagged Q(1): 3=20

DevQ(0:0:0): 0 waiting

DevQ(0:1:0): 0 waiting

scsi0:0:1:0: Device is active, asserting ATN

Recovery code sleeping

Recovery code awake

aic7xxx_abort returns 0x2002

scsi0:0:1:0: Attempting to queue a TARGET RESET message

aic7xxx_dev_reset returns 0x2003

Recovery SCB completes

scsi0:0:1:0: Attempting to queue an ABORT message

ahc_intr: HOST_MSG_LOOP bad phase 0x0

scsi0: Dumping Card State while idle, at SEQADDR 0x46

ACCUM =3D 0xa0, SINDEX =3D 0x61, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x88

SSTAT0 =3D 0x0, SSTAT1 =3D 0x0

STACK =3D=3D 0x15f, 0xe5, 0xe5, 0x3

SCB count =3D 4

Kernel NEXTQSCB =3D 3

Card NEXTQSCB =3D 2

QINFIFO entries: 2=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x40, s 0x17, l 0, t 0xff) 1(c 0x0, s 0xff, l 255=
, t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff)=
 4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0,=
 s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, =
l 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t=
 0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) =
13(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x=
0, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0x=
ff, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 2=
55, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0=
xff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24=
(c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0,=
 s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff=
, l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255=
, t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list: 2(c 0x50, s 0x17, l 0)

Kernel Free SCB list: 1 0=20

Untagged Q(1): 2=20

DevQ(0:0:0): 0 waiting

DevQ(0:1:0): 0 waiting

scsi0:0:1:0: Cmd aborted from QINFIFO

aic7xxx_abort returns 0x2002

scsi: device set offline - not ready or command retry failed after bus re=
set: host 0 channel 0 id 1 lun 0

scsi0:0:2:0: Attempting to queue an ABORT message

scsi0: Dumping Card State while idle, at SEQADDR 0x46

ACCUM =3D 0x3, SINDEX =3D 0x48, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80

SSTAT0 =3D 0x0, SSTAT1 =3D 0x0

STACK =3D=3D 0x175, 0xe5, 0xe5, 0x3

SCB count =3D 4

Kernel NEXTQSCB =3D 2

Card NEXTQSCB =3D 2

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x0, s 0x27, l 0, t 0xff) 1(c 0x0, s 0xff, l 255,=
 t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) =
4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, =
s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l=
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t =
0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 1=
3(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0=
, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xf=
f, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 25=
5, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0x=
ff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(=
c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, =
s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff,=
 l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255,=
 t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list:=20

Kernel Free SCB list: 3 1 0=20

DevQ(0:0:0): 0 waiting

DevQ(0:1:0): 0 waiting

scsi0:0:2:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:2:0: Attempting to queue an ABORT message

scsi0: Dumping Card State while idle, at SEQADDR 0x46

ACCUM =3D 0x2, SINDEX =3D 0x48, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80

SSTAT0 =3D 0x0, SSTAT1 =3D 0x0

STACK =3D=3D 0x175, 0xe5, 0xe5, 0x3

SCB count =3D 4

Kernel NEXTQSCB =3D 3

Card NEXTQSCB =3D 3

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x0, s 0x27, l 0, t 0xff) 1(c 0x0, s 0xff, l 255,=
 t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) =
4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, =
s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l=
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t =
0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 1=
3(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0=
, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xf=
f, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 25=
5, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0x=
ff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(=
c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, =
s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff,=
 l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255,=
 t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list:=20

Kernel Free SCB list: 2 1 0=20

DevQ(0:0:0): 0 waiting

DevQ(0:1:0): 0 waiting

scsi0:0:2:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:2:0: Attempting to queue a TARGET RESET message

scsi0:0:2:0: Is not an active device

aic7xxx_dev_reset returns 0x2002

scsi0:0:2:0: Attempting to queue an ABORT message

scsi0: Dumping Card State while idle, at SEQADDR 0x45

ACCUM =3D 0x3, SINDEX =3D 0x48, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80

SSTAT0 =3D 0x0, SSTAT1 =3D 0x0

STACK =3D=3D 0x175, 0xe5, 0xe5, 0x3

SCB count =3D 4

Kernel NEXTQSCB =3D 2

Card NEXTQSCB =3D 2

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x0, s 0x27, l 0, t 0xff) 1(c 0x0, s 0xff, l 255,=
 t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) =
4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, =
s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l=
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t =
0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 1=
3(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0=
, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xf=
f, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 25=
5, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0x=
ff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(=
c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, =
s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff,=
 l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255,=
 t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list:=20

Kernel Free SCB list: 3 1 0=20

DevQ(0:0:0): 0 waiting

DevQ(0:1:0): 0 waiting

scsi0:0:2:0: Command already completed

aic7xxx_abort returns 0x2002

scsi0:0:2:0: Attempting to queue an ABORT message

scsi0: Dumping Card State while idle, at SEQADDR 0x46

ACCUM =3D 0x2, SINDEX =3D 0x48, DINDEX =3D 0xe4, ARG_2 =3D 0x0

HCNT =3D 0x0 SCBPTR =3D 0x0

SCSISEQ =3D 0x12, SBLKCTL =3D 0xa

 DFCNTRL =3D 0x0, DFSTATUS =3D 0x89

LASTPHASE =3D 0x1, SCSISIGI =3D 0x0, SXFRCTL0 =3D 0x80

SSTAT0 =3D 0x0, SSTAT1 =3D 0x0

STACK =3D=3D 0x175, 0xe5, 0xe5, 0x3

SCB count =3D 4

Kernel NEXTQSCB =3D 3

Card NEXTQSCB =3D 3

QINFIFO entries:=20

Waiting Queue entries:=20

Disconnected Queue entries:=20

QOUTFIFO entries:=20

Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 1=
9 20 21 22 23 24 25 26 27 28 29 30 31=20

Sequencer SCB Info: 0(c 0x0, s 0x27, l 0, t 0xff) 1(c 0x0, s 0xff, l 255,=
 t 0xff) 2(c 0x0, s 0xff, l 255, t 0xff) 3(c 0x0, s 0xff, l 255, t 0xff) =
4(c 0x0, s 0xff, l 255, t 0xff) 5(c 0x0, s 0xff, l 255, t 0xff) 6(c 0x0, =
s 0xff, l 255, t 0xff) 7(c 0x0, s 0xff, l 255, t 0xff) 8(c 0x0, s 0xff, l=
 255, t 0xff) 9(c 0x0, s 0xff, l 255, t 0xff) 10(c 0x0, s 0xff, l 255, t =
0xff) 11(c 0x0, s 0xff, l 255, t 0xff) 12(c 0x0, s 0xff, l 255, t 0xff) 1=
3(c 0x0, s 0xff, l 255, t 0xff) 14(c 0x0, s 0xff, l 255, t 0xff) 15(c 0x0=
, s 0xff, l 255, t 0xff) 16(c 0x0, s 0xff, l 255, t 0xff) 17(c 0x0, s 0xf=
f, l 255, t 0xff) 18(c 0x0, s 0xff, l 255, t 0xff) 19(c 0x0, s 0xff, l 25=
5, t 0xff) 20(c 0x0, s 0xff, l 255, t 0xff) 21(c 0x0, s 0xff, l 255, t 0x=
ff) 22(c 0x0, s 0xff, l 255, t 0xff) 23(c 0x0, s 0xff, l 255, t 0xff) 24(=
c 0x0, s 0xff, l 255, t 0xff) 25(c 0x0, s 0xff, l 255, t 0xff) 26(c 0x0, =
s 0xff, l 255, t 0xff) 27(c 0x0, s 0xff, l 255, t 0xff) 28(c 0x0, s 0xff,=
 l 255, t 0xff) 29(c 0x0, s 0xff, l 255, t 0xff) 30(c 0x0, s 0xff, l 255,=
 t 0xff) 31(c 0x0, s 0xff, l 255, t 0xff)=20

Pending list:=20

Kernel Free SCB list: 2 1 0=20

DevQ(0:0:0): 0 waiting

DevQ(0:1:0): 0 waiting

scsi0:0:2:0: Command already completed

aic7xxx_abort returns 0x2002

scsi: device set offline - not ready or command retry failed after bus re=
set: host 0 channel 0 id 2 lun 0



--------------080006090807000408030906--

