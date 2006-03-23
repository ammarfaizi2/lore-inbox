Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWCWDOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWCWDOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCWDOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:14:07 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:19109 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751036AbWCWDOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:14:03 -0500
Subject: Re: 2.6.16-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <442176EB.1050403@cybsft.com>
References: <20060320085137.GA29554@elte.hu> <441F8017.4040302@cybsft.com>
	 <20060321211653.GA3090@elte.hu> <4420B5F0.6000201@cybsft.com>
	 <20060322062932.GA17166@elte.hu> <44215CCB.1080005@cybsft.com>
	 <442176EB.1050403@cybsft.com>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 22:13:53 -0500
Message-Id: <1143083633.32192.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 10:10 -0600, K.R. Foley wrote:
> K.R. Foley wrote:
> > Ingo Molnar wrote:
> >> * K.R. Foley <kr@cybsft.com> wrote:
> >>
> >>> Sorry I have been onsite and completely buried today. Am running an 
> >>> initial test on both UP and SMP now with 2.6.16-rt1. UP doesn't look 
> >>> bad at all. SMP on the other hand doesn't look so good. I will give 
> >>> -rt4 a spin when these are done.
> >> thanks for the testing - i'll check SMP too.
> >>
> >> 	Ingo
> >>
> > OK. On my dual 933 under heavy load I get the following with 2.6.16-rt4
> > and I get tons of missed interrupts. Running 2.6.15-rc16 I get a max of
> > 88usec with most falling under 30usec. On my UP AthlonXP 1700 I get a
> > max of 19usec with 2.6.16-rt4 under load. What sort of results do you
> > see on SMP?
> > 
> 
> Found something interesting. Having Wakeup latency timing turned on
> makes a HUGE difference. I turned it off and recompiled and now I am
> seeing numbers back in line with what I expected from 2.6.16-rt4. Sorry,
> but I had no idea it would make that much difference. I don't have a
> complete run yet, but I have seen enough to know that I am not seeing
> tons of missed interrupts and the highest reported latency thus far is
> 61 usec.

Hmm, high wake up latency on SMP and not on UP...

Ingo, could this be due to the migrate task latency?  This was where I
saw the problem with the 50ms latency running hack bench.  I remember
there was a bug in the older latency tool that didn't catch this latency
before.

I'm just getting back to looking at the latest stuff.  I had some
customer deliveries lately and haven't had time to look at the new
goodies.

-- Steve


