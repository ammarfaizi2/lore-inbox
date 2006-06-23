Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWFWQZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWFWQZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbWFWQZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:25:16 -0400
Received: from www.osadl.org ([213.239.205.134]:23432 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751534AbWFWQZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:25:14 -0400
Subject: Re: [patch 2/3] rtmutex: Propagate priority settings into PI lock
	chains
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060622190657.08944024.akpm@osdl.org>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
	 <20060622082812.607857000@cruncher.tec.linutronix.de>
	 <20060622190657.08944024.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 18:26:57 +0200
Message-Id: <1151080017.25491.240.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 19:06 -0700, Andrew Morton wrote:
> On Thu, 22 Jun 2006 09:08:39 -0000
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > When the priority of a task, which is blocked on a lock, changes we must
> > propagate this change into the PI lock chain. Therefor the chain walk
> > code is changed to get rid of the references to current to avoid false
> > positives in the deadlock detector, as setscheduler might be called by a 
> > task which holds the lock on which the task whose priority is changed is
> > blocked.
> > Also add some comments about the get/put_task_struct usage to avoid
> > confusion.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > 
> >  include/linux/sched.h |    2 ++
> >  kernel/rtmutex.c      |   41 ++++++++++++++++++++++++++++++++++++-----
> 
> That file's full of lockdep droppings from a different patchset.  Please
> check the end result.

Will do in a minute

	tglx


