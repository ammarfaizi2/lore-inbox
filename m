Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVEUBMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVEUBMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 21:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVEUBMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 21:12:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34032 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261624AbVEUBMq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 21:12:46 -0400
Message-ID: <428E8AEF.9030609@mvista.com>
Date: Fri, 20 May 2005 18:12:15 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: joe.korty@ccur.com, robustmutexes@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] A more general timeout specification
References: <20050518201517.GA16193@tsunami.ccur.com> <m1hdh0yu14.fsf@muc.de> <428CC6B5.3070206@mvista.com> <20050520190550.GB57598@muc.de>
In-Reply-To: <20050520190550.GB57598@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>I think the accepted and standard way to do this is to use different 
>>"clock"s. For example, in the HRT patch the clocks CLOCK_REALTIME_HR and 
>>CLOCK_MONOTONIC_HR are defined as high resolution clocks.
> 
> 
> Note precision here can be fairly long - some timers dont even
> if they run a minute earlier or later or even longer. For others
> it can be rather small.
> 
> I dont think you want own clocks for all possible numbers. It makes
> much more sense to give a numerical time offset.

That may be, but you will have a hard time finding a standard confroming way to 
pass that info into the kernel.  A few well chosen points should do it...

>
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
