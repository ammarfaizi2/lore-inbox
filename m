Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSEVH51>; Wed, 22 May 2002 03:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSEVH51>; Wed, 22 May 2002 03:57:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:29453 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316886AbSEVH50>; Wed, 22 May 2002 03:57:26 -0400
Message-ID: <3CEB4084.90806@evision-ventures.com>
Date: Wed, 22 May 2002 08:53:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 65
In-Reply-To: <Pine.LNX.4.33.0205211626530.22624-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> On Tue, 21 May 2002, Vojtech Pavlik wrote:
> 
>>>They aren't there to be respected by the ll_rw_blk layer - if some layer
>>>above it has created a request larger than the hard sector size, THAT is
>>>the problem, and there is nothing ll_rw_blk can do (except maybe BUG() on
>>>it, but I don't think we've ever really seen those kinds of bugs).
>>
>>Hum, I'm confused here - shouldn't that be "if some layer above it has
>>created a request SMALLER than the hard sector size"? Or better a
>>request that is not a multiple of hard sector size?
> 
> 
> Yes, yes, you're obviously right, and I just had a brainfart when writing
> it. It should be basically: "higher levels must make sure on their own
> that all requests are nice integer multiples of the hw sector-size", and 
> ll_rw_blk should never have to care.

Please add the following to the bag:
"We never saw a filesystem with less then 512 byte sectors,
so let's assume this is our request size unit." (CP/M uses 256...)
Not that pretty at all.

