Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbUKUUwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUKUUwW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 15:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUKUUwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 15:52:21 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:10986 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261809AbUKUUwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 15:52:04 -0500
Date: Sun, 21 Nov 2004 21:51:54 +0100
Message-Id: <200411212051.iALKpsu03417@inv.it.uc3m.es>
From: ptb@lab.it.uc3m.es (Peter T. Breuer)
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: can kfree sleep?
In-Reply-To: <41A0E4E9.3040902@colorfullife.com>
X-Newsgroups: gmane.linux.kernel
User-Agent: tin/1.7.4-20031226 ("Taransay") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <41A0E4E9.3040902@colorfullife.com> you wrote:
> Hi Peter,

Hi!

> >Just a question: can kfree sleep?
> >
> No, it never sleeps. It's safe to call kfree from arbitrary context. The 
> only exception is the NMI oopser and similar arch code.

OK - thanks. I'll take that as read and eliminate kfree from the list
of sleep "seeds" in my code analyser.

> >I believe so, but slab.c does not enlighten me immediately:
> >
> Yes, the kfree code is quite long - it must check if freeing one object 
> created a freeable page and return it to the page allocator. Together 
> with lots of caching and debug checks.

May I ask where your knowledge of this comes from? (So I can duplicate
the learning process)!

Peter
