Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVH0Rtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVH0Rtp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 13:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbVH0Rto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 13:49:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15625 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932222AbVH0Rto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 13:49:44 -0400
Date: Sat, 27 Aug 2005 19:49:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jerome Pinot <ngc891@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [KCONFIG] Can't compile 2.6.12 without Gettext
Message-ID: <20050827174934.GL6471@stusta.de>
References: <88ee31b705082421303697aef7@mail.gmail.com> <20050827124751.GK6471@stusta.de> <88ee31b7050827082345a393bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ee31b7050827082345a393bd@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 12:23:38AM +0900, Jerome Pinot wrote:
>...
> ---- snip ----
>...
> In file included from scripts/kconfig/conf.c:14:
> scripts/kconfig/lkc.h:11:21: libintl.h: No such file or directory
>...
> ---- snip ----
> 
> Actually, adding libintl.h in /usr/include didn't solve the issue in
> my case. My gettext implementation is not exactly complete. Anyway the
> script shouldn't failed at this step.
> 
> Segher Boessenkool, who had the same problem, sent me a way to compile
> the kernel by modifying a bit the lkc.h and mconf.c files. I suggested
> him to send this to lkml too.
> 
> The fix to do is really small but it needs to define a policy about
> how kconfig should decide about using gettext or not. It could use a
> configure script or a parameter from command line to choose whether or
> not to look for a gettext implementation (something like "make NLS=0
> menuconfig" maybe). This should be define prior to any patch attempt.
>...

You said "full gettext" was required and that the presence of "gettext 
binaries" should be checked what surprised me. It seems this is not the 
problem. Under Linux, libintl.h is not shipped with gettext but with the 
C library if you are using glibc or dietlibc.

I do not question your point that "uClibc is widely used", but it's 
widely used to _run_ a Linux kernel.

You said you are "thinking about small or embedded system with specific 
toolchain". If a system is so limited that you run uClibc on it, is this 
really the right system to _compile_ a kernel on? Where's the problem 
with cross-compiling the kernel for such a system?

> Regards,
> Jerome Pinot

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

