Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265058AbSKSB0t>; Mon, 18 Nov 2002 20:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKSB0s>; Mon, 18 Nov 2002 20:26:48 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:56715 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265058AbSKSB0r>; Mon, 18 Nov 2002 20:26:47 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 17:34:13 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD98B79.20102@kegel.com>
Message-ID: <Pine.LNX.4.44.0211181733070.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dan Kegel wrote:

> Davide Libenzi wrote:
> >>I'd be happy to contribute better doc... has the man page
> >>for sys_epoll been written yet?
> >
> > http://www.xmailserver.org/linux-patches/epoll.2
> > http://www.xmailserver.org/linux-patches/epoll_create.2
> > http://www.xmailserver.org/linux-patches/epoll_ctl.2
> > http://www.xmailserver.org/linux-patches/epoll_wait.2
> >
> > it is going to change though with the latest talks about the interface.
>
> Hmm.  Right off the bat, I see a terminology problem.
> The man page says
>
> .SH NAME
> epoll \- edge triggered asynchronous I/O facility
>
> That's going to confuse some users.  They might think
> epoll can actually initiate I/O.  Better to say
>
> epoll \- edge triggered I/O readiness notification facility

Yes, maybe sounds better ...


> Second, epoll_ctl(2) doesn't define the meaning of the
> event mask.  It should give the allowed bits and define
> their meanings.  If we use the traditional POLLIN etc, we
> can say
>    POLLIN - the fd has become ready for reading
>    POLLOUT - the fd has become ready for writing
>    Note: If epoll tells you e.g. POLLIN, it means that
>             poll will tell you the same thing,
>             since poll gives the current status,
>             and epoll gives changes in status.

I will have to change man pages also to fit EPOLL* definitions.



- Davide


