Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSKTXZV>; Wed, 20 Nov 2002 18:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbSKTXZV>; Wed, 20 Nov 2002 18:25:21 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:33924 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263276AbSKTXZT>; Wed, 20 Nov 2002 18:25:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 15:33:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021120232829.GD11879@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211201531010.974-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > > > And the lower size of the structure will help to reduce the amount of
> > > > memory transfered to userspace. I just saw that adding the extra "obj"
> > > > member lowered performance of about 15% with crazy tests like Ben's
> > > > pipetest. This because it creates, on my machine, more than 400000 events
> > > > per second, and saving memory bandwidth on such conditions is a must. With
> > > > the "more human" http test performance are about the same.
> > >
> > > I'd be quite surprised if 400,000 word/sec of memory bandwidth can
> > > explain a 15% time difference, especially considering all the other
> > > things that are done to communicate over a pipe (wakeups etc).
> >
> > Jamie, they were 16 bytes * 400000, and the token passed through the pipe
> > was 12 bytes.
>
> However, it's 4 bytes (1 word) * 400000 _difference_ between the two
> tests, yes?

Yep, the problem is that the "tool" used to measure ( Ben's pipetest ) on
my machine has a variance of about 35% and this makes every measure prety
fuzzy.



- Davide


