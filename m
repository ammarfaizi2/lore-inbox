Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265490AbSKAA0g>; Thu, 31 Oct 2002 19:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265471AbSKAA0g>; Thu, 31 Oct 2002 19:26:36 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:11955 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265459AbSKAA0g>;
	Thu, 31 Oct 2002 19:26:36 -0500
Date: Fri, 1 Nov 2002 00:32:38 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, davidel@xmailserver.org,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       lse-tech@lists.sourceforge.net, torvalds@transmeta.com, akpm@digeo.com
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021101003238.GA30865@bjl1.asuk.net>
References: <20021031005259.GA25651@bjl1.asuk.net> <Pine.LNX.4.44.0210301924190.1452-100000@blue1.dev.mcafeelabs.com> <20021031154112.GB27801@bjl1.asuk.net> <1036082758.8575.81.camel@irongate.swansea.linux.org.uk> <20021101090034.42e207e5.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101090034.42e207e5.rusty@rustcorp.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> I think a naive implementation of futex_set_wait would look like:

Vaguely.  We are looking for something with the queue-like semantics
of epoll and rt-signals: persistent (as opposed to one-shot)
listening, ordered delivery of events, scalable listening to thousands
at once (without the poll/select O(n) problem).

> Not sure I get the point about livelock though: deadlock is possible if
> apps seek multiple locks at once without care, of course.

I'm not sure what Alan meant either.

-- Jamie
