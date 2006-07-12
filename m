Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWGLQtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWGLQtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWGLQtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:49:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25530 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751161AbWGLQtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:49:42 -0400
Message-ID: <44B5283E.7090806@redhat.com>
Date: Wed, 12 Jul 2006 09:50:06 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com> 	<20060710155051.326e49da.rdunlap@xenotime.net> 	<m1veq4kcij.fsf@ebiederm.dsl.xmission.com> 	<1152601640.3128.7.camel@laptopd505.fenrus.org> <m1irm2bxk3.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irm2bxk3.fsf_-_@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig68D77FADE050ECCB63732D2F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68D77FADE050ECCB63732D2F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Eric W. Biederman wrote:
> But uname is noticeably faster than sysctl and uname is more portable
> across linux flavors.  So updating the glibc pthread code to use
> uname looks like the right way to implement is_smp_system.=20

This is (was?) not the universal through.  We used uname at some point
but then I did some profiling and sysctl turned out to be faster.

If the reverse is true now I can certainly look into changing this but
the evidence and ideally has to be there.  The simplicity of the uname
code should mean that it's faster.

In a year or two I'll remove the test anyway.  By then there will likely
not be any UP kernels on reasonable machines anymore and I can drop all
the conditional code.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig68D77FADE050ECCB63732D2F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEtSg+2ijCOnn/RHQRAvJ5AKCfxH3bGX0o3kndJC/xc0yeIZQ9EACgueKP
/zmuqElb6mUJS9n4pIAor48=
=nQJl
-----END PGP SIGNATURE-----

--------------enig68D77FADE050ECCB63732D2F--
