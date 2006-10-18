Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422749AbWJRSLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422749AbWJRSLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422751AbWJRSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:11:04 -0400
Received: from mga05.intel.com ([192.55.52.89]:22863 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1422749AbWJRSLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:11:02 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,325,1157353200"; 
   d="scan'208"; a="148487454:sNHT3209907477"
Date: Wed, 18 Oct 2006 10:50:35 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com,
       nickpiggin@yahoo.com.au
Subject: Re: [RFC] Cpuset: explicit dynamic sched domain control flags
Message-ID: <20061018105035.B26521@unix-os.sc.intel.com>
References: <20061016230351.19049.29855.sendpatchset@jackhammer.engr.sgi.com> <20061017114306.A19690@unix-os.sc.intel.com> <20061017121823.e6f695aa.pj@sgi.com> <20061017190144.A19901@unix-os.sc.intel.com> <20061018000512.1d13aabd.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061018000512.1d13aabd.pj@sgi.com>; from pj@sgi.com on Wed, Oct 18, 2006 at 12:05:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 12:05:12AM -0700, Paul Jackson wrote:
> Suresh wrote:
> > > What happens then is that the job manager marks the cpuset of this
> > > newly activated job as being a sched_domain.
> > 
> > With your patch, that will fail because there is already a cpuset defining
> > a sched domain and which overlaps with the one that is becoming active.
> 
> No, this does not fail.  The job manager also turned off the other cpusets
> sched_domain flag, because that job went inactive.
> 
> The job manager does not run active jobs on overlapping CPUs.  It marks
> the cpusets of only the active jobs as sched domains, and turns off the
> sched_domain flag on the cpusets of the inactive jobs.

So why can't the job manager remove the cpus from inactive cpusets and add
it to the cpuset that job manager is interested in.

Not sure what additional functionality your are adding here.

> > In this case, shouldn't we remove cpus0-3 from "cs1" cpus_allowed?
> 
> No, you missed my point.  The point of my example wasn't to show how to
> do this right.  It was to show that even the existing cpu_exclusive
> flag lets one create sched domains configurations that might not be
> what one wanted.

I agree with your point. Lets take this out of discussion for now.

thanks,
suresh
