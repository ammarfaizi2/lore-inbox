Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267036AbUBGTBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 14:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267038AbUBGTBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 14:01:23 -0500
Received: from pass-d9b86c1b.pool.mediaWays.net ([217.184.108.27]:46208 "EHLO
	avaloon.intern") by vger.kernel.org with ESMTP id S267036AbUBGTBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 14:01:15 -0500
Date: Sat, 7 Feb 2004 20:00:39 +0100
From: M G Berberich <berberic@fmi.uni-passau.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.2 wacom not working from /etc/modules
Message-ID: <20040207190039.GA1331@avaloon.intern>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I have the strange problem that the wacom driver in 2.6.2 does not
work if loaded from /etc/modules. If loaded "by hand" after the system
is up it works fine.=20

/proc/bus/input/devices is exactly the same in both cases:

  [...]

  I: Bus=3D0003 Vendor=3D056a Product=3D0042 Version=3D0126
  N: Name=3D"Wacom Intuos2 6x8"
  P: Phys=3Dusb-0000:00:0c.0-1/input0
  H: Handlers=3Dmouse1 event3
  B: EV=3D1b
  B: KEY=3D1cdf 0 1f0000 0 0 0 0 0 0 0 0
  B: ABS=3Df000163
  B: MSC=3D1

but if loaded from /etc/modules neither mouse1 nor event3 gives any
sign of the wacom beeing alive. syslog entries are the same, but in
different order:

input: PC Speaker
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
input: AT Translated Set 2 keyboard on isa0060/serio0
input: Wacom Intuos2 6x8 on usb-0000:00:0c.0-1
drivers/usb/core/usb.c: registered new driver wacom
drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet=
 driver

input: PC Speaker
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
input: AT Translated Set 2 keyboard on isa0060/serio0
drivers/usb/core/usb.c: registered new driver wacom
drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet=
 driver
input: Wacom Intuos2 6x8 on usb-0000:00:0c.0-1

System is a dual PIII, with stock 2.6.2-kernel

BTW: I'm not subscribed to the list.

	MfG
	bmg

--=20
"Des is v=F6llig wurscht, was heut beschlos- | M G Berberich
 sen wird: I bin sowieso dagegn!"          | berberic@fmi.uni-passau.de
(SPD-Stadtrat Kurt Schindler; Regensburg)  |

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAJTXXnp4msu7jrxMRArtOAJ0cUF6gj886zIxYjYOtLmNAoUVzUACgkLab
qKh+49SWPSXA20Ozacqrfug=
=GJdj
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
