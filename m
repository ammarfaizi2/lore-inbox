Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbSKTXUR>; Wed, 20 Nov 2002 18:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSKTXUQ>; Wed, 20 Nov 2002 18:20:16 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:42378 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S263366AbSKTXUP>;
	Wed, 20 Nov 2002 18:20:15 -0500
Date: Wed, 20 Nov 2002 23:28:29 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021120232829.GD11879@bjl1.asuk.net>
References: <20021120220426.GB11879@bjl1.asuk.net> <Pine.LNX.4.44.0211201406110.1989-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211201406110.1989-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> > > And the lower size of the structure will help to reduce the amount of
> > > memory transfered to userspace. I just saw that adding the extra "obj"
> > > member lowered performance of about 15% with crazy tests like Ben's
> > > pipetest. This because it creates, on my machine, more than 400000 events
> > > per second, and saving memory bandwidth on such conditions is a must. With
> > > the "more human" http test performance are about the same.
> >
> > I'd be quite surprised if 400,000 word/sec of memory bandwidth can
> > explain a 15% time difference, especially considering all the other
> > things that are done to communicate over a pipe (wakeups etc).
> 
> Jamie, they were 16 bytes * 400000, and the token passed through the pipe
> was 12 bytes.

However, it's 4 bytes (1 word) * 400000 _difference_ between the two
tests, yes?

-- Jamie

