Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVBOEP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVBOEP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 23:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVBOEP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 23:15:29 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51383 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261619AbVBOEPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 23:15:12 -0500
Date: Mon, 14 Feb 2005 21:14:18 -0700
From: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>
Subject: Re: Logitech MX1000 Horizontal Scrolling
In-reply-to: <87vf8uee2q.fsf@quasar.esben-stien.name>
To: Esben Stien <b0ef@esben-stien.name>
Cc: linux-kernel@vger.kernel.org
Message-id: <1108440859.26172.1.camel@localhost>
MIME-version: 1.0
X-Mailer: Evolution 2.1.3.2
Content-type: multipart/signed; boundary="=-m9KzcpRRh6J5VdsHEjhI";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
 <87zmylaenr.fsf@quasar.esben-stien.name> <20050204195410.GA5279@ucw.cz>
 <1108105875.5676.3.camel@localhost> <87vf8uee2q.fsf@quasar.esben-stien.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-m9KzcpRRh6J5VdsHEjhI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mar, 2005-02-15 at 03:45 +0100, Esben Stien wrote:=20
> Jeremy Nickurak <atrus@lkml.spam.rifetech.com> writes:
>=20
> > Oddly, my horizontal scroll worked fine as extra buttons under 2.6.10.
> > 2.6.11-rc3 causes the scroll wheel to appear under X.org 6.8.1 with the
> > evdev driver as two seperate mouse buttons being pressed simultaneously=
.
>=20
> I'm a little unclear as to what you mean here. Could you elaborate?

I use X.org with the following mouse configuration:

> Section "InputDevice"
>     Identifier "Mouse0"
>     Driver "mouse"
>     Option "Protocol" "evdev"
>     Option "Device" "/dev/input/event-mx1000"
>     Option "Buttons" "12"
>     Option "ZAxisMapping" "11 12"
>     Option "Resolution" "800"
> EndSection

With an Xmodmap rule:

> pointer =3D 1 2 3 8 9 10 11 12 6 7 4 5

This is to make sure that the scroll wheel shows up as 4/5 as expected,
and that the horizontal scroll shows up as 6/7, which most software
interprets as the left/right scroll buttons.

Xev says that the horizontal scrollers produce:

Scroll Left:

> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935139, (88,104), root:(89,150),
>     state 0x10, button 6, same_screen YES
>=20
> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935155, (88,104), root:(89,150),
>     state 0x10, button 5, same_screen YES
>=20
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935155, (88,104), root:(89,150),
>     state 0x1010, button 5, same_screen YES
>=20
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935267, (88,104), root:(89,150),
>     state 0x10, button 6, same_screen YES

And right:

> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935915, (88,104), root:(89,150),
>     state 0x10, button 7, same_screen YES
>=20
> ButtonPress event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935931, (88,104), root:(89,150),
>     state 0x10, button 4, same_screen YES
>=20
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334935931, (88,104), root:(89,150),
>     state 0x810, button 4, same_screen YES
>=20
> ButtonRelease event, serial 29, synthetic NO, window 0xe00001,
>     root 0x4a, subw 0x0, time 334936027, (88,104), root:(89,150),
>     state 0x10, button 7, same_screen YES

I'm being very careful not accidentally press the horizontal scroller
buttons. If there's a different mouse configuration I'm supposed to be
using here, I'd love to hear it. I spent alot of time trying out various
configurations under the 2.6.10 to find one that made everything
(including the cruise control buttons, which still don't work quite
right... see: http://bugzilla.kernel.org/show_bug.cgi?id=3D1786 ) working.

Various software versions below.

> atrus@agaeris:~$ xdpyinfo | grep 'X.Org version'
> X.Org version: 6.8.1.902
> atrus@agaeris:~$ uname -a
> Linux agaeris 2.6.11-rc3 #1 Thu Feb 10 23:17:14 MST 2005 i686
> GNU/Linux

--=20
Jeremy Nickurak <atrus@lkml.spam.rifetech.com>

--=-m9KzcpRRh6J5VdsHEjhI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCEXcatjFmtbiy5uYRAty3AJ42cGf+vFr/sEpN33Iu/wWZ7no5HACeM+o6
yqAEvuQg+w+8M2mvWySpXpA=
=v4pE
-----END PGP SIGNATURE-----

--=-m9KzcpRRh6J5VdsHEjhI--
