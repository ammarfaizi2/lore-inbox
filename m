Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264867AbUDWQnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264867AbUDWQnr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbUDWQnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:43:47 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:30735 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S264867AbUDWQno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:43:44 -0400
Subject: Re: nvidia binary driver broken with 2.6.6-rc{1,2}, reverting a
	-mm patch makes it work
From: Antony Suter <suterant@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Cc: m.c.p@kernel.linux-systeme.com, Ralf.Hildebrandt@charite.de,
       sleightofmind@xs4all.nl
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tiCcJv1mK0vn68BMQOlv"
Message-Id: <1082738585.26812.14.camel@hikaru.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 24 Apr 2004 02:43:05 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tiCcJv1mK0vn68BMQOlv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marc wrote:
> On Friday 23 April 2004 10:30, Ralf Hildebrandt wrote:
> Hi Ralf,
>=20
> > > Because of a patch from -mm merged in mainstream i cannot get the
nvidia
> > > binary to work with the 2.6.6 release candidates. I get this
message
> > > when doing `modprobe nvidia`:
>=20
> > $ uname -a
> > Linux hummus2 2.6.6-rc2-bk1 #1 Thu Apr 22 14:15:08 CEST 2004 i686
> > GNU/Linux
> > nvidia works like a charm here.
>=20
> that's the problem. It works for many people, for many others not. It
always=20
> worked fine for me too but I had to rip that out of my 2.6-WOLK tree
to=20
> satisfy all people using wolk and lack of knowledge to fix that by
myself.

I had this problem, and I resolved it for me like this: In the
NVIDIA-Linux-x86-1.0-5336-pkg?.run archive from Nvidia are multiple make
files. By default, my distro was using the make file "makefile" and it
stopped working. I switched to using "Makefile.kbuild", which is
oriented to 2.6 kernels, and it works again. Comments within
Makefile.kbuild touch on changes to module handling in 2.6 compared to
2.4.

--=20
- Antony Suter  (suterant users sourceforge net)  "Bonta"
- "...through shadows falling, out of memory and time..."

--=-tiCcJv1mK0vn68BMQOlv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiUeYZu6XKGV+xxoRAvHfAJ0ZLKJK4ayxV+rohHO390Zqp715HACfZGbi
0IVAM9A8gRRDycYApShXpGA=
=lL+0
-----END PGP SIGNATURE-----

--=-tiCcJv1mK0vn68BMQOlv--

