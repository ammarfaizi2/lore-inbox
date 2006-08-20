Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWHTQac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWHTQac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWHTQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:30:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750865AbWHTQab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:30:31 -0400
Message-ID: <44E88DC3.7000708@redhat.com>
Date: Sun, 20 Aug 2006 09:28:51 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
References: <20060820003840.GA17249@openwall.com>	 <20060820100706.GB6003@steel.home>  <20060820153037.GA20007@openwall.com> <1156089203.23756.46.camel@laptopd505.fenrus.org>
In-Reply-To: <1156089203.23756.46.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE09D0F8D92544178409C95DF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE09D0F8D92544178409C95DF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arjan van de Ven wrote:
> sounds like a good argument to get the setuid functions marked
> __must_check in glibc...

There are too many false positives.  E.g., in a SUID binaries switching
back from a non-root UID to root will not fail.  Very common.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigE09D0F8D92544178409C95DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFE6I3D2ijCOnn/RHQRAvopAKCXHVlRD3LlNKGlR1ARzwGxZD77vACfZCae
Xez/gwfN1G2Ihd5h12ZmvNw=
=p4nl
-----END PGP SIGNATURE-----

--------------enigE09D0F8D92544178409C95DF--
