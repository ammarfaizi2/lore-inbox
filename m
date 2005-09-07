Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVIGRkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVIGRkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVIGRkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:40:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28421 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751206AbVIGRkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:40:01 -0400
Message-ID: <431F2760.5060904@tmr.com>
Date: Wed, 07 Sep 2005 13:46:08 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jan.kiszka@googlemail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>	 <1125854398.23858.51.camel@localhost.localdomain>	 <p73aciqrev0.fsf@verdi.suse.de> <dfk5cp$19p$1@sea.gmane.org>	 <58d0dbf10509061005358dce91@mail.gmail.com>	 <dfkjav$lmd$1@sea.gmane.org> <58d0dbf105090612421dcd9d8d@mail.gmail.com>
In-Reply-To: <58d0dbf105090612421dcd9d8d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kiszka wrote:
> 2005/9/6, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>:
> 
>>Jan Kiszka wrote:
>>
>>
>>>The only way I see is to switch stacks back on ndiswrapper API entry.
>>>But managing all those stacks correctly is challenging, as you will
>>>likely not want to create a new stack on each switching point. Rather,
>>
>>This is what I had in mind before I saw this thread here. I, in fact, did
>>some work along those lines, but it is even more complicated than you
>>mentioned here: Windows uses different calling conventions (STDCALL,
>>FASTCALL, CDECL) so switching stacks by copying arguments/results gets
>>complicated. So I gave up on that approach. For X86-64 drivers we use
>>similar approach, but for that there is only one calling convention and we
>>don't need to switch stacks, but reshuffle arguments on stack / in
>>registers.
>>
>>I am still hoping that Andi's approach is possible (I don't understand how
>>we can make kernel see current info from private stack).
>>
> 
> 
> The more I think about this the more it becomes clear that this path
> will be too winding, especially when compared to the effort needed to
> patch 8K (or more) back into the kernel as an intermediate workaround.

Is there a technical reason ("hard to implement" is a practical reason) 
why all stacks need to be the same size?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
