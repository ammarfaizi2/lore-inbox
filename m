Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVCDLP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVCDLP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVCDLNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:13:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2578 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262825AbVCDLHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:07:51 -0500
Date: Fri, 4 Mar 2005 12:07:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mike Waychison <mike@waychison.com>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] unexport complete_all
Message-ID: <20050304110750.GD3992@stusta.de>
References: <422817C3.2010307@waychison.com> <58cb370e0503040240314120ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0503040240314120ea@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 11:40:08AM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 04 Mar 2005 03:09:39 -0500, Mike Waychison <mike@waychison.com> wrote:
> > > I didn't find any possible modular usage in the kernel.
> > >
> > > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > >
> > > --- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old      2005-03-04 01:04:28.000000000 +0100
> > > +++ linux-2.6.11-rc5-mm1-full/kernel/sched.c  2005-03-04 01:04:34.000000000 +0100
> > > @@ -3053,7 +3053,6 @@
> > >                        0, 0, NULL);
> > >       spin_unlock_irqrestore(&x->wait.lock, flags);
> > >  }
> > > -EXPORT_SYMBOL(complete_all);
> > >
> > >  void fastcall __sched wait_for_completion(struct completion *x)
> > >  {
> > > -
> > 
> > This is a valid piece of API that is exported for future use.
> 
> Let me guess: autofsng?
>...

I grepped through autofsng-0.4 but didn't find any usage.

> Bartlomiej

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

