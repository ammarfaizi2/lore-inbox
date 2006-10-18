Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWJRJ5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWJRJ5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWJRJ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:57:48 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10166 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932138AbWJRJ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:57:47 -0400
Date: Wed, 18 Oct 2006 04:56:21 -0500
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, dino@in.ibm.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, rohitseth@google.com, dipankar@in.ibm.com,
       nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-ID: <20061018095621.GB15877@lnx-holt.americas.sgi.com>
References: <20061017192547.B19901@unix-os.sc.intel.com> <20061018001424.0c22a64b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018001424.0c22a64b.pj@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 12:14:24AM -0700, Paul Jackson wrote:
> > Anyone would like to fix it up?
> 
> Hotplug is not high on my priority list.
> 
> I do what I can in my spare time to avoid having cpusets or hotplug
> break each other.
> 
> Besides, I'm not sure I'd be able.  I've gotten to the point where I am
> confident I can make simple changes at the edges, such as mimicing the
> sched domain side affects of the cpu_exclusive flag with my new
> sched_domain flag.  But that's near the current limit of my sched domain
> writing skills.

Paul and Suresh,

Could this be as simple as a CPU_UP_PREPARE or CPU_DOWN_PREPARE
removing all the cpu_exclusive cpusets and a CPU_UP_CANCELLED,
CPU_DOWN_CANCELLED, CPU_ONLINE, CPU_DEAD going through and
partitioning all the cpu_exclusive cpusets.

Thanks,
Robin
