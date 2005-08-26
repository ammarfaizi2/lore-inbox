Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVHZTQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVHZTQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVHZTQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:16:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38382 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1030206AbVHZTQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:16:28 -0400
Message-ID: <430F6A7E.203@mvista.com>
Date: Fri, 26 Aug 2005 12:16:14 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@hp.com>
CC: Christoph Lameter <clameter@engr.sgi.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Need better is_better_time_interpolator() algorithm
References: <1124988269.5331.49.camel@tdi>	 <1124991406.20820.188.camel@cog.beaverton.ibm.com>	 <1124995405.5331.90.camel@tdi>	 <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com> <1125073089.5182.30.camel@tdi>
In-Reply-To: <1125073089.5182.30.camel@tdi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Williamson wrote:
> On Fri, 2005-08-26 at 08:39 -0700, Christoph Lameter wrote:
> 
> 
>>I think a priority is something useful for the interpolators. Some of 
>>the decisions about which time sources to use also have criteria different 
>>from drift/latency/jitter/cpu. F.e. timers may not survive various 
>>power-saving configurations. Thus I would think that we need a priority 
>>plus some flags.
>>
>>Some of the criteria for choosing a time source may be:
> 
> 
> Hi Christoph,
> 
>    I sent another followup to this thread with a patch containing a
> fairly crude algorithm that I think better explains my starting point.
> I'm sure the weighting and scaling factors need work, but I think many
> of the criteria you describe will favor the right clock.
> 
> 
>>1. If a system boots up with a single cpu then there is no question that 
>>the ITC/TSC should be used because of the fast access.

We need to factor in frequency shifting here, especially if it happens 
with out notice.


~
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
