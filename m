Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270682AbTG0GUv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 02:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTG0GUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 02:20:51 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:54542 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S270682AbTG0GUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 02:20:46 -0400
Date: Sat, 26 Jul 2003 23:35:45 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] System stalls using usb-storage
Message-ID: <20030726233545.B20751@one-eyed-alien.net>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Kernel Developer List <linux-kernel@vger.kernel.org>
References: <20030723200051.C18354@one-eyed-alien.net> <200307270824.44851.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200307270824.44851.oliver@neukum.org>; from oliver@neukum.org on Sun, Jul 27, 2003 at 08:24:44AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2003 at 08:24:44AM +0200, Oliver Neukum wrote:
> Am Donnerstag, 24. Juli 2003 05:00 schrieb Matthew Dharm:
> > Many people, including myself, have observed system stalls when using
> > usb-storage.  It happens when copying large amounts of data to a USB de=
vice
> > -- everything (except the USB access) just stops for a little while.  My
> > best guess is that the block cache is filling up (easy since USB is so
> > slow).
>=20
> Can you do a vmstat run? That should provide conclusive data.
> If so, write throteling is failing.

I'll set up some tests and get back to you...

> > The question is, what is the best way to handle this.  I'm guessing that
> > increasing the priority of the usb-storage control thread will help, but
> > that's just a guess.  I'm not even sure how to go about doing that, tho=
...
>=20
> A kernel thread in the block io path has to have a higher priority than
> any user task. Otherwise a priority inversion is possible.

Reasonable.  So, other than renice at the command line, how does one go
about setting this?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Somebody call an exorcist!
					-- Dust Puppy
User Friendly, 5/16/1998

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/I3LBIjReC7bSPZARAhTPAJ9MJAmNo9NLMqocVzeJ603pgKASagCeOhRj
uVP5UXfcvUZKFs646twqGuk=
=mjS9
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
