Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWJRKyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWJRKyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWJRKyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:54:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:47778 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751166AbWJRKyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:54:17 -0400
Date: Wed, 18 Oct 2006 05:53:08 -0500
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Robin Holt <holt@sgi.com>, suresh.b.siddha@intel.com, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com,
       nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-ID: <20061018105307.GA17027@lnx-holt.americas.sgi.com>
References: <20061017192547.B19901@unix-os.sc.intel.com> <20061018001424.0c22a64b.pj@sgi.com> <20061018095621.GB15877@lnx-holt.americas.sgi.com> <20061018031021.9920552e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018031021.9920552e.pj@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 03:10:21AM -0700, Paul Jackson wrote:
>  2) I suspect that Mr. Cpusets doesn't understand sched domains and that
>     Mr. Sched Domain doesn't understand cpusets, and that we've ended
>     up with some inscrutable and likely unsuitable interactions between
>     the two as a result, which in particular don't result in cpusets
>     driving the sched domain configuration in the desired ways for some
>     of the less trivial configs.

You do, however, hopefully have enough information to create the
calls you would make to partition_sched_domain if each had their
cpu_exclusive flags cleared.  Essentially, what I am proposing is
making all the calls as if the user had cleared each as the
remove/add starts, and then behave as if each each was set again.

Thanks,
Robin
