Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTBOI5n>; Sat, 15 Feb 2003 03:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbTBOI5n>; Sat, 15 Feb 2003 03:57:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8165 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S264699AbTBOI5m>; Sat, 15 Feb 2003 03:57:42 -0500
Date: Sat, 15 Feb 2003 10:07:33 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: jochen@scram.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.61: tms380tr.c no longer compiles
Message-ID: <20030215090733.GV20159@fs.tum.de>
References: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302141709410.1376-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 05:11:43PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.60 to v2.5.61
> ============================================
>...
> <jochen@scram.de>:
>...
>   o Update several token ring drivers
>...

This broke the compilation of tms380tr.c:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/net/tokenring/.tms380tr.o.d -D__KERNEL__ -Iinclude 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=tms380tr -DKBUILD_MODNAME=tms380tr -c -o 
drivers/net/tokenring/tms380tr.o drivers/net/tokenring/tms380tr.c
drivers/net/tokenring/tms380tr.c: In function `tms380tr_open':
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c:260: invalid type argument of `->'
drivers/net/tokenring/tms380tr.c: In function `tms380tr_init_adapter':
drivers/net/tokenring/tms380tr.c:1461: warning: long unsigned int 
format, different type arg 
make[3]: *** [drivers/net/tokenring/tms380tr.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

