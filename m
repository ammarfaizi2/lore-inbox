Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVDTHbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVDTHbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 03:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDTHbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 03:31:03 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:42973 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261202AbVDTHa4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:30:56 -0400
Date: Wed, 20 Apr 2005 13:07:44 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, dipankar@in.ibm.com,
       colpatch@us.ibm.com
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050420073744.GB3931@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <20050418225427.429accd5.pj@sgi.com> <1113891575.5074.46.camel@npiggin-nld.site> <20050419095230.GC3963@in.ibm.com> <20050419082639.62d706ca.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419082639.62d706ca.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 08:26:39AM -0700, Paul Jackson wrote:
>  * Your understanding of "cpu_exclusive" is not the same as mine.

Sorry for creating confusion by what I said earlier, I do understand
exactly what cpu_exclusive means. Its just that when I started
working on this (a long time ago) I had a different notion and that is
what I was referring to, I probably should never have brought that up

> 
> > Since isolated cpusets are trying to partition the system, this
> > can be restricted to only the first level of cpusets.
> 
> I do not think such a restriction is a good idea.  For example, lets say
> our 8 CPU system has the following cpusets:
> 

And my current implementation has no such restriction, I was only
suggesting that to simplify the code.

> 
> > Also I think we can add further restrictions in terms not being able
> > to change (add/remove) cpus within a isolated cpuset.
> 
> My approach agrees on this restriction.  Earlier I wrote:
> > Also note that adding or removing a cpu from a cpuset that has
> > its domain_cpu_current flag set true must fail, and similarly
> > for domain_mem_current.
> 
> This restriction is required in my approach because the CPUs in the
> domain_cpu_current cpusets (the isolated CPUs, in your terms) form a
> partition (disjoint cover) of the CPUs in the system, which property
> would be violated immediately if any CPU were added or removed from any
> cpuset defining the partition.

See my other note explaining how things work currently. I do feel that
this restriction is not good

	-Dinakar
