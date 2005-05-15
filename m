Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVEOUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVEOUlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 16:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVEOUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 16:41:50 -0400
Received: from neveragain.de ([217.69.76.1]:39384 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261217AbVEOUlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 16:41:46 -0400
Date: Sun, 15 May 2005 22:41:38 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: USB broken for certain devices on nVIDIA nFORCE-ehci-chipsets
Message-ID: <20050515204138.GA9447@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (hobbit.neveragain.de [217.69.76.1]); Sun, 15 May 2005 22:41:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I just got my new nVIDIA nFORCE-board this morning, I put it into my comput=
er
and got it working up all nicely. Apart from one exception: The USB-chip do=
es
work nicely with my USB scanner, but not with the USB-dongle of my Logitech
MX900 bluetooth mouse. Whenever I put the plug of the dongle in, I just see
the following in dmesg:

hub 1-0:1.0: state 5 ports 10 chg 0000 evt 0200
ehci_hcd 0000:00:02.1: GetStatus port 9 status 001002 POWER sig=3Dse0  CSC
hub 1-0:1.0: port 9, status 0100, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 9: total 100ms stable 100ms status 0x100
hub 1-0:1.0: state 5 ports 10 chg 0000 evt 0200
ehci_hcd 0000:00:02.1: GetStatus port 9 status 001803 POWER sig=3Dj  CSC CO=
NNECT
hub 1-0:1.0: port 9, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 9: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.1: port 9 full speed --> companion
ehci_hcd 0000:00:02.1: GetStatus port 9 status 003001 POWER OWNER sig=3Dse0=
  CONNECT
hub 1-0:1.0: port_wait_reset: err =3D -107

lsusb does not list the device afterwards, and even the blue light in front=
=20
of the dongle, that is usually switched on once the thing works, is off. The
lspci-tool shows the following for the chipset:

0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 005a (rev a=
2)
0000:00:02.1 USB Controller: nVidia Corporation: Unknown device 005b (rev a=
3)

Board is Asus A8N SLI Deluxe. It seems that with Linux 2.6.10, the mouse or
rather the dongle works just fine, so I assume this has been introduced in
the 2.6.11-series. Is this a known problem and is a fix available for it?

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCh7QCHPo+jNcUXjARAo+jAJ9WQ+TBBnb2dIM6cMmw1VC7oZngmgCZAZ7I
mEnJ5mSUD6cZlCjJ6/OezHI=
=zOk1
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
