Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319069AbSIJHqb>; Tue, 10 Sep 2002 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319070AbSIJHqb>; Tue, 10 Sep 2002 03:46:31 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15813 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319069AbSIJHqa>; Tue, 10 Sep 2002 03:46:30 -0400
Date: Tue, 10 Sep 2002 09:51:13 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ingo Molnar <mingo@elte.hu>, <jffs-dev@axis.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.34
In-Reply-To: <Pine.LNX.4.33.0209091049180.11925-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0209100947310.11139-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Linus Torvalds wrote:

>...
> Ingo Molnar <mingo@elte.hu>:
>...
>   o shared thread signals
>...

FYI:

This change broke the compilation of JFFS:

<--  snip  -->

...
  gcc -Wp,-MD,./.intrep.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5
.34-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include    -DKBUILD_BASENAME=intrep   -c -o
intrep.o intrep.c
intrep.c: In function `jffs_garbage_collect_thread':
intrep.c:3382: warning: passing arg 1 of `dequeue_signal' from
incompatible pointer type
intrep.c:3382: warning: passing arg 2 of `dequeue_signal' from
incompatible pointer type
intrep.c:3382: too few arguments to function `dequeue_signal'
make[2]: *** [intrep.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.34-full/fs/jffs'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

