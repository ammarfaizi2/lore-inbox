Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSKTWCL>; Wed, 20 Nov 2002 17:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSKTWBM>; Wed, 20 Nov 2002 17:01:12 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:10116 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S262859AbSKTWBE>; Wed, 20 Nov 2002 17:01:04 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 20 Nov 2002 14:08:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <20021120220426.GB11879@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0211201406110.1989-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, Jamie Lokier wrote:

> Davide Libenzi wrote:
> > And the lower size of the structure will help to reduce the amount of
> > memory transfered to userspace. I just saw that adding the extra "obj"
> > member lowered performance of about 15% with crazy tests like Ben's
> > pipetest. This because it creates, on my machine, more than 400000 events
> > per second, and saving memory bandwidth on such conditions is a must. With
> > the "more human" http test performance are about the same.
>
> I'd be quite surprised if 400,000 word/sec of memory bandwidth can
> explain a 15% time difference, especially considering all the other
> things that are done to communicate over a pipe (wakeups etc).

Jamie, they were 16 bytes * 400000, and the token passed through the pipe
was 12 bytes.



- Davide


