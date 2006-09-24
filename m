Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWIXPsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWIXPsG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 11:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWIXPsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 11:48:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6084 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751173AbWIXPsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 11:48:04 -0400
Message-ID: <4516A8E3.4020100@redhat.com>
Date: Sun, 24 Sep 2006 08:48:51 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru>
In-Reply-To: <45169C0C.5010001@aknet.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35C4B2001155A90D1DF76CFF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35C4B2001155A90D1DF76CFF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Stas Sergeev wrote:
> The one that goes to /dev/shm should allow PROT_EXEC, yet
> not allow executing the binaries with execve().

Why on earth would you want this?  Previously you already acknowledged
that this kind of "protection" can be worked around by using ld.so
directly.  Even if you try to stop this you can implement this
functionality in a scripting language.

Either all executable mapping is forbidden or none.  No middle ground
can exist.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig35C4B2001155A90D1DF76CFF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFFqjj2ijCOnn/RHQRAqCJAJwK5lkRwq7rsTP2x08nCEWDmFdoqQCdEBx8
2KWIZz4ZhnlW3AHbQGSbNsU=
=3+/s
-----END PGP SIGNATURE-----

--------------enig35C4B2001155A90D1DF76CFF--
