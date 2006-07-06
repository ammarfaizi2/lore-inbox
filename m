Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWGFTKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWGFTKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWGFTKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:10:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2271 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750714AbWGFTKI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:10:08 -0400
Message-ID: <44AD600E.9050204@redhat.com>
Date: Thu, 06 Jul 2006 12:10:06 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Michael Kerrisk <mtk-manpages@gmx.net>, mtk-lkml@gmx.net, rlove@rlove.org,
       roland@redhat.com, eggert@cs.ucla.edu, paire@ri.silicomp.fr,
       torvalds@osdl.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop signals+SIGCONT
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com> <44AD5CB6.7000607@redhat.com> <44AD5E5C.6070703@colorfullife.com>
In-Reply-To: <44AD5E5C.6070703@colorfullife.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig39B33566E5661EE809854B5D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig39B33566E5661EE809854B5D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Manfred Spraul wrote:
> Is it necessary that the futex syscall ignores SA_RESTART?

You might break some incorrectly written code this wait.  sem_wait(),
one example, directly exposes the EINTR error to program.  That behavior
would change from what it is today, better or worse depends on the
situation.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig39B33566E5661EE809854B5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFErWAO2ijCOnn/RHQRAq3jAKCPwP1diMXBuD//8ptAPdA1E1xzxQCeOOhV
cSr7Y42mBLU+Nuh9CQEwL84=
=vYkp
-----END PGP SIGNATURE-----

--------------enig39B33566E5661EE809854B5D--
