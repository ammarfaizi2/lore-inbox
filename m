Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWHRJdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWHRJdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWHRJdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:33:36 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:46211 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751323AbWHRJdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:33:35 -0400
Message-ID: <44E588AB.3050900@aitel.hist.no>
Date: Fri, 18 Aug 2006 11:30:19 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: john stultz <johnstul@us.ibm.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
References: <20060813012454.f1d52189.akpm@osdl.org> <20060817224448.GB3616@aitel.hist.no> <1155856550.31755.142.camel@cog.beaverton.ibm.com> <200608181134.02427.ak@suse.de>
In-Reply-To: <200608181134.02427.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Friday 18 August 2006 01:15, john stultz wrote:
>   
>> On Fri, 2006-08-18 at 00:44 +0200, Helge Hafting wrote:
>>     
>>> I got 2.6.18-rc4-mm1 going, and it appears that system
>>> moves at about 3x normal speed.  A software clock need 3
>>> seconds to advance 10 seconds, for example.
>>>
>>> Everything else seems faster too, the keyboard autorepeat,
>>> delay loops in games, and so on.
>>>
>>> Guess I could live with this, if it'd also compile
>>> 3x faster. :-/
>>>
>>> This is a x86-64 kernel, with the jiffies hotfix applied.
>>>       
>> Sounds like the same issue Gregorie Favre is dealing with.
>>
>> Please send full dmesg output.
>>
>> Does 2.6.18-rc4, or 2.6.18-rc3-mm2 have this issue
>>     
>
> FWIW i looked through the x86-64 patch changes between
> rc3-mm2 and rc4-mm1 and I can't find anything that would be remotely
> related to the timer.
>
> If it's confirmed to have regressed in this time it would require a binary 
> search to track down I think.
>   
I have narrowed it down.  2.6.18-rc4 does not have the 3x time
problem,  while mm1 have it.  mm1 without the hotfix jiffies
patch is just as bad.

Helge Hafting
