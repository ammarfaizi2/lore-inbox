Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270439AbTGXCp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 22:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTGXCp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 22:45:56 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:42254 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S270439AbTGXCpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 22:45:55 -0400
Date: Wed, 23 Jul 2003 20:00:51 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: System stalls using usb-storage
Message-ID: <20030723200051.C18354@one-eyed-alien.net>
Mail-Followup-To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Kernel Developer List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Many people, including myself, have observed system stalls when using
usb-storage.  It happens when copying large amounts of data to a USB device
-- everything (except the USB access) just stops for a little while.  My
best guess is that the block cache is filling up (easy since USB is so
slow).

The question is, what is the best way to handle this.  I'm guessing that
increasing the priority of the usb-storage control thread will help, but
that's just a guess.  I'm not even sure how to go about doing that, tho...

This is seen on 2.4 and 2.5/6 kernels.

Anyone have any ideas?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

M:  No, Windows doesn't have any nag screens.
C:  Then what are those blue and white screens I get every day?
					-- Mike and Cobb
User Friendly, 1/4/1999

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/H0vjIjReC7bSPZARAjvgAJ4gL6yLJbHIufPrhFW3t+DXhzaG4ACfT9RA
n1O25A8kUfQMuQ7xPJM+ta8=
=WXW8
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
