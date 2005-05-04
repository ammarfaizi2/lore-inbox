Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVEDIXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVEDIXn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 04:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVEDIXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 04:23:43 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8632 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261309AbVEDIXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 04:23:40 -0400
Date: Wed, 4 May 2005 10:22:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
Message-ID: <20050504082241.GA13380@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu> <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu> <20050421073537.GA1004@elte.hu> <20050422062714.GA23667@elte.hu> <1114903693.12664.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114903693.12664.9.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Fri, 2005-04-22 at 08:27 +0200, Ingo Molnar wrote:
> > i have released the -V0.7.46-01 Real-Time Preemption patch, which can be 
> > downloaded from the usual place:
> > 
> >     http://redhat.com/~mingo/realtime-preempt/
> 
> Ingo,
> 
> With Mingming's patch to resolve the ext3 allocate-with-reservation 
> latency, it looks like we are finally getting close to the lower limit 
> that can be achieved with PREEMPT_DESKTOP.  I've attached the trace of 
> the lowest latency over several days of testing with 
> 2.6.12-rc3-RT-V0.7.46-02 + Mingming's patch.  It's only 127 usecs, and 
> IIRC you mentioned previously that this code path can't be made 
> preemptible in !PREEMPT_RT.

yeah, signal delivery will have to stay atomic in !PREEMPT_RT kernels.

> Since Mingming's patch will have to live in -mm for a while, can it be 
> added to the RT patchset as well?

i think so - i'll add it to the next patch.

	Ingo

