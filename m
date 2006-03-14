Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWCNV7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWCNV7z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 16:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbWCNV7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 16:59:55 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:12732 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S964780AbWCNV7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 16:59:53 -0500
Message-ID: <44173CD7.20200@watson.ibm.com>
Date: Tue, 14 Mar 2006 16:59:51 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 0/9] Per-task delay accounting
References: <1142296834.5858.3.camel@elinux04.optonline.net> <20060314192824.GB27012@kroah.com> <44172C4C.3020107@watson.ibm.com> <20060314212414.GA22202@kroah.com>
In-Reply-To: <20060314212414.GA22202@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Mar 14, 2006 at 03:49:16PM -0500, Shailabh Nagar wrote:
>  
>
>>Greg KH wrote:
>>
>>    
>>
>>>On Mon, Mar 13, 2006 at 07:40:34PM -0500, Shailabh Nagar wrote:
>>>
>>>
>>>      
>>>
>>>>This is the next iteration of the delay accounting patches
>>>>last posted at
>>>>	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html
>>>>  
>>>>
>>>>        
>>>>
>>>Do you have any benchmark numbers with this patch applied and with it
>>>not applied? 
>>>
>>>      
>>>
>>None yet. Wanted to iron out the collection/utility aspects a bit before 
>>going into
>>the performance impact.
>>
>>But this seems as good a time as any to collect some stats
>>using the usual suspects lmbench, kernbench, hackbench etc.
>>
>>    
>>
>>>Last I heard it was a measurable decrease for some
>>>"important" benchmark results...
>>>
>>>
>>>      
>>>
>>Might have been from an older iteration where schedstats was fully enabled.
>>But no point speculating....will run with this set of patches and see 
>>what shakes out.
>>
>>One point about the overhead is that it depends on the frequency with 
>>which data is
>>collected. So a proper test would probably be a comparison of a 
>>non-patched kernel
>>with
>>a) patches applied but delay accounting not turned on at boot i.e. cost 
>>of the checks
>>b) delay accounting turned on but not being read
>>    
>>
>
>This is probably the most important one, as that is what distros will be
>looking at.  They will have to enable the option, but will not "turn it
>on".
>  
>
I guess you meant a), not b) but yes, will run them in all these modes.

>  
>
>>c) delay accounting turned on and data read for all tasks at some 
>>"reasonable" rate
>>
>>Will that be good  ? Other suggestions welcome.
>>    
>>
>
>How about real benchmarks?  The ones that the big companies look at?  I
>know you have access to them :)
>  
>
Hmm...though you also know, from working for some "big company",  that 
it might
take a while to get such data since one has to stand in queue :-)
I'll try, and also explore the OSDL STP's DBT tests.


Thanks,
Shailabh

>thanks,
>
>greg k-h
>  
>

