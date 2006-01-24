Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWAXID4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWAXID4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWAXID4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:03:56 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:49130 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030231AbWAXIDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:03:55 -0500
Subject: Re: RCU latency regression in 2.6.16-rc1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20060124080157.GA25855@elte.hu>
References: <1138089139.2771.78.camel@mindpipe>
	 <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe>
	 <20060124080157.GA25855@elte.hu>
Content-Type: text/plain
Date: Tue, 24 Jan 2006 03:03:53 -0500
Message-Id: <1138089833.2771.86.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-24 at 09:01 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Tue, 2006-01-24 at 08:56 +0100, Ingo Molnar wrote:
> > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > > 
> > > > I ported the latency tracer to 2.6.16 and got this 13ms latency within 
> > > > a few hours.  This is a regression from 2.6.15.
> > > > 
> > > > It appears that RCU can invoke ipv4_dst_destroy thousands of times in 
> > > > a single batch.
> > > 
> > > could you try the PREEMPT_RCU patch below?
> > 
> > Sure.  If it works do you see this making it in 2.6.16?  Otherwise we 
> > still would have a regression...
> 
> nope, that likely wont make v2.6.16, which is frozen already.
> 

Well, the last latency regression I found, I was told "I wish you'd
caught this at 2.6.15-rc1, something could have been done".  Now I've
found another one at the -rc1 stage, and there's still nothing that can
be done?

Lee

