Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbVFJNez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbVFJNez (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVFJNez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:34:55 -0400
Received: from mail2.utc.com ([192.249.46.191]:25495 "EHLO mail2.utc.com")
	by vger.kernel.org with ESMTP id S262520AbVFJNee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:34:34 -0400
Message-ID: <42A996DC.4090300@cybsft.com>
Date: Fri, 10 Jun 2005 08:34:20 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42A7135C.5010704@cybsft.com> <42A72A53.5050809@cybsft.com> <20050608191848.GA3411@elte.hu> <20050609113916.GA8904@elte.hu>
In-Reply-To: <20050609113916.GA8904@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>># CONFIG_DEBUG_RT_LOCKING_MODE is not set
>>>
>>>it seems to work fine. With the above enabled it hangs on both of my 
>>>SMP systems as described above. :-/
>>
>>ahh ... i'll try to reproduce it that way.
> 
> 
> found the bug - it was the incorrect initialization of 
> debug_slock/rwlock. I've uploaded -48-02 with the fix. This release also 
> includes a new debugging feature: CONFIG_DETECT_SOFTLOCKUP, which works 
> similar to the NMI watchdog but detects soft (==no reschedules) lockups.  
> I've also converted a few more local_irq_*() calls to raw_local_irq_*() 
> calls.
> 
> 	Ingo
> 

Sorry for not reporting back sooner on this, I just kept getting 
interrupted. My problems seem to be resolved on my SMP systems, even when

CONFIG_DEBUG_RT_LOCKING_MODE=y

I should note that I didn't actually try with the version above because 
it had been updated before I got to it.

-- 
    kr
