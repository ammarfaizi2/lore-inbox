Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264042AbUEHSbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbUEHSbY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbUEHSbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:31:24 -0400
Received: from dhcp160178171.columbus.rr.com ([24.160.178.171]:48906 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S264042AbUEHSbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:31:03 -0400
Date: Sat, 8 May 2004 14:31:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040508183103.GA825@samarkand.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20040505013135.7689e38d.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6-rc3/2=
=2E6.6-rc3-mm2/

> +fix-deadlock-in-journalled-quota-fix.patch
>=20
>  Fix fix-deadlock-in-journalled-quota.patch

    This patch seems to be slightly mangled; patch complains if
fs/dquot.c.orig already exists, though it doesn't seem to create such
a file in either case.

> +remove-errno-refs.patch
> +ia64-remove-errno-refs.patch
>=20
>  Fiddle with kernel syscalls and remove the global `errno' variable.  I
>  actually meant to drop this because we'll be doing it differently.

    I had to back these two patches out to build for ppc:

  LD      .tmp_vmlinux1
arch/ppc/kernel/built-in.o(.text+0x32a2): In function `execve':
arch/ppc/kernel/entry.S: undefined reference to `errno'
arch/ppc/kernel/built-in.o(.text+0x32a6):arch/ppc/kernel/entry.S:
undefined reference to `errno'
make: *** [.tmp_vmlinux1] Error 1

    Probably just another reason to drop them.  I think I'm about to
find out if I should have backed out the syscall patch too. :)

--=20
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William G. Perry

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAnSdnWv4KsgKfSVgRAqwOAJ9Hi2DEoqkS/amOGOBe+33klzTRvwCghdZY
938dTP1Jfo1NvR2NlY8gf5w=
=4Wk6
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
