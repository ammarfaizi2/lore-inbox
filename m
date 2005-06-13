Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVFMHpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFMHpK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVFMHpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 03:45:10 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:49024 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261415AbVFMHpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 03:45:04 -0400
Date: Mon, 13 Jun 2005 09:44:45 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
In-Reply-To: <1118646527.5729.60.camel@sdietrich-xp.vilm.net>
Message-Id: <Pine.OSF.4.05.10506130942140.10063-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2005, Sven-Thorsten Dietrich wrote:

> On Sat, 2005-06-11 at 22:03 +0200, Ingo Molnar wrote:
> > * Esben Nielsen <simlo@phys.au.dk> wrote:
> > 
> > > > the jury is still out on the accuracy of those numbers. The test had 
> > > > RT_DEADLOCK_DETECT (and other -RT debugging features) turned on, which 
> > > > mostly work with interrupts disabled. The other question is how were 
> > > > interrupt response times measured.
> > > > 
> > > You would accept a patch where I made this stuff optional?
> > 
> > I'm not sure why. The soft-flag based local_irq_disable() should in fact 
> > be a tiny bit faster than the cli based approach, on a fair number of 
> > CPUs. But it should definitely not be slower in any measurable way.
> > 
> 
> Is there any such SMP concept as a local_preempt_disable()  ?
> 
You must think of preempt_disable() ? Except for the interface is a little
bit different using flags in local_irq_save(), preempt_disable() works
exactly the same way, blocking for everything but interrupts - on the
_local_ CPU. (Under PREEMPT_RT it ofcourse also blocks for threaded IRQ
handlers.)


Esben

