Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWGFQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWGFQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWGFQ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:26:49 -0400
Received: from mga05.intel.com ([192.55.52.89]:39951 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964870AbWGFQ0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:26:48 -0400
X-IronPort-AV: i="4.06,214,1149490800"; 
   d="scan'208"; a="94124177:sNHT14627361"
Date: Thu, 6 Jul 2006 09:19:30 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com
Subject: Re: cpuinfo_x86 and apicid
Message-ID: <20060706091930.A13512@unix-os.sc.intel.com>
References: <20060706150118.GB10110@frankl.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060706150118.GB10110@frankl.hpl.hp.com>; from eranian@hpl.hp.com on Thu, Jul 06, 2006 at 08:01:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2006 at 08:01:18AM -0700, Stephane Eranian wrote:
> Hello,
> 
> 
> In the context of the perfmon2 subsystem for processor with HyperThreading,
> we need to know on which thread we are currently running. This comes from
> the fact that the performance counters are shared between the two threads.
> 
> We use the thread id (smt_id) because we split the counters in half
> between the two threads such that two threads on the same core can run
> with monitoring on.  We are currently computing the smt_id from the
> apicid as returned by a CPUID instruction. This is not very efficient.
> 
> I looked through the i386 code and could not find a function nor 
> structure that would return this smt_id. In the cpuinfo_x86 structure
> there is an apicid field that looks good, yet it does not seem to be
> initialized nor used.
> 
> Is cpuinfo_x86->apicid field obsolete? 
> If so, what is replacing it?

In i386, it is getting initialized in generic_identify() in common.c and
it is getting used for example in intel_cacheinfo.c

thanks,
suresh
