Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965033AbWECJQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbWECJQf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 05:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965131AbWECJQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 05:16:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:45504 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965033AbWECJQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 05:16:35 -0400
From: Andi Kleen <ak@suse.de>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: sched_clock() uses are broken
Date: Wed, 3 May 2006 11:16:09 +0200
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christopher Friesen <cfriesen@nortel.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20060502132953.GA30146@flint.arm.linux.org.uk> <200605030940.20409.ak@suse.de> <1146647462.7440.12.camel@homer>
In-Reply-To: <1146647462.7440.12.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605031116.09428.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 May 2006 11:11, Mike Galbraith wrote:
> On Wed, 2006-05-03 at 09:40 +0200, Andi Kleen wrote:
> > On Wednesday 03 May 2006 09:09, Mike Galbraith wrote:
> > 
> > > Given that most people are going to end up using the pm_timer anyway, I
> > > don't see the point of even having a sched_clock().  If it's jiffy
> > > resolution, it's useless.  If it's wildly inaccurate (as it is in the
> > > SMP case, monotonicity issues aside) it's more than useless.
> > 
> > For sched_clock TSC is always used and it's fine - sched_clock
> > doesn't require the guarantees that make TSC often useless otherwise
> 
> Regrettable, that's not true.

Hmm, maybe I'm thinking too much x86-64. At least on x86-64 it's true.

I don't see a big reason to not do this on i386 either, except
on systems that truly don't have a TSC (386/486) 

Ok i suppose if you don't want cruft you can always go to 64bit @)

-Andi

