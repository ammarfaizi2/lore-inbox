Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVFJHrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVFJHrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 03:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVFJHrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 03:47:04 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:2019 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S262510AbVFJHqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 03:46:43 -0400
Date: Fri, 10 Jun 2005 09:46:38 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Milan Svoboda <milan.svoboda@centrum.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in Real-Time Preemption
In-Reply-To: <200506100918.3335@centrum.cz>
Message-Id: <Pine.OSF.4.05.10506100943340.5132-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005, Milan Svoboda wrote:

> >  I tried to your program: I couldn't make it fail under PREEMPT_RT. No
> > matter what the termination value for the while loop in the priority 10
> > thread I put in the priority 50 thread printed the same "Dif:".
> > I also put in a global variable, thread_done, which I set in the priority
> > 10 thread after the loop and printed it out along with "Dif:". It was not
> > set. I also tried to add exit(1) at the end of the priority 10 thread...
> > 
> > I see no odd behaviour.
> > 
> > Esben
> > 
> 
> Look at my results:
> 
> I added a flag too.
> 
> under non RT preempt:
> (these results are expected)
> 
> ./a.out
> Flag: 0, Dif:11714
> ./a.out
> Flag: 0, Dif:11678
>
(Flag:0 means the counting thread haven't finished, right?)

This is what I see on PREEMPT_RT 2.6.12-rc6-V0.7.48-04.

> under full RT preempt:
> ./a.out
> Flag: 1, Dif:582536
> ./a.out
> Flag: 1, Dif:579791
> 
> This shows that thread with bigger priority was
> blocked by the thread with lower priority!
> 

Yes. Odd. Tried on V0.7.48-04 ?

Esben

