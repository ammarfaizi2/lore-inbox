Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVGBPox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVGBPox (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 11:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVGBPoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 11:44:39 -0400
Received: from smtp2.irishbroadband.ie ([62.231.32.13]:37623 "EHLO
	smtp2.irishbroadband.ie") by vger.kernel.org with ESMTP
	id S261188AbVGBPm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 11:42:59 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: Tony Vroon <chainsaw@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120085446.9743.11.camel@localhost>
References: <1120085446.9743.11.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VkdlJCP7UODfnNxpOxuA"
Organization: Gentoo Linux
Date: Sat, 02 Jul 2005 16:42:05 +0100
Message-Id: <1120318925.21935.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VkdlJCP7UODfnNxpOxuA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-06-29 at 23:50 +0100, Tony Vroon wrote:
> For my Adaptec 29160 card; I see a regression after 2.6.12 final.
> To be exact, these releases work for me:
> 2.6.12
> 2.6.12.1
>=20
> These releases do not work for me:
> 2.6.12-mm1
> 2.6.12-mm2
> 2.6.12-git7
> 2.6.13-rc1
I can add 2.6.13-rc1-mm1 to that list.

> On a working kernel; I see the following:
I'd like to extend this so all devices on this adapter are visible,
perhaps it helps in debugging this case. Note that I also lowered the
tagged queuing depth to the default of 32. This had no effect.:
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level,
high) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

  Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:0): 6.600MB/s transfers (16bit)
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
 target0:0:0: Ending Domain Validation
(scsi0:A:1:0): refuses WIDE negotiation.  Using 8bit transfers
  Vendor: YAMAHA    Model: CRW2100S          Rev: 1.0N
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:1: Beginning Domain Validation
 target0:0:1: Domain Validation skipping write tests
(scsi0:A:1): 20.000MB/s transfers (20.000MHz, offset 7)
 target0:0:1: Ending Domain Validation
(scsi0:A:2:0): refuses WIDE negotiation.  Using 8bit transfers
  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:2: Beginning Domain Validation
 target0:0:2: Domain Validation skipping write tests
(scsi0:A:2): 20.000MB/s transfers (20.000MHz, offset 16)
 target0:0:2: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-ROM PX-40TS    Rev: 1.11
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:3: Beginning Domain Validation
 target0:0:3: Domain Validation skipping write tests
(scsi0:A:3): 20.000MB/s transfers (20.000MHz, offset 15)
 target0:0:3: Ending Domain Validation
  Vendor: QUANTUM   Model: ATLAS10K3_36_SCA  Rev: 020W
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:5:0: Tagged Queuing enabled.  Depth 32
 target0:0:5: Beginning Domain Validation
WIDTH IS 1
(scsi0:A:5): 6.600MB/s transfers (16bit)
(scsi0:A:5): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
 target0:0:5: Ending Domain Validation
  Vendor: SEAGATE   Model: ST373405LC        Rev: 0003
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 32
 target0:0:6: Beginning Domain Validation
WIDTH IS 1(scsi0:A:6): 6.600MB/s transfers (16bit)
(scsi0:A:6): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
 target0:0:6: Ending Domain Validation
SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71775284 512-byte hdwr sectors (36749 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71833096 512-byte hdwr sectors (36779 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 71833096 512-byte hdwr sectors (36779 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 5, lun 0
CSI device sdc: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 143374738 512-byte hdwr sectors (73408 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi0, channel 0, id 6, lun 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sr2: scsi-1 drive
Attached scsi CD-ROM sr2 at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 5
Attached scsi generic sg2 at scsi0, channel 0, id 2, lun 0,  type 5
Attached scsi generic sg3 at scsi0, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg4 at scsi0, channel 0, id 5, lun 0,  type 0
Attached scsi generic sg5 at scsi0, channel 0, id 6, lun 0,  type 0

> On a failing kernel, I see:
I still see this on 2.6.13-rc1-mm1:

ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC3] -> GSI 18 (level,high) -=
> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

target0:0:0: asynchronous
  Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
(scsi0:A:0): refuses tagged commands. Performing non-tagged I/O
 target0:0:0: asynchronous
[The PC hangs at this point]


> lspci output for the adapter:
> 0000:01:08.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
>         Subsystem: Adaptec 29160 Ultra160 SCSI Controller
>         Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
>         BIST result: 00
>         I/O ports at d800 [disabled] [size=3D256]
>         Memory at db000000 (64-bit, non-prefetchable) [size=3D4K]
>         Capabilities: [dc] Power Management version 2

> Please let me know if there are specific patches I need to apply or
> revert to debug this.

This stands. I would like to debug this, but a few recommendations of
what to do and where to start would be appreciated.

>  I have more drives on this controller; to be exact
> I have 2 U320-capable drives and one U160-capable drive on wide channel
> A; and 3 removable media units (CD-R, DVD, CD-ROM) on the 50-pin
> SCSI-bus.

Thanks,
Tony.
(Please CC replies to me as I am not subscribed to LKML or linux-scsi)

--=-VkdlJCP7UODfnNxpOxuA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCxrXNp5vW4rUFj5oRAmFGAJ9NZmw2wI+kqlCnXtiqWuXgMmqONgCfVozk
7AcCNQzY3WPAqzwJVt5RZcU=
=q13x
-----END PGP SIGNATURE-----

--=-VkdlJCP7UODfnNxpOxuA--

