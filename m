Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUKIKyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUKIKyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUKIKnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:43:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:965 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261486AbUKIKkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:40:05 -0500
Date: Tue, 9 Nov 2004 05:18:44 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041109071844.GB5473@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <20041108162731.GE2336@logos.cnet> <20041108185546.GA3468@logos.cnet> <419029D9.90506@cyberone.com.au> <20041108183552.7caccad1.akpm@osdl.org> <41902F83.6060200@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41902F83.6060200@cyberone.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 01:46:27PM +1100, Nick Piggin wrote:
> 
> 
> Andrew Morton wrote:
> 
> >Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> >>I'm not sure... it could also be just be a fluke
> >>due to chaotic effects in the mm, I suppose :|
> >>
> >
> >2.6 scans less than 2.4 before declaring oom.  I looked at the 2.4
> >implementation and thought "whoa, that's crazy - let's reduce it and see
> >who complains".  My three-year-old memory tells me it was reduced by 2x to
> >3x.
> >
> >We need to find testcases (dammit) and do the analysis.  It could be that
> >we're simply not scanning far enough.
> >
> >
> >
> 
> Oh yeah, there definitely seems to be OOM problems as well (although
> luckily not _too_ many people seem to be complaining).
> 
> I thought Marcelo was talking about increased incidents of people
> reporting eg. order-0 atomic allocation failures though, after the
> recentish code from you and I to fix up alloc_pages.

Yes that is what I'm talking about - it should be happening. 

The amount of reports is _too high_. I can at least one report 
of 0-order page allocation failure a day.
