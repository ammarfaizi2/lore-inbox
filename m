Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWCNUtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWCNUtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWCNUtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:49:20 -0500
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:26335 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750724AbWCNUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:49:19 -0500
Message-ID: <44172C4C.3020107@watson.ibm.com>
Date: Tue, 14 Mar 2006 15:49:16 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 0/9] Per-task delay accounting
References: <1142296834.5858.3.camel@elinux04.optonline.net> <20060314192824.GB27012@kroah.com>
In-Reply-To: <20060314192824.GB27012@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Mon, Mar 13, 2006 at 07:40:34PM -0500, Shailabh Nagar wrote:
>  
>
>>This is the next iteration of the delay accounting patches
>>last posted at
>>	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html
>>    
>>
>
>Do you have any benchmark numbers with this patch applied and with it
>not applied? 
>
None yet. Wanted to iron out the collection/utility aspects a bit before 
going into
the performance impact.

But this seems as good a time as any to collect some stats
using the usual suspects lmbench, kernbench, hackbench etc.

> Last I heard it was a measurable decrease for some
>"important" benchmark results...
>  
>
Might have been from an older iteration where schedstats was fully enabled.
But no point speculating....will run with this set of patches and see 
what shakes out.

One point about the overhead is that it depends on the frequency with 
which data is
collected. So a proper test would probably be a comparison of a 
non-patched kernel
with
a) patches applied but delay accounting not turned on at boot i.e. cost 
of the checks
b) delay accounting turned on but not being read
c) delay accounting turned on and data read for all tasks at some 
"reasonable" rate

Will that be good  ? Other suggestions welcome.

>thanks,
>
>greg k-h
>  
>

