Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263960AbSJJUVs>; Thu, 10 Oct 2002 16:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263836AbSJJUOO>; Thu, 10 Oct 2002 16:14:14 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:13215 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S262776AbSJJUHL>; Thu, 10 Oct 2002 16:07:11 -0400
Date: Thu, 10 Oct 2002 15:12:45 -0500
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 fails to build on alpha (sys_sync gone?)
Message-ID: <20021010201245.GK18973@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YQEH9CATo+4lan7A"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YQEH9CATo+4lan7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

gcc -Wp,-MD,arch/alpha/kernel/.alpha_ksyms.o.d -D__KERNEL__ -Iinclude -Wall=
 -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-al=
iasing -fno-common -pipe -mno-fp-regs -ffixed-8 -msmall-data -mcpu=3Dev56 -=
Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=3Dalpha_ksyms =
-DEXPORT_SYMTAB  -c -o arch/alpha/kernel/alpha_ksyms.o arch/alpha/kernel/al=
pha_ksyms.c
arch/alpha/kernel/alpha_ksyms.c:164: `sys_sync' undeclared here (not in a f=
unction)
arch/alpha/kernel/alpha_ksyms.c:164: initializer element is not constant
arch/alpha/kernel/alpha_ksyms.c:164: (near initialization for `__ksymtab_sy=
s_sync.value')
make[1]: *** [arch/alpha/kernel/alpha_ksyms.o] Error 1
make: *** [arch/alpha/kernel] Error 2

What happened to sys_sync?!?  It isn't defined anywhere!

cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--YQEH9CATo+4lan7A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2l3zwACgkQjwioWRGe9K2rCACg9WwB10/GqLgwNmlHW5VKKWu7
vmkAnAskowBju0vCjkPbZBoGKT9LQbCh
=2D5O
-----END PGP SIGNATURE-----

--YQEH9CATo+4lan7A--
