Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263338AbTC0RlR>; Thu, 27 Mar 2003 12:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263339AbTC0RlQ>; Thu, 27 Mar 2003 12:41:16 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:47253 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263338AbTC0RlN>; Thu, 27 Mar 2003 12:41:13 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 27 Mar 2003 10:03:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch][bugfix] epoll cross-thread deletion fix ...
In-Reply-To: <200303271819.58713.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.50.0303271002270.2009-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303261210470.2114-100000@blue1.dev.mcafeelabs.com>
 <200303271819.58713.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Mar 2003, Marc-Christian Petersen wrote:

> On Wednesday 26 March 2003 21:20, Davide Libenzi wrote:
>
> Hi Davide,
>
> > This fixes a bug that might happen having a thread doing epoll_wait() with
> > another thread doing epoll_ctl(EPOLL_CTL_DEL) and close(). The fast check
> > inside eventpoll_release() is good to not effect performace of code not
> > using epoll, but it requires get_file() to be called ( that can be avoided
> > by dropping the fast check ). I opted to keep the fast check and to have
> > epoll to call get_file() before the event send loop. I tested it on UP and
> > 2SMP with a bug-exploiting program provided by @pivia.com ( thx to them )
> > and it looks fine. I also update the 2.4.20 epoll patch with this fix :
> >
> > http://www.xmailserver.org/linux-patches/epoll-lt-2.4.20-0.5.diff
> so this is v0.63?

Ok, I messed up with namings :) Yes, it'll be 0.63 ...



- Davide

