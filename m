Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbSK1Bdh>; Wed, 27 Nov 2002 20:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbSK1Bdh>; Wed, 27 Nov 2002 20:33:37 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38644 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265051AbSK1Bdg>; Wed, 27 Nov 2002 20:33:36 -0500
Date: Thu, 28 Nov 2002 02:40:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.49-ac2
Message-ID: <20021128014038.GV21307@fs.tum.de>
References: <200211262321.gAQNLPR12191@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211262321.gAQNLPR12191@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

I'm getting the following compile error in 2.5.49-ac{1,2} but not in
2.5.49 (I haven't tried older -ac kernels):

<--  snip  -->

...
  gcc -Wp,-MD,arch/i386/math-emu/.reg_ld_str.o.d -D__KERNEL__ -Iinclude
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6 -p -Iarch/i386/mach-generic
-Iarch/i386/mach-defaults -DPARANOID  -fno-builtin  -nostdinc -iwithprefix include
-DKBUILD_BASENAME=reg_ld_str -DKBUILD_MODNAME=reg_ld_str   -c -o
arch/i386/math-emu/reg_ld_str.o arch/i386/math-emu/reg_ld_str.c
cpp0: output pipe has been closed
gcc: Internal compiler error: program cc1 got fatal signal 11
make[1]: *** [arch/i386/math-emu/reg_ld_str.o] Error 1
make: *** [arch/i386/math-emu] Error 2
{standard input}: Assembler messages:
{standard input}:2235: Warning: end of file not at end of a line; newline inserted
{standard input}:2438: Error: suffix or operands invalid for `mov'

<--  snip  -->

This is with a 2.95 gcc (the one in Debian unstable). Compiling with
3.2.1 or setting the optimization to -O1 fixes the problem so it might
be an optimizer bug.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

