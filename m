Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263512AbTJBVxR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263514AbTJBVxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:53:17 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:16799 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S263512AbTJBVxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:53:14 -0400
Subject: Re: Serial ATA on Dell Dimension 8300 (Was: Re: Serial ATA support
	in	2.4.22)
From: Martin List-Petersen <martin@list-petersen.se>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Marold <andrew.marold@wlm.edial.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
In-Reply-To: <3F7C9CFF.8090002@pobox.com>
References: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>
	 <3F7AEF15.1070301@pobox.com>  <3F7B0209.7070509@pobox.com>
	 <1065130970.5842.193.camel@loke>  <3F7C9CFF.8090002@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KfaOETIf61t6CFcAaj59"
Message-Id: <1065131571.5842.196.camel@loke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 02 Oct 2003 23:52:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KfaOETIf61t6CFcAaj59
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-10-02 at 23:47, Jeff Garzik wrote:
> Martin List-Petersen wrote:
> > I simply can't figure out, whats wrong here.
>=20
> The last line gives it away...
>=20
>=20
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebu=
s=3Dxx
> > ICH5: IDE controller at PCI slot 00:1f.1
> > ICH5: chipset revision 2
> > ICH5: not 100% native mode: will probe irqs later
> >     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
> > ICH5-SATA: IDE controller at PCI slot 00:1f.2
> > ICH5-SATA: chipset revision 2
> > ICH5-SATA: 100% native mode on irq 18
> >     ide0: BM-DMA at 0xfea0-0xfea7, BIOS settings: hda:DMA, hdb:pio
> > hda: ST3120026AS, ATA DISK drive
> > hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
> > hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x50)
> > blk: queue c041d460, I/O limit 4095Mb (mask 0xffffffff)
> > hdc: SAMSUNG DVD-ROM SD-616T, ATAPI CD/DVD-ROM drive
> > hdd: _NEC DVD+RW ND-1100A, ATAPI CD/DVD-ROM drive
> > ide0 at 0xfe00-0xfe07,0xfe12 on irq 18
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: attached ide-disk driver.
> > hda: host protected area =3D> 1
> > hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=3D14589/255/63,=
 UDMA(33)
> > hdc: attached ide-cdrom driver.
> > hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> > Uniform CD-ROM driver Revision: 3.12
> > hdd: attached ide-cdrom driver.
> > hdd: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> > Partition check:
> >  /dev/ide/host0/bus0/target0/lun0: p1 p2
>=20
> > Please append a correct "root=3D" boot option
> > Kernel panic: VFS: Unable to mount root fs on 08:02
>=20
> You gave it an incorrect root=3D statement.  The IDE driver picks up=20
> ICH5-SATA, as you see above, so you would use root=3D/dev/hda1 or whateve=
r.

No .. that's exactly the point. Check the other dmesg out, which is the
same machine, same partitions, same kernel-config (nearly) just another
kernel. It's not the root=3D boot option that is wrong. that is correct.

It points to /dev/sda2 and that is exactly the same partition i boot to
every time.

Regards,
Martin List-Petersen
martin at list-petersen dot se
--
Q: What's the difference between the 1950's and the 1980's?
A: In the 80's, a man walks into a drugstore and states loudly, "I'd
like some condoms," and then, leaning over the counter, whispers,
"and some cigarettes."

--=-KfaOETIf61t6CFcAaj59
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/fJ4zzAGaxP8W1ugRAluJAKCaLNDUTLS3fniGS8alhdme/s4M5QCg29oR
4ca+pwCnrpLxtyAos05niIM=
=O+ED
-----END PGP SIGNATURE-----

--=-KfaOETIf61t6CFcAaj59--

