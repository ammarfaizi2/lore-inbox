Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbTLLBJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 20:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbTLLBJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 20:09:24 -0500
Received: from dp.samba.org ([66.70.73.150]:45015 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264443AbTLLBJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 20:09:23 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler 
In-reply-to: Your message of "Thu, 11 Dec 2003 19:57:31 +1100."
             <3FD8317B.4060207@cyberone.com.au> 
Date: Fri, 12 Dec 2003 11:58:59 +1100
Message-Id: <20031212010922.BA8B12C15F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FD8317B.4060207@cyberone.com.au> you write:
> 
> 
> Nick Piggin wrote:
> 
> >
> > Don't ask me why it runs out of steam at 150 rooms. hackbench does
> > something similar. I think it might be due to some resource running
> > short, or a scalability problem somewhere else.
> 
> 
> OK, it is spinning on .text.lock.futex. The following results are
> top 10 profiles from a 120 rooms run and a 150 rooms run. The 150
> room run managed only 24.8% the throughput of the 120 room run.
> 
> Might this be a JVM problem?

Not if hackbench is showing it.

> I'm using Sun Java HotSpot(TM) Server VM (build 1.4.2_01-b06, mixed mode)
> 
>             ROOMS          120             150
> PROFILES
> total                   100.0%          100.0%
> default_idle             81.0%           66.8%
> .text.lock.rwsem          4.6%            1.3%
> schedule                  1.9%            1.4%
> .text.lock.futex          1.5%           19.1%

Increase FUTEX_HASHBITS?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
