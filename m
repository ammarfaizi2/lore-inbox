Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWJWQDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWJWQDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWJWQDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:03:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51425 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751946AbWJWQDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:03:44 -0400
Date: Mon, 23 Oct 2006 09:03:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Paul Jackson <pj@sgi.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       mbligh@google.com, akpm@osdl.org, menage@google.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
In-Reply-To: <453C5AF4.8070707@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610230901470.27654@schroedinger.engr.sgi.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
 <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com>
 <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com>
 <20061022035135.2c450147.pj@sgi.com> <20061022222652.B2526@unix-os.sc.intel.com>
 <20061022225456.6adfd0be.pj@sgi.com> <453C5AF4.8070707@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006, Nick Piggin wrote:

> It is somewhat improved. The load balancing will now retry other CPUs,
> but this is pretty costly in terms of latency and rq lock hold time.
> And the algorithm itself still breaks down if you have lots of pinned
> tasks, even if the load balancer is willing to try lesser loaded cpus.

We would need to have a way of traversing the processors by load in order 
to avoid it. John Hawkes solves that issue earlier in 2.4.X by managing a 
list of processors according to their load.


