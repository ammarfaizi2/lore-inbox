Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263893AbSIQIci>; Tue, 17 Sep 2002 04:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263895AbSIQIci>; Tue, 17 Sep 2002 04:32:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:15344 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S263893AbSIQIch>; Tue, 17 Sep 2002 04:32:37 -0400
Date: Tue, 17 Sep 2002 10:37:30 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.35 atm driver compile fix
In-Reply-To: <20020916212331.B70462@sfgoth.com>
Message-ID: <Pine.NEB.4.44.0209171033460.26796-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, Mitchell Blank Jr wrote:

> Adrian Bunk wrote:
> > This change results in a compile error in the ATM drivers:
>
> Yes, this was a bug in the ATM drivers... they really should have been using
> do_gettimeofday() instead of touching xtime anyway.
>
> Here's a patch that should fix up all these ATM compile errors.  Linus,
> please apply

Thanks for this patch, the next compile error is that compilation of
firestream.c fails at all occurences of func_enter:

<--  snip  -->

...
  gcc -Wp,-MD,./.firestream.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.35/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=firestream
-c -o firestream.o firestream.c
firestream.c: In function `fs_open':
firestream.c:870: called object is not a function
firestream.c:870: parse error before string constant
...
make[2]: *** [firestream.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.35/drivers/atm'

<--  snip  -->


> -Mitch  (deadbeat ATM maintainer)

I didn't Cc you because you are only listed as PPP OVER ATM (RFC 2364)
maintainer in MAINTAINERS. Do you now maintain the complete ATM subsystem?
If yes, could you send a patch for MAINTAINERS?

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


