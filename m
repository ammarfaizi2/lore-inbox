Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTKTSa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 13:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTKTSa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 13:30:27 -0500
Received: from dsl254-027-160.sea1.dsl.speakeasy.net ([216.254.27.160]:25328
	"EHLO mail.tranzoa.net") by vger.kernel.org with ESMTP
	id S262788AbTKTSaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 13:30:25 -0500
Date: Thu, 20 Nov 2003 10:30:22 -0800
From: Scott Robinson <scott@tranzoa.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 sidewinder joystick
Message-ID: <20031120183022.GA7602@tara.mvdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
X-Disclaimer: The contents of this e-mail, unless otherwise stated, are the property of David Ryland Scott Robinson. Copyright (C) 2003, All Rights Reserved.
X-Operating-System: Linux tara 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This is a repeat bug report - originally to the input subsystem mailing list
and the module maintainer. I received no response and no indication there
was reception. I have updated the results for -test9. (the bug has existed
through the entire -test series) This bug does not exist in the 2.4 series.

I am using the 2.6.0-test9 kernel. I have loaded the
joydev/emu10k1-gp/sidewinder modules. The sidewinder driver, however,
appears to not work properly.

I have a Sidewinder Gamepad connected. I have also tested with my old Gravis
Gamepad. (analog)

[joydev, emu10k1-gp, sidewinder results w/ sidewinder connected]

Nov 20 10:22:38 tara kernel: gameport: pci0000:01:07.1 speed 828 kHz
Nov 20 10:23:29 tara kernel: drivers/input/joystick/sidewinder.c: Init 0: O=
pened pci0000:01:07.1/gameport0, io 0xd400, speed 828
Nov 20 10:23:29 tara kernel: sidewinder.c: Read 0 triplets. []
Nov 20 10:23:29 tara kernel: drivers/input/joystick/sidewinder.c: Init 1: M=
ode 1. Length 0.
Nov 20 10:23:29 tara kernel: sidewinder.c: Read 0 triplets. []
Nov 20 10:23:29 tara kernel: drivers/input/joystick/sidewinder.c: Init 1b: =
Length 0.

joydev/devfs does not create /dev/js0 symlink.

[joydev, emu10k1-gp, analog results w/ sidewinder connected]

Nov 20 10:24:31 tara kernel: gameport: pci0000:01:07.1 speed 828 kHz
Nov 20 10:24:33 tara kernel: input: Analog 4-axis 4-button joystick at pci0=
000:01:07.1/gameport0 [TSC timer, 1446 MHz clock, 1239 ns res]

joydev/devfs creates /dev/js0 symlink. jstest /dev/js0 is unresponsive.

[joydev, emu10k1-gp, analog results w/ gravis connected]

Nov 20 10:26:04 tara kernel: gameport: pci0000:01:07.1 speed 828 kHz
Nov 20 10:26:06 tara kernel: input: Analog 2-axis 4-button joystick at pci0=
000:01:07.1/gameport0 [TSC timer, 1446 MHz clock, 1250 ns res]

joydev/devfs creates /dev/js0 symlink. jstest /dev/js0 is responsive.

I am not subscribed to the linux-kernel mailing list. (Kernel Traffic is
enough, thanks! :-D)

Thank you, in advance, for any help you can provide.

Scott.

--=20
http://quadhome.com/            - Personal webpage
http://tranzoa.net/             - Corporate webpage

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iEYEARECAAYFAj+9CD4ACgkQfOrjFoFaMKI45ACePIWa6qphchtaeuSBeIsih5Qz
4JQAnR+knIVG9JR5al2Bn/yzm1jmXhx7
=VC2N
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
