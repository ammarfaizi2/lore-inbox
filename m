Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTJPKx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 06:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTJPKx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 06:53:56 -0400
Received: from dyn-ctb-210-9-241-190.webone.com.au ([210.9.241.190]:1037 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262814AbTJPKxr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 06:53:47 -0400
Message-ID: <3F8E7780.5060603@cyberone.com.au>
Date: Thu, 16 Oct 2003 20:48:32 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Eli Billauer <eli_billauer@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net>
In-Reply-To: <3F8E70E0.7070000@users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eli Billauer wrote:

>>
>>
>>> Frandom is the faster version of the well-known /dev/urandom random 
>>> number generator. Not instead of, but rather as a supplement, when 
>>> pseudorandom data is needed at high rate. Few tests so far show that 
>>> frandom is 10-50 times faster than urandom.
>>>
>>
>> Without looking at the code, why should this be done in the kernel?
>
>
> I suppose you're asking why having a /dev/frandom device at all. Why 
> not let everyone write their own little random generator (based upon 
> well-known C functions) whenever random data is needed.


Yes, a userspace solution that makes use of the existing kernel random
number source if needed.

>
> There are plenty of handy things in the kernel, that could be done in 
> userspace. /dev/zero is my favourite example, but I'm sure there are 
> other cases where things were put in the kernel simply because people 
> found them handy. Which is a good reason, if you ask me.


There is probably a lot in the kernel that can (and a lot that should) be
done in userspace (although I'm not sure /dev/zero is one of them).

This doesn't mean having them in the kernel is a good idea because they are
handy. I'm not passing judgement on your module though - I was just 
wondering
why it is in kernel.

>
> Besides, it's quite easy to do something wrong with random numbers. By 
> having a good source of random data, I suppose we can spare a lot of 
> people the headache of getting their own user-space application right 
> for the one-off thing they want to do.


Although we do have 2 types of random number sources in the kernel. I'm not
sure we'd want to keep adding them as the need arises. Maybe if it were 
a very
general and configurable one, but AFAIKS frandom is not.

Cheers,
Nick


