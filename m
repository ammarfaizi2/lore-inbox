Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSEBVfC>; Thu, 2 May 2002 17:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSEBVfB>; Thu, 2 May 2002 17:35:01 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:60429 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315438AbSEBVe7>; Thu, 2 May 2002 17:34:59 -0400
Date: Thu, 2 May 2002 23:34:44 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020502213443.GA10617@louise.pinerecords.com>
In-Reply-To: <20020502103810.GA7937@louise.pinerecords.com> <28926.1020342106@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 10 days, 16:19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Another question I'd like to ask (soooorry :D) -- would there be a little
> >cunning target in Makefile-2.5 that'd create the asm-$arch symlink for me
> >in include/ like kbuild 2.4 does? Whenever I run "make -f Makefile-2.5 clean"
> >followed by "make -f Makefile-2.5 menuconfig" I get some serious whipping
> >from kbuild 2.5, cos the asm-$arch symlink gets deleted in the cleaning,
> >and I have to resurrect it by hand.
>
> It works for me.  menuconfig does not use include/asm-$ARCH.
> 
> make -f Makefile-2.5 clean
> make -f Makefile-2.5 menuconfig
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/checklist.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/checklist.c
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/menubox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/menubox.c
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/textbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/textbox.c
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/yesno.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/yesno.c
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/inputbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/inputbox.c
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/util.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/util.c
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog.c
> gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/msgbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/msgbox.c
> gcc -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/checklist.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/menubox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/textbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/yesno.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/inputbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/util.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/msgbox.o -lncurses
> Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
> Generating global Makefile
>   phase 1 (find all inputs)
> Using defaults found in .config
> Preparing scripts: functions, parsing......................................................................................done.
> 
> Saving your kernel configuration...

Hmmm.

kala@nibbler:/usr/src$ rm -Rf linux-2.5.12
kala@nibbler:/usr/src$ tar xzf linux-2.5.12.tgz
kala@nibbler:/usr/src$ rm -f linux; ln -s linux-2.5.12 linux
kala@nibbler:/usr/src$ cd linux-2.5.12
kala@nibbler:/usr/src/linux-2.5.12$ zcat ../kbuild-2.5-core-9.gz ../kbuild-2.5-common-2.5.12-1.gz ../kbuild-2.5-i386-2.5.12-1.gz| patch -sp1
kala@nibbler:/usr/src/linux-2.5.12$ cp ../.config .
kala@nibbler:/usr/src/linux-2.5.12$ make oldconfig
...

kala@nibbler:/usr/src/linux-2.5.12$ make -f Makefile-2.5 oldconfig
...

kala@nibbler:/usr/src/linux-2.5.12$ make -f Makefile-2.5 installable
spec value %p not found
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
...

kala@nibbler:/usr/src/linux-2.5.12$ make -f Makefile-2.5 clean
spec value %p not found
kala@nibbler:/usr/src/linux-2.5.12$ make -f Makefile-2.5 menuconfig
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/checklist.o /usr/src/linux-2.5.12/scripts/lxdialog/checklist.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/menubox.o /usr/src/linux-2.5.12/scripts/lxdialog/menubox.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/textbox.o /usr/src/linux-2.5.12/scripts/lxdialog/textbox.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/yesno.o /usr/src/linux-2.5.12/scripts/lxdialog/yesno.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/inputbox.o /usr/src/linux-2.5.12/scripts/lxdialog/inputbox.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/util.o /usr/src/linux-2.5.12/scripts/lxdialog/util.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/lxdialog.o /usr/src/linux-2.5.12/scripts/lxdialog/lxdialog.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /usr/src/linux-2.5.12/scripts/lxdialog/msgbox.o /usr/src/linux-2.5.12/scripts/lxdialog/msgbox.c
gcc -o /usr/src/linux-2.5.12/scripts/lxdialog/lxdialog /usr/src/linux-2.5.12/scripts/lxdialog/checklist.o /usr/src/linux-2.5.12/scripts/lxdialog/menubox.o /usr/src/linux-2.5.12/scripts/lxdialog/textbox.o /usr/src/linux-2.5.12/scripts/lxdialog/yesno.o /usr/src/linux-2.5.12/scripts/lxdialog/inputbox.o /usr/src/linux-2.5.12/scripts/lxdialog/util.o /usr/src/linux-2.5.12/scripts/lxdialog/lxdialog.o /usr/src/linux-2.5.12/scripts/lxdialog/msgbox.o -lncurses
In file included from /usr/include/bits/errno.h:25,
                 from /usr/include/errno.h:36,
                 from /usr/src/linux-2.5.12/scripts/mdbm/common.h:19,
                 from /usr/src/linux-2.5.12/scripts/mdbm/debug.c:6:
/usr/include/linux/errno.h:4: asm/errno.h: No such file or directory
In file included from /usr/include/netinet/in.h:212,
                 from /usr/src/linux-2.5.12/scripts/mdbm/mdbm.h:185,
                 from /usr/src/linux-2.5.12/scripts/mdbm/common.h:24,
                 from /usr/src/linux-2.5.12/scripts/mdbm/debug.c:6:
/usr/include/bits/socket.h:305: asm/socket.h: No such file or directory
make: *** [/usr/src/linux-2.5.12/scripts/mdbm/debug.o] Error 1

'/usr/include/asm' points to '/usr/src/linux/include/asm', which doesn't
exist at this moment. It seems to me that kbuild 2.5 makes the assumption
that the 'asm' symlink in /usr/include already determines the machine
architecture type by pointing to a concrete asm-$arch
in /usr/src/linux/include.


Tomas

-- 
"hello it's not like i read my mail so that you have where to offer to sell me
a giant turnip or anything else thankyou." -tomas szepe <kala@pinerecords.com>          
