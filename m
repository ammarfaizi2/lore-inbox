Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTELQ7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTELQ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:59:34 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:62632 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S262306AbTELQ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:59:30 -0400
Date: Mon, 12 May 2003 12:14:02 -0500
From: Josh Litherland <josh@emperorlinux.com>
To: linux-kernel@vger.kernel.org
Subject: Speedstream SS1012 not detecting media
Message-ID: <20030512171402.GA19081@temp123.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
X-GPG-Key: http://temp123.org/~fauxpas/fauxpas.pgp
X-GPG-Fingerprint: CFF3 EB2B 4451 DC3C A053  1E07 06B4 C3FC 893D 9228
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have a SpeedStream 1012 cardbus ethernet card, which seems to be
indicated as a supported tulip cardbus device.  However, tulip_core.c in
2.4.20 (and several other kernels I tried while working with this card)
don't have the PCI IDs for the card, vendor 0x02ac, device 0x1012. =20

When I patch tulip.o to attach to this card, this is the result:

cs: cb_free(bus 21)
cs: cb_alloc(bus 21): vendor 0x02ac, device 0x1012
PCI: Enabling device 15:00.0 (0000 -> 0003)
PCI: 15:00.0 PCI cache line size set incorrectly (0 bytes) by BIOS/FW,
correcting to 32
PCI: Setting latency timer of device 15:00.0 to 64
tulip1: Old style EEPROM with no media selection information.
eth0: Digital DS21143 Tulip rev 16 at 0xd1067000, EEPROM not present,
00:10:7A:69:1F:1C, IRQ 11.

At this point, the '10M' LED glows orange (normal is green) regardless
of the type of link that is attached to the card.  No traffic gets
through the interface.=20

Where can I start to get this card going ?

Thanks in advance.

--=20
Josh Litherland (josh@emperorlinux.com)

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+v9ZaBrTD/Ik9kigRApntAKCSANyeHoYQ8QQKtfih+/DM2T8SvwCgrk6x
M1hmCHKtzimYCYbco6o+N8Y=
=J/Yo
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
