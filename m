Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932858AbWCVW1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932858AbWCVW1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932860AbWCVW1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:27:47 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:19067 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932858AbWCVW1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:27:45 -0500
Message-ID: <4421CF5F.7010402@bigpond.net.au>
Date: Thu, 23 Mar 2006 09:27:43 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashok Raj <ashok.raj@intel.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Linux v2.6.16
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <4420DF21.8060700@bigpond.net.au> <20060321223120.A4003@unix-os.sc.intel.com>
In-Reply-To: <20060321223120.A4003@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 22 Mar 2006 22:27:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Tue, Mar 21, 2006 at 09:22:41PM -0800, Peter Williams wrote:
> 
>>   I/O APICs
>>   Mar 22 16:10:31 heathwren kernel: More than 8 CPUs detected and
>>   CONFIG_X86_PC cannot handle it.
>>
>>   ###  No more CPUs seen but something in there thinks there's more than
>>   8
>>   of them.
>>
>>   Mar 22 16:10:31 heathwren kernel: Use CONFIG_X86_GENERICARCH or
>>   CONFIG_X86_BIGSMP.
>>
> 
> 
> 
> This was disussed here,  
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114228068804099&w=2
> 
> but we didnt yet close out on it, Andrew didnt feel comfortable
> making CONFIG_HOTPLUG_CPU depend on !X86_PC, and making it depend on CONFIG_GENERICARCH
> or CONFIG_BIGSMP this late in the process.
> 
> The warning is bogus,

That's what I thought but I thought I should still report it as bogus 
messages can cause people to become inured and ignore real ones.

> when BIGSMP was first introduced it was solely to handle >8 CPUS
> using custer mode configuration. We switched bigsmp to use flat physical mode just like 
> what we do for x86_64, because some chipsets have ill effects with cpu hotplug.
> when we wakeup a new cpu. Details here
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113261865814107&w=2
> 
> Hence we switched to bigsmp, but the error message was not reworked, better yet is
> to have the right config depends so we dont run into any race and instability issues.
> 
> 

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
