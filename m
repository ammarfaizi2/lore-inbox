Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUHRSkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUHRSkD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267416AbUHRSkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:40:03 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:62614 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S267475AbUHRSjt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:39:49 -0400
Subject: Re: 2.6.8.1-mm1 Tty problems?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olh@suse.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <2a4f155d040817224449ef0874@mail.gmail.com>
References: <2a4f155d040817070854931025@mail.gmail.com>
	 <412247FF.5040301@microgate.com>
	 <2a4f155d0408171116688a87f1@mail.gmail.com>
	 <4122501B.7000106@microgate.com>
	 <2a4f155d04081712005fdcdd9b@mail.gmail.com>
	 <412272C8.6050203@microgate.com> <1092778561.8998.18.camel@nosferatu.lan>
	 <2a4f155d040817224449ef0874@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ckwbaBo4E0AUXPIj/uoJ"
Message-Id: <1092854584.8998.29.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 20:43:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ckwbaBo4E0AUXPIj/uoJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-18 at 07:44, ismail d=C3=B6nmez wrote:
> On Tue, 17 Aug 2004 23:36:02 +0200, Martin Schlemmer <azarah@nosferatu.za=
.org>=20
> > He has the wrong permissions in
> > /etc/udev/permissions.d/50-udev.permissions (or whatever), or no
> > entry for it, and his default_mode (in /etc/udev/udev.conf) is very
> > restrictive, or he does not use pam_console (or using it with a
> > display manager?), or add some other explanation.  Personally I would
> > just say that he/his_distribution should fix the shipped
> > udev.permissions.
>=20
> I run Slackware 10 and got this in /etc/udev/permissions.d/udev.permissio=
ns :
>=20
> # console devices
> console:root:tty:0600
> tty:root:tty:0666
> tty[0-9][0-9]*:root:tty:0660
> vc/[0-9]*:root:tty:0660
>=20
>=20
> But the real problem is not permissions but the fact that /dev/tty is
> a directory now not a character device. Is this intended? If yes this
> will break many userspace applications which will assume /dev/tty is a
> character device. Greg can you please comment?
>=20

---
# ls -l /dev/tty
crw-rw-rw-  1 root tty 5, 0 Aug 16 20:25 /dev/tty
---

I think its something else - most likely a rule in
/etc/udev/rules.d/50-udev.rules ?  Could you post that
(or /etc/udev/rules.conf or whatever file is applicable) ?


--=20
Martin Schlemmer

--=-ckwbaBo4E0AUXPIj/uoJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBI6M4qburzKaJYLYRAlSKAJ9C/IiCZ1YMsiLapEXiEhKANhwiXACfX7PV
xW6PTfQZLzCKSDmT+8P2idA=
=Fge2
-----END PGP SIGNATURE-----

--=-ckwbaBo4E0AUXPIj/uoJ--

