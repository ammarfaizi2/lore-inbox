Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314378AbSEBMV7>; Thu, 2 May 2002 08:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314379AbSEBMV6>; Thu, 2 May 2002 08:21:58 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:57362 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314378AbSEBMV6>;
	Thu, 2 May 2002 08:21:58 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Thu, 02 May 2002 12:38:10 +0200."
             <20020502103810.GA7937@louise.pinerecords.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 May 2002 22:21:46 +1000
Message-ID: <28926.1020342106@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 May 2002 12:38:10 +0200, 
tomas szepe <kala@pinerecords.com> wrote:
>Yeah, I have to say, kbuild 2.5 is definitely a nice thing..
>Looking fw to seeing it included in mainline.
>
>Btw, Keith, how's the bug (if it is a bug at all) w/ CONFIG_MODVERSIONS?
>Whenever I built a kernel with it set using kbuild 2.5 everything went fine
>up to the moment I tried to load a module into the new kernel -- not one would
>actually work, complaining about unresolved symbols (at the same time, though,
>depmod -ae had nothing to report). Since I couldn't find any info on this
>I concluded it might be that CONFIG_MODVERSIONS was considered obsolete and
>as such would no longer be supported?

kbuild 2.5 deliberately does not support modversions, you can turn it
on but it does nothing.  The original implementation of modversions
does not fit with the way that people build kernels now (apply patches,
change configs, rebuild without make mrproper).  To do modversions
right needs a new version of modutils as well, there is no chance of
that work being started until kbuild 2.5 is in the kernel.

>Another question I'd like to ask (soooorry :D) -- would there be a little
>cunning target in Makefile-2.5 that'd create the asm-$arch symlink for me
>in include/ like kbuild 2.4 does? Whenever I run "make -f Makefile-2.5 clean"
>followed by "make -f Makefile-2.5 menuconfig" I get some serious whipping
>from kbuild 2.5, cos the asm-$arch symlink gets deleted in the cleaning,
>and I have to resurrect it by hand.

It works for me.  menuconfig does not use include/asm-$ARCH.

make -f Makefile-2.5 clean
make -f Makefile-2.5 menuconfig
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/checklist.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/checklist.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/menubox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/menubox.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/textbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/textbox.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/yesno.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/yesno.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/inputbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/inputbox.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/util.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/util.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog.c
gcc -Wall -Wstrict-prototypes -g  -DLOCALE  -I/usr/include/ncurses -DCURSES_LOC="<ncurses.h>" -c -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/msgbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/msgbox.c
gcc -o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/checklist.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/menubox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/textbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/yesno.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/inputbox.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/util.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/lxdialog.o /build/kaos/2.5.12-kbuild-2.5/scripts/lxdialog/msgbox.o -lncurses
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E' AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
Using defaults found in .config
Preparing scripts: functions, parsing......................................................................................done.

Saving your kernel configuration...

