Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbUA0CUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 21:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbUA0CUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 21:20:51 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:1752 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261872AbUA0CUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 21:20:50 -0500
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: New NUMA scheduler and hotplug CPU
Date: Mon, 26 Jan 2004 20:21:45 -0600
User-Agent: KMail/1.5
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20040125235431.7BC192C0FF@lists.samba.org> <200401261740.12657.habanero@us.ibm.com> <4015ABA8.3090202@cyberone.com.au>
In-Reply-To: <4015ABA8.3090202@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401262021.45885.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 January 2004 18:07, Nick Piggin wrote:
> >>Well OK, this would require a per architecture function to handle
> >>CPU hotplug. It could possibly just default to arch_init_sched_domains,
> >>and just completely reinitialise everything which would be the simplest.
> >
> >Call me crazy, but why not let the topology be determined via userspace at
> > a more appropriate time?  When you hotplug, you tell it where in the
> > scheduler to plug it.  Have structures in the scheduler which represent
> > the nodes-runqueues-cpus topology (in the past I tried a node/rq/cpu
> > structs with simple pointers), but let the topology be built based on
> > user's desires thru hotplug.
>
> Well isn't userspace's idea of topology just what the kernel tells it?
> I'm not sure what it would buy you... but I guess it wouldn't be too
> much harder than doing it in kernel, just a matter of making the userspace
> API.

Sort of, the cpus to node is pretty much what the kernel says it is, but the 
cpu to runqueue mapping IMO is not a clear cut thing.

