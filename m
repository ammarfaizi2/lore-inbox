Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbTIDLuv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTIDLuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:50:50 -0400
Received: from mail0.epfl.ch ([128.178.50.57]:18447 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id S264919AbTIDLur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:50:47 -0400
Date: Thu, 4 Sep 2003 13:50:44 +0200
From: Frederic Gobry <frederic.gobry@smartdata.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4 does not detect my touchpad
Message-ID: <20030904115044.GA7114@rhin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(please CC to my address)

Hi,

I've a touchpad issue with the 2.6.0-test4 kernel on a Compaq Presario
1694. This seems _not_ to be related to a missing XFree driver, rather
on the detection of the device itself.

During the boot, I only have the following messages regarding the
keyboard/mouse detection:

kernel: mice: PS/2 mouse device common for all mice
kernel: input: AT Set 2 keyboard on isa0060/serio0
kernel: serio: i8042 KBD port at 0x60,0x64 irq 1

After boot, /proc/bus/input/devices contains only:

I: Bus=3D0011 Vendor=3D0001 Product=3D0002 Version=3Dab02
N: Name=3D"AT Set 2 keyboard"
P: Phys=3Disa0060/serio0/input0
H: Handlers=3Dkbd event0
B: EV=3D120003
B: KEY=3D4 2000000 c061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe
B: LED=3D7


This is with and without the psmouse_noext option.

Below is my current kernel config (the part I related to input
devices).

Is there a way to perform some probing on the PS/2 port, so that I can
provide more detailed info ?

Thanks in advance,
Fr=E9d=E9ric


--------------------------------------------------
Current configuration:
--------------------------------------------------

CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=3Dy
# CONFIG_INPUT_EVBUG is not set
=20
#
# Input I/O drivers
#
CONFIG_GAMEPORT=3Dy
CONFIG_SOUND_GAMEPORT=3Dy
CONFIG_GAMEPORT_NS558=3Dy
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dy
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
CONFIG_SERIO_PCIPS2=3Dm
=20
#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy   <---- when testing with test4-mm5


--=20
 Fr=E9d=E9ric Gobry       SMARTDATA    	 =20
                      http://www.smartdata.ch/
 PGP: 5B44F4A5        Lausanne - Switzerland
                      +41 21 693 84 98

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/VycUFjQHpltE9KURAuroAJsEb1PPS74R1EChc0eGIuJHPJm9BACcCT60
MdvuiWFpJAbtYVLoY9Q8Y4M=
=QgDB
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
