Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282167AbRK1X3D>; Wed, 28 Nov 2001 18:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282168AbRK1X2y>; Wed, 28 Nov 2001 18:28:54 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:12298 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S282167AbRK1X2m>; Wed, 28 Nov 2001 18:28:42 -0500
Date: Wed, 28 Nov 2001 15:28:36 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: How do I keep a thread alive through shutdown?
Message-ID: <20011128152836.D15412@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Several people are reporting long delays when shutting down and using
usb-storage.  My guess is that the control thread is getting killed during
the shutdown process, and when the SCSI layer decides to send a final
command to the device, it's never completed because the thread is dead.

So, how do I make a kernel thread immune from being killed during a
shutdown?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I don't have a left mouse button.  I only have one mouse and it's on my rig=
ht.
					-- Customer
User Friendly, 2/13/1999

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8BXMkz64nssGU+ykRAk3WAKD2Em6fs3mLzh4h++EoJ05DlBqQOACffWi4
y5HHQ2a6VW3qFOydBaOA62w=
=9PET
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
