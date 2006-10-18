Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWJRKKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWJRKKf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 06:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWJRKKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 06:10:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27575 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750785AbWJRKKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 06:10:34 -0400
Date: Wed, 18 Oct 2006 03:10:21 -0700
From: Paul Jackson <pj@sgi.com>
To: Robin Holt <holt@sgi.com>
Cc: suresh.b.siddha@intel.com, dino@in.ibm.com, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, mbligh@google.com,
       rohitseth@google.com, dipankar@in.ibm.com, nickpiggin@yahoo.com.au
Subject: Re: exclusive cpusets broken with cpu hotplug
Message-Id: <20061018031021.9920552e.pj@sgi.com>
In-Reply-To: <20061018095621.GB15877@lnx-holt.americas.sgi.com>
References: <20061017192547.B19901@unix-os.sc.intel.com>
	<20061018001424.0c22a64b.pj@sgi.com>
	<20061018095621.GB15877@lnx-holt.americas.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin wrote:
> Could this be as simple as a CPU_UP_PREPARE or CPU_DOWN_PREPARE
> removing all the cpu_exclusive cpusets and a CPU_UP_CANCELLED,
> CPU_DOWN_CANCELLED, CPU_ONLINE, CPU_DEAD going through and
> partitioning all the cpu_exclusive cpusets.

Perhaps.

The somewhat related problems, in my book, are:

 1) I don't know how to tell what sched domains/groups a system has, nor
    how to tell my customers how to see what sched domains they have, and

 2) I suspect that Mr. Cpusets doesn't understand sched domains and that
    Mr. Sched Domain doesn't understand cpusets, and that we've ended
    up with some inscrutable and likely unsuitable interactions between
    the two as a result, which in particular don't result in cpusets
    driving the sched domain configuration in the desired ways for some
    of the less trivial configs.

    Well ... at least the first suspcicion above is a near certainty ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
