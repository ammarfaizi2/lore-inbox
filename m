Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSJ3DeU>; Tue, 29 Oct 2002 22:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263571AbSJ3DeU>; Tue, 29 Oct 2002 22:34:20 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:27550 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263544AbSJ3DeT>; Tue, 29 Oct 2002 22:34:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 29 Oct 2002 19:50:12 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
In-Reply-To: <3DBF5372.901E3CB3@digeo.com>
Message-ID: <Pine.LNX.4.44.0210291946260.1457-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Oct 2002, Andrew Morton wrote:

> Davide Libenzi wrote:
> >
> > Thanks to Andrew and John suggestions I coded another version of the
> > sys_epoll patch ( 0.13 skipped ... superstition :) ). I won't send the
> > patch to not waste bandwidth, the patch is available here :
> >
> > http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-last.diff
> >
> > Comments are welcome ...
> >
>
> Looking good to me, Davide.  I think you've nailed everything there
> except:
>
> - Do we want to introduce new list macros, or change epoll a little
>   to use the existing list manipulators (I think the latter)

Andrew, sys_epoll uses linux/list.h interface. Doesn't it ?
And more, we can schedule the sys_close() review later if you want ...



> - Do we keep the vmalloc, replace it with alloc_pages() or go all the
>   way and remove the hash table?
>
>   Seems that you're leaning toward the final option but either way,
>   it would be best to get that vmalloc out of there - it's basically
>   hit-or-miss for anything larger than a single page - for a really
>   robust implementation it is best to avoid its use.

This will be the last patch that will use the hash. So vmalloc() will go
away. I'm still failing to find creep in my proposed plan to remove the
hash ...



- Davide


