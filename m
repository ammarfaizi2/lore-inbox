Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267513AbTALHPZ>; Sun, 12 Jan 2003 02:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbTALHPZ>; Sun, 12 Jan 2003 02:15:25 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62667 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267513AbTALHPY>; Sun, 12 Jan 2003 02:15:24 -0500
Date: Sun, 12 Jan 2003 08:24:09 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Tony <kernel@mail.vroon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (revised) fix net/irda warnings for 2.4.21-pre3
Message-ID: <20030112072409.GL21826@fs.tum.de>
References: <20030111120432.GA28023@sawmill> <20030112024225.GA28485@sawmill>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030112024225.GA28485@sawmill>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 03:42:25AM +0100, Tony wrote:

> Adrian,
> 
> You're right, I seem to have missed quite a lot, I have double-checked 
> things and updated the patch-file on the website.
>...
> Tony
> 
> P.S. This one doesn't give any warnings in a compile test.

Really???

2.95 still gives me several valid warnings like e.g.:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/include -Wall -Ws
trict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=ircomm_tty_attach  -c -o ircomm_tty_attach.o ircomm_tty_attach.c
ircomm_tty_attach.c: In function `ircomm_tty_disconnect_indication':
ircomm_tty_attach.c:360: warning: too few arguments for format
...

<--  snip  -->

In this case the bug in your patch is pretty obvious:

-       IRDA_DEBUG(2, __FUNCTION__ "()\n");
+       IRDA_DEBUG(2, "%s()\n");


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

