Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314465AbSEVOUQ>; Wed, 22 May 2002 10:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSEVOUP>; Wed, 22 May 2002 10:20:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16144 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314465AbSEVOUO>; Wed, 22 May 2002 10:20:14 -0400
Message-ID: <3CEB9A3C.6000102@evision-ventures.com>
Date: Wed, 22 May 2002 15:16:44 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.GSO.4.21.0205220957320.2737-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alexander Viro napisa?:
> 
> On Wed, 22 May 2002, Martin Dalecki wrote:
> 
> 
>>So at least we know now:
>>
>>1. Kernel is bogous.
>>2. util-linux is bogous.
>>
>>IOCTL is ineed the way to go to implement such functionality...
> 
> 
> For kbdrate???  sysctl I might see - after all, we are talking about
> setting two numbers.  ioctl() to pass a couple of integers to the kernel?
> No, thanks.

Ahhh and just another note - we are talking about a property of a
*device* not a property of the kernel - so ioctl (read io as device)
and certainly not sysctl (read sys as kernel).

What could be sonsidered as an *serious* alternative would
be to abstract it out even further and implement it on
the tset (terminal settings) levels. But *certainly* not sysctl.



