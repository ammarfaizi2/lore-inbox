Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSGZH5t>; Fri, 26 Jul 2002 03:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSGZH5t>; Fri, 26 Jul 2002 03:57:49 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:20461 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317354AbSGZH5t>;
	Fri, 26 Jul 2002 03:57:49 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kiran <geekazoid@phreaker.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Patch 2.5.25: Ensure xtime_lock and timerlist_lock are on difft cachelines 
In-reply-to: Your message of "Fri, 26 Jul 2002 12:56:05 +0530."
             <20020726125605.A2822@phreaker.net> 
Date: Fri, 26 Jul 2002 17:56:19 +1000
Message-Id: <20020726080211.3E71E4824@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020726125605.A2822@phreaker.net> you write:
> This patch was not meant to be a definitive fix for do_gettimeofday.
> I thought having diffrent locks  on the same cacheline was bad. Atleast, 
> I don't think there'd be any negative performance impact due to my patch.  
> Pls correct me if I am wrong. 

Did you ever wonder why we don't declare spinlock to be ____cacheline_aligned?
While it's probably justified in this case, you pay for it in a slight
increase in size...

> I want to get some nos too .. and probably will...(still waiting for my 
> turn to use the 4way here :-) ).  But, I decided to post this patch 
> as a follow up to the 2.5 profiler discussion on lse-tech.  
> Anywayz, point taken. Next time I submit an optimization patch to you,
> I'll post the measuements too.

Sure!

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
