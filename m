Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262708AbSJJB1t>; Wed, 9 Oct 2002 21:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262782AbSJJB1s>; Wed, 9 Oct 2002 21:27:48 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:20439 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262708AbSJJB1s>;
	Wed, 9 Oct 2002 21:27:48 -0400
Message-ID: <3DA4D8E9.9050605@candelatech.com>
Date: Wed, 09 Oct 2002 18:33:29 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] High-res-timers part 2 (x86 platform code) take 5.1
References: <3DA4CED6.1BD30A2F@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> george anzinger wrote:
> 
>>Linus Torvalds wrote:
>>
>>>I really don't get the notion of partial ticks, and quite frankly, this
>>>isn't going into my tree until some major distribution kicks me in the
>>>head and explains to me why the hell we have partial ticks instead of just
>>>making the ticks shorter.
>>
>>...
>>
>>Making ticks shorter causes extra overhead ALL the time,
>>even when it is not needed.  Higher resolution is not free
>>in any case, but it is much closer to free with this patch
>>than by increasing HZ (which, of course, can still be
>>done).  Overhead wise and resolution wise, for timers, we
>>would be better off with a 1/HZ tick and the "on demand"
>>high-res interrupts this patch introduces.

I would like to add my small vote for including the timers too.

I have not looked at the code, but the idea seems sound (let
those who need the timers pay the price at that time, don't make
the rest of the machine suffer otherwise)....

Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


