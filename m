Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVFWDos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVFWDos (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 23:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVFWDor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 23:44:47 -0400
Received: from thunder.netspace.net.au ([203.10.110.71]:31495 "EHLO
	mail.netspace.net.au") by vger.kernel.org with ESMTP
	id S261987AbVFWDod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 23:44:33 -0400
Message-ID: <42BA300D.9080106@netspace.net.au>
Date: Thu, 23 Jun 2005 11:44:13 +0800
From: Andrew Lewis <andrew-lewis@netspace.net.au>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: ARM Linux Suitability for Real-time Application
References: <20050622100231.A28181@flint.arm.linux.org.uk> <Pine.LNX.4.10.10506220951190.455-100000@godzilla.mvista.com> <20050622182250.A13976@flint.arm.linux.org.uk>
In-Reply-To: <20050622182250.A13976@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Jun 22, 2005 at 09:52:40AM -0700, Daniel Walker wrote:
> 
>>On Wed, 22 Jun 2005, Russell King wrote:
>>
>>>If you're just after some background process to run off interrupts with
>>>minimal interrupt latency, the good news is that you don't have to modify
>>>the kernel on ARM, and you certainly don't need any RT patches.
>>>
>>>If you use the FIQ, then your FIQ latency will be the time it takes the
>>>CPU to enter your FIQ function.  Since the kernel _never_ disables FIQs
>>>in any way, FIQs have ultimate priority over everything else in the
>>>system.
>>>
>>
>>Aren't FIQ's only on some ARM's ? 
> 
> 
> Yes, but please read the original mail.  I think you'll find my reply
> is completely relevant to the question being posed, which was based
> upon the AT91RM9200 SoC.

Thanks for the suggestions.  The FIQ solutions sounds like the one to 
use.  I'll probably do a little testing sometime in the next few weeks 
to determine the maximum loading I can place on the processor when 
running some of the other peripherals simultaneously.  If I have time 
I'll test the -RT patches as well and post up some numbers for this 
processor.

