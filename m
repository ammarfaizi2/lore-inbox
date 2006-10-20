Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946524AbWJTVUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946524AbWJTVUK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946527AbWJTVUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:20:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:42086 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1030370AbWJTVUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:20:03 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,336,1157353200"; 
   d="scan'208"; a="148273891:sNHT21618359"
Date: Fri, 20 Oct 2006 13:59:44 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-ID: <20061020135944.B8481@unix-os.sc.intel.com>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com> <453750AA.1050803@yahoo.com.au> <20061019105515.080675fb.pj@sgi.com> <4537BEDA.8030005@yahoo.com.au> <20061019115652.562054ca.pj@sgi.com> <4537CC1E.60204@yahoo.com.au> <20061019203744.09b8c800.pj@sgi.com> <453882AC.3070500@yahoo.com.au> <20061020130141.b5e986dd.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061020130141.b5e986dd.pj@sgi.com>; from pj@sgi.com on Fri, Oct 20, 2006 at 01:01:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 01:01:41PM -0700, Paul Jackson wrote:
> Nick wrote:
> > Or, another question, how does my patch hijack cpus_allowed? In
> > what way does it change the semantics of cpus_allowed?
> 
> It limits load balancing for tasks in cpusets containing
> a superset of that cpusets cpus.
> 
> There are always such cpusets - the top cpuset if no other.

Its just a corner case issue that Nick didn't consider while doing a quick
patch. Nick meant to partition the sched domain at the top
exclusive cpuset and he probably missed the case where root cpuset is marked
as exclusive.

thanks,
suresh
