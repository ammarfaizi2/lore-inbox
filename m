Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVBQMig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVBQMig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 07:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVBQMif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 07:38:35 -0500
Received: from kokytos.rz.informatik.uni-muenchen.de ([141.84.214.13]:11496
	"EHLO kokytos.rz.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S262194AbVBQMiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 07:38:03 -0500
From: Michael Brade <brade@informatik.uni-muenchen.de>
Organization: =?iso-8859-1?q?Universit=E4t?= =?iso-8859-1?q?_M=FCnchen?=, Institut =?iso-8859-1?q?f=FCr?= Informatik
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc4: touch pad misidentified (ALPS instead of ImPS/2)
Date: Thu, 17 Feb 2005 13:37:55 +0100
User-Agent: KMail/1.7.92
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2069527.AF7kVMJFd2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502171337.58081.brade@informatik.uni-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2069527.AF7kVMJFd2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

the new 2.6.11-rc series has another problem for me, my touchpad (Toshiba=20
Laptop) stopped working. I guess this has to do with "[PATCH] ALPS touchpad=
=20
detection fix" that was posted about 4 weeks ago. The kernel says while=20
booting:

newton kernel: mice: PS/2 mouse device common for all mice
newton kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
newton kernel: ALPS Touchpad (Glidepoint) detected
newton kernel:   Disabling hardware tapping
newton kernel: input: AlpsPS/2 ALPS TouchPad on isa0060/serio1

and when I try to use it, the following is spit out:

last message repeated 2 times
kernel: psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
kernel: psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1
last message repeated 2 times
kernel: psmouse.c: TouchPad at isa0060/serio1/input0 - driver resynched.
kernel: psmouse.c: TouchPad at isa0060/serio1/input0 lost sync at byte 1

This goes on until I stop touching the touchpad. With up to 2.6.10 there we=
re=20
no problems and the kernel said:

newton kernel: mice: PS/2 mouse device common for all mice
newton kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
newton kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1

I haven't compiled in any ISA support, but I don't think this can be the=20
reason since I haven't changed the kernel config between 2.6.10 and 2.6.11.

Thanks for any help,
  Michael

PS: I'm not subscribed.
=2D-=20
Michael Brade;                 KDE Developer, Student of Computer Science
  |-mail: echo brade !#|tr -d "c oh"|s\e\d 's/e/\@/2;s/$/.org/;s/bra/k/2'
  =B0--web: http://www.kde.org/people/michaelb.html

KDE 3: The Next Generation in Desktop Experience

--nextPart2069527.AF7kVMJFd2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCFJAmdK2tAWD5bo0RArdwAKDkmlb5odlxaoLrRwx1FskcGhyqtACgt0iS
HQOYovulFx9gZtiFy7CgKQs=
=nrhY
-----END PGP SIGNATURE-----

--nextPart2069527.AF7kVMJFd2--
