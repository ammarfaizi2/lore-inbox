Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWC0S2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWC0S2l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 13:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWC0S2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 13:28:41 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:19643 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750818AbWC0S2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 13:28:41 -0500
Message-ID: <44282ECE.5040803@watson.ibm.com>
Date: Mon, 27 Mar 2006 13:28:30 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 0/9] Performance
References: <1142296834.5858.3.camel@elinux04.optonline.net> <20060314192824.GB27012@kroah.com> <4422BBD9.40901@watson.ibm.com> <20060325023808.GB6416@kroah.com>
In-Reply-To: <20060325023808.GB6416@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Thu, Mar 23, 2006 at 10:16:41AM -0500, Shailabh Nagar wrote:
>  
>
>>Greg KH wrote:
>>    
>>
>>>On Mon, Mar 13, 2006 at 07:40:34PM -0500, Shailabh Nagar wrote:
>>>
>>>      
>>>
>>>>This is the next iteration of the delay accounting patches
>>>>last posted at
>>>>	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html
>>>>        
>>>>
>>>Do you have any benchmark numbers with this patch applied and with it
>>>not applied?  Last I heard it was a measurable decrease for some
>>>"important" benchmark results...
>>>
>>>thanks,
>>>
>>>greg k-h
>>>      
>>>
>>Here are some numbers for the latest set of posted patches
>>using microbenchmarks hackbench, kernbench and lmbench.
>>
>>I was trying to get the real/big benchmark numbers too but
>>it looks like getting a run whose numbers can be trusted
>>will take a bit longer than expected. Preliminary runs of
>>transaction processing benchmarks indicate that overhead
>>actually decreases with the patch (as also seen in some of
>>the lmbench numbers below).
>>    
>>
>
>That's good to hear.
>
>But your .5% is noticable on the +patch results, which I don't think
>people who take performance issues seriously will like (that's real
>money for the big vendors.)  And distros will be forced to enable that
>option in their kernels, so those vendors will have to get that
>percentage back some other way...
>  
>

Sorry, missed your response.

Yes, even the slight deterioration might be an issue for distros. We 
discovered one memcpy,
lack of use of "__read_mostly" and another "unlikely" that might help 
with the 0.5% but other than
that don't see any major way of reducing overhead further for the +patch 
case.

I'll be posting another iteration of the patches with these changes and 
corresponding results
(as well as the changes for the netlink interface which has been 
stabilized after incorporating Jamal's
comments). Lets see what that does.

Thanks,
Shailabh

>thanks,
>
>greg k-h
>  
>

