Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266136AbUHDOrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266136AbUHDOrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266187AbUHDOrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:47:13 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9675 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266136AbUHDOrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:47:11 -0400
Date: Wed, 4 Aug 2004 10:50:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, V Srivatsa <vatsa@in.ibm.com>,
       Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
In-Reply-To: <1091567239.28036.36.camel@biclops.private.network>
Message-ID: <Pine.LNX.4.58.0408041048350.19619@montezuma.fsmlabs.com>
References: <20040802094907.GA3945@in.ibm.com>  <20040802095741.GA4599@in.ibm.com>
  <1091475519.29556.4.camel@pants.austin.ibm.com>  <1091478386.29556.36.camel@pants.austin.ibm.com>
 <1091567239.28036.36.camel@biclops.private.network>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Nathan Lynch wrote:

>                 __setscheduler(rq->idle, SCHED_NORMAL, 0);
>                 task_rq_unlock(rq, &flags);
>                 BUG_ON(rq->nr_running != 0);
>
> I can reproduce this on both ppc64 and i386.  Does anyone know why this
> is happening?
>
> If I remove the BUG_ON, things seem to go ok, but I doubt that's the
> right thing to do.

It could have something to do with the staircase scheduler, Con, got any
wise words?

