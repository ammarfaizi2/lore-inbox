Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWJWGEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWJWGEC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 02:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbWJWGEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 02:04:01 -0400
Received: from mga07.intel.com ([143.182.124.22]:25380 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751558AbWJWGEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 02:04:00 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,341,1157353200"; 
   d="scan'208"; a="134554712:sNHT21810278"
Date: Sun, 22 Oct 2006 22:43:30 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Paul Jackson <pj@sgi.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, mbligh@google.com,
       nickpiggin@yahoo.com.au, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-ID: <20061022224330.A3120@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com> <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com> <20061022035135.2c450147.pj@sgi.com> <20061022222652.B2526@unix-os.sc.intel.com> <20061022225456.6adfd0be.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061022225456.6adfd0be.pj@sgi.com>; from pj@sgi.com on Sun, Oct 22, 2006 at 10:54:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 10:54:56PM -0700, Paul Jackson wrote:
> Suresh wrote:
> > group of pinned tasks can completely skew the system load balancing..
> 
> Ah - yes.  That was a problem.  If the load balancer couldn't offload
> tasks from one or two of the most loaded CPUs (perhaps because they
> were pinned.) it tended to give up.
> 
> I believe that Christoph is actively working that problem.  Adding him
> to the cc list, so he can explain the state of this work more
> accurately.

Pinned tasks can cause a number of challenges to scheduler. 

Christoph has recently addressed one such issue and that too only partial.

It is very difficult to nicely and uniformly  distribute the load pinned
to group of cpus..
