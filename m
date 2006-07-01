Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWGAK6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWGAK6z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWGAK6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:58:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22403 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932643AbWGAK6y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:58:54 -0400
Date: Sat, 01 Jul 2006 06:56:57 -0400
From: Jeff Bailey <jbailey@ubuntu.com>
Subject: Re: [klibc] klibc and what's the next step?
In-reply-to: <44A5B07E.9040007@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Message-id: <1151751417.2553.8.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-V48LWzIPk2/Emw3vL3Bw"
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
 <Pine.LNX.4.64.0606271316220.17704@scrub.home>
 <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru>
 <44A5B07E.9040007@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V48LWzIPk2/Emw3vL3Bw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le vendredi 30 juin 2006 =C3=A0 16:15 -0700, H. Peter Anvin a =C3=A9crit :
> Michael Tokarev wrote:
> > Pavel Machek wrote:
> > [klibc/kinit in kernel]
> >> I'd like to eventually move swsusp out of kernel, and klibc means I
> >> may be able to do that without affecting users. Being in kinit is good
> >> enough, because I can actually share single source between kinit
> >> version and suspend.sf.net version.
> >=20
> > Heh.  Take a look at anyone who's using real initramfs for their boot
> > process.  Not initrd, not kernel-without-any-preboot-fs, but real
> > initramfs.  For them, if kinit/klibc will be in kernel, nothing changes=
,
> > because their initramfs *replaces* in-kernel code and future supplied-
> > with-kernel-klibc-based-kinit.  So if you'll move swsusp into kinit,
> > it WILL break setups for those users!.. ;)
> Either the kernel can unconditionally invoke /kinit, which then would=20
> invoke the users /init if present, or the swsusp can be a separate=20
> initramfs binary which the user's initramfs gets to invoke (the second=20
> is arguably neater, but requires minor changes to the users initramfs.)

The Ubuntu initramfs doesn't use kinit, and it would be nice if we
weren't forced to.  We do a number of things in our initramfs (like a
userspace bootsplace) which we need done before most of the things kinit
wants to do take place.

kinit is a nice default tool but longer term, I almost imagine it as a
busybox type of setup.  Either you say "go" and it brings up the system,
or you call it with an argument, change argv[0] or something to get just
the functionality asked for.

Tks,
Jeff Bailey

--=20
* Canonical Ltd * Ubuntu Service and Support * +1 514 691 7221 *

Linux for Human Beings.

--=-V48LWzIPk2/Emw3vL3Bw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEplT5kNAc0s37a3gRAknbAJ9EXTduG0Lh4cxDuW7+K8+RArrG6ACgqRlP
bDl/lvxcFgZAXkjcYyfwpBw=
=c3q2
-----END PGP SIGNATURE-----

--=-V48LWzIPk2/Emw3vL3Bw--

