Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbUAHSQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUAHSQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:16:28 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:62980 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S265937AbUAHSQS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:16:18 -0500
Date: Thu, 8 Jan 2004 12:16:16 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: PCI parport irq sharing?
Message-ID: <20040108181615.GA20930@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

Does parport_pc have the capability to share IRQs?  I have a PCI
parallel card with two ports on it:

parport0: PC-style at 0x3bc (0x7bc), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EC=
P,DMA]
parport1: PC-style at 0xc400 (0xc800), irq 9, using FIFO [PCSPP,TRISTATE,CO=
MPAT,ECP]
parport1: irq 9 in use, resorting to polled operation
parport2: PC-style at 0xcc00 (0xd000) [PCSPP,TRISTATE]

parport0 is the mb's builtin parallel port, and parport1/parport2 are
the two ports on the PCI card.  IRQ 9 is taken by USB already.  But
since it's a modern PCI card, it would stand to reason that it should be
able to share the IRQ with another PCI device, no?  Unfortunately, my
application requires interrupt-driven operation.

/proc/interrupts:
CPU0      =20
  0:     276501          XT-PIC  timer
  1:       1196          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  7:          7          XT-PIC  parport0
  8:          4          XT-PIC  rtc
  9:    2724988          XT-PIC  acpi, usb-ohci
 10:       8745          XT-PIC  eth0
 11:          0          XT-PIC  CMI8738-MC4
 12:          0          XT-PIC  PS/2 Mouse
 14:      16219          XT-PIC  ide0
 15:         29          XT-PIC  ide1
NMI:          0=20
LOC:          0=20
ERR:          0
MIS:          0

Kernel 2.4.24

thanks,

--=20
Ryan Underwood, <nemesis@icequake.net>

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//Z5vIonHnh+67jkRAoqrAJ9bR+yBS0X6ycb5qOwnTYXwF8fBwQCfcSVY
JmhWRDKx9JARIdfUpy80jik=
=a29J
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
