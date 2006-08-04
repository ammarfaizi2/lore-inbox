Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWHDHOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWHDHOW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWHDHOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:14:22 -0400
Received: from ausmtp05.au.ibm.com ([202.81.18.154]:8942 "EHLO
	ausmtp05.au.ibm.com") by vger.kernel.org with ESMTP
	id S1161074AbWHDHOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:14:21 -0400
Date: Fri, 4 Aug 2006 12:40:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu controller
Message-ID: <20060804071009.GA15141@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060804062036.GA28137@in.ibm.com> <20060803234537.e9b6736d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060803234537.e9b6736d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 11:45:37PM -0700, Andrew Morton wrote:
> On Fri, 4 Aug 2006 11:50:36 +0530
> > 
> > FWIW, this controller was originally written for f-series.
> 
> What the heck is an f-series?

Sorry, the resource group - (formerly ckrm) series that Chandra posted 
a few months ago. 

http://lkml.org/lkml/2006/4/27/378

> > It should
> > be trivial to put it back there. So really, f-series isn't gone 
> > anywhere. If you want to merge it, I am sure it can be re-submitted.
> 
> Well.  It shouldn't be a matter of what I want to merge - you're the
> resource-controller guys.  But...

The point is that putting the controller back to the ckrm framework
would not be that difficult since it came from there.

> > One of
> > the strongest points raised in the BoF was - forget the infrastructure
> > for now, get some mergable controllers developed.
> 
> I wonder what inspired that approach.  Perhaps it was a reaction to CKRM's
> long and difficult history?  Perhaps it was felt that doing standalne
> controllers with ad-hoc interfaces would make things easier to merge?
> 
> Perhaps.  But I think you guys know that the end result would be inferior,
> and that getting good infrastructure in place first will produce a better
> end result, but you decided to go this way because you want to get
> _something_ going?

I think part of it was the fact that the two main controllers
would were in scheduler and VM code made people to be
more cautious about the controllers and wanted those issues
to be sorted out first.

> > If you
> > want to stick to f-series infrastructure and want to see some
> > consensus controllers evolve on top of it, that can be done too.
> 
> Do you think that the CKRM core as last posted had any unnecessary
> features?  I don't have the operational experience to be able to judge
> that, so I'd prefer to trust your experience and judgement on that.  But
> the features which _were_ there looked quite OK from an implementation POV.
> 
> So my take was "looks good, done deal - let's go get some sane controllers
> working".  And now this!

My recollection from the BoF is that people felt interface wasn't a major
issue and it wasn't discussed much. Most of the discussion centered
around grouping of tasks and the mem/cpu controllers and some additional
resource control requirements from openvz folks.

One way to go forward with the interface could be to request Chandra
to repost the ckrm infrastructure and see if the stake holders (primarily
container folks) can review and agree on it.

Thanks
Dipankar
