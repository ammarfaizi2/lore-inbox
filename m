Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263187AbTCTB06>; Wed, 19 Mar 2003 20:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263195AbTCTB06>; Wed, 19 Mar 2003 20:26:58 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:8599 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S263187AbTCTB04>;
	Wed, 19 Mar 2003 20:26:56 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [BENCHMARK] 2.5.65-mm2 with contest
Date: Thu, 20 Mar 2003 12:37:50 +1100
User-Agent: KMail/1.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
References: <200303201016.54818.kernel@kolivas.org> <3E791241.3070700@cyberone.com.au>
In-Reply-To: <3E791241.3070700@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303201237.50702.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Mar 2003 11:58, Nick Piggin wrote:
> Con Kolivas wrote:
> >Contest results for mm2:
>
> Contest is starting to look good. Especially in
> loads and lcpu.

Very good point. Some of the loads are exhibiting better overall cpu usage and 
dropping the compile time (tar loads are a good example)

> >no_load:
> >Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> >2.5.65              3   80      95.0    0.0     0.0     1.00
> >2.5.65-mm1          3   79      94.9    0.0     0.0     1.00
> >2.5.65-mm2          3   79      94.9    0.0     0.0     1.00
>
> AS is now on par with deadline here which is nice.

Excellent.

> [snip]
>
> >dbench_load:
> >Kernel         [runs]   Time    CPU%    Loads   LCPU%   Ratio
> >2.5.65              3   542     14.2    9.0     62.5    6.78
> >2.5.65-mm1          3   361     21.1    6.3     55.4    4.57
> >2.5.65-mm2          3   437     17.4    7.7     60.6    5.53
>
> I don't know if this is a good balance shift or not. Maybe not
> related to AS but I'll investigate.

I dont think there are other tweaks in mm2 that could be responsible. It's 
extremely hard to know what exactly is the best balance in this load. If 
dbench 16 should get 80% of the total cpu usage (since the kernel compile has 
4 processes) then mm2 is very close at 78%. However I didnt think dbench was 
supposed to be a particularly cpu bound task. The overall cpu usage is higher 
which is good though.

> Thanks Con

A pleasure,
Con
