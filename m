Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUC3HHX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 02:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbUC3HHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 02:07:23 -0500
Received: from ns.suse.de ([195.135.220.2]:16268 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263291AbUC3HHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 02:07:20 -0500
Date: Tue, 30 Mar 2004 09:07:16 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040330090716.67d2a493.ak@suse.de>
In-Reply-To: <20040330064015.GA19036@elte.hu>
References: <20040325162121.5942df4f.ak@suse.de>
	<20040325193913.GA14024@elte.hu>
	<20040325203032.GA15663@elte.hu>
	<20040329084531.GB29458@wotan.suse.de>
	<4068066C.507@yahoo.com.au>
	<20040329080150.4b8fd8ef.ak@suse.de>
	<20040329114635.GA30093@elte.hu>
	<20040329221434.4602e062.ak@suse.de>
	<4068B692.9020307@yahoo.com.au>
	<20040330083450.368eafc6.ak@suse.de>
	<20040330064015.GA19036@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 08:40:15 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > So both -mm5 and Ingo's sched.patch are much worse than
> > > what 2.4 and 2.6 get?
> > 
> > Yes (2.6 vanilla and 2.4-aa at that, i haven't tested 2.4-vanilla)
> > 
> > Ingo's sched.patch makes it a bit better (from 1x CPU to 1.5-1.7xCPU),
> > but still much worse than the max of 3.7x-4x CPU bandwidth.
> 
> Andi, could you please try the patch below - this will test whether this
> has to do with the rate of balancing between NUMA nodes. The patch
> itself is not correct (it way overbalances on NUMA), but it tests the
> theory.

This works much better, but wildly varying (my tests go from 2.8xCPU to 
~3.8x CPU for 4 CPUs. 2,3 CPU cases are ok). A bit more consistent 
results would be better though.

-Andi
