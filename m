Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265909AbUH0Wuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265909AbUH0Wuh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 18:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUH0Wuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 18:50:37 -0400
Received: from grendel.firewall.com ([66.28.58.176]:58509 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S265909AbUH0Wts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 18:49:48 -0400
Date: Sat, 28 Aug 2004 00:49:37 +0200
From: Marek Habersack <grendel@caudium.net>
To: "Nemosoft Unv." <webcam@smcc.demon.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Craig Milo Rogers <rogers@isi.edu>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040827224937.GA5107@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20040826233244.GA1284@isi.edu> <20040827185541.GC24018@isi.edu> <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org> <200408272342.30619@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <200408272342.30619@smcc.demon.nl>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 27, 2004 at 11:42:30PM +0200, Nemosoft Unv. scribbled:
[snip]
> > So I'd personally much prefer the user mode approach. At that point it's
> > still closed-source, but at least there is not even a whiff of a "hook"
> > inside the kernel.
>=20
> My problem with that is that it makes using such cams a lot harder for bo=
th=20
> users and developers of webcam tools. Basicly, every tool that wanted to=
=20
> use webcam X that has some binary-only library would need to specifically=
=20
> support it, use probing routines, check which formats are supported, set =
up=20
> the decompressor, push the data through it, etc. Conversely, every user=
=20
> that wanted to use webcams X, Y and Z would need to check first if they a=
re=20
> all supported by the program(s) he would like to use.
Forgive me if I'm talking bullshit, but wouldn't it be possible for you to
route the stream through a device with an entry in /dev/ which would be
opened by a userspace daemon which would take the stream from the in-kernel
pwc driver, apply all the codec magic to it, and then give it back to the
driver in the kernel so that the application that grabs the frames would get
the processed data? That way you would need only one userlevel daemon to
support the codecs and all the other apps would just read the data from the
framebuffer.

regards,

marek

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBL7qBq3909GIf5uoRAsqeAJ9Ku82tiB+o8HisF3qO6tZQA72u/wCeOegk
ui3Qn7ldatMfye5JQ8/Yjqk=
=arjn
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
