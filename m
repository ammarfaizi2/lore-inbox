Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSHBMdc>; Fri, 2 Aug 2002 08:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSHBMdb>; Fri, 2 Aug 2002 08:33:31 -0400
Received: from [195.63.194.11] ([195.63.194.11]:6663 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S312962AbSHBMda>;
	Fri, 2 Aug 2002 08:33:30 -0400
Message-ID: <3D4A7BBE.90104@evision.ag>
Date: Fri, 02 Aug 2002 14:31:58 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
References: <1028288066.1123.5.camel@laptop.americas.sgi.com> <20020802114713.GD1055@suse.de> <3D4A7178.7050307@evision.ag> <1028289940.1123.19.camel@laptop.americas.sgi.com> <3D4A771A.9020308@evision.ag> <20020802123055.GQ3010@suse.de>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:

>>*/
>>+	ch->max_segment_size = (1<<16) - 512;
>>
>>
>>I would in esp. like to see the result of setting  ch->max_segment_size 
>>= (1 << 15).
> 
> 
> This might not be such a good idea, since the limit-bio-size etc stuff
> isn't in yet, depending on _exactly_ how big the bio's xfs are building
> are. If they are max 8 pages (I seem to recall so), then yeah the above
> test would be nice to see. If they are bigger than 8 pages, then the
> above would be a meaningless test.

Sure. I'm aware of this. And I haven't looked at the XFS code
yet, so I can only guess about it.

What I can do myself is just pushing this limit even lower just to
see at which point my own system (ext3) starts to turn tits up ...

> I'll hack up a rq_dump() function to slap in pcidma.c as well.

Yes that would be a "nice to have too".
But it is a request for actual data as far as I can see.

