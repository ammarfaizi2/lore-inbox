Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265780AbUFVXFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUFVXFC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUFVXDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:03:11 -0400
Received: from [195.251.120.63] ([195.251.120.63]:29312 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S265100AbUFVR7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:59:18 -0400
From: V13 <v13@priest.com>
To: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Stop the Linux kernel madness
Date: Tue, 22 Jun 2004 20:46:20 +0300
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <40D232AD.4020708@opensound.com> <20040622020615.GE14478@dualathlon.random> <Pine.LNX.4.58.0406221033350.8222@zeus.compusonic.fi>
In-Reply-To: <Pine.LNX.4.58.0406221033350.8222@zeus.compusonic.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_1BH2AkurQN6a1s1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406222046.30018.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-02=_1BH2AkurQN6a1s1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 June 2004 10:54, Hannu Savolainen wrote:
> This kind of "breaks" are not so fatal provided that there is some way to
> detect them reliably. Usually it's possible to check LINUX_VERSION_CODE
> and use different approaches depending on the kernel version. However
> this doesn't always work because distribution vendors often back port
> features from the newer kernels into their distribution kernels which
> have older LINUX_VERSION_CODE. A better  approach would be marking them
> with #define HAVE_NEW_something in the header file that implements this
> change.

I believe we are seeing this kind of problems all the time. This is not jus=
t a=20
kernel 'problem'. Just take a look at the autoconf info page and the tests=
=20
that a portable program has to run.

Of course the makers of (i.e.) glib could just try to find a source tree th=
at=20
would compile everywhere but they know that this is impossible so they have=
=20
to run tests like :

(warning: long list)
checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... 64
checking for _LARGE_FILES value needed for large files... no
checking for locale.h... yes
checking for LC_MESSAGES... yes
checking libintl.h usability... yes
checking libintl.h presence... yes
checking for libintl.h... yes
checking for dgettext in libc... yes
checking size of char... 1
checking for short... yes
checking size of short... 2
checking for nl_langinfo... yes
checking for nl_langinfo and CODESET... yes
checking whether we are using the GNU C Library 2.1 or newer... yes
checking for vasprintf... yes
checking for unsetenv... yes
checking for getc_unlocked... yes
checking for C99 vsnprintf... yes
checking for nl_langinfo (CODESET)... yes
checking for OpenBSD strlcpy/strlcat... no
checking for an implementation of va_copy()... yes
checking for an implementation of __va_copy()... yes
checking whether va_lists can be copied by value... yes
checking for RTLD_GLOBAL brokenness... no
checking for preceeding underscore in symbols... no
checking for dlerror... yes
checking size of pthread_t... 4
checking for pthread_attr_setstacksize... yes
checking for minimal/maximal thread priority...=20
sched_get_priority_min(SCHED_OTHER)/sched_get_priority_max(SCHED_OTHER)
checking for posix yield function... sched_yield
checking whether to use the PID niceness surrogate for thread priorities...=
=20
yes
checking size of pthread_mutex_t... 24
checking byte contents of PTHREAD_MUTEX_INITIALIZER...=20
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
checking value of POLLIN... 1
checking value of POLLOUT... 4
checking value of POLLPRI... 2
checking value of POLLERR... 8
checking value of POLLHUP... 16
checking value of POLLNVAL... 32

=2E. and many more ..

I don't believe that your source code is more complex than theirs. Maybe th=
e=20
solution to your problem is as simple as 'info autoconf'. You know that the=
re=20
are more than one ways to compile kernel modules so you just have to test=20
each one of them and see which one works. We're talking about no more than =
30=20
minutes work. After that you may add another distro in the supported=20
distributions list of your module.

> Hannu
<<V13>>

--Boundary-02=_1BH2AkurQN6a1s1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2HB1VEjwdyuhmSoRAg2VAKCMWWG80B0jiry/P4/wQO9F2CBnUgCghjsL
rNcPrAcsjmWvGucFKstxK6M=
=2Byv
-----END PGP SIGNATURE-----

--Boundary-02=_1BH2AkurQN6a1s1--
