Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWJRRzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWJRRzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422709AbWJRRzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:55:05 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:64163 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751518AbWJRRzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:55:03 -0400
Date: Wed, 18 Oct 2006 23:24:58 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: pj@sgi.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, rohitseth@google.com,
       dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-ID: <20061018175458.GC7885@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061017192547.B19901@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017192547.B19901@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 07:25:48PM -0700, Siddha, Suresh B wrote:
> When ever a cpu hotplug happens, current kernel calls build_sched_domains()
> with cpu_online_map. That will destroy all the domain partitions(done by
> partition_sched_domains()) setup so far by exclusive cpusets.
> 
> And its not just cpu hotplug, this happens even if someone changes multi core
> sched power savings policy.
> 
> Anyone would like to fix it up? In the presence of cpusets, we basically
> need to traverse all the exclusive sets and setup the sched domains
> accordingly.
> 
> If no one does :( then I will do that when I get some time...

Suresh,

I have a patch (though a very old one...) for handling hotplug and cpusets.
However there were some ugly locking issues and nesting of locks that I
ran into and I never got the time to sort them out. Also there didnt
seem to be any users for it and so I had no motivation to further complicate
the cpusets code/sched domains code. However I can dust up the patches if
there is a need

	-Dinakar
