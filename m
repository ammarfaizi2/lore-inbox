Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261539AbSJUQzP>; Mon, 21 Oct 2002 12:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJUQzP>; Mon, 21 Oct 2002 12:55:15 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:28811 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261539AbSJUQzP>; Mon, 21 Oct 2002 12:55:15 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 21 Oct 2002 10:10:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: re: [patch] sys_epoll ...
In-Reply-To: <3DB3A732.2080405@kegel.com>
Message-ID: <Pine.LNX.4.44.0210211008160.1641-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Dan Kegel wrote:

> Davide wrote:
>  >asmlinkage int sys_epoll_create(int maxfds);
>  >asmlinkage int sys_epoll_ctl(int epfd, int op, int fd, unsigned int events);
>  >asmlinkage int sys_epoll_wait(int epfd, struct pollfd **events, int timeout);
>
> Hey Davide,
> I've always been a bit bothered by the need to specify maxfds in
> advance.  What's the preferred way to handle the situation
> where you guess wrong on the value of maxfds?  Create a new
> epoll and register all the old fds with it?  (Sounds like
> a good job for a userspace wrapper library.)

I'm currently looking at doing it automatically, w/out the need of
specifying it. I don't like it either ...


> Regardless, thanks for pushing /dev/epoll along towards inclusion
> in 2.5.  I'm looking forward to seeing it it integrated.
> Even if the interface doesn't please everyone, the performance
> should...

You should thank Hanna Linder that bugged Linus way more than I did :)



- Davide


