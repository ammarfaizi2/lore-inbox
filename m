Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbVHWWJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbVHWWJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 18:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVHWWJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 18:09:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52612 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932459AbVHWWJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 18:09:11 -0400
Message-ID: <430B9E45.3080107@redhat.com>
Date: Tue, 23 Aug 2005 15:08:05 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mremap() use is racy
References: <430B7EAE.6020001@redhat.com> <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com> <430B8D96.5080002@redhat.com> <Pine.LNX.4.58.0508231425330.3317@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508231425330.3317@g5.osdl.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig12358AB1233D1F415FA77B41"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12358AB1233D1F415FA77B41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> Actually, it should be pretty much as valid as using mremap - ie it wor=
ks=20
> on Linux.=20
>=20
> Especially if you use MAP_SHARED, you don't even need to mprotect=20
> anything: you'll get a nice SIGBUS if you ever try to access past the l=
ast=20
> page that maps the file.

If you guarantee this (and test for this) it's fine with me.  The POSIX
spec explicitly leaves this undefined and requiring to use mremap()
would be a nice way to work around this without allowing the
introduction of undefined behavior into programs.  I probably would
prefer to use mremap() since this makes it clear what should happen but
I can live with using the too-large mapping.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig12358AB1233D1F415FA77B41
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDC55F2ijCOnn/RHQRAtugAKCK2/T+WjZFDz4feCK1v0eTF7eRIgCgsbbg
g1c/bAVdMdJLDAubEuIazPI=
=BXNk
-----END PGP SIGNATURE-----

--------------enig12358AB1233D1F415FA77B41--
