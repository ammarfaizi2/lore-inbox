Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265712AbSKATKi>; Fri, 1 Nov 2002 14:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265715AbSKATKi>; Fri, 1 Nov 2002 14:10:38 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:10166 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265712AbSKATKg>;
	Fri, 1 Nov 2002 14:10:36 -0500
Date: Fri, 1 Nov 2002 19:16:43 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Dan Kegel <dank@kegel.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021101191643.GA1471@bjl1.asuk.net>
References: <Pine.LNX.4.44.0210311043380.1562-100000@blue1.dev.mcafeelabs.com> <3DC2BCF5.5010607@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC2BCF5.5010607@kegel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
> Davide Libenzi wrote:
> >>Do you avoid the cost of epoll_ctl() per new fd?
> >
> >Jamie, the cost of epoll_ctl(2) is minimal/zero compared with the average
> >life of a connection.
> 
> Depends on the workload.  Where I work, the http client I'm writing
> has to perform extremely well even on 1 byte files with HTTP 1.0.
> Minimizing system calls is suprisingly important - even
> a gettimeofday hurts.

For this sort of thing, I would like to see an option to automatically
set the non-blocking flag on accept().  To really squeeze the system
calls, you could also automatically epoll-register on accept(), and
for super bonus automatically do the accept() at event delivery time.

But it's getting very silly at that point.

-- Jamie

