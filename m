Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTBQDo2>; Sun, 16 Feb 2003 22:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTBQDo2>; Sun, 16 Feb 2003 22:44:28 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:35022 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S266368AbTBQDo0>;
	Sun, 16 Feb 2003 22:44:26 -0500
Date: Mon, 17 Feb 2003 09:24:21 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
In-Reply-To: <20030217034644.GA10083@nevyn.them.org>
Message-ID: <Pine.SOL.3.96.1030217092308.27688B-100000@osiris.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried compiling using the actual gcc, I got the following error.

gcc -Wp,-MD,init/.vermagic.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686
-Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc
-iwithprefix include    -DKBUILD_BASENAME=vermagic
-DKBUILD_MODNAME=vermagic -c -o init/.tmp_vermagic.o init/vermagic.c
In file included from include/linux/cache.h:4,
                 from include/asm/processor.h:18,
                 from include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:44,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from init/vermagic.c:2:
include/linux/kernel.h:10:20: stdarg.h: No such file or directory
In file included from include/linux/cache.h:4,
                 from include/asm/processor.h:18,
                 from include/asm/thread_info.h:13,
                 from include/linux/thread_info.h:21,
                 from include/linux/spinlock.h:12,
                 from include/linux/capability.h:44,
                 from include/linux/sched.h:7,
                 from include/linux/module.h:10,
                 from init/vermagic.c:2:
include/linux/kernel.h:73: parse error before "va_list"
include/linux/kernel.h:73: warning: function declaration isn't a prototype
include/linux/kernel.h:76: parse error before "va_list"
include/linux/kernel.h:76: warning: function declaration isn't a prototype
include/linux/kernel.h:80: parse error before "va_list"
include/linux/kernel.h:80: warning: function declaration isn't a prototype
make[1]: *** [init/vermagic.o] Error 1
make: *** [init/vermagic.o] Error 2


--
Rahul Vaidya
Hostel Room G46,
Ph.3942451

"Life can only be understood going backwards, 
	            but it must be lived going forwards"
						-Kierkegaard

On Sun, 16 Feb 2003, Daniel Jacobowitz wrote:

> On Mon, Feb 17, 2003 at 09:03:30AM +0530, Rahul Vaidya wrote:
> > The command ./gcc -v -iwithprefix include -E - < /dev/null
> > from the directory containing the actual gcc file.
> > 
> > Reading specs from ./../lib/gcc-lib/i686-pc-linux-gnu/3.2/specs
> > Configured with: ../gcc-3.2/configure --prefix=/usr/local/gcc-3.2
> 
> >  ../lib/gcc-lib/i686-pc-linux-gnu/3.2/include
> 
> And isn't that the right directory?  Try building a kernel this way.
> 
> -- 
> Daniel Jacobowitz
> MontaVista Software                         Debian GNU/Linux Developer
> 

