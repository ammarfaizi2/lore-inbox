Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266993AbUAXScx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266994AbUAXScx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:32:53 -0500
Received: from h80ad2738.async.vt.edu ([128.173.39.56]:50307 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266993AbUAXScv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:32:51 -0500
Message-Id: <200401241832.i0OIWYl1030218@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Serge Belyshev <33554432@mtu-net.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/i386/Makefile,scripts/gcc-version.sh,Makefile small fixes 
In-Reply-To: Your message of "Sat, 24 Jan 2004 10:17:04 PST."
             <20040124101704.3bf3ada2.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <87oestsard.fsf@mtu-net.ru>
            <20040124101704.3bf3ada2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1896796858P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Jan 2004 13:32:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1896796858P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <30207.1074969154.1@turing-police.cc.vt.edu>

On Sat, 24 Jan 2004 10:17:04 PST, Andrew Morton said:

> > Makefile: 
> > *  There is no point in adding -funit-at-a-time option because it is
> >    enabled by default at levels -Os, -O2 and -O3.
> 
> hm.  Didn't Andi say that adding -fno-unit-at-a-time caused code shrinkage?

Also, at least for the Fedora gcc-ssa compiler, -funit-at-a-time is *not* a
default option (provably so - building with gcc-ssa makes a kernel that hangs
*very* early on (right after 'decompressing the kernel' - I haven't dug into
this yet) - but commenting out this:

# Enable unit-at-a-time mode when possible. It shrinks the
# kernel considerably.
CFLAGS += $(call check_gcc,-funit-at-a-time,)

results in a working kernel.  This is with:

%  gcc-ssa --version
gcc-ssa (GCC) 3.5-tree-ssa 20040115 (Fedora Core Rawhide 3.5ssa-108)


--==_Exmh_-1896796858P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAErpCcC3lWbTT17ARArxQAKCuGPv9Gprz2TCEq6sKTtB+t/V6pgCgpUp9
usnEma5rJS17zYW3S1Nw0z8=
=JqXI
-----END PGP SIGNATURE-----

--==_Exmh_-1896796858P--
