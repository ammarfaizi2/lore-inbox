Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSC3O3s>; Sat, 30 Mar 2002 09:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313301AbSC3O3j>; Sat, 30 Mar 2002 09:29:39 -0500
Received: from [195.63.194.11] ([195.63.194.11]:24075 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313254AbSC3O3b>; Sat, 30 Mar 2002 09:29:31 -0500
Message-ID: <3CA5CB1C.1060904@evision-ventures.com>
Date: Sat, 30 Mar 2002 15:26:36 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Mikael Pettersson <mikpe@csd.uu.se>, vojtech@ucw.cz,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 pre-UDMA PIIX bug
In-Reply-To: <Pine.LNX.3.96.1020329103625.22866A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On Fri, 29 Mar 2002, Martin Dalecki wrote:
> 
> 
>>>  333		T = 1000000000 / piix_clock;
>>>  334		UT = T / umul;
>>
>>I think that it should be just sufficient to add the
>>following test just in front of the offending calculartion.
>>
>>if (umul == 0)
>>   ++umul;
> 
> 
> - 334               UT = T / umul;
> + 334               UT = T / (umul || 1);

That is ceratily wrong. becouse umul || 1 == 1 independently
from umul.

