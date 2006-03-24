Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWCXPHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWCXPHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 10:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWCXPHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 10:07:00 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:51351 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750910AbWCXPG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 10:06:59 -0500
Message-ID: <44240B04.3050909@aitel.hist.no>
Date: Fri, 24 Mar 2006 16:06:44 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, bob.picco@hp.com,
       iwamoto@valinux.co.jp, christoph@lameter.com, wfg@mail.ustc.edu.cn,
       npiggin@suse.de, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
References: <20060322223107.12658.14997.sendpatchset@twins.localnet> <20060322145132.0886f742.akpm@osdl.org> <20060323205324.GA11676@dmt.cnet> <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603231003390.26286@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Thu, 23 Mar 2006, Marcelo Tosatti wrote:
>  
>
>>IMHO the page replacement framework intent is wider than fixing the     
>>currently known performance problems.
>>
>>It allows easier implementation of new algorithms, which are being
>>invented/adapted over time as necessity appears.
>>    
>>
>
>Yes and no.
>
>It smells wonderful for a pluggable page replacement standpoint, but 
>here's a couple of observations/questions:
> a) the current one actually seems to have beaten the on-comers (except 
>    for loads that were actually made up to try to defeat LRU)
> b) is page replacement actually a huge issue?
>
>Now, the reason I ask about (b) is that these days, you buy a Mac Mini, 
>and it comes with half a gig of RAM, and some apple users seem to worry 
>about the fact that the UMA graphics removes 50MB or something of that is 
>a problem.
>
>IOW, just under half a _gigabyte_ of RAM is apparently considered to be 
>low end, and this is when talking about low-end (modern) hardware!
>
>And don't tell me that the high-end people care, because both databases 
>(high end commercial) and video/graphics editing (high end desktop) very 
>much do _not_ care, since they tend to try to do their own memory 
>management anyway.
>
>  
>
>>One example (which I mentioned several times) is power saving:
>>
>>PB-LRU: A Self-Tuning Power Aware Storage Cache Replacement Algorithm
>>for Conserving Disk Energy.
>>    
>>
>
>Please name a load that really actually hits the page replacement today.
>  
>
Any load where things goes into swap?
Sure - I have 512MB in my machines, I still tend to
get 20-50 MB in swap after a while.  And now and then
I wait for stuff to swap in again.

I don't claim the current system is bad, and a more gradual
appraoach may very well be the better way.  But if someone can
demonstrate an improvement, then I'm for it.  Getting an
improved selection for the 50M in swap will be noticeable at times.

Remember, people compensate the bigger memory with bigger apps.
Linux should run those apps well. ;-)

>It smells like university research to me.
>
>And don't flame me: I'm perfectly happy to be shown to be wrong. I just 
>get a very strong feeling that the people who care about tight memory 
>conditions and perhaps about page replacement are the same people who 
>think that our kernel is too big - the embedded people. 
>  
>
Well, how about desktop users?  Snappyness is a nice thing.
The "enough memory" argument can be turned around too. 
If the power users don't care because they have the memory - then
they shouldn't worry about someone changing the replacement
algorithms. :-)

>What I'm trying to say is that page replacement hasn't been what seems to 
>have worried people over the last year or two. We had some ugly problems 
>in the early 2.4.x timeframe, and I'll claim that most (but not all) of 
>those were related to highmem/zoning issues which we largely solved. Which 
>was about page replacement, but really a very specific issue within that 
>area.
>
>So seriously, I suspect Andrew's "Holy cow" comes from the fact that he is 
>more worried about VM maintainability and stability than page replacement. 
>I certainly am.
>  
>
Sure, the incremental approach is good, and this replaceable
system may be a thing for interested VM developers.
But there is definitely interest if they can show improvement.

Helge Hafting

