Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265233AbSJRRsZ>; Fri, 18 Oct 2002 13:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265341AbSJRR1K>; Fri, 18 Oct 2002 13:27:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2523 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265278AbSJRQyt>; Fri, 18 Oct 2002 12:54:49 -0400
Date: Fri, 18 Oct 2002 19:00:44 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Linus Torvalds <torvalds@transmeta.com>, Ben Collins <bcollins@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.43
In-Reply-To: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210181856330.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.42 to v2.5.43
> ============================================
>...
> Ben Collins <bcollins@debian.org>:
>   o Linux IEEE-1394 Updates
>...

This patch added an argument "flags" to the prototypes of
sbp2_handle_physdma_write and sbp2_handle_physdma_read in
drivers/ieee1394/sbp2.h but doesn't include the corresponding changes to
drivers/ieee1394/sbp2.c resulting in the following compile error:

<--  snip  -->

...
  gcc -Wp,-MD,drivers/ieee1394/.sbp2.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -Iarch/i386/mach-generic
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=sbp2   -c -o
drivers/ieee1394/sbp2.o drivers/ieee1394/sbp2.c
drivers/ieee1394/sbp2.c:1516: conflicting types for `sbp2_handle_physdma_write'
drivers/ieee1394/sbp2.h:513: previous declaration of `sbp2_handle_physdma_write'
drivers/ieee1394/sbp2.c:1532: conflicting types for `sbp2_handle_physdma_read'
drivers/ieee1394/sbp2.h:515: previous declaration of `sbp2_handle_physdma_read'
make[2]: *** [drivers/ieee1394/sbp2.o] Error 1

<--  snip  -->

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed


