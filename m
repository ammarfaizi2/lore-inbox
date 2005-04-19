Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVDSHJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVDSHJw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDSHJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:09:52 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:35223 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261358AbVDSHJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:09:49 -0400
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lkml <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       dipankar@in.ibm.com, colpatch@us.ibm.com
In-Reply-To: <20050418235902.7632d68a.pj@sgi.com>
References: <1097110266.4907.187.camel@arrakis>
	 <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com>
	 <1113891575.5074.46.camel@npiggin-nld.site>
	 <20050418235902.7632d68a.pj@sgi.com>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 17:09:43 +1000
Message-Id: <1113894584.5074.54.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 23:59 -0700, Paul Jackson wrote:
> Nick wrote:
> >  Basically you just have to know that it has the
> > capability to partition the system in an arbitrary disjoint set
> > of sets of cpus.
> > 
> > If you can make use of that, then we're in business ;)
> 
> You read fast ;)
> 
> So you do _not_ want to consider nested sched domains, just disjoint
> ones.  Good.
> 

You don't either? Good. :)

> 
> > From what I gather, this partitioning does not exactly fit
> > the cpusets architecture. Because with cpusets you are specifying
> > on what cpus can a set of tasks run, not dividing the whole system.
> 
> My evil scheme, and Dinakar's as well, is to provide a way for the user
> to designate _some_ of their cpusets as also defining the partition that
> controls which cpus are in each sched domain, and so dividing the
> system.
> 
>   "partition" == "an arbitrary disjoint set of sets of cpus"
> 

That would make sense. I'm not familiar with the workings of cpusets,
but that would require every task to be assigned to one of these
sets (or a subset within it), yes?

> This fits naturally with the way people use cpusets anyway.  They divide
> up the system along boundaries that are natural topologically and that
> provide a good fit for their jobs, and hope that the kernel will adapt
> to such localized placement.  They then throw a few more nested (smaller)
> cpusets at the problem, to deal with various special needs.  If we can
> provide them with a means to tell us which of their cpusets define the
> natural partitioning of their system, for the job mix and hardware
> topology they have, then all is well.
> 

Sounds like a good fit then. I'll touch up the sched-domains side of
the equation when I get some time hopefully this week or next.

-- 
SUSE Labs, Novell Inc.


