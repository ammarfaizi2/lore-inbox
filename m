Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267001AbSKRWtR>; Mon, 18 Nov 2002 17:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSKRWtR>; Mon, 18 Nov 2002 17:49:17 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:14723 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S267001AbSKRWtQ>;
	Mon, 18 Nov 2002 17:49:16 -0500
Date: Mon, 18 Nov 2002 22:56:25 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ulrich Drepper <drepper@redhat.com>, Mark Mielke <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021118225625.GB3939@bjl1.asuk.net>
References: <3DD946A2.7030501@redhat.com> <Pine.LNX.4.44.0211181324060.979-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211181324060.979-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Ok, the message has been post and noone argued about your solution. Like
> it is used to say "speak now or forever hold your piece" :) So we will go
> with it, no problem for me. We will define a struct epollfd and all POLL*
> bits in EPOLL*

1. Fwiw, I would really like to see epoll extended beyond fds, to a more
general edge-triggered event collector - signals, timers, aios.  I've
written about this before as you know (but been too busy lately to
pursue the idea).  I'm not going to say any more about this until I
have time to code something...

2. I don't like the "int64_t" proposal because there is no
   language guarantee that 64 bits is enough to hold a pointer - and
   of course, a pointer is what many applications will store in it.

   "long" seems to be the de facto standard for holding a pointer
   value in the kernel (e.g. in a futex).  That's ugly too, but quite
   consistent.  Nothing clean presents itself.

-- Jamie
