Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262132AbSJHL5P>; Tue, 8 Oct 2002 07:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbSJHL5P>; Tue, 8 Oct 2002 07:57:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50671 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262132AbSJHL5O>; Tue, 8 Oct 2002 07:57:14 -0400
Date: Tue, 8 Oct 2002 14:02:50 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Pavel Machek <pavel@ucw.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.41
In-Reply-To: <Pine.LNX.4.33.0210071157270.1917-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0210081359280.8340-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Linus Torvalds wrote:

>...
> Summary of changes from v2.5.40 to v2.5.41
> ============================================
>...
> Pavel Machek <pavel@ucw.cz>:
>   o Swsusp updates, do not thrash ide disk on suspend
>...

This change causes the following compile error with CONFIG_DISCONTIGMEM
enabled:

<--  snip  -->

...
  gcc -Wp,-MD,kernel/.suspend.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -Iarch/i386/mach-generic -nostdinc -iwithprefix include
-DKBUILD_BASENAME=suspend   -c -o kernel/suspend.o kernel/suspend.c
...
kernel/suspend.c: In function `count_and_copy_data_pages':
kernel/suspend.c:479: `max_mapnr' undeclared (first use in this function)
kernel/suspend.c:479: (Each undeclared identifier is reported only once
kernel/suspend.c:479: for each function it appears in.)
make[1]: *** [kernel/suspend.o] Error 1
make: *** [kernel] Error 2

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

