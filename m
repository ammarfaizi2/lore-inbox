Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284135AbRLROpr>; Tue, 18 Dec 2001 09:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284163AbRLROph>; Tue, 18 Dec 2001 09:45:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7825 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284135AbRLROp1>;
	Tue, 18 Dec 2001 09:45:27 -0500
Date: Tue, 18 Dec 2001 17:43:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: bcrl <bcrl@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] mempool-2.5.1-D2
In-Reply-To: <200112172357.AAA17058@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.33.0112181731520.3480-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Stephan von Krawczynski wrote:

> Hm, and where is the real-world-difference to standard VM? I mean
> today your bad-ass application gets shot down by L's oom-killer and
> your VM will "refill". So you're not going to die for long in the
> current situation either. [...]

Think of the following trivial case: 'the whole system is full of dirty
pagecache pages, the rest is kmalloc()ed somewhere'. Nothing to oom,
nothing to kill, plenty of swap left and no RAM. And besides, in this
situation, oom is the worst possible answer, the application getting
oom-ed is not at fault in this case.

	Ingo

