Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUEXBwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUEXBwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUEXBwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:52:39 -0400
Received: from web90003.mail.scd.yahoo.com ([66.218.94.61]:7511 "HELO
	web90003.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S263818AbUEXBvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:51:53 -0400
Message-ID: <20040524015153.32010.qmail@web90003.mail.scd.yahoo.com>
Date: Sun, 23 May 2004 18:51:53 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: Help understanding slow down
To: William Lee Irwin III <wli@holomorphy.com>,
       Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040524012828.GK1833@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so ran the test with vmstat running.  I ran it
capturing every 1 sec.  Here is an excert:

procs                      memory      swap         
io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi   
bo   in    cs us sy id wa
 1  0      0 8153848  17000  82348    0    0     0    
0 4568  4028  6 16 78  0
 0  1      0 8154168  17008  82340    0    0     0  
160 4596  4079  7 17 76  1
 1  0      0 8153848  17008  82340    0    0     0    
0 4511  3998  7 16 76  0
 1  0      0 8153912  17008  82340    0    0     0    
0 4460  3952  7 14 79  0
 1  0      0 8153784  17016  82332    0    0     0    
0 4437  3962  7 16 77  0
 1  0      0 8153528  17016  82332    0    0     0    
0 4444  3927  7 14 78  0
 1  1      0 8153784  17024  82392    0    0     0  
144 4399  3895  7 15 77  1
 0  0      0 8153592  17024  82392    0    0     0    
0 4367  3821  7 15 78  0
 1  0      0 8153848  17024  82392    0    0     0    
0 4393  3926  6 16 78  0
 1  0      0 8153528  17024  82460    0    0     0    
0 4438  3960  8 14 78  0
 1  0      0 8154040  17024  82460    0    0     0    
0 4415  3912  6 15 78  0
 1  1      0 8153720  17032  82452    0    0     0  
140 4457  3953  7 15 77  1
 1  0      0 8153784  17032  82452    0    0     0    
0 4437  3889  7 14 79  0
 0  0      0 8153784  17040  82444    0    0     0    
0 4398  3903  8 15 77  0
 1  0      0 8153464  17040  82444    0    0     0    
0 4398  3902  7 14 79  0
 0  0      0 8153528  17040  82444    0    0     0    
0 4447  3922  6 17 77  0
 0  1      0 8153720  17052  82432    0    0     0  
144 4490  3960  6 16 77  1
 0  0      0 8153656  17056  82428    0    0     0    
0 4449  3954  7 15 78  0


--- William Lee Irwin III <wli@holomorphy.com> wrote:
> On Mon, May 24, 2004 at 03:25:53AM +0200, Jakob
> Oestergaard wrote:
> > Eh, not if I read the numbers right:
> > 2.6.7-p1: 24.86user 51.77system 2:58.87elapsed
> 42%CPU
> > 24.86 + 51.77 = 76.63 seconds on CPU, 102.24
> seconds of waiting
> > 2.4.21: 28.68user 34.98system 1:12.34elapsed
> 87%CPU
> > 28.68 + 34.98 = 63.66 seconds on CPU, 8.68 seconds
> of waiting
> > So, 2.6.7-p1 spends 16.79 seconds more in the
> kernel as you observed,
> > but it spends 93.56 seconds more waiting for I/O
> (or whatever).
> > Unless I'm totally missing something, the wait
> seems to be the
> > regression.
> 
> I'm sorry, you're right. Let's start by looking into
> IO activity.
> Phy, could you log the output of vmstat(1) during
> the runs?
> 
> 
> -- wli
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains – Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
