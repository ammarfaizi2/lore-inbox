Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSILUue>; Thu, 12 Sep 2002 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSILUue>; Thu, 12 Sep 2002 16:50:34 -0400
Received: from ns.suse.de ([213.95.15.193]:47117 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317404AbSILUuc>;
	Thu, 12 Sep 2002 16:50:32 -0400
To: Alan Cox <alan@redhat.com>
Cc: rml@tech9.net (Robert Love), mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac task->cpu abstraction and optimization
References: <15744.57073.2852.707839@kim.it.uu.se.suse.lists.linux.kernel> <200209122022.g8CKMJS15137@devserv.devel.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Sep 2002 22:55:20 +0200
In-Reply-To: Alan Cox's message of "12 Sep 2002 22:28:54 +0200"
Message-ID: <p73bs73udvr.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> >  > also took a look at your patch -- looks good, you should submit it to
> >  > Marcelo... it cannot hurt for 2.4.
> > 
> > I might do that, unless Alan plans on pushing the -ac sched.c stuff to
> > Marcelo, in which case my patch would just confuse things. Alan?
> 
> I'd like to see it in 2.4 base. Its really Marcelo's call.

One imho major problem with the new scheduler is that its new
sched_yield breaks programs like OpenOffice, who rely on the old
sched_yield behaviour. With new scheduler and 2.5 yield  OpenOffice
can be completely starved just by a kernel compile because sched_yield
kills all its time slices.

I don't think a stable release should break programs in such a way.

-Andi
