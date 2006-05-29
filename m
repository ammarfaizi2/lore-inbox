Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWE2GA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWE2GA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 02:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWE2GA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 02:00:26 -0400
Received: from pool-72-66-202-199.ronkva.east.verizon.net ([72.66.202.199]:8903
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751216AbWE2GAZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 02:00:25 -0400
Message-Id: <200605290559.k4T5xDVO029424@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: 4Front Technologies <dev@opensound.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       bidulock@openss7.org, Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
In-Reply-To: Your message of "Sun, 28 May 2006 22:35:56 PDT."
             <447A883C.5070604@opensound.com>
From: Valdis.Kletnieks@vt.edu
References: <e55715+usls@eGroups.com> <1148596163.31038.30.camel@mindpipe> <1148653797.3579.18.camel@laptopd505.fenrus.org> <20060528130320.GA10385@osiris.ibm.com> <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org>
            <447A883C.5070604@opensound.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1148882352_6867P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 May 2006 01:59:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1148882352_6867P
Content-Type: text/plain; charset=us-ascii

On Sun, 28 May 2006 22:35:56 PDT, 4Front Technologies said:

> Yet one more reason to have something like kernel-config (similar to gtk-config 
> or xmms-config) where you can get the package's cflags, ldflags, other info.
> 
> for example
> 
> kernel-config --cflags should say -DUSE_REGPARM -I/lib/modules/blah/blah

The problem is that there's *hundreds* of *lines* of config data, rather than
just the half-dozen or so entries that the average pkgconfig produces, and some
of the config lines influence the actual compile parameters and some don't.

I happen to have a kernel build going - here's what the compile lines looks:

25616 pts/2    S+     0:00 /bin/sh -c set -e; ?   echo '  CC      net/ipv4/udp.o'; gcc -m32 -Wp,-MD,net/ipv4/.udp.o.d  -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.1.1/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Wcomment -Wendif-labels -Wshadow -Os -fno-omit-frame-pointer -fno-optimize-sibling-calls -fasynchronous-unwind-tables -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i686 -mtune=pentium4 -mregparm=3 -ffreestanding -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement -Wno-pointer-sign    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(udp)"  -D"KBUILD_MODNAME=KBUILD_STR(udp)" -c -o net/ipv4/udp.o net/ipv4/udp.c;  scripts/basic/fixdep net/ipv4/.udp.o.d net/ipv4/udp.o 'gcc -m32 -Wp,-MD,net/ipv4/.udp.o.d  -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.1.1/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Wall -Wundef -W!
 strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Wcomment -Wendif-labels -Wshadow -Os -fno-omit-frame-pointer -fno-optimize-sibling-calls -fasynchronous-unwind-tables -pipe -msoft-float -mpreferred-stack-boundary=2  -march=i686 -mtune=pentium4 -mregparm=3 -ffreestanding -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement -Wno-pointer-sign    -D"KBUILD_STR(s)=\#s" -D"KBUILD_BASENAME=KBUILD_STR(udp)"  -D"KBUILD_MODNAME=KBUILD_STR(udp)" -c -o net/ipv4/udp.o net/ipv4/udp.c' > net/ipv4/.udp.o.tmp; rm -f net/ipv4/.udp.o.d; mv -f net/ipv4/.udp.o.tmp net/ipv4/.udp.o.cmd
25617 pts/2    S+     0:00 gcc -m32 -Wp,-MD,net/ipv4/.udp.o.d -nostdinc -isystem /usr/lib/gcc/i386-redhat-linux/4.1.1/include -D__KERNEL__ -Iinclude -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Wcomment -Wendif-labels -Wshadow -Os -fno-omit-frame-pointer -fno-optimize-sibling-calls -fasynchronous-unwind-tables -pipe -msoft-float -mpreferred-stack-boundary=2 -march=i686 -mtune=pentium4 -mregparm=3 -ffreestanding -Iinclude/asm-i386/mach-default -Wdeclaration-after-statement -Wno-pointer-sign -DKBUILD_STR(s)=#s -DKBUILD_BASENAME=KBUILD_STR(udp) -DKBUILD_MODNAME=KBUILD_STR(udp) -c -o net/ipv4/udp.o net/ipv4/udp.c
25618 pts/2    R+     0:01 /usr/libexec/gcc/i386-redhat-linux/4.1.1/cc1 -quiet -nostdinc -Iinclude -Iinclude/asm-i386/mach-default -D__KERNEL__ -DKBUILD_STR(s)=#s -DKBUILD_BASENAME=KBUILD_STR(udp) -DKBUILD_MODNAME=KBUILD_STR(udp) -isystem /usr/lib/gcc/i386-redhat-linux/4.1.1/include -include include/linux/autoconf.h -MD net/ipv4/.udp.o.d net/ipv4/udp.c -quiet -dumpbase udp.c -m32 -msoft-float -mpreferred-stack-boundary=2 -march=i686 -mtune=pentium4 -mregparm=3 -auxbase-strip net/ipv4/udp.o -Os -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -Wcomment -Wendif-labels -Wshadow -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-aliasing -fno-common -fno-omit-frame-pointer -fno-optimize-sibling-calls -fasynchronous-unwind-tables -ffreestanding -o -

The reason we have the whole kbuild thing than pkgconfig is because it's
a bit more complicated to build than what pkgconfig can easily express (for
instance, the exact parameters are different for module versus built-in,
and on some architectures it may even matter if a module is under fs/ or
drivers/, and so on....)



--==_Exmh_1148882352_6867P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEeo2wcC3lWbTT17ARAqEaAKCCig40JDKm/POTTs6U0kYhbUR6CgCg/l8c
x2P7bnFTrRwp7RcYiq4CJhU=
=JWJW
-----END PGP SIGNATURE-----

--==_Exmh_1148882352_6867P--
