Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWFRTjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWFRTjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 15:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWFRTjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 15:39:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40071 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932281AbWFRTju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 15:39:50 -0400
Message-ID: <4495AC3B.4020508@redhat.com>
Date: Sun, 18 Jun 2006 12:40:43 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] Implement AT_SYMLINK_FOLLOW flag for linkat
References: <200606171913.k5HJDM3U021408@devserv.devel.redhat.com> <20060618191629.GE27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606181220590.5498@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606181220590.5498@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig588665742129F7A0D9CC4241"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig588665742129F7A0D9CC4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Linus Torvalds wrote:
> Well, the patch as sent in does seem sane, as long as glibc doesn't sta=
rt=20
> defaulting to the insane behaviour. Giving users the _ability_ to link =
to=20
> the symlink target is certainly not wrong, regardless of any standard. =

> Doing it by default is another matter.

I do not intend to change the link implementation in glibc.  That would
be majorly stupid, it'd break the ABI.

The AT_SYMLINK_FOLLOW flag to linkat was the result of the discussion
how to resolve the issue of the conflict between POSIX and the Linux
implementation of link (BTW: the Solaris link syscall behaves the same
as Linux's).  This is an easy an non-intrusive way to help people who
depend on the questionable POSIx-mandated behavior to work around the
incompatiblity.  Nothing more.  Don't change the link syscall, don't
assume the glibc will be changed.  This is only one little extra bit of
new functionality.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig588665742129F7A0D9CC4241
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFElaw72ijCOnn/RHQRAu8IAKCCA4tpmmE0WCUgRJEeGHSzKHwsTwCfTmMA
JirmQs3TT9+k6WuDvG0GSJ4=
=1gRv
-----END PGP SIGNATURE-----

--------------enig588665742129F7A0D9CC4241--
