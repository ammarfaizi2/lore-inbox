Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSAFB5h>; Sat, 5 Jan 2002 20:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286866AbSAFB51>; Sat, 5 Jan 2002 20:57:27 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:38664 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286825AbSAFB5T>; Sat, 5 Jan 2002 20:57:19 -0500
Date: Sat, 5 Jan 2002 18:02:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201060427590.4730-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201051753090.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Ingo Molnar wrote:

> And George Anzinger has a nice idea to help those platforms which have
> slow bitsearch functions, we can keep a floating pointer of the highest
> priority queue which can be made NULL if the last task from a priority
> level was used up or can be increased if a higher priority task is added,
> this pointer will be correct in most of the time, and we can fall back to
> the bitsearch if it's NULL.

Ingo, you don't need that many queues, 32 are more than sufficent.
If you look at the distribution you'll see that it matters ( for
interactive feel ) only the very first ( top ) queues, while lower ones
can very easily tollerate a FIFO pickup w/out bad feelings.




- Davide




