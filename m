Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbSKSBml>; Mon, 18 Nov 2002 20:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265143AbSKSBml>; Mon, 18 Nov 2002 20:42:41 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:53644 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265135AbSKSBmk>; Mon, 18 Nov 2002 20:42:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 17:50:06 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021119013400.GC4377@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211181744560.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Jamie Lokier wrote:

> > Anything that "exposes" a file* interface that support f_op->poll() is
> > usable with epoll. File rocks !! :)
>
> I agree, fds are pretty good, and it's nice that they work equally
> well with poll/select/sigio as with epoll.
>
> It's just that to write an ideal, general event loop, pollable fds
> need to be created on the fly for futexes, signals, timers and aio
> requests at least.  Currently this is already done for futexes.  In
> addition, some kinds of event result need to return a few words of
> data with each event (for example, SIGCHLD events).
>
> Perhaps it's not a bad idea, but I do wonder whether fds created on
> the fly for every requested event, and events than can only report
> "readable" not anything richer than that are a good solution.

IMHO it is very elegant to have these objects to be a file* internally.
Common event retrival and automatic cleanup are just the first two points
that come in my mind.



- Davide


