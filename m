Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbRFAVDI>; Fri, 1 Jun 2001 17:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbRFAVC7>; Fri, 1 Jun 2001 17:02:59 -0400
Received: from think.faceprint.com ([166.90.149.11]:52491 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S261558AbRFAVCw>; Fri, 1 Jun 2001 17:02:52 -0400
Date: Fri, 1 Jun 2001 14:35:44 -0400
To: linux-kernel@vger.kernel.org
Subject: New USB HID driver in -ac series
Message-ID: <20010601143544.A2091@patience.faceprint.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: Nathan Walp <faceprint@faceprint.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I upgraded from 2.4.5-ac2 to 2.4.5-ac5 recently, and all seemed well.
However, I noticed that the scrollwheel on my mouse wasn't working very
well.  I have that new Logitech cordless optical mouse, so my first
thought was that the batteries were low, but it was late at night, and I
didn't have spares, so I just dealt with it.  I got new batteries, and
the problem didn't go away.  Booted into windows, and the scrollwheel
worked fine.  I then remembered seeing the HID drivers in Alan's
changelog.  I booted back into -ac2, and the scrollwheel worked fine.
-ac5 and -ac6 both show this problem, and I assume every kernel since
the HID driver update has it as well.  Here's the contents of
/proc/bus/usb/devices:

T:  Bus=3D02 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D 11/900 us ( 1%), #Int=3D  1, #Iso=3D  0
D:  Ver=3D 1.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB UHCI Root Hub
S:  SerialNumber=3Dd000
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
T:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Spd=3D12  MxC=
h=3D 4
D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D058f ProdID=3D9254 Rev=3D 1.00
S:  Manufacturer=3DALCOR
S:  Product=3DGeneric USB Hub
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   1 Ivl=3D255ms
T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  MxC=
h=3D 2
B:  Alloc=3D118/900 us (13%), #Int=3D  1, #Iso=3D  0
D:  Ver=3D 1.00 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
S:  Product=3DUSB UHCI Root Hub
S:  SerialNumber=3Dd400
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D255ms
T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D01 Cnt=3D01 Dev#=3D  2 Spd=3D1.5 MxC=
h=3D 0
D:  Ver=3D 1.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
P:  Vendor=3D046d ProdID=3Dc501 Rev=3D 9.10
S:  Manufacturer=3DLogitech
S:  Product=3DUSB Receiver
C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3Da0 MxPwr=3D 50mA
I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D03(HID  ) Sub=3D01 Prot=3D02 Driver=
=3Dhid
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D 10ms

Hope this is of some help
Nathan


--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7F+CAPkYs3Ekt234RAiULAKDI5Xl6ibsqTn4Hn3hRC7bPUDDZVgCgizrs
fvnSLuADhGLXJasynT+mMLw=
=0UlE
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
