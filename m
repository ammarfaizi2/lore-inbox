Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSEWV5C>; Thu, 23 May 2002 17:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSEWV5B>; Thu, 23 May 2002 17:57:01 -0400
Received: from [195.63.194.11] ([195.63.194.11]:60677 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317025AbSEWV47>; Thu, 23 May 2002 17:56:59 -0400
Message-ID: <3CED56CA.7010709@evision-ventures.com>
Date: Thu, 23 May 2002 22:53:30 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: Christer Weinigel <wingel@acolyte.hack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.33.0205231251430.2815-100000@penguin.transmeta.com> <3CED438B.6090906@evision-ventures.com> <20020523212239.EA736F5B@acolyte.hack.org> <20020523173716.B12899@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Pete Zaitcev napisa?:
>>From: Christer Weinigel <wingel@acolyte.hack.org>
>>Date: Thu, 23 May 2002 23:22:39 +0200 (CEST)
> 
> 
>>Martin Dalecki <dalecki@evision-ventures.com> wrote:
>>
>>
>>>"I will submitt my dual 8255 PIO ISA card driver from 1.xx days
>>>immediately for kernel inclusion"
>>
>>Please do *grin* I will probably have to write a driver for just such
>>a card (a PC104 card though, but that's just a differenct connector),
>>so I'd love to have such a driver. [...]
> 
> 
> The 8255 is way too flexible for a single driver to be possible,
> IMHO. Also, it is used in devices which plug into a variety of
> upstream APIs, which makes the factorization not worth the effort.
> E.g. what if you have 8255 driving a 9 track tape and 8255 driving
> HP-IB bus? I think it would hardly be reasonable to unify those.
> OTOH, If Martin submits a header file with register breakdown,
> it may be useful (unlike a continuation of /dev/port discussion).


Well I wasn't serious about this submission thing precisely
for the above reasons. From long past times I can remember
that those beasts could be configured to have A B C D or whichever
ports, which could be neraly infinitely permuted to provide
many not usefull combinations of 4 or 8 bit bus buffers.
The externall visible register address or data lines where very
likely to be permutted between the chip and the data part of the ISA bus,
just becouse the layouter of the card did feel like beeing creative.
(So even register values won't help you!)
And last but not least they could be coupled in bunches.
So the chances for a genrically usefull driver are indeed not big.

And last but not least: The source for a driver for a 1.0.xx kernel
isn't very usefull nowadays.
And admittedly, well most lekely I don't have the code around
any longer... but it was just about 400 lines I can remember.

