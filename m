Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUHXBcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUHXBcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269065AbUHXBax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:30:53 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:663 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S268132AbUHXBaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:30:15 -0400
References: <336080000.1093280286@[10.10.2.4]> <200408231431.25986.jbarnes@engr.sgi.com> <412A8EAD.3060907@cyberone.com.au>
Message-ID: <cone.1093310997.326407.10766.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Martin =?ISO-8859-1?B?Si4=?= Bligh <mbligh@aracnet.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance of -mm2 and -mm4
Date: Tue, 24 Aug 2004 11:29:57 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:

> 
> 
> Jesse Barnes wrote:
> 
>>On Monday, August 23, 2004 9:58 am, Martin J. Bligh wrote:
>>
>>>The -mm4 looks more like sched stuff to me (copy_to/from_user, etc),
>>>but the -mm2 stuff looks like something else. Buggered if I know what.
>>>-mm3 didn't compile cleanly, so I didn't bother, but I prob can if you
>>>like.
>>>
>>
>>If you suspect the scheduler, you could try bumping SD_NODES_PER_DOMAIN in 
>>kernel/sched.c to a larger value (e.g. the number of nodes in your system).  
>>That'll make the scheduler balance more aggressively across the whole system.
>>
>>
> 
> Try increasing /proc/sys/kernel/base_timeslice as well.

Or back out nicksched.patch
