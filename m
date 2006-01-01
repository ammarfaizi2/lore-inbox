Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWAATGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWAATGv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 14:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWAATGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 14:06:51 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53182 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932243AbWAATGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 14:06:50 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Eric Dumazet <dada1@cosmosbay.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, vatsa@in.ibm.com
In-Reply-To: <1136142127.13079.51.camel@mindpipe>
References: <20051229202848.GC29546@elte.hu>
	 <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu>
	 <1135990270.31111.46.camel@mindpipe>
	 <Pine.LNX.4.64.0512301701320.3249@g5.osdl.org>
	 <1135991732.31111.57.camel@mindpipe>
	 <Pine.LNX.4.64.0512301726190.3249@g5.osdl.org>
	 <1136001615.3050.5.camel@mindpipe> <20051231042902.GA3428@us.ibm.com>
	 <1136004855.3050.8.camel@mindpipe>  <20051231201426.GD5124@us.ibm.com>
	 <1136094372.7005.19.camel@mindpipe>
	 <Pine.LNX.4.64.0601011047320.3668@g5.osdl.org>
	 <1136142127.13079.51.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 01 Jan 2006 14:06:47 -0500
Message-Id: <1136142408.13079.53.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-01 at 14:02 -0500, Lee Revell wrote:
> On Sun, 2006-01-01 at 10:56 -0800, Linus Torvalds wrote:
> > The thing is, "maxbatch" doesn't actually _work_ because what happens
> > is that the tasklet will continually re-schedule itself, and the
> > caller will keep calling it. So maxbatch is actually broken.
> > 
> > However, what happens is that after kernel/softirq.c has called the 
> > tasklet ten times, and it is still pending, it will do the softirq in
> > a thread (see the "max_restart" logic). 
> 
> Ah OK thanks for the explanation.  I'll try Paul's patch (yours did not
> seem to help).
> 

s/try Paul's patch/set maxbatch to 10/



