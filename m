Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbTHKJP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 05:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270823AbTHKJP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 05:15:56 -0400
Received: from dyn-ctb-210-9-244-185.webone.com.au ([210.9.244.185]:53259 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S267561AbTHKJPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 05:15:54 -0400
Message-ID: <3F375EBD.5030106@cyberone.com.au>
Date: Mon, 11 Aug 2003 19:15:41 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Martin Schlemmer <azarah@gentoo.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]O14int
References: <200308090149.25688.kernel@kolivas.org> <200308091904.19222.kernel@kolivas.org> <1060580691.13254.7.camel@workshop.saharacpt.lan> <200308111608.18241.kernel@kolivas.org>
In-Reply-To: <200308111608.18241.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Mon, 11 Aug 2003 15:44, Martin Schlemmer wrote:
>
>>On Sat, 2003-08-09 at 11:04, Con Kolivas wrote:
>>
>>>On Sat, 9 Aug 2003 01:49, Con Kolivas wrote:
>>>
>>>>More duck tape interactivity tweaks
>>>>
>>>s/duck/duct
>>>
>>>
>>>>Wli pointed out an error in the nanosecond to jiffy conversion which
>>>>may have been causing too easy to migrate tasks on smp (? performance
>>>>change).
>>>>
>>>Looks like I broke SMP build with this. Will fix soon; don't bother
>>>trying this on SMP yet.
>>>
>>Not to be nasty or such, but all these patches have taken
>>a very responsive HT box to one that have issues with multiple
>>make -j10's running and random jerkyness.
>>
>
>A UP HT box you mean? That shouldn't be capable of running multiple make -j10s 
>without some noticable effect. Apart from looking impressive, there is no 
>point in having 30 cpu heavy things running with only 1 and a bit processor 
>and the machine being smooth as silk; the cpu heavy things will just be 
>unfairly starved in the interest of appearance (I can do that easily enough). 
>Please give details if there is a specific issue you think I've broken or 
>else I wont know about it.
>

Yeah make -j10s won't be without impact, but I think for a lot of
interactive stuff they don't need a lot of CPU, just to get it
in a timely manner. And Martin did say it had been responsive.
Sounds like in this case your changes are causing the interactive
stuff to get less CPU or higher scheduling latency?


