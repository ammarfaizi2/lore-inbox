Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSBRWT6>; Mon, 18 Feb 2002 17:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288325AbSBRWTt>; Mon, 18 Feb 2002 17:19:49 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:47049 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S288174AbSBRWTi>;
	Mon, 18 Feb 2002 17:19:38 -0500
Message-ID: <3C717DEA.7090309@candelatech.com>
Date: Mon, 18 Feb 2002 15:19:22 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Oliver Hillmann <oh@novaville.de>, linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <E16cvzs-0006y2-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>>counter, and I'm currently digging into that area... Stuff like a pc
>>speaker driver going wild bothers me a bit more...
>>
> 
> Fix the speaker driver I guess is the answer. It shouldnt have done that.
> 
> 
>>Could anybody perhaps tell me why he/she doesn't consider this a
>>problem? And is there a fundamental problem with solving this in
>>general? (I do see a problem with defining jiffies long long on x86,
>>because it might break a lot of things and probably wouldnt perform
>>as often as jiffies is touched... And you might sense I haven't
>>been into kernel hacking much...)
>>
> 
> Counting in long long is expensive and the drivers are meant to all use
> roll over safe compares


I wonder, is it more expensive to write all drivers to handle the
wraps than to take the long long increment hit?  The increment is
once every 10 miliseconds, right?  That is not too often, all things
considered...

Maybe the non-atomicity of the long long increment is the problem?

Does this problem still exist on 64-bit machines?

THanks,
Ben



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


