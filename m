Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWGGGUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWGGGUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 02:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGGGUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 02:20:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48279 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751190AbWGGGUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 02:20:45 -0400
Message-ID: <44ADFD43.4040204@redhat.com>
Date: Thu, 06 Jul 2006 23:20:51 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Michael Kerrisk <michael.kerrisk@gmx.net>
CC: mtk-manpages@gmx.net, mtk-lkml@gmx.net, rlove@rlove.org, roland@redhat.com,
       eggert@cs.ucla.edu, torvalds@osdl.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com> <20060707043220.186800@gmx.net> <44ADE9B6.1020900@redhat.com> <20060707050731.186770@gmx.net>
In-Reply-To: <20060707050731.186770@gmx.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBFE2EFCE5A58DFB09D356DC3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBFE2EFCE5A58DFB09D356DC3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Michael Kerrisk wrote:
> Yes; this is why I'm only proposing to change EINTR to ERESTARTNOHAND
> at the moment.  The only userspace visible change that I think
> this will bring about is in the stop+SIGCONT case.

That's fine.


> Changing EINTR
> to ERESTARTSYS is likely to have more impact on userland (though=20
> it still strikes me as a desirable gola to have all system calls=20
> restartable via SA_RESTART).

This is certainly a nice goal but it changes the current ABI.  Therefore
it cannot be anything but an option and I don't assume we want to add so
much cruft for just this.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigBFE2EFCE5A58DFB09D356DC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFErf1D2ijCOnn/RHQRAuSVAKC0zV6nwR45UbA/vgjbv2jOr2x6TACZARe2
+K6h5tHU9OOQVV4Vb4Wkdkk=
=PjBh
-----END PGP SIGNATURE-----

--------------enigBFE2EFCE5A58DFB09D356DC3--
