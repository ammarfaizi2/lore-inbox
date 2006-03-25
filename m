Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWCYUnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWCYUnI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWCYUnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 15:43:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751421AbWCYUnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 15:43:07 -0500
Message-ID: <4425AB3C.8010008@redhat.com>
Date: Sat, 25 Mar 2006 12:42:36 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: <alpha/poll.h> change
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig09667111AF2970DEE6A058E1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig09667111AF2970DEE6A058E1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alpha's <sys/poll.h> file was so far compatible with most of the other
archs (except SPARC).  Since the introduction of POLLREMOVE it's
different.  In Alpha:

 #define POLLREMOVE     (1 << 11)
+#define POLLRDHUP       (1 << 12)

For the other archs:

 #define POLLREMOVE     0x1000
+#define POLLRDHUP       0x2000


For Alpha the values should have been 1<<12 and 1<<13.  Neither
POLLREMOVE nor POLLRDHUP have been in any glibc header.  How widely are
they used elsewhere?  Is it too late to change the Alpha definitions to
match the rest?

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig09667111AF2970DEE6A058E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEJas82ijCOnn/RHQRAs/mAJ0eRh/g8xgTI4N03NfNi/Fh5BZFYQCfb7WR
/9M1A4+L+op33J0BKSeS/5M=
=mbUa
-----END PGP SIGNATURE-----

--------------enig09667111AF2970DEE6A058E1--
