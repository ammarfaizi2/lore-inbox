Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVGVDru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVGVDru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 23:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGVDqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 23:46:44 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:13786 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S262008AbVGVDql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 23:46:41 -0400
Message-ID: <42E06C1D.8050802@bigpond.net.au>
Date: Fri, 22 Jul 2005 13:46:37 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Paul Jackson <pj@sgi.com>, Matthew Helsley <matthltc@us.ibm.com>,
       akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1 (ckrm)
References: <E1Dvnm8-0006iD-00@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1Dvnm8-0006iD-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Fri, 22 Jul 2005 03:46:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:
> On Fri, 22 Jul 2005 11:06:14 +1000, Peter Williams wrote:
> 
>>Paul Jackson wrote:
>>
>>>Matthew wrote:
>>>
>>>
>>>>I don't see the large ifdefs you're referring to in -mm's
>>>>kernel/sched.c.
>>>
>>>
>>>Perhaps someone who knows CKRM better than I can explain why the CKRM
>>>version in some SuSE releases based on 2.6.5 kernels has substantial
>>>code and some large ifdef's in sched.c, but the CKRM in *-mm doesn't.
>>>Or perhaps I'm confused.  There's a good chance that this represents
>>>ongoing improvements that CKRM is making to reduce their footprint
>>>in core kernel code.  Or perhaps there is a more sophisticated cpu
>>>controller in the SuSE kernel.
>>
>>As there is NO CKRM cpu controller in 2.6.13-rc3-mm1 (that I can see) 
>>the one in 2.6.5 is certainly more sophisticated :-).  So the reason 
>>that the considerable mangling of sched.c evident in SuSE's 2.6.5 kernel 
>>source is not present is that the cpu controller is not included in 
>>these patches.
> 
>  
>  Yeah - I don't really consider the current CPU controller code something
>  ready for consideration yet for mainline merging.  That doesn't mean
>  we don't want a CPU controller for CKRM - just that what we have
>  doesn't integrate cleanly/nicely with mainline.
> 
> 
>>I imagine that the cpu controller is missing from this version of CKRM 
>>because the bugs introduced to the cpu controller during upgrading from 
>>2.6.5 to 2.6.10 version have not yet been resolved.
> 
> 
>  I don't know what bugs you are referring to here.  I don't think we
>  have any open defects with SuSE on the CPU scheduler in their releases.
>  And that is not at all related to the reason for not having a CPU
>  controller in the current patch set.

The bugs were in the patches for the 2.6.10 kernel not SuSE's 2.6.5 
kernel.  I reported some of them to the ckrm-tech mailing list at the 
time.  There were changes to the vanilla scheduler between 2.6.5 and 
2.6.10 that were not handled properly when the CKRM scheduler was 
upgraded to the 2.6.10 kernel.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
