Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUIAIh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUIAIh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUIAIh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:37:56 -0400
Received: from witte.sonytel.be ([80.88.33.193]:9433 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264386AbUIAIh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:37:26 -0400
Date: Wed, 1 Sep 2004 10:36:14 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Dan Kegel <dank@kegel.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Getting kernel.org kernel to build for m68k?
In-Reply-To: <41355F88.2080801@kegel.com>
Message-ID: <Pine.GSO.4.58.0409011029390.15681@waterleaf.sonytel.be>
References: <41355F88.2080801@kegel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004, Dan Kegel wrote:
> I noticed today that Linus's m68k kernel can't be built (at least with gcc-3.4.1).
>
> The first problem I ran into,
>    CC      arch/m68k/kernel/asm-offsets.s
>    In file included from include/linux/spinlock.h:12,
>                   from include/linux/capability.h:45,
>                   from include/linux/sched.h:7,
>                   from arch/m68k/kernel/asm-offsets.c:12:
>    include/linux/thread_info.h:30: error: parse error before '{' token
> is solved already in the m68k tree.
> (In particular,
> the #ifndef __HAVE_THREAD_FUNCTIONS ... #endif in
> http://linux-m68k-cvs.apia.dhs.org/c/cvsweb/linux/include/linux/thread_info.h?rev=1.5;content-type=text%2Fplain
> probably solves it.)
> There are other problems after that.

Roman Zippel changed the threading stuff on m68k. Since it would affect other
architectures, I never submitted it on my own.

In short, we never really compile this code, since the m68k tree doesn't use it
anymore. And yes, it even fails with older compiler versions, like 2.95.2.

> Any chance you could spend a bit of time sending Linus enough
> patches for his kernel to build for m68k, if not run?

I'll make sure a plain kernel.org kernel can build an m68k kernel.

> It would be helpful to my crosstool project (I'm adding a
> "can this toolchain build the kernel" test, and it's a lot
> easier if I can count on the kernel.org tree at least building).

Great!

Let's hope people start doing the other way around as well, so I don't have to
run allyesconfigs to catch bugs in non-m68k drivers ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
