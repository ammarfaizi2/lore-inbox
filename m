Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265286AbSJWWfn>; Wed, 23 Oct 2002 18:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265290AbSJWWfn>; Wed, 23 Oct 2002 18:35:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:59297 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265286AbSJWWfi>; Wed, 23 Oct 2002 18:35:38 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 15:50:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
In-Reply-To: <3DB722DC.3090306@netscape.com>
Message-ID: <Pine.LNX.4.44.0210231543290.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, John Gardiner Myers wrote:

> Again, it comes down to whether or not one has the luxury of being able
> to (re)write one's application and supporting libraries from scratch.
>  If one can ensure that the code for handling an event will never block
> for any significant amount of time, then single-threaded process-per-CPU
> will most likely perform best.  If, on the other hand, the code for
> handling an event can occasionally block, then one needs a thread pool
> in order to have reasonable latency.
>
> A thread pool based server that is released will trivially outperform a
> single threaded server that needs a few more years development to
> convert all the blocking calls to use the event subsystem.

I beg you pardon but where an application is possibly waiting for ?
Couldn't it be waiting to something somehow identifiable as a file ? So,
supposing that an interface like sys_epoll ( or AIO, or whatever )
delivers you events for all your file descriptors your application is
waiting for, why would you need threads ? In fact, I personally find that
coroutines make threaded->single-task transaction very easy. Your virtual
threads shares everything by default w/out having a single lock inside
your application.



- Davide



