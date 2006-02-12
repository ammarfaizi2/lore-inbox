Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWBLQgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWBLQgB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWBLQgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:36:01 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751141AbWBLQgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:36:00 -0500
Message-ID: <43EF6473.3090607@redhat.com>
Date: Sun, 12 Feb 2006 08:38:11 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] updated fstatat64 support
References: <200602101528.k1AFSFIg011658@devserv.devel.redhat.com> <20060211112157.GA9371@osiris.boeblingen.de.ibm.com> <20060212130903.GA20732@suse.de>
In-Reply-To: <20060212130903.GA20732@suse.de>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C3EE7385D16787C02C82D0B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C3EE7385D16787C02C82D0B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Olaf Hering wrote:
> s390 doesnt compile because sys_newfstatat() is not defined.
> __ARCH_WANT_STAT64 is defined for 32bit build in
> include/asm-s390/unistd.h. This change fixes compilation, but its likel=
y
> not correct to do it that way:

Indeed.  You most probably want to change the reference in the syscall
table to sys_fstatat64.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig0C3EE7385D16787C02C82D0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD72Rz2ijCOnn/RHQRAku6AJ441WXSqtF38Wt1r0i55wVFWUV39wCglhml
2vj4OhKR4WN8rHBvkQLrRP8=
=DW47
-----END PGP SIGNATURE-----

--------------enig0C3EE7385D16787C02C82D0B--
