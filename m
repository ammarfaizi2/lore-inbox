Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263324AbTC0RLX>; Thu, 27 Mar 2003 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263308AbTC0RKS>; Thu, 27 Mar 2003 12:10:18 -0500
Received: from [80.190.48.67] ([80.190.48.67]:50952 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id <S263317AbTC0RJ2> convert rfc822-to-8bit; Thu, 27 Mar 2003 12:09:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch][bugfix] epoll cross-thread deletion fix ...
Date: Thu, 27 Mar 2003 18:19:58 +0100
User-Agent: KMail/1.4.3
Cc: Davide Libenzi <davidel@xmailserver.org>
References: <Pine.LNX.4.50.0303261210470.2114-100000@blue1.dev.mcafeelabs.com>
In-Reply-To: <Pine.LNX.4.50.0303261210470.2114-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303271819.58713.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 March 2003 21:20, Davide Libenzi wrote:

Hi Davide,

> This fixes a bug that might happen having a thread doing epoll_wait() with
> another thread doing epoll_ctl(EPOLL_CTL_DEL) and close(). The fast check
> inside eventpoll_release() is good to not effect performace of code not
> using epoll, but it requires get_file() to be called ( that can be avoided
> by dropping the fast check ). I opted to keep the fast check and to have
> epoll to call get_file() before the event send loop. I tested it on UP and
> 2SMP with a bug-exploiting program provided by @pivia.com ( thx to them )
> and it looks fine. I also update the 2.4.20 epoll patch with this fix :
>
> http://www.xmailserver.org/linux-patches/epoll-lt-2.4.20-0.5.diff
so this is v0.63?

ciao, Marc
