Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbSBRVYW>; Mon, 18 Feb 2002 16:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSBRVYM>; Mon, 18 Feb 2002 16:24:12 -0500
Received: from adsl-63-200-86-10.dsl.scrm01.pacbell.net ([63.200.86.10]:19664
	"EHLO frx774.dhs.org") by vger.kernel.org with ESMTP
	id <S287631AbSBRVX7>; Mon, 18 Feb 2002 16:23:59 -0500
From: Jesse Wyant <jrwyant@frx774.dhs.org>
Message-Id: <200202182123.g1ILNGS27486@frx774.dhs.org>
Subject: Re: 2.5.4 make errorf
To: lee@imyourhandiman.com (lee johnson)
Date: Mon, 18 Feb 2002 13:23:16 -0800 (PST)
Cc: linux-kernel@vger.kernel.org (kernel-list)
In-Reply-To: <1013744965.21906.8.camel@imyourhandiman> from "lee johnson" at Feb 14, 2002 07:49:24 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hi..
> 
>    anyone actually getting 2.5.4 to make without errors...mine starts
> and ends fairly abruptly..I thought it was a good idea due to hearing
> alsa  is in 2.5.5 patch.
> 
> thx
> lee
> -===   
> 
> 
> -------------------------------
> In file included from /usr/src/linux-2.5.4/include/asm/thread_info.h:13,
>                  from
> /usr/src/linux-2.5.4/include/linux/thread_info.h:10,
>                  from /usr/src/linux-2.5.4/include/linux/spinlock.h:7,
>                  from /usr/src/linux-2.5.4/include/linux/mmzone.h:8,
>                  from /usr/src/linux-2.5.4/include/linux/gfp.h:4,
>                  from /usr/src/linux-2.5.4/include/linux/slab.h:14,
>                  from /usr/src/linux-2.5.4/include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> /usr/src/linux-2.5.4/include/asm/processor.h: In function
> `thread_saved_pc':
> /usr/src/linux-2.5.4/include/asm/processor.h:444: dereferencing pointer
> to incomplete type
> /usr/src/linux-2.5.4/include/asm/processor.h:445: warning: control
> reaches end of non-void function
> make: *** [init/main.o] Error 1

I saw the same thing.  Poking around in 
http://www.kernel.org/pub/linux/kernel/v2.5/testing/patch-2.5.5.log,
I saw an entry where axboe@burns.home.kernel.dk fixed the
thread_saved_pc function, where this compilation problem was occuring.

I downloaded the 2.5.5-pre1 patch, applied it to 2.5.4, and compiled:
problem solved.  (Once other thing: ALSA didn't show up in my 'menuconfig'
display under Sound in 2.5.4, but it did in 2.5.5-pre1.)

-jesse


Jesse Wyant - jrwyant@frx774.dhs.org
------------------------------------------------------------
That that is is that that is not is not.

