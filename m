Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUC3Jgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbUC3Jgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:36:49 -0500
Received: from ns.suse.de ([195.135.220.2]:3470 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263574AbUC3Jg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:36:26 -0500
Date: Tue, 30 Mar 2004 11:36:18 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: nickpiggin@yahoo.com.au, jun.nakajima@intel.com, ricklind@us.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040330113618.42869473.ak@suse.de>
In-Reply-To: <20040330081840.GA22733@elte.hu>
References: <4068066C.507@yahoo.com.au>
	<20040329080150.4b8fd8ef.ak@suse.de>
	<20040329114635.GA30093@elte.hu>
	<20040329221434.4602e062.ak@suse.de>
	<4068B692.9020307@yahoo.com.au>
	<20040330083450.368eafc6.ak@suse.de>
	<20040330064015.GA19036@elte.hu>
	<20040330090716.67d2a493.ak@suse.de>
	<20040330071519.GA20227@elte.hu>
	<20040330094811.622af0f4.ak@suse.de>
	<20040330081840.GA22733@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2004 10:18:40 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > > ok, could you try min_interval,max_interval and busy_factor all with a
> > > value as 4, in sched.h's SD_NODE_INIT template? (again, only for testing
> > > purposes.)
> > 
> > I kept the old patch and made these changes. The results are much more
> > consistent now 3+x CPU. I still get varyations of ~2GB/s, but I had
> > this with older kernels too.
> 
> great.
> 
> now, could you try the following patch, against vanilla -mm5:
> 
> 	redhat.com/~mingo/scheduler-patches/sched2.patch
> 
> this includes 'context balancing' and doesnt touch the NUMA async
> balancing tunables. Do you get better performance than with stock -mm5?

I get better performance (roughly 2.1x CPU), but only about half the optimum.

-Andi

