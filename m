Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314525AbSDZX2X>; Fri, 26 Apr 2002 19:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314526AbSDZX2W>; Fri, 26 Apr 2002 19:28:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:30475 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314525AbSDZX2W>; Fri, 26 Apr 2002 19:28:22 -0400
Message-ID: <3CC9D3EC.80504@evision-ventures.com>
Date: Sat, 27 Apr 2002 00:25:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 IDE 42
In-Reply-To: <Pine.LNX.4.44.0204261454440.30456-100000@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Somewhat agreed. Also, the above is just not the right way to do
>>printouts.
>>
>>I'd suggest rewriting the whole big mess as something like
>>
>>	#define STAT_STR(x,s) \
>>		((stat & x ##_STAT) ? s " " : "")
>>
>>	...
>>
>>	printf("IDE: %s%s%s%s%s%s..\n"
>>		STAT_STR(READY, "DriveReady"),
>>		STAT_STR(WERR, "DeviceFault"),
>>		...
> 
> 
> I'd go even further and suggest that pulling the mapping from a mask or
> key to string out into a table and looping through it is preferable for
> this sort of thing. You win later if you decide you need the same mapping
> elsewhere or if you want to format your messages differently, add bits to
> it, etc. Tables are generally easier to inspect for errors than code,
> although Linus' version is very nearly a table.
> 
> Maintaining tables as code is a pain and is generally only a win for
> small or sparse state machines.


Once could have a look at the ll_rw_blk.c file. There is
a function there, which is dissecting the differnt request
attributes, which are stored as bitfields there.

