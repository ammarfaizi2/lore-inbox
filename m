Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWIKFVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWIKFVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWIKFVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:21:32 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:64941 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S964817AbWIKFVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:21:31 -0400
Message-ID: <4504F257.7020306@free.fr>
Date: Mon, 11 Sep 2006 07:21:27 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.8.0.5) Gecko/20060405 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
References: <20060908011317.6cb0495a.akpm@osdl.org>	<200609101032.17429.ak@suse.de>	<20060910115722.GA15356@elte.hu>	<200609101334.34867.ak@suse.de>	<20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org>
In-Reply-To: <450499D3.5010903@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 11.09.2006 01:03, Jeremy Fitzhardinge a écrit :
> Andrew Morton wrote:
>> I must say that having an unreliable early-current is going to be quite a
>> pita for evermore.  Things like mcount-based tricks and
>> basic-block-profiling-based tricks, for example.
>>
>> Is it really going to be too messy to fake up some statically-defined gdt
>> which points at init_task, install that before we call any C at all?
> 
> That's on my TODO list - make %gs set correctly before hitting C code, 
> and get rid of all the early_* stuff.  I had already encountered a 
> PDA-related oops with lockdep enabled, and addressed it.
> 
> It's pretty easy to solve in general for the boot CPU, but its a bit 
> more tricky to handle for secondary CPUs.
> 
> Laurent, could you resend your original oops?  It doesn't seem to have 
> appeared on lkml.

I guess my original mail was too big. Sorry for that. 
Please go to http://laurent.riffard.free.fr/2.6.18-rc6-mm1/, 
you'll find the files I sent in my first post:

* DSC02674.jpg (96k): screenshot of first GPF  
* config-2.6.18-rc6-mm1 (48k)
* dmesg-2.6.18-rc6-mm1 (25k)
 
> In the meantime, I'll work on a proper fix for this.
> 
>    J

-- 
laurent
