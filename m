Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSG1VQ2>; Sun, 28 Jul 2002 17:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSG1VQ2>; Sun, 28 Jul 2002 17:16:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15232 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317399AbSG1VQ1>;
	Sun, 28 Jul 2002 17:16:27 -0400
Date: Sun, 28 Jul 2002 23:18:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: inlines in kernel/sched.c
In-Reply-To: <Pine.LNX.4.44.0207282309430.5116-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207282317320.5236-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Jul 2002, Ingo Molnar wrote:

> > Ingo, could you please review the use of inlines in the
> > scheduler sometime?  They seem to be excessive.
> > 
> > For example, this patch reduces the sched.d icache footprint
> > by 1.5 kilobytes.
> 
> the patch also hurts context-switch latencies - it went
> from 1.35 usecs to 1.42 usecs - a 5% drop.

i'll do something else - create non-inlined wrappers so that the slowpath
can use those, and let the fastpath inline them. We'll see what kind of
code footprint that has.

	Ingo

