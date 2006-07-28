Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161359AbWG1XFx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161359AbWG1XFx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 19:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161360AbWG1XFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 19:05:53 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6851 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161359AbWG1XFw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 19:05:52 -0400
Message-Id: <200607282305.k6SN5e0k015125@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
In-Reply-To: Your message of "Fri, 28 Jul 2006 20:48:31 +0200."
             <1154112511.6416.46.camel@laptopd505.fenrus.org>
From: Valdis.Kletnieks@vt.edu
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154102736.6416.19.camel@laptopd505.fenrus.org> <200607282045.05292.ak@suse.de>
            <1154112511.6416.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154127939_2994P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 19:05:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154127939_2994P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <15051.1154127931.1@turing-police.cc.vt.edu>

On Fri, 28 Jul 2006 20:48:31 +0200, Arjan van de Ven said:
> On Fri, 2006-07-28 at 20:45 +0200, Andi Kleen wrote:
> > > +ifdef CONFIG_CC_STACKPROTECTOR
> > > +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> > > +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
> > 
> > Why can't you just use the normal call cc-option for this?
> 
> this requires gcc 4.2; cc-option is not useful for that.

At least some things calling themselves 4.1.1 include it.  On a Fedora
Rawhide box:

% gcc -v -fstack-protector hello.c
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --enable-plugin --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --with-cpu=generic --host=i386-redhat-linux
Thread model: posix
gcc version 4.1.1 20060721 (Red Hat 4.1.1-13)
 /usr/libexec/gcc/i386-redhat-linux/4.1.1/cc1 -quiet -v hello.c -quiet -dumpbase hello.c -mtune=generic -auxbase hello -version -fstack-protector -o /tmp/ccLfn4gs.s
ignoring nonexistent directory "/usr/lib/gcc/i386-redhat-linux/4.1.1/../../../../i386-redhat-linux/include"
#include "..." search starts here:
#include <...> search starts here:
 /usr/local/include
 /usr/lib/gcc/i386-redhat-linux/4.1.1/include
 /usr/include
End of search list.
GNU C version 4.1.1 20060721 (Red Hat 4.1.1-13) (i386-redhat-linux)
        compiled by GNU C version 4.1.1 20060721 (Red Hat 4.1.1-13).
GGC heuristics: --param ggc-min-expand=81 --param ggc-min-heapsize=96852
Compiler executable checksum: cbc4b2991046c2b178d1ad5878ca2677
hello.c: In function 'main':
hello.c:1: warning: incompatible implicit declaration of built-in function 'printf'
 as -V -Qy -o /tmp/cceHv3eO.o /tmp/ccLfn4gs.s
GNU assembler version 2.17.50.0.3-1 (i386-redhat-linux) using BFD version 2.17.50.0.3-1 20060715
 /usr/libexec/gcc/i386-redhat-linux/4.1.1/collect2 --eh-frame-hdr -m elf_i386 --hash-style=gnu -dynamic-linker /lib/ld-linux.so.2 /usr/lib/gcc/i386-redhat-linux/4.1.1/../../../crt1.o /usr/lib/gcc/i386-redhat-linux/4.1.1/../../../crti.o /usr/lib/gcc/i386-redhat-linux/4.1.1/crtbegin.o -L/usr/lib/gcc/i386-redhat-linux/4.1.1 -L/usr/lib/gcc/i386-redhat-linux/4.1.1 -L/usr/lib/gcc/i386-redhat-linux/4.1.1/../../.. /tmp/cceHv3eO.o -lgcc --as-needed -lgcc_s --no-as-needed -lc -lgcc --as-needed -lgcc_s --no-as-needed /usr/lib/gcc/i386-redhat-linux/4.1.1/crtend.o /usr/lib/gcc/i386-redhat-linux/4.1.1/../../../crtn.o

--==_Exmh_1154127939_2994P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyphDcC3lWbTT17ARAh62AKChMKPjCLUBSFCmevTPmp1EzVSb9ACffOXd
YT64VbVDz7dmh1rJSSX3ecc=
=w2OV
-----END PGP SIGNATURE-----

--==_Exmh_1154127939_2994P--
