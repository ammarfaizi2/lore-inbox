Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSH0MBQ>; Tue, 27 Aug 2002 08:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSH0MBQ>; Tue, 27 Aug 2002 08:01:16 -0400
Received: from B5764.pppool.de ([213.7.87.100]:896 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S315634AbSH0MBP>; Tue, 27 Aug 2002 08:01:15 -0400
Subject: VIA Apollo IDE UDMA1?
From: Daniel Egger <degger@fhm.edu>
To: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-kGJ5QHUQceZcdFq+mdN5"
X-Mailer: Ximian Evolution 1.0.7 
Date: 27 Aug 2002 13:28:48 +0200
Message-Id: <1030447729.2539.21.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kGJ5QHUQceZcdFq+mdN5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hija,

further investigation on my last mail discovered that another thing is
fishy; my first IDE drive works only un UDMA1 mode which is choosen by
the driver. Apart from never having seen that 22MB/s mode before both
the chipset and the drive are capable of more, the two drives on the
second channel also run in UDMA2.

The drive is a:
ATA device, with non-removable media
        Model Number:       WDC WD400EB-00CPF0                     =20
        Serial Number:      WD-WCAAT63853**
        Firmware Revision:  06.04G06
Standards:
        Supported: 5 4 3 2=20
        Likely used: 6
Configuration:
        Logical         max     current
        cylinders       16383   4047
        heads           16      16
        sectors/track   63      255
        --
        CHS current addressable sectors:   16511760
        LBA    user addressable sectors:   78165360
        device size with M =3D 1024*1024:       38166 MBytes
        device size with M =3D 1000*1000:       40020 MBytes (40 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 40     Queue depth: 1
        Standby timer values: spec'd by Standard, with device specific mini=
mum
        R/W multiple sector transfer: Max =3D 16  Current =3D 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 *udma1 udma2 udma3 udma4 udma5=20
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4=20
             Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s

and everything from the last report is the same here.
/proc/ide/via says:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x47 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xe000
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA      UDMA      UDMA
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:          90ns     600ns      60ns      60ns
Transfer Rate:   22.0MB/s   3.3MB/s  33.0MB/s  33.0MB/s


--=20
Servus,
       Daniel

--=-kGJ5QHUQceZcdFq+mdN5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9a2Jwchlzsq9KoIYRAv5xAKDZboBck66TZ9eQu3cf6th9Q0c88wCguI+E
MxyDHRNY+ksR1WjI4CCSQT8=
=xCqR
-----END PGP SIGNATURE-----

--=-kGJ5QHUQceZcdFq+mdN5--

