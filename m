Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbVINOcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbVINOcP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVINOcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 10:32:15 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:65293 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965205AbVINOcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 10:32:15 -0400
Message-ID: <43282BF5.5080101@tmr.com>
Date: Wed, 14 Sep 2005 09:56:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903064124.GA31400@codepoet.org> <4319BEF5.2070000@zytor.com> <B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com> <dfhs4u$1ld$1@terminus.zytor.com> <5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com> <9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com> <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com> <20050910014543.1be53260.akpm@osdl.org> <4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com> <20050910150446.116dd261.akpm@osdl.org> <E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com> <20050910174818.579bc287.akpm@osdl.org> <93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com> <20050912010954.70ac90e2.pj@sgi.com> <43259C9E.1040300@zytor.com> <20050912084756.4fa2bd07.pj@sgi.com> <67DD59DE-B7B3-43EC-A241-670ACD4C0322@mac.com>
In-Reply-To: <67DD59DE-B7B3-43EC-A241-670ACD4C0322@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Sep 12, 2005, at 11:47:56, Paul Jackson wrote:
> 
>> hpa wrote:
>>
>>> The only sane thing is to have a set of ABI headers with a clean,
>>> specific set of rules, which is included by the kernel private  headers,
>>> as well as userspace.
>>>
>>
>> Why must the ABI headers be included by both kernel and user  headers to
>> be sane?
>>
>> Hmmm ... I'm not sure I want to ask that, actually.  I have this  feeling
>> from the tone of your assertion that you can explain to me why such a
>> header organization is the only one that fits your mental model of how
>> these things are structured, but that communication between us may
>> break down when you try to convince me that your mental model for this
>> is the only correct one.
> 
> 
> If we acknowledge the fact that syncing the release dates of two  projects
> is basically futile, especially given that under your system the kernel
> headers would not change much/at-all to make the user-headers project
> easier, then any feature X that appears in a new release of the kernel
> will not be accessible from userspace tools without ignoring the  point of
> the user-headers project all together and having separate headers.   Given
> this, as well as the maintenance burden for those who would need to
> maintain the user-headers (which would be nearly nil if the current
> kernel headers could be cleaned up to the point which they could be used
> instead), this project is lots of messy work either way, but in the long
> run, if included into the upstream kernel, it will result in much less
> duplication of effort and much cleaner code.

The issue, as I see it, is not that the nifty new ioctl doesn't become 
instantly available, although that's not a small benefit of having one 
and only one set of user headers. The real benefit is avoiding the case 
where some part of the API *changes* and some feature stops working.

This is obviously uncommon, but not unheard of.

I see the greatest benefit from just not having two sets of headers, I 
believe all that stuff I learned in CS classes about not having two 
copies of stuff and assuming that they're the same. It would be less 
work to clean up the headers once, and let the folks who now maintain 
the separate headers become the "kernel janitors" to keep it clean.

Not my job, but we have someone offering to do the first cut at it, and 
it seems a desirable end result.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

