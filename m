Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWASGGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWASGGI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWASGGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:06:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932545AbWASGGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:06:07 -0500
Message-ID: <43CF2CA3.5020001@redhat.com>
Date: Wed, 18 Jan 2006 22:07:31 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prototypes for *at functions & typo fix
References: <200601190429.k0J4TWXD018136@devserv.devel.redhat.com>	 <20060118203733.5aac5ee4.akpm@osdl.org> <1137646586.2842.6.camel@entropy>
In-Reply-To: <1137646586.2842.6.camel@entropy>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB4274C94C7FCC131BB6E12A2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4274C94C7FCC131BB6E12A2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Nicholas Miell wrote:
> AMD64 renumbered all the syscalls for optimal cacheline usage or
> something stupid like that. I suppose the x86 emulation on AMD64 kernel=
s
> could share the i386 table, but then _NR_foo will have a different valu=
e
> depending on context, and that'll just get confusing.

Yes, the syscall numbers are quite different, especially because x86 has
all syscalls, even the obsolete ones.

But what I mean is that the __NR_ia32_* macros in
asm-x86-64/ia32_unistd.h aren't used anywhere in the kernel.  And in
userland the asm-x86/unistd.h file is used when compiling x86 apps.  At
least this is how the kernel headers for userlevel use should be set up.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigB4274C94C7FCC131BB6E12A2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDzyyj2ijCOnn/RHQRAhL5AJ9M4Z40OIrkaJ5KuCvpnFTf9Wol5QCfdTDa
ovAp2R5VLVmBogbeugh1PtA=
=/Nqq
-----END PGP SIGNATURE-----

--------------enigB4274C94C7FCC131BB6E12A2--
