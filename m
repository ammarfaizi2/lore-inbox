Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263489AbTDMMqE (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 08:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263492AbTDMMqE (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 08:46:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33744 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263489AbTDMMqC (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 08:46:02 -0400
Date: Sun, 13 Apr 2003 14:57:44 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@digeo.com>, bcollins@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.67-mm2: ieee1394/nodemgr.c doesn't compile
Message-ID: <20030413125744.GN9640@fs.tum.de>
References: <20030412180852.77b6c5e8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030412180852.77b6c5e8.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 06:08:52PM -0700, Andrew Morton wrote:
>...
> Changes since 2.5.67-mm1:
> 
> 
>  linus.patch
> 
>  Latest -bk
>...

The following compile error #ifdef CONFIG_IEEE1394_VERBOSEDEBUG seems to 
come from Linus' tree:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/ieee1394/.nodemgr.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=nodemgr -DKBUILD_MODNAME=ieee1394 -c -o 
drivers/ieee1394/nodemgr.o drivers/ieee1394/nodemgr.c
drivers/ieee1394/nodemgr.c: In function `dump_directories':
drivers/ieee1394/nodemgr.c:1021: structure has no member named `unit_directories'
drivers/ieee1394/nodemgr.c:1021: warning: left-hand operand of comma expression has no effect
drivers/ieee1394/nodemgr.c:1021: structure has no member named `unit_directories'
drivers/ieee1394/nodemgr.c:1022: structure has no member named `node_list'
drivers/ieee1394/nodemgr.c:1022: warning: type defaults to `int' in declaration of `__mptr'
drivers/ieee1394/nodemgr.c:1022: warning: initialization from incompatible pointer type
drivers/ieee1394/nodemgr.c:1022: structure has no member named `node_list'
make[2]: *** [drivers/ieee1394/nodemgr.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

