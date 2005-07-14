Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVGNAds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVGNAds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 20:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVGNAdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 20:33:40 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:22667 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262806AbVGNAb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 20:31:59 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Bill Davidsen <davidsen@tmr.com>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
X-X-Sender: dlang@dlang.diginsite.com
Date: Wed, 13 Jul 2005 17:31:40 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
In-Reply-To: <200507141021.55020.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.62.0507131726390.11024@qynat.qvtvafvgr.pbz>
References: <200507122110.43967.kernel@kolivas.org> <200507122202.39988.kernel@kolivas.org>
 <42D55562.3060908@tmr.com> <200507141021.55020.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2005, Con Kolivas wrote:

> On Thu, 14 Jul 2005 03:54, Bill Davidsen wrote:
>> Con Kolivas wrote:
>>> On Tue, 12 Jul 2005 21:57, David Lang wrote:
>>>> for audio and video this would seem to be a fairly simple scaleing factor
>>>> (or just doing a fixed amount of work rather then a fixed percentage of
>>>> the CPU worth of work), however for X it is probably much more
>>>> complicated (is the X load really linearly random in how much work it
>>>> does, or is it weighted towards small amounts with occasional large
>>>> amounts hitting? I would guess that at least beyond a certin point the
>>>> liklyhood of that much work being needed would be lower)
>>>
>>> Actually I don't disagree. What I mean by hardware changes is more along
>>> the lines of changing the hard disk type in the same setup. That's what I
>>> mean by careful with the benchmarking. Taking the results from an athlon
>>> XP and comparing it to an altix is silly for example.
>>
>> I'm going to cautiously disagree. If the CPU needed was scaled so it
>> represented a fixed number of cycles (operations, work units) then the
>> effect of faster CPU would be shown. And the total power of all attached
>> CPUs should be taken into account, using HT or SMP does have an effect
>> of feel.
>
> That is rather hard to do because each architecture's interpretation of fixed
> number of cycles is different and this doesn't represent their speed in the
> real world. The calculation when interbench is first run to see how many
> "loops per ms" took quite a bit of effort to find just how many loops each
> different cpu would do per ms and then find a way to make that not change
> through compiler optimised code. The "loops per ms" parameter did not end up
> being proportional to cpu Mhz except on the same cpu type.

right, but the amount of cpu required to do a specific task will also vary 
significantly between CPU families for the same task as well. as long as 
the loops don't get optimized away by the compiler I think you can setup 
some loops to do the same work on each CPU, even if they take 
significantly different amounts of time (as an off-the-wall, obviously 
untested example you could make your 'loop' be a calculation of Pi and for 
the 'audio' test you compute the first 100 digits, for the video test you 
compute the first 1000 digits, and for the X test you compute a random 
number of digits between 10 and 10000)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
