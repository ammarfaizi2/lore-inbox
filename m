Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274909AbTHKXfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274953AbTHKXfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:35:32 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:3595 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S274909AbTHKXfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:35:23 -0400
Message-ID: <3F382B8B.9000301@techsource.com>
Date: Mon, 11 Aug 2003 19:49:31 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rob@landley.net
CC: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>, linux-kernel@vger.kernel.org,
       kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <3F303494.3030406@techsource.com> <200308110414.28569.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rob Landley wrote:
> On Tuesday 05 August 2003 18:49, Timothy Miller wrote:
> 
> 
>>Or closer to the point:
>>
>>"For each record player, there is a record which it cannot play."
>>For more detail, please read this dialog:
>>http://www.geocities.com/g0del_escher_bach/dialogue4.html
> 
> ...
> 
>>The interactivity detection algorithm will always be inherently
>>imperfect.  Given that it is not psychic, it cannot tell in advance
>>whether or not a given process is supposed to be interactive, so it must
>>GUESS based on its behavior.
> 
> 
> Another way of looking at it is that every time you remove a bottleneck, the 
> next most serious problem becomes the new bottleneck.
> 
> Does this mean it's a bad idea to stop trying to identify the next bottleneck?  
> (Whether or not you then choose to deal with it is another question...)


No.  It just means that it's possible to produce artificial loads that 
break things, and since those artificial loads won't be encountered in 
typical usage, they should not be optimized for.


Mind you, we prefer that the worst case "record you cannot play" doesn't 
have TOO much impact, because we don't want people writing DoS programs 
which exploit those artificial cases.

