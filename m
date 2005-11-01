Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbVKAVnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbVKAVnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVKAVnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:43:46 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:52650 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751270AbVKAVnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:43:45 -0500
Message-ID: <4367E1CA.9040400@tmr.com>
Date: Tue, 01 Nov 2005 16:44:42 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>,
       "Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems (SOLVED)
References: <53JVy-4yi-19@gated-at.bofh.it> <545a6-2GZ-17@gated-at.bofh.it>	 <43679B8F.8000305@gmail.com> <43679FFB.6040504@mnsu.edu>	 <4367A369.5030003@gmail.com> <1130872775.22089.1.camel@mindpipe>
In-Reply-To: <1130872775.22089.1.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-11-01 at 18:18 +0100, Patrizio Bassi wrote:
> 
>>Jeffrey Hundstad ha scritto:
>>
>>
>>>Since you're going to 250 Hz.  Please, if you would, see if you can
>>>tell any performance change and report that as well.  I'm more than a
>>>little skeptical that you'll notice.  BTW: Your battery life should be
>>>a little better at 100 Hz also.
>>>
>>
>>sincerely i can notice that task and application switching is a bit slower.
>>i have a 500mhz cpu so i think i can notice a bit the difference.
>>i can't estimate it mmm...
>>i'll say no more that 5-8%.
>>but i don't know where i'm gaining speed..
> 
> 
> Um, wasn't a consensus reached at OLS two years ago that the target for
> desktop responsiveness would be 1ms which is impossible with HZ=100 or
> 250?

Go back and reread the thread in the archives. The short answer is that 
he who controls the code controls the decisions. I just fix it 
everywhere, since 250 is too fast for optimal battery life, too slow for 
optimal response or multimedia, and not optimal for any server 
application I run (usenet, dns, mail, http, firewall).

A perfect compromise is one which makes everyone reasonably happy; this 
is like the XOR of that, it leaves everyone slightly dissatisfied. ;-)

I'm convinced that Linus choose this value to make everyone slightly 
unhappy, so development of various variable rate and tick skipping 
projects would continue. Unfortunately that doesn't seem to have 
happened :-(

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
