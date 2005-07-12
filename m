Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVGLMUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVGLMUC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVGLMSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:18:33 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:43905 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261385AbVGLMRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:17:15 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
X-X-Sender: dlang@dlang.diginsite.com
Date: Tue, 12 Jul 2005 05:17:09 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
In-Reply-To: <200507122202.39988.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.62.0507120507430.9200@qynat.qvtvafvgr.pbz>
References: <200507122110.43967.kernel@kolivas.org>
 <Pine.LNX.4.62.0507120446450.9200@qynat.qvtvafvgr.pbz>
 <200507122202.39988.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2005, Con Kolivas wrote:

> 
> On Tue, 12 Jul 2005 21:57, David Lang wrote:
>> this looks very interesting, however one thing that looks odd to me in
>> this is the thought of comparing the results for significantly different
>> hardware.
>>
>> for some of the loads you really are going to be independant of the speed
>> of the hardware (burn, compile, etc will use whatever you have) however
>> for others (X, audio, video) saying that they take a specific percentage
>> of the cpu doesn't seem right.
>>
>> if I have a 400MHz cpu each of these will take a much larger percentage of
>> the cpu to get the job done then if I have a 4GHz cpu for example.
>>
>> for audio and video this would seem to be a fairly simple scaleing factor
>> (or just doing a fixed amount of work rather then a fixed percentage of
>> the CPU worth of work), however for X it is probably much more complicated
>> (is the X load really linearly random in how much work it does, or is it
>> weighted towards small amounts with occasional large amounts hitting? I
>> would guess that at least beyond a certin point the liklyhood of that much
>> work being needed would be lower)
>
> Actually I don't disagree. What I mean by hardware changes is more along the
> lines of changing the hard disk type in the same setup. That's what I mean by
> careful with the benchmarking. Taking the results from an athlon XP and
> comparing it to an altix is silly for example.
>

however if you defined these loads in terms of the amount of work (number 
of loops) rather then percentage of the CPU I think you would be pretty 
close (especially if there was a way to tweak these for a test if needed). 
This sort of testing would be especially useful for low-end/embedded 
applications.

for example a series 1 DirectTv tivo manages to write two program streams 
to disk while reading and viewing a third, all on a 75MHz PPC with 64M of 
ram (on a tweaked 2.1 kernel) you are pretty close to being able to 
simulate this load

which brings up another possible config option/test case, changing the 
read/write tests to try to do X MB/sec rather then the max possible speed 
(probably defaulting to max if nothing is specified)

thanks again for working to define a good test case

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
