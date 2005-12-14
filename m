Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVLNOBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVLNOBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVLNOBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:01:44 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:7934 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964780AbVLNOBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:01:44 -0500
Date: Wed, 14 Dec 2005 09:01:28 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Thomas Gleixner <tglx@linutronix.de>
cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
 patches
In-Reply-To: <1134568867.4275.7.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.58.0512140857150.30887@gandalf.stny.rr.com>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de> 
 <1134507927.18921.26.camel@localhost.localdomain>  <20051214084019.GA18708@elte.hu>
  <20051214084333.GA20284@elte.hu>  <1134568080.18921.42.camel@localhost.localdomain>
 <1134568867.4275.7.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Dec 2005, Thomas Gleixner wrote:

> >
> > So the fix to this, in the case of preempting the softirq, that we need
> > to introduce some wait queue that will allow processes to wait for the
> > softirq to finish, and then the softirq will wake up all the processes.
>
> We had the waitqueue in the ktimer based -rt patches and did not add it
> back.
>

Actually, to save on the memory, I was thinking of a general purpose wait
queue, that is either one for all softirqs, or one for each particular
softirq,  that the softirq handler would wakeup when finished.

Thoughts?

-- Steve
