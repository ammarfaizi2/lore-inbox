Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283720AbRLRDRa>; Mon, 17 Dec 2001 22:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283723AbRLRDRV>; Mon, 17 Dec 2001 22:17:21 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:27920 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S283720AbRLRDRM>; Mon, 17 Dec 2001 22:17:12 -0500
Date: Mon, 17 Dec 2001 19:19:54 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.40.0112171849490.1577-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.40.0112171913450.1577-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Davide Libenzi wrote:

> What i was thinking was something like, in timer.c :
>
>         if (p->counter > decay_ticks)
>             --p->counter;
>         else if (++p->timer_ticks >= MAX_RUN_TIME) {
>             p->counter -= p->timer_ticks;
>             p->timer_ticks = 0;
>             p->need_resched = 1;
>         }

Obviously that code doesn't work :) but the idea is to not permit the task
to run more than a maximum time consecutively.



- Davide


