Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261755AbTCZQIa>; Wed, 26 Mar 2003 11:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261756AbTCZQIa>; Wed, 26 Mar 2003 11:08:30 -0500
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:58561 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S261755AbTCZQI1>; Wed, 26 Mar 2003 11:08:27 -0500
Date: Wed, 26 Mar 2003 16:19:31 +0000
From: Chris Sykes <chris@sigsegv.plus.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030326161931.GF2695@spackhandychoptubes.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
User-Agent: Mutt/1.4i
x-gpg-fingerprint: 1D0A 139D DDA3 F02F 6FC0  B2CA CBC6 5EC0 540A F377
x-gpg-key: wwwkeys.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

LKML Subscribers.

I'm getting a repeatable BUG in sched.c:564 when accessing
/dev/ttyUSB[01] which are provided by ftdi_sio.o.
I've tried both 2.4.21-pre5-ac3 as well as vanilla 2.4.20 and the
results are the same.

The USB hardware in question is an EasySync dual port RS485 to USB
converter (USB-2COMi).

I understand that ftdi_sio.o was intended for single port converters,
and wonder whether the fact that this hardware is dual port is causing
the problem, however both ports appear to be detected and set up OK
(/dev/ttyUSB0 and /dev/ttyUSB1) and we've had minicom sessions on two
boxes talking to each other.

However it is easy to cause the BUG by simply:

bash # echo "Some string" >/dev/ttyUSB0

The decoded Oops, output from dmesg and my .config are all attached.

Any help in this matter would be much appreciated,

Thankyou.

--=20

(o-  Chris Sykes  -- GPG Key: http://www.sigsegv.plus.com/key.txt
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt


--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gdMTy8ZewFQK83cRAkL3AJ0Xj4IrtWzXQdNyG3z0aiNBOxLoLQCeKT+7
YIwZb6OKrXOhd35kaCoL9f4=
=F66z
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
