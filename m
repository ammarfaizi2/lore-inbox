Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVBPHKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVBPHKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 02:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVBPHKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 02:10:18 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:45206 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261818AbVBPHKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 02:10:07 -0500
Date: Wed, 16 Feb 2005 00:10:15 -0700
From: Jeremy Nickurak <atrus@rifetech.com>
Subject: Re: Logitech MX1000 Horizontal Scrolling
In-reply-to: <87psz1fv8c.fsf@quasar.esben-stien.name>
To: Esben Stien <b0ef@esben-stien.name>
Cc: linux-kernel@vger.kernel.org
Message-id: <1108537815.32143.12.camel@localhost>
MIME-version: 1.0
X-Mailer: Evolution 2.1.3.2
Content-type: multipart/signed; boundary="=-F/HUpvMuoQ+n1i/NK5U/";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
 <87zmylaenr.fsf@quasar.esben-stien.name> <20050204195410.GA5279@ucw.cz>
 <1108105875.5676.3.camel@localhost> <87vf8uee2q.fsf@quasar.esben-stien.name>
 <1108440859.26172.1.camel@localhost> <87psz1fv8c.fsf@quasar.esben-stien.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-F/HUpvMuoQ+n1i/NK5U/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On mar, 2005-02-15 at 21:01 +0100, Esben Stien wrote:
> How did you get that /dev/input/event-mx1000?

A custom rule in /etc/udev/rules.d/00_logitech.rules:
> KERNEL=3D"event*", SYSFS{idVendor}=3D"046d", SYSFS{idProduct}=3D"c50e" NA=
ME=3D"input/event-mx1000" SYMLINK=3D"input/%k"
> KERNEL=3D"mouse*", SYSFS{idVendor}=3D"046d", SYSFS{idProduct}=3D"c50e" NA=
ME=3D"input/mouse-mx1000" SYMLINK=3D"input/%k"

gets event-mx1000 and mouse-mx1000 rules, with compatibility symlinks
for other configurations. This is basically so don't have to tell evdev
where exactly on the USB hierarchy the mouse is. (You'll note that my
xorg.conf lacks the Phys descriptor line). I can now plug my mouse into
different ports, or ports on a hub, and still have it work ok.


> > and that the horizontal scroll shows up as 6/7 which most software
> > interprets as the left/right scroll buttons.
>=20
> I got mine on 11/12, but what do you mean most software interprets
> horizontal scroll as 6/7?. This has to be incorrect. It's logical that
> horizontal directions turns up as 11/12 along with top clicks as 9/10
> and side click 8 as these features/buttons were the last added to the
> mouse.

This certainly seems to be the convention. Just like programs interpret
buttons 4 and 5 as vertical scrolling, they interpret 6 and 7 as the
horizontal scrollers. GTK, mozilla, galeon, and firefox all go by this
principal, so you don't actually need to use a program like xbindkeys to
fake keyboard events.

(Mozilla/galeon/firefox use the horizontal scroll for backward/foreward
by default. You can change this by setting

> mousewheel.horizscroll.withnokey.action =3D 0
> mousewheel.horizscroll.withnokey.numlines =3D 1
> mousewheel.horizscroll.withnokey.sysnumlines =3D true

in about:config. )

--=20
Jeremy Nickurak <atrus@rifetech.com>

--=-F/HUpvMuoQ+n1i/NK5U/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCEvHXtjFmtbiy5uYRApCcAJ93ZliRJMfYy1u5tkGQ387X/GyqaQCfVDPX
b4euoVZMOQebMmDE0fMbWaM=
=u2EC
-----END PGP SIGNATURE-----

--=-F/HUpvMuoQ+n1i/NK5U/--
