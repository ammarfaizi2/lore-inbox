Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSJ2LVQ>; Tue, 29 Oct 2002 06:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSJ2LVQ>; Tue, 29 Oct 2002 06:21:16 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:7593 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261686AbSJ2LVP>;
	Tue, 29 Oct 2002 06:21:15 -0500
Date: Tue, 29 Oct 2002 11:20:46 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] epoll more scalable than poll
Message-ID: <20021029112045.GA19970@bjl1.asuk.net>
References: <20021029015139.GB18727@bjl1.asuk.net> <Pine.LNX.4.44.0210282042170.1002-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210282042170.1002-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> IMHO sys_epoll is going to be a replacement for rt-signals, because it
> scales better, it collapses events and does not have the overflowing queue
> problem.

Scalability is also solved by the signal-per-fd patch, as you know.
The main advantage of epoll is that it's lighter weight than rt-signals.

(IMHO signal-per-fd really ought to be included in 2.6 _anyway_, regardless
of any better mechanism for reading events.)

> The sys_epoll interface was coded to use the existing infrastructure w/out
> adding any legacy code added to suite the implementation. Basically,
> besides the few lines added to fs/pipe.c to support pipes ( rt-signal did
> not support them ), the hook lays inside sk_wake_async().

I agree that was the way to do it for 2.4 and earlier - you have to
work with a range of kernels, and minimum impact.

But now in 2.5 it's appropriate to implement whatever's _right_.

Time for me to take the big plunge and try a 2.5 kernel on my IDE
laptop, I guess :-)

-- Jamie

