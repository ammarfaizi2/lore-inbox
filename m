Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSIIJ5g>; Mon, 9 Sep 2002 05:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316795AbSIIJ5g>; Mon, 9 Sep 2002 05:57:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17360 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S316792AbSIIJ5g>;
	Mon, 9 Sep 2002 05:57:36 -0400
Date: Mon, 9 Sep 2002 12:06:26 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@mwaikambo.name>, Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
In-Reply-To: <Pine.LNX.4.44.0209081453010.1293-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209091204070.15029-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Sep 2002, Linus Torvalds wrote:

> As far as I can tell, the only time when this might be an advantage is
> an SMP machine with multiple devices sharing an extremely busy irq line.
> Then the per-isr in-progress bit allows multiple CPU's to actively
> handle several of the devices at the same time.
> 
> Or is there some other case where this is helpful?

it could also improve latency of a faster interrupt source that shares its
irq line with a slow (but still frequent) handler. (such as SCSI or ne2k.)  
This is both on UP and on SMP.

although this might be less of an issue these days.

	Ingo

