Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSJ1WBl>; Mon, 28 Oct 2002 17:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbSJ1WBl>; Mon, 28 Oct 2002 17:01:41 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:28052 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261571AbSJ1WBk>; Mon, 28 Oct 2002 17:01:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 14:17:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Waitz <tali@admingilde.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] epoll more scalable than poll
In-Reply-To: <20021028205647.GC1402@admingilde.org>
Message-ID: <Pine.LNX.4.44.0210281409060.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Martin Waitz wrote:

> hi :)
>
> On Mon, Oct 28, 2002 at 11:14:19AM -0800, Hanna Linder wrote:
> > 	The results of our testing show not only does the system call
> > interface to epoll perform as well as the /dev interface but also that epoll
> > is many times better than standard poll. No other implementations of poll
> > have performed as well as epoll in any measure. Testing details and results
> > are published here, please take a minute to check it out: http://lse.sourceforge.net/epoll/index.html
> how does this compare to the kqueue mechanism found in {Free,Net}BSD?
> (see http://people.freebsd.org/~jlemon/papers/kqueue.pdf)
>
> i especially like their combined event update/event wait,
> needing only one syscall per poll while building a changelist in
> userspace...
>
> a replacement for poll/select is _really_ needed.
> but i think we should use existing interfaces if possible,
> to reduce the changes needed in userspace.

KQueue has not been tested simply because it does not ( to my knowledge )
have patches to apply to lk. I'd expect kqueue to scale in a similar way
of sys_epoll though. Where for "similar" I mean to not suffer high
connection load drops. About the interface, it looks pretty simple to me :

http://www.xmailserver.org/linux-patches/epoll_create.txt
http://www.xmailserver.org/linux-patches/epoll_ctl.txt
http://www.xmailserver.org/linux-patches/epoll_wait.txt




- Davide


