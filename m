Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVHNEPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVHNEPt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 00:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVHNEPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 00:15:49 -0400
Received: from smtpout.mac.com ([17.250.248.84]:63732 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932448AbVHNEPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 00:15:48 -0400
In-Reply-To: <200508141018.29668.kernel@kolivas.org>
References: <20050812201946.GA5327@in.ibm.com> <200508140053.21056.kernel@kolivas.org> <20050813164618.GA4659@in.ibm.com> <200508141018.29668.kernel@kolivas.org>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6189ECD1-1CE7-4E36-B9F4-FD4D9E5871FA@mac.com>
Cc: vatsa@in.ibm.com, ck@vds.kolivas.org, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, linux-kernel Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, schwidefsky@de.ibm.com, george@mvista.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Date: Sun, 14 Aug 2005 00:15:38 -0400
To: Con Kolivas <kernel@kolivas.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 13, 2005, at 20:18:28, Con Kolivas wrote:
> It does seems there are some timing issues
> with this patch, although it is also quite stable (up for 10 hours  
> now).
> I've had a few interesting messages in my syslog suggesting problems:
> Hangcheck: hangcheck value past margin!
>
> and then later on a few of:
> set_rtc_mmss: can't update from 0 to 59

It may be a good idea to rebase this patch off the new generic time- 
keeping
subsystem that John Stultz is working on.  He's cleaned up much of  
the code
relating to system time processing, which may make it easier to get it
right when skipping ticks (IE: You probably don't need to do anything
special to replay missed ticks, the new timer code automatically  
handles it
for you).  There is an excellent LWN article on his project here:
http://lwn.net/Articles/120850/

Cheers,
Kyle Moffett

--
Simple things should be simple and complex things should be possible
   -- Alan Kay



