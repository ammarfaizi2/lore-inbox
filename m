Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUBVRXT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUBVRXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:23:19 -0500
Received: from smtp.golden.net ([199.166.210.31]:36875 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S261705AbUBVRXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:23:15 -0500
Date: Sun, 22 Feb 2004 12:23:07 -0500
From: Paul Mundt <lethal@linux-sh.org>
To: linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
       Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
       cliff white <cliffw@osdl.org>, "Timothy D. Witham" <wookie@osdl.org>
Cc: Richard Curnow <richard.curnow@superh.com>
Subject: Re: Kernel Cross Compiling [update]
Message-ID: <20040222172307.GB11162@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	linux-kernel@vger.kernel.org, Jim Wilson <wilson@specifixinc.com>,
	Judith Lebzelter <judith@osdl.org>, Dan Kegel <dank@kegel.com>,
	cliff white <cliffw@osdl.org>, "Timothy D. Witham" <wookie@osdl.org>,
	Richard Curnow <richard.curnow@superh.com>
References: <20040222035350.GB31813@MAIL.13thfloor.at> <20040222155209.GA11162@linux-sh.org> <20040222170720.GA24703@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20040222170720.GA24703@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2004 at 06:07:20PM +0100, Herbert Poetzl wrote:
> but why does the sh/sh case fail?
>=20
The sh/sh case failed due to the .rept usage. I'm not entirely sure when
this started to pop up, but it does work again in binutils CVS (or at least
it did the last time I checked it out). For the time being, I've just gotten
rid of it entirely and just padded out with sys_ni_syscall. (Look at your
error log for the exact line).

> okay, binutils and gcc seem to 'know' sh and sh64 as=20
> architectures, (in my case binutils 2.14.90.0.8, and=20
> gcc 3.3.2, w/o any patches), what binutils/gcc would
> you suggest for building sh or sh64?
>=20
A lot of that depends on what you're trying to build for. The sh defconfig
is for SH-3, in which case the default gcc and binutils should work just
fine. For SH-2 and SH-4, there's patch work that needs to be done both
for gcc and binutils.

> is there a toolchain/binutils which 'know' and 'support'
> the '-isa=3Dsh64' option? maybe it was depreciated?
>=20
I don't know of one out in the wild. SuperH has their own toolchains that
support this, and is what I currently use. I'm not sure what the status of
their patches are in relation to getting merged into current gcc/binutils.
Richard (CC'ed) might know though, Richard?


--jho1yZJdad60DJr+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFAOOV71K+teJFxZ9wRAhvfAJ9vBZ3nVzFDklVk8QZMl7SmX/VJbwCfZnE2
p0+Tjz2GsVp2B8CmgUd//gI=
=zGPK
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
