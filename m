Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262191AbREQWEY>; Thu, 17 May 2001 18:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262192AbREQWEO>; Thu, 17 May 2001 18:04:14 -0400
Received: from mout0.freenet.de ([194.97.50.131]:28344 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S262191AbREQWEA>;
	Thu, 17 May 2001 18:04:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Franck <afranck@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: oops in 2.4.4-ac9 (mm/slab.c)
Date: Thu, 17 May 2001 23:59:35 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <E150BVu-0004ja-00@the-village.bc.nu>
In-Reply-To: <E150BVu-0004ja-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01051723593500.06477@dg1kfa>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote: 

> Its a deliberate debugging trap.
>
> > #if DEBUG
> >         if (cachep->flags & SLAB_POISON)
> >                 if (kmem_check_poison_obj(cachep, objp))
> >                         BUG();
> > 			^^^^^^ This one is triggered
>
> Someone freed memory and then scribbled on it.
>
> The first thing useful here is to know which drivers you were using shortly
> before the oops

Sorry, I really can't reproduce it; as I said, it was nothing unusual I did 
(with respect to loaded drivers, which I always have quite a lot of), and it 
happened while doing some editing in vi, which surely doesn't have any bad 
impact, I hope dearly :-)

But it might as well have been some cron job or so, I'll try to check better 
when this happens again. Any more debugging hints you could give me?

Mike Galbraith wrote:
> blogd?

It's SuSE-specific I think, something to log boot messages to a console. 
This SHOULD have finished at this point, however - it's only needed during 
the boot process, so I don't know why this is there... 

> In any case, one thing you can do is to disable the BUG() and
> see if whoever scribbled on the freed area has a reference to
> it still and trips over the damage poison or the new owner did
> to what he thinks is his data.

Can you explain that in more detail, what I should do and what is expected to 
happen then?

Greetings,
Andreas
