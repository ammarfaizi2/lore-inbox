Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbRFGPML>; Thu, 7 Jun 2001 11:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbRFGPLv>; Thu, 7 Jun 2001 11:11:51 -0400
Received: from www.hr.vc-graz.ac.at ([193.171.240.3]:50961 "EHLO
	www.hr.vc-graz.ac.at") by vger.kernel.org with ESMTP
	id <S261347AbRFGPLn>; Thu, 7 Jun 2001 11:11:43 -0400
Message-ID: <3B1F99DF.6CCF6DF3@fl.priv.at>
Date: Thu, 07 Jun 2001 17:12:31 +0200
From: Friedrich Lobenstock <fl@fl.priv.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac9 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ftape and kernel 2.4 problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As the linux-ftape mailing list is gone I'm asking you guys.

Can someone tell me how to adapt the ftape driver that I can use it
under kernel 2.4.x (x >= 5)? I'm not that into kernel hacking that
I know what changed from 2.2.x to 2.4.x. Below is the output of make.

BTW why wasn't the newer ftape driver ported to 2.4 but the stone age
ftape driver is still in 2.4?

PS: Please CC me because I'm not on linux-kernel.


friedl:/usr/src/ftape-4.04a # make
for i in ftape ; do make -C $i all ; done
make[1]: Entering directory `/mount/2/src/ftape-4.04a/ftape'
> ../include/linux/modftversions.h
for i in  lowlevel internal parport zftape compressor; \
do \
  make -C $i NODEP=true versions; \
done
make[2]: Entering directory `/mount/2/src/ftape-4.04a/ftape/lowlevel'
rm -f ../../include/linux/modules/ftape_syms.ver.tmp; gcc -D__KERNEL__ -I. -I../../include -I/usr/src/linux/include  -E -D__GENKSYMS__ ftape_syms.c | /sbin/genksyms ../../include/linux/modules 2> /dev/null; rm -f ../../include/linux/modules/ftape_syms.ver.tmp
make[2]: Leaving directory `/mount/2/src/ftape-4.04a/ftape/lowlevel'
make[2]: Entering directory `/mount/2/src/ftape-4.04a/ftape/internal'
make[2]: Nothing to be done for `versions'.
make[2]: Leaving directory `/mount/2/src/ftape-4.04a/ftape/internal'
make[2]: Entering directory `/mount/2/src/ftape-4.04a/ftape/parport'
make[2]: Nothing to be done for `versions'.
make[2]: Leaving directory `/mount/2/src/ftape-4.04a/ftape/parport'
make[2]: Entering directory `/mount/2/src/ftape-4.04a/ftape/zftape'
rm -f ../../include/linux/modules/zftape_syms.ver.tmp; gcc -D__KERNEL__ -I. -I../../include -I/usr/src/linux/include  -E -D__GENKSYMS__ zftape_syms.c | /sbin/genksyms ../../include/linux/modules 2> /dev/null; rm -f ../../include/linux/modules/zftape_syms.ver.tmp
updating ../../include/linux/modftversions.h
make[2]: Leaving directory `/mount/2/src/ftape-4.04a/ftape/zftape'
make[2]: Entering directory `/mount/2/src/ftape-4.04a/ftape/compressor'
make[2]: Nothing to be done for `versions'.
make[2]: Leaving directory `/mount/2/src/ftape-4.04a/ftape/compressor'
set -e; for i in  lowlevel internal parport zftape compressor; do make -C $i modules; done
make[2]: Entering directory `/mount/2/src/ftape-4.04a/ftape/lowlevel'
make[2]: Leaving directory `/mount/2/src/ftape-4.04a/ftape/lowlevel'
make[2]: Entering directory `/mount/2/src/ftape-4.04a/ftape/lowlevel'
gcc -Wall -Wstrict-prototypes -O2  -fomit-frame-pointer -fno-strength-reduce -D__KERNEL__ -I. -I../../include -I/usr/src/linux/include -DMODULE -DMODVERSIONS -include ../../include/linux/modftversions.h  -DEXPORT_SYMTAB -c ftape_syms.c
In file included from /usr/src/linux/include/linux/fs.h:12,
                 from /usr/src/linux/include/linux/capability.h:17,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from ../../include/linux/ftape.h:35,
                 from ftape_syms.c:32:
/usr/src/linux/include/linux/wait.h: In function `__add_wait_queue_tail':
/usr/src/linux/include/linux/wait.h:220: warning: implicit declaration of function `list_add_tail'
In file included from ftape-tracing.h:35,
                 from ftape_syms.c:33:
../lowlevel/ftape-init.h: In function `ft_sigtest':
../lowlevel/ftape-init.h:70: structure has no member named `signal'
../lowlevel/ftape-init.h:71: warning: control reaches end of non-void function
make[2]: *** [ftape_syms.o] Error 1
make[2]: Leaving directory `/mount/2/src/ftape-4.04a/ftape/lowlevel'
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/mount/2/src/ftape-4.04a/ftape'
make: *** [all] Error 2
friedl:/usr/src/ftape-4.04a #

-- 
MfG / Regards
Friedrich Lobenstock
