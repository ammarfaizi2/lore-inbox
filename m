Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314348AbSDRNSd>; Thu, 18 Apr 2002 09:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314349AbSDRNSc>; Thu, 18 Apr 2002 09:18:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:50705 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314348AbSDRNSb>; Thu, 18 Apr 2002 09:18:31 -0400
Message-ID: <3CBEB909.7000306@evision-ventures.com>
Date: Thu, 18 Apr 2002 14:16:09 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020416204329.4c71102f.sebastian.droege@gmx.de> <3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de> <3CBEABEF.1030009@evision-ventures.com> <20020418125757.GF2492@suse.de> <3CBEB51F.90105@evision-ventures.com> <20020418130743.GH2492@suse.de> <3CBEB754.6010205@evision-ventures.com> <20020418131248.GI2492@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Apr 18 2002, Martin Dalecki wrote:
> 
>>Jens Axboe wrote:
>>
>>>On Thu, Apr 18 2002, Martin Dalecki wrote:
>>>
>>>
>>>>Jens Axboe wrote:
>>>>
>>>>
>>>>>On Thu, Apr 18 2002, Martin Dalecki wrote:
>>>>>
>>>>>
>>>>>
>>>>>>BTW>  Jens: Do you have any idea what the "sector chaing" in ide-cd is
>>>>>>good for?! I would love to just get rid of it alltogether!
>>>>>
>>>>>
>>>>>Sector chaining? Are you talking about the cdrom_read_intr() comments?
>>>>
>>>>Sorry I did mean sector caching.
>>>
>>>
>>>That's for padding/caching sub-frame sized reads.
>>
>>I tought the BIO layer did this alredy... Well it's a pain
> 
> 
> Nope, it does not.
> 
> 
>>in the a** to deal with it. IDE-FLOPPY is passing packet commands
> 
> 
> It sure is... sr doesn't do it and lots of others don't as well, so I
> suppose we could rip it out. We already require reblocking with loop in
> those cases anyway.
> 
> 
>>through the request buffer but IDE-CD is passing them through
>>request special field... argh!
> 
> 
> So kill ->special usage in ide-cd and use ->buffer?

That's the idea, but the caching code mentioned above
is abusing it already in a way I can't grasp wholly immediately.

> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

