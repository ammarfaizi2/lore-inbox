Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWJFVQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWJFVQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 17:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWJFVQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 17:16:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932629AbWJFVQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 17:16:34 -0400
Message-ID: <4526C7F4.6090706@redhat.com>
Date: Fri, 06 Oct 2006 14:17:40 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stas Sergeev <stsp@aknet.ru>, Andrew Morton <akpm@osdl.org>,
       Jakub Jelinek <jakub@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] honour MNT_NOEXEC for access()
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru>	 <1159887682.2891.537.camel@laptopd505.fenrus.org>	 <45229A99.6060703@aknet.ru>	 <1159899820.2891.542.camel@laptopd505.fenrus.org>	 <4522AEA1.5060304@aknet.ru>	 <1159900934.2891.548.camel@laptopd505.fenrus.org>	 <4522B4F9.8000301@aknet.ru>	 <20061003210037.GO20982@devserv.devel.redhat.com>	 <45240640.4070104@aknet.ru>  <45269BEE.7050008@aknet.ru> <1160170464.12835.4.camel@localhost.localdomain>
In-Reply-To: <1160170464.12835.4.camel@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD665DC0788E2268AC908603E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD665DC0788E2268AC908603E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alan Cox wrote:
> I doubt anyone uses access() any more for anything but this doesn't see=
m
> to conflict with the POSIX spec.

Well, there are cases where access is used (libc, for instance, uses it
instead of an open for files which most likely don't exist since access
if faster than a failed open call).

The change itself is conceptually correct.  I haven't looked at the
technical details but it looks OK.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigD665DC0788E2268AC908603E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFJsf02ijCOnn/RHQRAqzEAJ9vfeXvyzGjeXG8nJp7HOyluWMOKgCgyGuT
yP0rm2miFyV73383nPomnaA=
=uWSw
-----END PGP SIGNATURE-----

--------------enigD665DC0788E2268AC908603E--
