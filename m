Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbSLKVY6>; Wed, 11 Dec 2002 16:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbSLKVY6>; Wed, 11 Dec 2002 16:24:58 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:22533 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S267292AbSLKVY4>; Wed, 11 Dec 2002 16:24:56 -0500
Message-Id: <5.1.1.6.2.20021211223006.00cded00@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 11 Dec 2002 22:33:05 +0100
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Same with Linux 2.4.20-ac2 <-> Re: Problems compiling 2.4.20 -
  fail just in 'make' - please help
In-Reply-To: <5.1.1.6.2.20021211210820.00cde0c0@192.168.2.131>
References: <Pine.LNX.4.33L2.0212111138530.15702-100000@dragon.pdx.osdl .net>
 <20021211192105.GA1649@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same problem with Linux 2.4.20-ac2

I think its not a kernel code problem. Have any some idea about the real one?
Any compatibility problem with gcc3.2.2 in variable use?

BTW: special warning with:
-> /usr/src/linux-2.4.20/include/linux/kernel.h:10:20: stdarg.h: No such 
file or directory

At 21:11 11/12/2002 +0100, system_lists@nullzone.org wrote:


>My gcc compiler:
>
>server01:/usr/src/linux-2.4.20# gcc -v
>Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.2/specs
>Configured with: ../src/configure -v 
>--enable-languages=c,c++,java,f77,proto,pascal,objc,ada --prefix=/usr 
>--mandir=/usr/share/man --infodir=/usr/share/info 
>--with-gxx-include-dir=/usr/include/c++/3.2 --enable-shared 
>--with-system-zlib --enable-nls --without-included-gettext 
>--enable-__cxa_atexit --enable-clocale=gnu --enable-java-gc=boehm 
>--enable-objc-gc i386-linux
>Thread model: posix
>gcc version 3.2.2 20021202 (Debian prerelease)
>
>
>------- the fail --------
>
>server01:/usr/src/linux-2.4.20# make
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
>-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
>-pipe -mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=main -c 
>-o init/main.o init/main.c
>. scripts/mkversion > .tmpversion
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
>-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
>-pipe -mpreferred-stack-boundary=2 -march=i686  -DUTS_MACHINE='"i386"' 
>-DKBUILD_BASENAME=version -c -o init/version.o init/version.c
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
>-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
>-pipe -mpreferred-stack-boundary=2 
>-march=i686   -DKBUILD_BASENAME=do_mounts -c -o init/do_mounts.o 
>init/do_mounts.c
>make CFLAGS="-D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall 
>-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
>-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 " 
>-C  kernel
>make[1]: Entering directory `/usr/src/linux-2.4.20/kernel'
>make all_targets
>make[2]: Entering directory `/usr/src/linux-2.4.20/kernel'
>gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall -Wstrict-prototypes 
>-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
>-pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix 
>include -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c -o sched.o sched.c
>In file included from /usr/src/linux-2.4.20/include/linux/wait.h:13,
>                  from /usr/src/linux-2.4.20/include/linux/fs.h:12,
>                  from /usr/src/linux-2.4.20/include/linux/capability.h:17,
>                  from /usr/src/linux-2.4.20/include/linux/binfmts.h:5,
>                  from /usr/src/linux-2.4.20/include/linux/sched.h:9,
>                  from /usr/src/linux-2.4.20/include/linux/mm.h:4,
>                  from sched.c:23:
>/usr/src/linux-2.4.20/include/linux/kernel.h:10:20: stdarg.h: No such file 
>or directory
>In file included from /usr/src/linux-2.4.20/include/linux/wait.h:13,
>                  from /usr/src/linux-2.4.20/include/linux/fs.h:12,
>                  from /usr/src/linux-2.4.20/include/linux/capability.h:17,
>                  from /usr/src/linux-2.4.20/include/linux/binfmts.h:5,
>                  from /usr/src/linux-2.4.20/include/linux/sched.h:9,
>                  from /usr/src/linux-2.4.20/include/linux/mm.h:4,
>                  from sched.c:23:
>/usr/src/linux-2.4.20/include/linux/kernel.h:74: parse error before "va_list"
>/usr/src/linux-2.4.20/include/linux/kernel.h:74: warning: function 
>declaration isn't a prototype
>/usr/src/linux-2.4.20/include/linux/kernel.h:77: parse error before "va_list"
>/usr/src/linux-2.4.20/include/linux/kernel.h:77: warning: function 
>declaration isn't a prototype
>/usr/src/linux-2.4.20/include/linux/kernel.h:81: parse error before "va_list"
>/usr/src/linux-2.4.20/include/linux/kernel.h:81: warning: function 
>declaration isn't a prototype
>make[2]: *** [sched.o] Error 1
>make[2]: Leaving directory `/usr/src/linux-2.4.20/kernel'
>make[1]: *** [first_rule] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.4.20/kernel'
>make: *** [_dir_kernel] Error 2
>server01:/usr/src/linux-2.4.20#
>
>
>
>???????
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/




