Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUEXGXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUEXGXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUEXGXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:23:41 -0400
Received: from web90007.mail.scd.yahoo.com ([66.218.94.65]:33386 "HELO
	web90007.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264012AbUEXGXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:23:38 -0400
Message-ID: <20040524062337.97797.qmail@web90007.mail.scd.yahoo.com>
Date: Sun, 23 May 2004 23:23:37 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Help understanding slow down
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, jakob@unthought.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040523194352.4468da09.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply.   No this is a dual Xeon
3.06Ghz.  All runs are with the same hardware and same
make/build system.

How do I generate a profile of the system.  I have
alrady compiled profiling and have enabled the kernel.

Thanks,
Phy
--- Andrew Morton <akpm@osdl.org> wrote:
> Phy Prabab <phyprabab@yahoo.com> wrote:
> >
> > Okay, so ran the test with vmstat running.  I ran
> it
> >  capturing every 1 sec.  Here is an excert:
> 
> That was horridly wordwrapped.
> 
> procs                      memory      swap        
> io     system         cpu
>  r  b   swpd   free   buff  cache   si   so    bi  
> bo   in    cs us sy id wa
>  1  0      0 8153848  17000  82348    0    0     0  
>  0 4568  4028  6 16 78  0
>  0  1      0 8154168  17008  82340    0    0     0 
> 160 4596  4079  7 17 76  1
>  1  0      0 8153848  17008  82340    0    0     0  
>  0 4511  3998  7 16 76  0
>  1  0      0 8153912  17008  82340    0    0     0  
>  0 4460  3952  7 14 79  0
>  1  0      0 8153784  17016  82332    0    0     0  
>  0 4437  3962  7 16 77  0
>  1  0      0 8153528  17016  82332    0    0     0  
>  0 4444  3927  7 14 78  0
>  1  1      0 8153784  17024  82392    0    0     0 
> 144 4399  3895  7 15 77  1
>  0  0      0 8153592  17024  82392    0    0     0  
>  0 4367  3821  7 15 78  0
>  1  0      0 8153848  17024  82392    0    0     0  
>  0 4393  3926  6 16 78  0
>  1  0      0 8153528  17024  82460    0    0     0  
>  0 4438  3960  8 14 78  0
>  1  0      0 8154040  17024  82460    0    0     0  
>  0 4415  3912  6 15 78  0
>  1  1      0 8153720  17032  82452    0    0     0 
> 140 4457  3953  7 15 77  1
>  1  0      0 8153784  17032  82452    0    0     0  
>  0 4437  3889  7 14 79  0
>  0  0      0 8153784  17040  82444    0    0     0  
>  0 4398  3903  8 15 77  0
>  1  0      0 8153464  17040  82444    0    0     0  
>  0 4398  3902  7 14 79  0
>  0  0      0 8153528  17040  82444    0    0     0  
>  0 4447  3922  6 17 77  0
>  0  1      0 8153720  17052  82432    0    0     0 
> 144 4490  3960  6 16 77  1
>  0  0      0 8153656  17056  82428    0    0     0  
>  0 4449  3954  7 15 78  0
> 
> This is a single-CPU machine, yes?
> 
> Your application is spending most of the time in an
> explicit sleep of some
> form.  Suggest you run strace against it and see
> what it's up to.


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
