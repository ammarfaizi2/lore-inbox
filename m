Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136330AbRDWB51>; Sun, 22 Apr 2001 21:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136334AbRDWB5S>; Sun, 22 Apr 2001 21:57:18 -0400
Received: from cdsl18.ptld.uswest.net ([209.180.170.18]:28767 "HELO
	galen.magenet.net") by vger.kernel.org with SMTP id <S136330AbRDWB5G>;
	Sun, 22 Apr 2001 21:57:06 -0400
Date: Sun, 22 Apr 2001 18:57:37 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: linux-kernel@vger.kernel.org
Subject: USB fails in 2.4.3-ac6
Message-ID: <20010422185737.H4009@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Operating-System: Linux galen 2.4.3-ac4+lm+bttv
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 2.4.3-ac6, USB input doesn't work.  It works with -ac4, and I'm
waiting for -ac13 or so before I try something later.

By "doesn't work", I mean that the USB keyboard and mouse are never
detected.  A config snippet:

CONFIG_INPUT=3Dy
CONFIG_INPUT_KEYBDEV=3Dy
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dy
CONFIG_INPUT_EVDEV=3Dy

CONFIG_USB=3Dy
# CONFIG_USB_DEBUG is not set

CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set

CONFIG_USB_UHCI_ALT=3Dy

CONFIG_USB_HID=3Dy


Has anyone else seen this problem?  I suspect it is the Alt UHCI driver
which I read somewhere was preferred for VIA-based systems.  I don't
really know what the difference is between them - the help in the kernel
doesn't really say much about how they are different other than that they
are.

I must compile the USB stuff into the kernel as I do not have legacy input
devices on this system (and am proud of it!  hehe)

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

<Iambe> you are not a nutcase
<Knghtbrd> You obviously don't know me well enough yet.  =3D>


--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjrjjBEACgkQj/fXo9z52rOC9gCeLYVHGQhwSnRwqE8fUyyduuHK
0E0An3LgiyoQ/CXas7Y0/LL0XUjy0jSj
=gL7z
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--
