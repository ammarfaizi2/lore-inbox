Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWIPUXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWIPUXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 16:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWIPUXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 16:23:25 -0400
Received: from mail.isohunt.com ([69.64.61.20]:4076 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1751167AbWIPUXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 16:23:24 -0400
X-Spam-Check-By: mail.isohunt.com
Date: Sat, 16 Sep 2006 13:38:12 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc7-git1: AHCI not seeing devices on ICH8 mobo (DG965RY)
Message-ID: <20060916203812.GC30391@curie-int.orbis-terrarum.net>
References: <20060914200500.GD27531@curie-int.orbis-terrarum.net> <4509AB2E.1030800@garzik.org> <20060914205050.GE27531@curie-int.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <20060914205050.GE27531@curie-int.orbis-terrarum.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2006 at 01:50:50PM -0700, Robin H. Johnson wrote:
> > Unfortunately the SATA phy isn't showing that a SATA device (hd or cdro=
m=20
> > or anything) is connected.  So can't do anything much at all, if that i=
s=20
> > the case.
> >=20
> > Perhaps re-check all the power connections, cables, etc.
> I neglected to say, that the BIOS sees it perfectly fine, and the
> initial boot sequence perfectly with ISOLINUX (everything just falls
> over later when the initrd tries to load up a squashfs image from the
> CD).
Ok, I picked up some SATA hard drives now, and the AHCI driver DOES see the=
m.
However, it gets more interesting now.

The board has 4 SATA ports.

In the BIOS, all 4 of them work, and can start the bootloader from any
of them.

In the kernel, ONLY the first two ports work.

The only thing I see on this, is that in my original dmesg, when the DVD
drive was connected to the 4th port, and nothing connected on SATA1-3,
SControl was 300 for 1/2 and 0 for 3/4.

libata version 2.00 loaded.
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x33 impl SATA mo=
de
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part=20
ata1: SATA max UDMA/133 cmd 0xFFFFC20000040100 ctl 0x0 bmdma 0x0 irq 74
ata2: SATA max UDMA/133 cmd 0xFFFFC20000040180 ctl 0x0 bmdma 0x0 irq 74
ata3: SATA max UDMA/133 cmd 0xFFFFC20000040200 ctl 0x0 bmdma 0x0 irq 74
ata4: SATA max UDMA/133 cmd 0xFFFFC20000040280 ctl 0x0 bmdma 0x0 irq 74
scsi1 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48=20
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/133
scsi2 : ahci
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48=20
ata2.00: ata2: dev 0 multi count 0
ata2.00: configured for UDMA/133
scsi3 : ahci
ata3: SATA link down (SStatus 0 SControl 0)
scsi4 : ahci
ata4: SATA link down (SStatus 0 SControl 0)
  Vendor: ATA       Model: WDC WD2500JS-00M  Rev: 02.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
=2E..
(picks up the second drive, and continues)

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFDGC0PpIsIjIzwiwRApEmAKCbHOhIJSoZJ5NFI00+H1jqEo865ACfXhVb
tGjFU72E93yeWNLqH9eYV34=
=k1JB
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
