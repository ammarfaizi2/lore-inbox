Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTFRJId (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 05:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265120AbTFRJId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 05:08:33 -0400
Received: from dns2.seagha.com ([217.66.0.19]:32528 "EHLO relay-1.seagha.com")
	by vger.kernel.org with ESMTP id S265117AbTFRJIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 05:08:32 -0400
Posted-and-Mailed: no
Subject: Re: How do I make this thing stop laging?  Reboot?  Sounds like  Windows!
From: Karl Vogel <karl.vogel@seagha.com>
References: <200306172030230870.01C9900F@smtp.comcast.net> <3EF0214A.3000103@aitel.hist.no>
Organization: SEAGHA cv
User-Agent: Xnews/5.04.25
To: linux-kernel@vger.kernel.org
Message-Id: <E19SZ8v-0005Ie-00@relay-1.seagha.com>
Date: Wed, 18 Jun 2003 11:22:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2003, you wrote in linux.kernel:

> rmoser wrote:
> [...]
>> Ten minutes later I get the brains to run top.  It seems I have about
>> 50 MB in swap, and 54 MB free memory.  So I wait ten minutes more.
>> 
>> No change.
>> 
>> % swapoff -a; swapon -a
>> 
>> Fixes all my problems.
>> 
>> Now this long story shows something:  The kernel appears to be unable
>> to intelligently pull swap back into RAM.  What gives?
>> 
> Because the problem _is_ unsolvable.  You want the kernel
> to go "oh, lots of free memory showed up, lets pull
> everything in from swap just in case someone might need it."


You might want to try Con Kolivas' patches on:
   http://members.optusnet.com.au/ckolivas/kernel/

More specifically the 'swap prefetch' patch. From this FAQ:

--
Swap prefetching? If you have >10% free physical ram and any used swap it 
will start swapping pages back into physical ram. Probably not of real 
benefit but many people like this idea. I have a soft spot for it and like 
using it.
--

The disadvantage is ofcourse that you will be using up more RAM than is 
really necessary.
