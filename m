Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314050AbSDKNZY>; Thu, 11 Apr 2002 09:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314051AbSDKNZX>; Thu, 11 Apr 2002 09:25:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:9747 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314050AbSDKNZW>;
	Thu, 11 Apr 2002 09:25:22 -0400
Message-ID: <3CB57FF9.3020804@evision-ventures.com>
Date: Thu, 11 Apr 2002 14:22:17 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: More than 10 IDE interfaces
In-Reply-To: <Pine.LNX.3.96.1020411085829.3677F-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On Thu, 11 Apr 2002, Martin Dalecki wrote:
> 
> 
>>Baldur Norddahl wrote:
>>
>>>Hi,
>>>
>>>I have a machine with the following configuration:
>>>
>>>2 on board IDE interfaces (AMD chipset)
>>>2 Promise Technology UltraDMA100 controllers with each 2 IDE interfaces.
>>>4 Promise Technology UltraDMA133 controllers with each 2 IDE interfaces.
>>>
>>>This adds up to 14 IDE interfaces. And I just discovered that the kernel
>>>only supports 10 IDE interfaces :-(
>>>
>>>So I tried to hack the kernel, and I was partially successfull. I changed
>>>MAX_HWIF from 10 to 14. I made up some major numbers for the extra
>>
>>In your case if should be changed to 15 there is an off by one error here in the
>>interpretation of this constant.

>   Anyway, if you have a moment to hint why an off by one error is not
> biting us on ten drives I'd be interested.

I think simply (not tested) that MAX_HWIF provides only 9 possible interfaces 
right now.

