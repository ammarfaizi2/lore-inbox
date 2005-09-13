Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVIMUha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVIMUha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 16:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVIMUha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 16:37:30 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:30021 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932494AbVIMUh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 16:37:29 -0400
Date: Tue, 13 Sep 2005 22:39:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Grant Grundler <grundler@parisc-linux.org>
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050913203949.GB20422@mars.ravnborg.org>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru> <20050913185759.GA17272@mars.ravnborg.org> <20050913203720.GA12868@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913203720.GA12868@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey.

 
> > > parisc:
> > > 
> > > 2.6.13-git11
> 
> > >   CC      arch/parisc/kernel/asm-offsets.s
> > > In file included from include/asm/spinlock.h:4,
> > >                  from include/asm/bitops.h:5,
> > >                  from include/linux/bitops.h:77,
> > >                  from include/linux/thread_info.h:20,
> > >                  from include/linux/spinlock.h:53,
> > >                  from include/linux/capability.h:45,
> > >                  from include/linux/sched.h:7,
> > >                  from arch/parisc/kernel/asm-offsets.c:31:
> > > include/asm/system.h:174: error: parse error before "pa_tlb_lock"
> 
> > > In file included from include/linux/spinlock_types.h:13,
> > >                  from include/linux/spinlock.h:80,
> > >                  from include/linux/capability.h:45,
> > >                  from include/linux/sched.h:7,
> > >                  from include/linux/mm.h:4,
> > >                  from arch/sh/kernel/asm-offsets.c:13:
> > > include/asm/spinlock_types.h:16: error: parse error before "atomic_t"
> 

...
> 
> fb1c8f93d869b34cacb8b8932e2b83d96a19d720 is first bad commit
> diff-tree fb1c8f93d869b34cacb8b8932e2b83d96a19d720 (from 4327edf6b8a7ac7dce144313947995538842d8fd)
> Author: Ingo Molnar <mingo@elte.hu>
> Date:   Sat Sep 10 00:25:56 2005 -0700
> 
>     [PATCH] spinlock consolidation
>     
>     This patch (written by me and also containing many suggestions of Arjan van
>     de Ven) does a major cleanup of the spinlock code.  It does the following
>     things:
> 
> 	[snip]
> 
>     arm, i386, ia64, ppc, ppc64, s390/s390x, x64 was build-tested via
>     crosscompilers.  m32r, mips, sh, sparc, have not been tested yet, but should
>     be mostly fine.
> 
> P. S.: git bisect absolutely rocks! 10 minutes.

I was chasing a bug in asm-offsets.h handling and looked at a far to old
tree (read: 24 hour old).
I leave this to Ingo and friends.

	Sam
