Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbTCZTOX>; Wed, 26 Mar 2003 14:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbTCZTOW>; Wed, 26 Mar 2003 14:14:22 -0500
Received: from marstons.services.quay.plus.net ([212.159.14.223]:61862 "HELO
	marstons.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S261970AbTCZTOQ>; Wed, 26 Mar 2003 14:14:16 -0500
Date: Wed, 26 Mar 2003 19:25:20 +0000
From: Chris Sykes <chris@sigsegv.plus.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030326192520.GH2695@spackhandychoptubes.co.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030326162538.GG2695@spackhandychoptubes.co.uk> <20030326185236.GE24689@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="81JctsDUVPekGcy+"
Content-Disposition: inline
In-Reply-To: <20030326185236.GE24689@kroah.com>
User-Agent: Mutt/1.4i
x-gpg-fingerprint: 1D0A 139D DDA3 F02F 6FC0  B2CA CBC6 5EC0 540A F377
x-gpg-key: wwwkeys.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--81JctsDUVPekGcy+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2003 at 10:52:36AM -0800, Greg KH wrote:
> On Wed, Mar 26, 2003 at 04:25:38PM +0000, Chris Sykes wrote:
> > However it is easy to cause the BUG by simply:
> >=20
> > bash # echo "Some string" >/dev/ttyUSB0
>=20
> The oops happens on close(), right?  To verify this try:

Yes it would seem so.

> 	cat /dev/ttyUSB0
> no oops should happen until you interrupt this.
>=20
> Anyway, this is a known usb-serial bug right now.  It should be fixed in
> the 2.5 tree, but I haven't had enough people test that code out to know
> if this is really true (I can't duplicate the bug on 2.4 myself.)

I seem to have worked around it for now.  I've jumpered the hardware
to stop it from echoing what you transmit back locally and all seems
OK now.

> Can you test 2.5 to see if this is fixed there for you or not?

I can test it yes, but 2.5 may be a bit too unstable for our
production use ATM.
Anyway I'll test out a 2.5 kernel when I'm back in the office
tomorrow, I can devote some time to tracking down the problem if you
can give me some pointers on where to start.  I'd like to be able to
feel confident that this will work reliably under 2.4, otherwise I
guess I need to look for alternate solutions.

Thanks for your help,

--=20

(o-  Chris Sykes  -- GPG Key: http://www.sigsegv.plus.com/key.txt
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt


--81JctsDUVPekGcy+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gf6gy8ZewFQK83cRAtBYAJ4ssvGTBWu+PMn70+HFVgQb/76D6QCfWOZu
WQKv6VBL7lapKzCcHTWzYjk=
=ctTc
-----END PGP SIGNATURE-----

--81JctsDUVPekGcy+--
