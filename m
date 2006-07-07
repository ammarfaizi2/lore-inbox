Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWGGWPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWGGWPn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 18:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWGGWPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 18:15:43 -0400
Received: from lucidpixels.com ([66.45.37.187]:28077 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932350AbWGGWPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 18:15:42 -0400
Date: Fri, 7 Jul 2006 18:15:41 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: <17582.55703.209583.446356@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0607071814510.8499@p34.internal.lan>
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
 <Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
 <Pine.LNX.4.64.0607071037190.5153@p34.internal.lan> <17582.55703.209583.446356@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jul 2006, Neil Brown wrote:

> On Friday July 7, jpiszcz@lucidpixels.com wrote:
>>>>
>>>> Jul  7 08:44:59 p34 kernel: [4295845.933000] raid5: reshape: not enough
>>>> stripes.  Needed 512
>>>> Jul  7 08:44:59 p34 kernel: [4295845.962000] md: couldn't update array
>>>> info. -28
>>>>
>>>> So the RAID5 reshape only works if you use a 128kb or smaller chunk size?
>>>>
>>
>> Neil,
>>
>> Any comments?
>>
>
> Yes.   This is something I need to fix in the next mdadm.
> You need to tell md/raid5 to increase the size of the stripe cache
> before the grow can proceed.  You can do this with
>
>  echo 600 > /sys/block/md3/md/stripe_cache_size
>
> Then the --grow should work.  The next mdadm will do this for you.
>
> NeilBrown
>

Hey!  You're awake :)

I am going to try it with just 64kb to prove to myself it works with that, 
but then I will re-create the raid5 again like I had it before and attempt 
it again, I did not see that documented anywhere!! Also, how do you use 
the --backup-file option? Nobody seems to know!
