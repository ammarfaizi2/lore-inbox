Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbUKATMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbUKATMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 14:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S290114AbUKATMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 14:12:36 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:37513 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S289886AbUKATLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:11:02 -0500
Date: Mon, 1 Nov 2004 11:10:36 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>
Cc: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 USB storage problems
Message-ID: <20041101191036.GA18227@one-eyed-alien.net>
Mail-Followup-To: Wolfgang Scheicher <worf@sbox.tu-graz.ac.at>,
	bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
References: <200410121424.59584.worf@sbox.tu-graz.ac.at> <20041012175117.GA11113@outpost.ds9a.nl> <200411011850.47870.worf@sbox.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <200411011850.47870.worf@sbox.tu-graz.ac.at>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You're using the UB driver.  Does it work if you turn that off and use the
usb-storage driver instead?

Matt

On Mon, Nov 01, 2004 at 06:50:47PM +0100, Wolfgang Scheicher wrote:
> Am Dienstag, 12. Oktober 2004 19:51 schrieb bert hubert:
> > On Tue, Oct 12, 2004 at 02:24:59PM +0200, Wolfgang Scheicher wrote:
> >> if i mount my usb-stick ( Sandisk Micro 256MB, USB2.0, FAT ), write a
> >> file (for example 4MB) to it and unmount or sync, then there is a lot =
of
> >> activity on the stick, but the unmount or sync doesn't finish ( waited=
 >
> >> 10 Minutes - should not take more than 1-2 sec ).
> >
> > Can you run vmstat 1 during this process - so start vmstat 1 before umo=
unt,
> > and then umount but leave it running.
> >
> >> any hints? any patches i shall try?
> >
> > Please provide dmesg output, and vmstat 1.
>=20
> sorry for not responding earlier.
>=20
> what exactely of dmesg?
> i think this is the usb stick related part in dmesg:
> [...]
> ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 5 (level, low) -> IRQ 5
> ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
> PCI: Setting latency timer of device 0000:00:02.0 to 64
> ohci_hcd 0000:00:02.0: irq 5, pci mem e0c22000
> ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 3 ports detected
> ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 11 (level, low) -> IRQ 11
> ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
> PCI: Setting latency timer of device 0000:00:02.1 to 64
> ohci_hcd 0000:00:02.1: irq 11, pci mem e0c34000
> ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 3 ports detected
> ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 3 (level, low) -> IRQ 3
> ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
> PCI: Setting latency timer of device 0000:00:02.2 to 64
> ehci_hcd 0000:00:02.2: irq 3, pci mem e0c36000
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
> PCI: cache line size of 64 is not supported by device 0000:00:02.2
> ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 6 ports detected
> forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.29.
> ACPI: PCI interrupt 0000:00:04.0[A] -> GSI 11 (level, low) -> IRQ 11
> PCI: Setting latency timer of device 0000:00:04.0 to 64
> ohci_hcd 0000:00:02.1: wakeup
>=20
> [...]
>=20
> usb 3-2: new high speed USB device using address 4
> ub: sizeof ub_scsi_cmd 60 ub_dev 924
> uba: device 4 capacity nsec 512000 bsize 512
> uba: was not changed
>  /dev/ub/a: p1
> usbcore: registered new driver ub
> uba: was not changed
>=20
>=20
> vmstat 1 looks like:
>=20
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cp=
u----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy =
id wa
>  0  0      0  69388  47636 197444    0    0     0     0 1426  1449 13  7 =
80  0
>  0  0      0  69388  47636 197448    0    0     0   148 1430  1311 10  4 =
86  0
>  0  0      0  69388  47636 197448    0    0     0     0 1428  1426 11  4 =
85  0
> [now umount starts]
>  0  1      0  69132  47636 197448    0    0     0    80 1392  1869 16  3 =
19 62
>  0  1      0  69132  47636 197448    0    0     0     0 1410  1119  8  1 =
 0 91
>  0  1      0  69132  47636 197448    0    0     0     0 1413  1103  6  3 =
 0 91
> [...this was a 200kb test file, skipping ca. 30 similar lines...]
>  0  1      0  69164  47636 197448    0    0     0     0 1409  1130  7  2 =
 0 91
>  0  1      0  69164  47636 197448    0    0     0     0 1421  1088  8  2 =
 0 90
>  0  0      0  70716  47468 197240    0    0     0     0 1394  1206 11  1 =
12 76
> [now umount finished]
>  0  0      0  70716  47508 197240    0    0     0   112 1366  1033  8  2 =
90  0
>  0  0      0  70716  47508 197240    0    0     0    84 1387  1047  6  5 =
89  0
>  0  0      0  70716  47508 197240    0    0     0     0 1365  1134  6  2 =
92  0
>=20
> i tested with 100kb, 200kb and 400kb (which takes long, but not too long =
to=20
> wait) and i wonder if time actually grows linear with bigger files, or if=
=20
> it's eaven worse.
>=20
> reading is at ca. 500kb/sec
>=20
> btw - i compared several kernel versions in the meantime.
> 2.6.8 doesn't show the issue, 2.6.9-rc2 up to 2.6.9 does...
>=20
> Worf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBhoosIjReC7bSPZARAnl/AJ48U33W1sQpnW+lxpB55gab0IsGEQCgivVI
QexrbeKmHcc/ZDGF5/5HF2Y=
=u0m9
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
