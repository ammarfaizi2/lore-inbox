Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264488AbUE0NdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUE0NdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUE0NdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:33:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:51853 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S264488AbUE0Nc5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:32:57 -0400
Message-ID: <40B5EDDB.9010102@tmr.com>
Date: Thu, 27 May 2004 09:32:11 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joris van Rantwijk <joris@eljakim.nl>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: System clock speed too high - 2.6.3 kernel
References: <1085518688.8653.19.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0405270020080.1496@eljakim.netsystem.nl>
In-Reply-To: <Pine.LNX.4.58.0405270020080.1496@eljakim.netsystem.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joris van Rantwijk wrote:
> On Tue, 25 May 2004, john stultz wrote:
> 
>>On Tue, 2004-05-25 at 02:22, Joris van Rantwijk wrote:
>>
>>>If there are many systems with this problem, then calibrating the PM timer
>>>against the PIT timer at boot time (possibly rejecting invalid rates)
>>>might be an option.
> 
> 
>>I'll put it on my todo list, but if you'd like to take a swing at ti and
>>beat me to the implementation, I wouldn't complain.
> 
> 
> Sounds fair. I tried something and it even seems to work here.
> My dmesg now says:
>   PM-Timer running at invalid rate: 199% of normal - aborting.
>   Detected 400.816 MHz processor.
>   Using tsc for high-res timesource
> 
> Hmm, I think I'm enjoying this :-)
> My patch is included below and also submitted at the Kernel Bugzilla
> thing. I would appreciate it if someone else could also test it a bit.
> 
> Yesterday, I ran into a (hopefully) completely seperate issue with the
> timer. This happened before I even started messing with the kernel and
> while running with "clock=tsc". The kernel suddenly logged:
>   Losing too many ticks!
>   TSC cannot be used as a timesource
>    ...
>   Falling back to a sane timesource now.
> 

Have to say that since adding clock=tsc my test systems are all keeping 
perfect time (ntpd running) which has not been the case since I started 
using test kernels about 2.5.38.

You do seem to have an issue with the pit.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
