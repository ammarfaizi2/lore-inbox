Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUEVOlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUEVOlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUEVOlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:41:04 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:7557 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261422AbUEVOk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:40:59 -0400
Message-ID: <40AF66FA.7090305@tmr.com>
Date: Sat, 22 May 2004 10:43:06 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
References: <Pine.LNX.4.58.0405210032160.2864@montezuma.fsmlabs.com> <20040520234006.291c3dfa.akpm@osdl.org>
In-Reply-To: <20040520234006.291c3dfa.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> 
>>This patch silences the default i386 boot by putting a lot of development
>> related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
>> to be turned on by using the 'debug' kernel parameter.
> 
> 
> I think I like it chatty.  Turning this stuff off by default makes kernel
> developers' lives that little bit harder.
> 
> Is the `quiet' option not suitable?

That may be too much of a good thing, but perhaps we can go to quiet=N 
or bootmsglvl=N or some such to let people tune the output. I personally 
like having the verbose output, but my systems tend to be stable enough 
that I don't see it often other than benchmarking, etc.

While throwing out ideas, bootmsgmask=#dddd would let people control 
various parts of the output individually. That may be overkill, but it 
is flexible overkill. And the default could be what we have now, with 
the option of even more babble for debugging. Developers might find that 
highly useful if they had a way to let users selectively enable more 
info at boot time.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
