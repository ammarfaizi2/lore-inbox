Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUIQIG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUIQIG6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 04:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUIQIG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 04:06:58 -0400
Received: from barclay.balt.net ([195.14.162.78]:17969 "EHLO barclay.balt.net")
	by vger.kernel.org with ESMTP id S268565AbUIQIGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 04:06:55 -0400
Date: Fri, 17 Sep 2004 11:05:04 +0300
From: Zilvinas Valinskas <zilvinas@gemtek.lt>
To: Helge Hafting <helge.hafting@hist.no>
Cc: Jeff Garzik <jgarzik@pobox.com>, Lee Revell <rlrevell@joe-job.com>,
       Ricky Beam <jfbeam@bluetronic.net>, Erik Tews <erik@debian.franken.de>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 rc2 freezing
Message-ID: <20040917080503.GA7634@gemtek.lt>
Reply-To: Zilvinas Valinskas <zilvinas@gemtek.lt>
References: <Pine.GSO.4.33.0409151255240.10693-100000@sweetums.bluetronic.net> <1095270555.2406.154.camel@krustophenia.net> <41488140.4050109@pobox.com> <4149512E.9040005@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4149512E.9040005@hist.no>
X-Attribution: Zilvinas
X-Url: http://www.gemtek.lt/
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 10:39:10AM +0200, Helge Hafting wrote:
> Jeff Garzik wrote:
> 
> >Lee Revell wrote:
> >
> >>Interesting.  Still, this looks like a specific bug that needs fixing,
> >>it doesn't imply that preemption is a hack.  For many workloads
> >>preemption is a necessity.
> >
> >
> >
> >For any workload that you feel preemption is a necessity, that 
> >indicates a latency problem in the kernel that should be solved.
> >
> >Preemption is a hack that hides broken drivers, IMHO.
> >
> >I would rather directly address any latency problems that appear.
> 
> Current preempt is broken, sure.  But having robust preempt
> would allow code simplification.  Long loops outside critical
> sections would be ok - no time or code spent testing for a need for
> rescheduling because you'll be preempted when necessary anyway.

Could be the case. This morning I've turned off PREEMPT support in
linux 2.6.9-rc2 kernel, booted just fine, ran apt-get update ... it
seemed everything is ok. 

Then setup IPsec policies, ping remote end, racoon has tried to negotiate 
with a remote end and ... laptop freezes again (this time without
PREEMPT).

At a time I was in X, couldn't capture the OOPS, after reboot
/var/log/kern.log is empty ... :(

Doesn't seem it is PREEMPT related I think now.
> 
> Or am I missing something?  Other than that current preempt isn't up to
> this and might be hard to get there?
> 
> Helge Hafting
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
