Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbUEWHzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbUEWHzo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 03:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUEWHzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 03:55:44 -0400
Received: from nasty.thecoop.net ([216.218.255.165]:58853 "EHLO
	nasty.thecoop.net") by vger.kernel.org with ESMTP id S263033AbUEWHzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 03:55:41 -0400
Subject: Problems w/ 2.6.6 on smp system...
From: Drew Bertola <drew@drewb.com>
Reply-To: drew@drewb.com
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RMPlfBCUYLnZ1qng70zb"
Message-Id: <1085298938.2760.22.camel@ws.thecoop.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 23 May 2004 00:55:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RMPlfBCUYLnZ1qng70zb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've installed FC2 and am experiencing problems with usb devices and
ethernet cards (it might be everything on the pci bus).  I don't have
this problem with their UP kernel, but I do have it with their SMP
kernel.

I decided to build a 2.6.6 using the FC2 i686-smp config to see if that
would help, but I have the same problems.

I notice that right after uncompressing the smp kernel, there's a
message that says (paraphrasing from memory)

  ACPI: S3 and PAE don't play nicely together.  Disabling S3.

I didn't see this message when I booted the UP kernel.

The system is a Tyan Tiger 230T (S2507T) with dual 800MHz PIIIs.  This
board has a Via Apollo Pro133T chipset, a VT82C694T north bridge, and a
VT82CC686B south bridge.  lspci output is below.

I have 2 nics installed (e100 and 8139too).  Both have the right modules
loaded and are configured properly (including routes), but I can't ping
out of the system nor do anything else over the network other than
pinging the nics themselves.

My usb hosts are detected, but nothing attached works.  My usb optical
mouse doesn't even light up.

All of these problems go away in UP mode.

Any suggestions?

Here's the output of lspci:

$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]=
 (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro13=
3x AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (r=
ev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT82=
3x/A/C PIPC Bus Master IDE (rev 06)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40=
)
00:09.0 USB Controller: NEC Corporation USB (rev 41)
00:09.1 USB Controller: NEC Corporation USB (rev 41)
00:09.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08=
)
00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev=
 08)
00:0b.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev =
02)
00:0c.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev =
01)

Thanks,
--
Drew

--=-RMPlfBCUYLnZ1qng70zb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsFj6t26h+Ap1SlURAkBnAJ9rn8IZmfADFvH2Fe2hHzdhCR9HcQCgtRfF
/Wh3qq669xP8Vzup4+xXTu0=
=QKvb
-----END PGP SIGNATURE-----

--=-RMPlfBCUYLnZ1qng70zb--

