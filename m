Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVKOAim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVKOAim (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVKOAim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:38:42 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:8427 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S932217AbVKOAil
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:38:41 -0500
Message-ID: <43792DFF.1000300@mvista.com>
Date: Mon, 14 Nov 2005 16:38:23 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Andi Kleen <ak@suse.de>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 13/39] NLKD/x86-64 - time adjustment
References: <43720DAE.76F0.0078.0@novell.com> <200511110312.15616.ak@suse.de> <20051112092200.GA7997@midnight.suse.cz> <200511121821.11552.ak@suse.de> <20051112204428.GA14733@midnight.suse.cz>
In-Reply-To: <20051112204428.GA14733@midnight.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> On Sat, Nov 12, 2005 at 06:21:11PM +0100, Andi Kleen wrote:
> 
>>On Saturday 12 November 2005 10:22, Vojtech Pavlik wrote:
>>
>>
>>>Is there any advantage to using 64-bit HPET? 
>>
>>Yes - it can tolerate long delays between ticks, e.g. caused by noidletick / 
>>debuggers / target probes / smm etc. At least the first case will be fairly
>>important soon.
> 
> 
> A 32-bit 14 MHz HPET counter will overflow in approximately 5 minutes. I
> don't think going 64-bit makes sense for noidletick, but for debuggers,
> etc, it could make a good sense indeed.
> 
> 
>>>It's read is even slower 
>>
>>Why? The read should be on cache line granuality and there shouldn't
>>be any difference in theory.
> 
>  
> I'll try to measure this. Indeed, in theory there shouldn't be a
> significant difference.
> 
Doesn't this depend on the atomic nature of the 64-bit read?  If it is really two 32-bit reads one 
would need to do extra work to make sure the two parts belong together.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
