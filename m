Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUHQVcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUHQVcl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 17:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266792AbUHQVcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 17:32:41 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:52443 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S268464AbUHQVcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 17:32:36 -0400
Subject: Re: 2.6.8.1-mm1 Tty problems?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: ismail =?ISO-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olh@suse.org,
       Greg KH <greg@kroah.com>
In-Reply-To: <412272C8.6050203@microgate.com>
References: <2a4f155d040817070854931025@mail.gmail.com>
	 <412247FF.5040301@microgate.com>
	 <2a4f155d0408171116688a87f1@mail.gmail.com>
	 <4122501B.7000106@microgate.com>
	 <2a4f155d04081712005fdcdd9b@mail.gmail.com>
	 <412272C8.6050203@microgate.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xjwv2PcMbDsOp4DNBSZb"
Message-Id: <1092778561.8998.18.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 17 Aug 2004 23:36:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xjwv2PcMbDsOp4DNBSZb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-17 at 23:04, Paul Fulghum wrote:
> ismail d=C3=B6nmez wrote:
>=20
> > On Tue, 17 Aug 2004 13:36:11 -0500, Paul Fulghum <paulkf@microgate.com>=
 wrote:
> >=20
> >>Even if a feature is not be enabled,
> >>backing out a patch can verify it does not
> >>touch code outside of the feature.
> >>
> >=20
> >=20
> > Indeed backing up selinux-revalidate-access-to-controlling-tty.patch
> > fixed "less" problem. But some other problems remain and the real
> > issue is /dev/tty is a directory now! :
> >=20
> >=20
> > cartman@southpark:~$ ls -al /dev/tty
> > total 0
> > drwxr-xr-x   2 root root     0 2004-08-18 00:52 ./
> > drwxr-xr-x  15 root root     0 2004-08-17 21:53 ../
> > crw-------   1 root root 3, 10 2004-08-18 00:52 s
> > crw-------   1 root root 3,  0 2004-08-18 00:52 s0
> > crw-------   1 root root 3,  1 2004-08-18 00:52 s1
> > crw-------   1 root root 3,  2 2004-08-18 00:52 s2
> > crw-------   1 root root 3,  3 2004-08-18 00:52 s3
> > crw-------   1 root root 3,  4 2004-08-18 00:52 s4
> > crw-------   1 root root 3,  5 2004-08-18 00:52 s5
> > crw-------   1 root root 3,  6 2004-08-18 00:52 s6
> > crw-------   1 root root 3,  7 2004-08-18 00:52 s7
> > crw-------   1 root root 3,  8 2004-08-18 00:52 s8
> > crw-------   1 root root 3,  9 2004-08-18 00:52 s9
> >=20
> >=20
> > And this breaks many applications. Any idea why /dev/tty is a directory=
 now?
>=20
> Olaf, Greg:
>=20
> The addition of pty devices to sysfs in bk-driver-core.patch
> of 2.6.8.1-mm1 seems to be causing the problem described above.
> See the rest of this thread for more details.
>=20

He has the wrong permissions in
/etc/udev/permissions.d/50-udev.permissions (or whatever), or no
entry for it, and his default_mode (in /etc/udev/udev.conf) is very
restrictive, or he does not use pam_console (or using it with a
display manager?), or add some other explanation.  Personally I would
just say that he/his_distribution should fix the shipped
udev.permissions.

Apart from above, I cannot say anything is wrong with the addition of
tty's to sysfs, and if its the same in functionality as the old patch
from Greg, then I ran it for months no problem.


--=20
Martin Schlemmer

--=-xjwv2PcMbDsOp4DNBSZb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBInpBqburzKaJYLYRAl6oAJ9sLt4YE29WnM+h0mO5+CjzD05VigCggUQm
wvfudwTTIebRVFXykUdUhJA=
=4fjL
-----END PGP SIGNATURE-----

--=-xjwv2PcMbDsOp4DNBSZb--

