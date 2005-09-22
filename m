Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbVIVHIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbVIVHIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVIVHIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:08:50 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:10661 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750867AbVIVHIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:08:49 -0400
Message-ID: <433258D1.8080301@aitel.hist.no>
Date: Thu, 22 Sep 2005 09:10:09 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vadim Lobanov <vlobanov@speakeasy.net>
CC: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: A pettiness question.
References: <200509212046.15793.nick@linicks.net> <Pine.LNX.4.58.0509211305250.24543@shell4.speakeasy.net>
In-Reply-To: <Pine.LNX.4.58.0509211305250.24543@shell4.speakeasy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vadim Lobanov wrote:

>On Wed, 21 Sep 2005, Nick Warne wrote:
>
>  
>
>>>>This give a enum of {0,1}. If test is not 0, !!test will give 1,
>>>>otherwise 0.
>>>>
>>>>Am I right?
>>>>        
>>>>
>>>Yes.  I think of it as a "truth value" predicate (or operator).
>>>      
>>>
>>Interesting.  I thought maybe this way was trick, until later I experimented.
>>
>>My post here (as Bill Stokes):
>>
>>http://www.quakesrc.org/forums/viewtopic.php?t=5626
>>
>>So what is the reason to doing !!num as opposed to num ? 1:0 (which is more
>>readable I think, especially to a lesser experienced C coder).  Quicker to
>>type?
>>    
>>
>
>Some people also prefer the following form:
>	num != 0
>  
>
That one looks good for if-tests and such. But if you need
a 0 or 1 for adding to a counter, then

a += !!x;

looks much better than

a += (x != 0);

There is nothing special about !!.  Just learn to use it, it
is easy to understand/read, and saves typing.

Perhaps a "C-contructs FAQ" might be useful, for the benefit
of newbies and beginners.  It could document things like
the use of !!, common kernel macro tricks, when not to
use zero initializers, and so on.

Helge Hafting
