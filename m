Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286403AbSAEXaw>; Sat, 5 Jan 2002 18:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286395AbSAEXam>; Sat, 5 Jan 2002 18:30:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46607 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286399AbSAEXaj>; Sat, 5 Jan 2002 18:30:39 -0500
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sat, 5 Jan 2002 23:41:38 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org (lkml),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.40.0201051242080.1607-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Jan 05, 2002 03:04:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16N0RW-0001We-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > In fact it's the cr3 switch (movl %0, %%cr3) that accounts for about 30%
> > of the context switch cost. On x86. On other architectures it's often
> > much, much cheaper.
> 
> TLB flushes are expensive everywhere, and you know exactly this and if you

Not every processor is dumb enough to have TLB flush on a context switch.
If you have tags on your tlb/caches it's not a problem.

> Again, the history of our UP scheduler thought us that noone has been able
> to makes it suffer with realistic/high not-stupid-benchamrks loads.

Apache under load, DB2, Postgresql, Lotus domino all show bad behaviour. 
(Whether apache, db2, and postgresql want fixing differently is a seperate
 argument)

Alan
