Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265850AbTFSRPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbTFSRPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:15:18 -0400
Received: from users.ccur.com ([208.248.32.211]:40306 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S265850AbTFSRPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:15:14 -0400
Date: Thu, 19 Jun 2003 13:28:40 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Robert Love <rml@mvista.com>
Cc: george anzinger <george@mvista.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>, "Li, Adam" <adam.li@intel.com>
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta sks
Message-ID: <20030619172839.GA1087@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <A46BBDB345A7D5118EC90002A5072C780DD16DB0@orsmsx116.jf.intel.com> <3EF1DE35.20402@mvista.com> <20030619171950.GA936@rudolph.ccur.com> <1056043409.8770.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056043409.8770.25.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 10:23:30AM -0700, Robert Love wrote:
> On Thu, 2003-06-19 at 10:19, 'joe.korty@ccur.com' wrote:
> 
> > I posted a fix for this a month ago that was ignored.  Which is a
> > good thing, since now that I look at it again, I don't care for the
> > approach I took nor does it appear to be complete.
> 
> Ah, sorry for missing it. Other than that tertiary statement inside an
> if ;) my patch is about the same.
> 
> Why do you think it is incomplete? It looks correct to me.


It may be better to add it to __activate_task() rather than after the
single activate_task() use.  At the time I wrote the patch I did not
think to look at the five __activate_task() calls to see if they each
needed the test.  By me not looking, my patch is automatically
incorrect, even if it turns out to be correct.

Joe

