Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVLNIwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVLNIwx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVLNIwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:52:53 -0500
Received: from smtp04.auna.com ([62.81.186.14]:43758 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S932162AbVLNIww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:52:52 -0500
Date: Wed, 14 Dec 2005 09:54:59 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: SMP+nosmp=hang [was: Re: 2.6.15-rc5-mm2]
Message-ID: <20051214095459.3912d59e@werewolf.auna.net>
In-Reply-To: <20051211041308.7bb19454.akpm@osdl.org>
References: <20051211041308.7bb19454.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs86 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_xE3kqP4ZBrQvc88O8V72s=a";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.219.198] Login:jamagallon@able.es Fecha:Wed, 14 Dec 2005 09:52:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_xE3kqP4ZBrQvc88O8V72s=a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 11 Dec 2005 04:13:08 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/=
2.6.15-rc5-mm2/
>=20

Booting a SMP built kernel with 'nosmp' just hangs at the VFS layer, with
the message about 'not being able to find root device sda1'.
sda is a SATA drive on an Intel ICH5 controller:

libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:=
407f
ata1: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0xC807
scsi1 : ata_piix
  Vendor: ATA       Model: ST3200822AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda

I would have to double check, but I think it even missed the USB keyboard.

Something really strange...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam4 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_xE3kqP4ZBrQvc88O8V72s=a
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDn93jRlIHNEGnKMMRAqhtAKCi0gl+spMr6POtPhjTC8QvlGCumQCfadSc
FJgV8pJPGlzzFA/grS6iTdA=
=miOP
-----END PGP SIGNATURE-----

--Sig_xE3kqP4ZBrQvc88O8V72s=a--
