Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992540AbWJTRuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992540AbWJTRuJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 13:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992550AbWJTRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 13:50:09 -0400
Received: from mga05.intel.com ([192.55.52.89]:4682 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S2992540AbWJTRuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 13:50:07 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,336,1157353200"; 
   d="scan'208"; a="149595374:sNHT2229258906"
Date: Fri, 20 Oct 2006 10:29:46 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Martin Bligh <mbligh@google.com>, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-ID: <20061020102946.A8481@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com> <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com> <4538F34A.7070703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4538F34A.7070703@yahoo.com.au>; from nickpiggin@yahoo.com.au on Sat, Oct 21, 2006 at 02:03:22AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 02:03:22AM +1000, Nick Piggin wrote:
> Martin Bligh wrote:
> > We (Google) are planning to use it to do some partitioning, albeit on
> > much smaller machines. I'd really like to NOT use cpus_allowed from
> > previous experience - if we can get it to to partition using separated
> > sched domains, that would be much better.
> > 
> >  From my dim recollections of previous discussions when cpusets was
> > added in the first place, we asked for exactly the same thing then.
> > I think some of the problem came from the fact that "exclusive"
> > to cpusets doesn't actually mean exclusive at all, and they're
> > shared in some fashion. Perhaps that issue is cleared up now?
> > /me crosses all fingers and toes and prays really hard.
> 
> The I believe, is that an exclusive cpuset can have an exclusive parent
> and exclusive children, which obviously all overlap one another, and
> thus you have to do the partition only at the top-most exclusive cpuset.
> 
> Currently, cpusets is creating partitions in cpus_exclusive children as
> well, which breaks balancing for the parent.
> 
> The patch I posted previously should (modulo bugs) only do partitioning
> in the top-most cpuset. I still need clarification from Paul as to why
> this is unacceptable, though.

I like the direction of Nick's patch which do domain partitioning at the
top-most exclusive cpuset.

thanks,
suresh
