Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbUKPFag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUKPFag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbUKPFag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:30:36 -0500
Received: from smtp.gentoo.org ([156.56.111.197]:14757 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261863AbUKPFaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:30:18 -0500
Subject: dma_timer_expiry issues
From: Lance Albertson <ramereth@gentoo.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ik1pXx2hPgGuucy4Sxcf"
Message-Id: <1100583017.2075.9.camel@mirage>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 15 Nov 2004 23:30:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ik1pXx2hPgGuucy4Sxcf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've been trying to troubleshoot an odd problem I've been having for a
month or two now. I can't figure out if its the
kernel/motherboard/powersupply/etc. I've basically ruled out that its
the harddrive because I've tried this with three drives in the last
three months, and the same basic thing happens to all of them.

So here's the scoop:

I get the following error when the drive is trying to start X or
sometimes even while in the init phase of bootup:

hda: dma_timer_expiry: dma status =3D=3D 0x21
hda: DMA timeout error
hda: dma timeout error: status=3D0x50 { DriveReady SeekComplete }

ide: failed opcode was: unknown
hda: task_in_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: task_in_intr: error=3D0x04 { DriveStatusError }

After this happens dma gets disabled (which I can tell by looking at
hdparm -d /dev/hda). Sometimes this will just temporarily lock up the
machine, or just completely lock it up to where I have to do a hard
reset. Also, when this happens, I can definitely hear a click noise just
once like its changing something on the drive.=20

Here's some dmesg output (using gentoo-2.6.9-r1)

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=3Dxx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI interrupt 0000:00:11.1[A] -> GSI 11 (level, low) -> IRQ 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 6Y080P0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CREATIVE DVD-ROM DVD6240E, ATAPI CD/DVD-ROM drive
hdd: LITE-ON DVDRW SOHW-812S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15

Here's the list of things I've *already* tried doing:

1. updated the motherboard bios
2. tried different drives
3. gradually pulled out pci cards I didn't need to boot up (I had a few
ethernet cards)
4. turned off any extra ide controllers onboard
5. ran smartctl on the drive with it passing with flying colors

I'm running an Abit KX7-333R motherboard running Gentoo Linux (x86) and
keep it fairly up to date. I'm thinking this is a hardware issue, but I
wanted to confirm that this isn't some kernel issue I couldn't find in
Google. If you can help me with this, it would be very appreciated!

--=20
Lance Albertson <ramereth@gentoo.org>
Gentoo Infrastructure

---
Public GPG key:  <http://www.ramereth.net/lance.asc>
Key fingerprint: 0423 92F3 544A 1282 5AB1  4D07 416F A15D 27F4 B742

ramereth/irc.freenode.net

--=-ik1pXx2hPgGuucy4Sxcf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBmZBpQW+hXSf0t0IRAkJGAJ99tYH80AH3XrliSmPtk7Ef7MESuACeLhYe
pfvJf9hvQ95MRdt2+Z+YN+I=
=YeCm
-----END PGP SIGNATURE-----

--=-ik1pXx2hPgGuucy4Sxcf--

