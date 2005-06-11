Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVFKJQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVFKJQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 05:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFKJQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 05:16:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39931 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261217AbVFKJQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 05:16:21 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, mingo@elte.hu, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, ak@muc.de, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <42AA812D.2060701@yahoo.com.au>
References: <42AA6A6B.5040907@opersys.com>  <42AA812D.2060701@yahoo.com.au>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 02:15:15 -0700
Message-Id: <1118481315.9519.39.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 16:14 +1000, Nick Piggin wrote:
> Kristian Benoit wrote:
> > For the past few weeks, we've been conducting comparison tests between
> > PREEMPT_RT and the Adeos nanokernel. As was clear from previous discussion,
> > we've been open to be proven wrong regarding endorsement of either method.
> > Hence, this comparison was done in order to better understand the impact
> > of each method vis-a-vis vanilla Linux.
> > 
> 
> This is wonderful data, thanks very much for putting in the work.
> I hope this thread and future threads on this topic can be steered
> more towards technical facts and numbers, as that is the only way
> to make sane choices.
> 

Its a good start, and its excellent that its being looked at. Thank you
guys very much for taking the time to compare these 2 very different
systems. 

I am too looking forward to seeing results against the >= 07.48 RT
kernels incorporating Daniel's recent IRQ disable relief.

I think the comparison should absolutely compare identical community
kernels. The comparison between two different release candidates is
questionable. rc2 to rc4 doesn't seem like much, after all, how much
code could go into a release candidate. (diff | wc -l) 

Also, I question testing -rc code in the first place, except for
regression purposes. 

Linus, Andrew, and everyone else apply due diligence to drop stable
kernels along the way :)  (Thanks very much).  

The -rc code in between is impressive, but not always as stable, or as
high quality, for obvious reasons. It is integration work in progress.

Finally, there are other big-picture issues. How hard is it to maintain
the code in general? At the risk of ruffling feathers, forward-porting
RT code (or backporting) it a few revisions of rc's isn't too bad. 

At Ingo's pace, we have all done some of that.

How does that effort compare for porting ADEOS code? If several weeks of
work are invested in a comparison of rc2 to rc4, how much additional
work is needed to bring Adeos up to the base for the current RT kernel?

In addition, I think the discrepancy between the vanilla kernel and the
RT kernel could be much greater, if the workload specifically, or even
coincidentally exercised bottlenecks.

I'll stop there, at the brink of speculating, and await the scripts and
background info.

Cheers,

Sven


