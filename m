Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbTFSEtu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 00:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265433AbTFSEtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 00:49:50 -0400
Received: from tehunlose.com ([68.15.181.213]:22699 "EHLO
	cerebellum.tehunlose.com") by vger.kernel.org with ESMTP
	id S265431AbTFSEtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 00:49:39 -0400
From: Zack Gilburd <zack@tehunlose.com>
To: linux-kernel@vger.kernel.org
Subject: aic7xxx and SiI3112 problems (2.4.21[-ac1] and 2.5.7x)
Date: Wed, 18 Jun 2003 22:03:34 -0700
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_oQU8+lkqff6vMcK";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200306182203.36845.zack@tehunlose.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_oQU8+lkqff6vMcK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Long reader, first time poster -- please go lightly if I've forgotten to=20
include any essential information.

I have an Adaptec 29160N that uses the aic7xxx driver.  I have had no probl=
ems=20
with this driver in 2.4.20, but in 2.4.21, my drives fail parity checks. =20
I've gone back and forward between 2.4.20 kernels and 2.4.21 kernels just t=
o=20
make sure it wasn't the drive's fault.  The exact error message(s) are at t=
he=20
middle-end of this email.

I have tried to solve the problem by disabling parity checks on the card to=
 no=20
avail.  I've also tried compiling certain options in with the driver to,=20
again, no avail.

Now, on to the SiI3112 problems that I am having.  When I run the 2.5.7x=20
kernel without the SiI3112 support, everything goes along just fine. =20
However, when I compile support in, I recieve the errors at the VERY end of=
=20
this email.  The errors eventually go away (or at least they're no longer=20
reported to me in metalog) after mid-boot (when Gentoo is "calculating modu=
le=20
dependencies").  If I log in and try to do anything regarding the disk=20
(including but not limited to both `hdparm -i /dev/hdX` and `fdisk=20
/dev/hdX`), the system hardlocks and I cannot even SSH in.

Of course, IANAKH so I can't contribute patches, sorry.

Any help is very appreciated

******** aic7xxx stuff in 2.4.21[-ac1] ********

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

blk: queue f7e6f014, I/O limit 4095Mb (mask 0xffffffff)
  Vendor: QUANTUM   Model: ATLAS10K3_18_WLS  Rev: 020W
  Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue f7e6f214, I/O limit 4095Mb (mask 0xffffffff)
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
(scsi0:A:6:1): parity error detected in Data-in phase. SEQADDR(0x77)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
scsi0:A:6:0: Tagged Queuing enabled.  Depth 253
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W4012A  Rev: 1.00
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 6, lun 0
SCSI device sda: 35916548 512-byte hdwr sectors (18389 MB)
 /dev/scsi/host0/bus0/target6/lun0:(scsi0:A:6:0): parity error detected in=
=20
Data-in phase. SEQADDR(0x8b) SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 0
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x1a3)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 2
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 4
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 6
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 0
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x89)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 2
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 4
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8b)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
(scsi0:A:6:0): parity error detected in Data-in phase. SEQADDR(0x8a)=20
SCSIRATE(0xc2)
        CRC Value Mismatch
SCSI disk error : host 0 channel 0 id 6 lun 0 return code =3D 8000002
Current sd08:00: sns =3D 70  b
ASC=3D48 ASCQ=3D 0
Raw sense data:0x70 0x00 0x0b 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00=
=20
0x48 0x00 0x00 0x00 0x00 0x00
 I/O error: dev 08:00, sector 6
 unable to read partition table

******** END OF aic7xxx stuff in 2.4.21[-ac1] ********

******** START OF SiI3112 errors in 2.5.7x ******

Jun 16 15:34:37 [kernel] bad: scheduling while atomic!
Jun 16 15:34:37 [kernel] bad: scheduling while atomic!
                - Last output repeated 243 times -
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
Jun 16 15:34:38 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:38 [kernel] bad: scheduling while atomic!
                - Last output repeated 153 times -
Jun 16 15:34:40 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:40 [kernel] bad: scheduling while atomic!
                - Last output repeated 149 times -
Jun 16 15:34:44 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:44 [kernel] bad: scheduling while atomic!
Jun 16 15:34:44 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:44 [kernel] bad: scheduling while atomic!
Jun 16 15:34:44 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:44 [kernel] bad: scheduling while atomic!
Jun 16 15:34:44 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:44 [kernel] bad: scheduling while atomic!
Jun 16 15:34:44 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
Jun 16 15:34:45 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:45 [kernel] bad: scheduling while atomic!
                - Last output repeated 734 times -
Jun 16 15:34:46 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:46 [kernel] bad: scheduling while atomic!
Jun 16 15:34:46 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:46 [kernel] bad: scheduling while atomic!
Jun 16 15:34:46 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:46 [kernel] bad: scheduling while atomic!
Jun 16 15:34:46 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:46 [kernel] bad: scheduling while atomic!
                - Last output repeated 43 times -
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
Jun 16 15:34:48 [kernel] Call Trace: [<c0106e70>]  [<c0116ab9>]  [<c0106e70=
>] =20
[<c0106e70>]  [<c0106e70>]  [<c0106f15>]  [<c0105000>]  [<c046a6a8>] =20
[<c046a420>]
Jun 16 15:34:48 [kernel] bad: scheduling while atomic!
****** END OF SiI3112 errors in 2.5.7x ******
=2D-=20
Zack Gilburd
http://tehunlose.com

--Boundary-02=_oQU8+lkqff6vMcK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+8UQop5pFZoJAq2wRApZfAKCYZqQ8OI+M9esUe+rW7a5LO6/zvgCg2uzH
/jIXVukatPPr+B2TCU5orBQ=
=Dud+
-----END PGP SIGNATURE-----

--Boundary-02=_oQU8+lkqff6vMcK--

