Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFJVJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFJVJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 17:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFJVJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 17:09:50 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:31448 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261236AbVFJVJI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 17:09:08 -0400
Date: Fri, 10 Jun 2005 23:09:00 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: hackbench: 2.6.12-rc6 vs.  2.6.12-rc6-RT-V0.7.48-06
In-Reply-To: <1118436975.1702.11.camel@alderaan.trey.hu>
Message-Id: <Pine.OSF.4.05.10506102306360.5042-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jun 2005, Gabor MICSKO wrote:

> Hi!
> 
> I made some test with 2.6.12-rc6-RT-V0.7.48-06 and 2.6.12-rc6 kernels.
> Here is my results:
> 
> 2.6.12-rc6-RT-V0.7.48-0			       2.6.12-rc6
> ------------------------------------			    ----------------	
> 
> ./hackbench 30
> 
> 1st run:  6.139					    5.110	
> 2nd run: 6.119					   4.946
> 3rd run: 6.135					    5.168
> 
> ./hackbench 100
> 
> 1st run:  23.254				   16.603	
> 2nd run: 23.481					  16.478
> 3rd run:  23.790				   16.387
> 
> ./hackbench 130
> 
> 1st run:  33.395				   21.731	
> 2nd run: 32.652					  21.821
> 3rd run:  32.517				   21.698
> 
> ./hackbench 150
> 
> 1st run:  89.100				   47.862	
> 2nd run: 39.308					  25.121
> 3rd run:  90.157				   25.125
> 
> It seems to me 2.6.12-rc faster than 2.6.12-rc6-RT-V0.7.48-0. It is
> normal? 

Depends on the configuration options. If you used the same configs they 
should be the same but if you activated PREEMPT_RT it should slow things
down due to the overhead of irq-threading and  mutexes instead of
spinlocks - although I am surprised the factor is _that_ big!

Esben

> 
> thanks,
> 
> -
> mg
> 

