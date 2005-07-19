Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVGSMLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVGSMLH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 08:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbVGSMLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 08:11:07 -0400
Received: from [216.208.38.107] ([216.208.38.107]:61056 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S261966AbVGSMLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 08:11:05 -0400
Subject: Re: Fix missing refrigerator invocation in jffs2.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050718181855.GA19802@wohnheim.fh-wedel.de>
References: <1121660092.13487.83.camel@localhost>
	 <20050718181855.GA19802@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=iso-8859-1
Organization: Cycades
Message-Id: <1121775180.3133.39.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 19 Jul 2005 22:13:01 +1000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2005-07-19 at 04:18, Jörn Engel wrote:
> On Mon, 18 July 2005 14:14:53 +1000, Nigel Cunningham wrote:
> > 
> > Here's a patch to fix a missing refrigerator call in jffs2.
>                                                            ^
> You should shorten the description by one letter, roughly. ;)

Oh oops! Sorry!

Nigel

> > 
> > Signed-off by: Nigel Cunningham <nigel@suspend2.net>
> > 
> >  intrep.c |    3 +++
> >  1 files changed, 3 insertions(+)
> > diff -ruNp 235-jffs-intrep.patch-old/fs/jffs/intrep.c 235-jffs-intrep.patch-new/fs/jffs/intrep.c
> > --- 235-jffs-intrep.patch-old/fs/jffs/intrep.c	2005-07-18 06:36:59.000000000 +1000
> > +++ 235-jffs-intrep.patch-new/fs/jffs/intrep.c	2005-07-18 14:02:27.000000000 +1000
> > @@ -3397,6 +3397,9 @@ jffs_garbage_collect_thread(void *ptr)
> >  			siginfo_t info;
> >  			unsigned long signr = 0;
> >  
> > +			if (try_to_freeze())
> > +				continue;
> > +
> >  			spin_lock_irq(&current->sighand->siglock);
> >  			signr = dequeue_signal(current, &current->blocked, &info);
> >  			spin_unlock_irq(&current->sighand->siglock);
> > 
> > -- 
> > Evolution.
> > Enumerate the requirements.
> > Consider the interdependencies.
> > Calculate the probabilities.
> > Be amazed that people believe it happened. 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> Jörn
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

