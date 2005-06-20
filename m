Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVFTVfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVFTVfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVFTVdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:33:12 -0400
Received: from server262.com ([64.14.68.15]:60359 "EHLO server262.com")
	by vger.kernel.org with ESMTP id S261628AbVFTVag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:30:36 -0400
Subject: Re: IBM HDAPS Someone interested?
From: Adam Goode <adam@evdebs.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
In-Reply-To: <20050620204533.GA9520@ucw.cz>
References: <20050620155720.GA22535@ucw.cz>
	 <005401c575b3_5f5bba90_600cc60a@amer.sykes.com>
	 <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz>
	 <20050620204533.GA9520@ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TVeEpsMLe6yr4gONrWdh"
Date: Mon, 20 Jun 2005 17:30:16 -0400
Message-Id: <1119303016.5194.24.camel@lynx.auton.cs.cmu.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TVeEpsMLe6yr4gONrWdh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-06-20 at 22:45 +0200, Vojtech Pavlik wrote:
> On Mon, Jun 20, 2005 at 06:57:04PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > > I don't think they have anything in the BIOS related to the HDAPS, =
else they
> > > > would have put something in it. (You can't even disable the chip in=
 the
> > > > BIOS) I just think is the accelerometer, there, by itself with an e=
xtra card
> > > > they added.
> > > =20
> > > Well, some piece of software needs to park the HDD when the notebook =
is
> > > falling, and that piece of software should better be running since th=
e
> > > notebook is powered on. Hence my suspicion it's in the BIOS. It doesn=
't
> > > have to be visible to the user, at all.
> >=20
> > Actually yes, it needs to be visible to the user and no, it probably
> > should not run during boot.  If user is in plane/train,
> > accellerometers will basically detect problems all the time; still you
> > want to use the computer.
>=20
> It likely won't. What it does is that it detects a situation with no
> gravity - free fall.
>=20
> > (And you still want the machine to boot =3D> default =3D=3D fall detect=
ion off).
>=20
> It will boot. It may boot slower if you're jumping from an airplane at
> the time, but it'll just park the heads now and then, which, with
> IBM/Hitachi drives doesn't take long.
>=20
> > IIRC there's windows program to control it.
> =20
> That's likely. What good would a feature be for marketing if it wasn't
> visible to the user. ;)
>=20


This paper tells about the "heuristic learning algorithm" used to park
the drives:

http://www-307.ibm.com/pc/support/site.wss/document.do?lndocid=3DMIGR-53432

It seems that by IBM's calculations, desk-to-floor distance is
insufficient time to detect freefall and park the heads. So they
actually park the heads when it detects "starting to slide off table"...

Freefall detection: 300 ms
Head park time: 300-500 ms
  (from page 2 of document)

Still doesn't seem too bad to figure out how to code though, at least
once we can figure out how to get the data stream!

P.S. The main control system runs as a Windows kernel driver. Not as
safe as full hardware, but probably better than userspace. :)


Thanks,

Adam


--=-TVeEpsMLe6yr4gONrWdh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCtzVolenB4PQRJawRAoVAAJ9O79QO6jWbFlURCNflOx3AgBqLfACfdcs7
lXz98LrvsapvQzkNGOgwR3I=
=Fo+2
-----END PGP SIGNATURE-----

--=-TVeEpsMLe6yr4gONrWdh--

