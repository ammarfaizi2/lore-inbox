Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264506AbRFSRl4>; Tue, 19 Jun 2001 13:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264502AbRFSRlq>; Tue, 19 Jun 2001 13:41:46 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:7975
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S264487AbRFSRld>; Tue, 19 Jun 2001 13:41:33 -0400
Date: Tue, 19 Jun 2001 10:41:32 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Message-ID: <20010619104132.X3089@work.bitmover.com>
Mail-Followup-To: Jonathan Lundell <jlundell@pobox.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0106190940420.28643-100000@gene.pbi.nrc.ca> <3B2F769C.DCDB790E@kegel.com> <20010619090956.R3089@work.bitmover.com> <p05100302b7553d481172@[10.128.7.49]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <p05100302b7553d481172@[10.128.7.49]>; from jlundell@pobox.com on Tue, Jun 19, 2001 at 10:36:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 10:36:00AM -0700, Jonathan Lundell wrote:
> At 9:09 AM -0700 2001-06-19, Larry McVoy wrote:
> >Don't you think it is funny that Sun doesn't publish numbers comparing
> >their thread performance to process performance?  Sure, you can find
> >context switch benchmarks where they have user level switching going on
> >but those are a red herring.  The real numbers you want are the kernel
> >level context switches and those are just as expensive as the process
> >context switch numbers.
> 
> Sun (or at least SPARC) is a bit of a special case, though. SPARC's 
> register-window architecture makes thread-switching (not to mention 
> recursion) significantly more expensive than on most other 
> architectures.

Yes, but that misses the point.  The point is that you have to do the same
work, almost, to switch a kernel thread as a process.  You don't have to
switch the VM context but that isn't the dominating term.  So the fact that
Sun has slow[er] context switching and slow[er] thread switching isn't the
issue.  The issue is that people perceive threads to be cheap but they are
not cheap at all.  It's the relative cheapness, or lack thereof, when 
comparing them to processes.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
