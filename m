Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWGFSzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWGFSzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWGFSzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:55:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750727AbWGFSzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:55:49 -0400
Message-ID: <44AD5CB6.7000607@redhat.com>
Date: Thu, 06 Jul 2006 11:55:50 -0700
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
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com> <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
In-Reply-To: <44AD599D.70803@colorfullife.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEDEDC8ABD897C31D263FB50D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDEDC8ABD897C31D263FB50D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Manfred Spraul wrote:
> 1) I would go further and try ERESTARTSYS: ERESTARTSYS means that the
> kernel signal handler honors SA_RESTART
> 2) At least for the futex functions, it won't be as easy as replacing
> EINTR wiht ERESTARTSYS: the futex functions receive a timeout a the
> parameter, with the duration of the wait call as a parameter. You must
> use ERESTART_RESTARTBLOCK.

Whoa, not so fast.  At least the futex syscall but be interruptible by
signals.  It is crucial to return EINTR.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigEDEDC8ABD897C31D263FB50D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFErVy22ijCOnn/RHQRAvKBAJ4+VdRG6fAjZULIcCOFEoKtQJeiVACfXDD/
v0be8jH77ytM4K5413Xd66k=
=/qGm
-----END PGP SIGNATURE-----

--------------enigEDEDC8ABD897C31D263FB50D--
