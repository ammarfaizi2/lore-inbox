Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUHDNRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUHDNRW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 09:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUHDNRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 09:17:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:33684 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265288AbUHDNRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 09:17:16 -0400
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
From: Nathan Lynch <nathanl@austin.ibm.com>
To: vatsa@in.ibm.com
Cc: dipankar@in.ibm.com, Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       lkml <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, zwane@linuxpower.ca
In-Reply-To: <20040804100642.GA20278@in.ibm.com>
References: <20040802094907.GA3945@in.ibm.com>
	 <20040802095741.GA4599@in.ibm.com>
	 <1091475519.29556.4.camel@pants.austin.ibm.com>
	 <1091478386.29556.36.camel@pants.austin.ibm.com>
	 <1091567239.28036.36.camel@biclops.private.network>
	 <20040804100642.GA20278@in.ibm.com>
Content-Type: text/plain
Message-Id: <1091625124.9360.14.camel@biclops.private.network>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 08:12:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-04 at 05:06, Srivatsa Vaddagiri wrote:
> On Tue, Aug 03, 2004 at 04:07:20PM -0500, Nathan Lynch wrote:
> >                 BUG_ON(rq->nr_running != 0);
> > 
> > I can reproduce this on both ppc64 and i386.  Does anyone know why this
> > is happening?
> 
> I guess some task is still stuck with the dead CPU. Can you put a breakpoint on the BUG_ON 
> and see the ps output (in kdb) to see which task is that when you hit the breakpoint?

The task is always something like cc1 or sh from the build which is
running.

> 
> I will also try debugging the 2.6.8-rc2 CPU Hotplug woes as soon as I can.
> 

Well, I am seeing this with 2.6.8-rc2-mm2 -- with 2.6.8-rc2-bk13 (plus
the same patch) I cannot reproduce it; I have run the test for 12 hours
without problem.

Nathan

