Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRCGAkn>; Tue, 6 Mar 2001 19:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRCGAkd>; Tue, 6 Mar 2001 19:40:33 -0500
Received: from mail.valinux.com ([198.186.202.175]:32261 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129764AbRCGAk0>;
	Tue, 6 Mar 2001 19:40:26 -0500
Date: Tue, 6 Mar 2001 16:40:00 -0800
To: Ying Chen <yingchenb@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20010306164000.A28219@valinux.com>
In-Reply-To: <F41oVQAiEGKROptzzpY000014a6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F41oVQAiEGKROptzzpY000014a6@hotmail.com>; from yingchenb@hotmail.com on Tue, Mar 06, 2001 at 03:55:55PM -0800
From: Don Dugger <n0ano@valinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ying-

I'm a little confused here.  It's very hard to compare a UP application
vs. the same app. converted to use threads.  Unless the app. is
structured such that multiple threads can run at the same time then
no, you won't see any improvement by going to SMP, in fact a true
single threaded app. will frequently slow down when run on an SMP
kernel.

Have you watched a CPU meter while your benchmark runs?  Even something
basic like `top' should give you a feel for whether or not your
using all of the CPU's.


On Tue, Mar 06, 2001 at 03:55:55PM -0800, Ying Chen wrote:
> Hi,
> 
> I have two questions on Linux pthread related issues. Would anyone be able 
> to help?
> 
> ...
>
> 2. We ran multi-threaded application using Linux pthread library on 2-way 
> SMP and UP intel platforms (with both 2.2 and 2.4 kernels). We see 
> significant increase in context switching when moving from UP to SMP, and 
> high CPU usage with no performance gain in turns of actual work being done 
> when moving to SMP, despite the fact the benchmark we are running is 
> CPU-bound. The kernel profiler indicates that the a lot of kernel CPU ticks 
> went to scheduling and signaling overheads. Has anyone seen something like 
> this before with pthread applications running on SMP platforms? Any 
> suggestions or pointers on this subject?
> 
> Thanks a lot!
> 
> Ying
> 
> 
> 
> _________________________________________________________________
> Get your FREE download of MSN Explorer at http://explorer.msn.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838
