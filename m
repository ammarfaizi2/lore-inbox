Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288749AbSADUbN>; Fri, 4 Jan 2002 15:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288747AbSADUbC>; Fri, 4 Jan 2002 15:31:02 -0500
Received: from mx2.elte.hu ([157.181.151.9]:16780 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284842AbSADUaw>;
	Fri, 4 Jan 2002 15:30:52 -0500
Date: Fri, 4 Jan 2002 23:28:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrey Nekrasov <andy@spylog.ru>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
In-Reply-To: <Pine.NEB.4.43.0201042111580.19208-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0201042324210.14208-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Adrian Bunk wrote:

> It seems the following part of your patch broke it (net/ipv4/ipconfig.c
> includes include/linux/sched.h; linux/tty.h includes linux/major.h that
> defines UNNAMED_MAJOR):
>
> --- linux/include/linux/sched.h.orig    Thu Jan  3 18:49:58 2002
> +++ linux/include/linux/sched.h Fri Jan  4 15:27:20 2002
> @@ -21,7 +21,6 @@
>  #include <asm/mmu.h>
>
>  #include <linux/smp.h>
> -#include <linux/tty.h>
>  #include <linux/sem.h>
>  #include <linux/signal.h>
>  #include <linux/securebits.h>

thanks for the detective work - i've reverted this part of the 2.4.17
patch and have uploaded the -A2 patch.

	Ingo

