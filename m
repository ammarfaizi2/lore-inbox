Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271642AbRH0C7o>; Sun, 26 Aug 2001 22:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271643AbRH0C7e>; Sun, 26 Aug 2001 22:59:34 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54800 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271642AbRH0C7X>; Sun, 26 Aug 2001 22:59:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: Updated Linux kernel preemption patches
Date: Mon, 27 Aug 2001 05:06:18 +0200
X-Mailer: KMail [version 1.3.1]
Cc: nigel@nrg.org
In-Reply-To: <998877465.801.19.camel@phantasy>
In-Reply-To: <998877465.801.19.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827025934Z16098-32383+1547@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 03:57 am, Robert Love wrote:
> This is a straight update of Nigel Gamble's Linux kernel preemption
> patch from http://kpreempt.sourceforge.net, updated for the above
> kernels.  Thus, this is Nigel's code -- I merely updated it.
> [...]
> The performance increase in kernel compile and dbench 16 is decent, but
> the decrease in dbench 1 is odd.  I am curious what numbers others find.
> My "how does it feel" benchmark is that bandwidth seems similar while
> multitasking may be a tad smoother with the patch.

Congratulations on showing evidence that preemption can improve performance 
under some loads, especially the all-important kernel compile.  Don't be too 
worried about the dbench 1 results, dbench can vary by a factor of 2 
depending on the alignment of the planets (ask Tridge).  Try something more 
stable like bonnie.

The theory goes that preemption improves performance by cutting down the time 
between IO completion and user task resume, with only a small cost in extra 
locking.  It would be nice to see profiling statistics to support this idea.

--
Daniel
