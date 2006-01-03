Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWACOKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWACOKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWACOKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:10:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:5573 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751429AbWACOKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:10:16 -0500
Date: Tue, 3 Jan 2006 19:41:01 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>, vatsa@in.ibm.com
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20060103141101.GC5075@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <1135991732.31111.57.camel@mindpipe> <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org> <1136001615.3050.5.camel@mindpipe> <20051231042902.GA3428@us.ibm.com> <1136004855.3050.8.camel@mindpipe> <20051231201426.GD5124@us.ibm.com> <1136094372.7005.19.camel@mindpipe> <Pine.LNX.4.64.0601011047320.3668@g5.osdl.org> <20060103111211.GA5075@in.ibm.com> <Pine.LNX.4.62.0601030524570.30559@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0601030524570.30559@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 05:28:15AM -0800, David Lang wrote:
> On Tue, 3 Jan 2006, Dipankar Sarma wrote:
> 
> >I do agree that the two layers of batching really makes things
> >subtle. I think the best we can do is to figure out some way of
> >automatic throttling in RCU and forced quiescent state under extreme
> >conditions. That way we will have less dependency on softirq
> >throttling.
> 
> would it make sense to have the RCU subsystems with a threshold so that 
> when more then X items are outstanding they trigger a premption of all 
> other CPU's ASAP (forceing the scheduling break needed to make progress on 
> clearing RCU)? This wouldn't work in all cases, but it could significantly 
> reduce the problem situations.

Yes, I think it would make sense to try something like that. See Paul's earlier
mail in this thread for an example code snippet.

Thanks
Dipankar
