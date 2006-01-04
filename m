Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWADL4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWADL4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 06:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWADL4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 06:56:18 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:49493 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751761AbWADL4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 06:56:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=MJBV1CXCwcjHgA6E8WgRcmgYVXABY9Z44jOGADGXAn2pghr+JgWowZe4ACQaW4FV1Xvv794fKtQ8mGaxiwSv63Rb835UluWvaP0nGWa8Kn8XX7fYuYMeNZEeDYCs4ik2LUtNKRWbjJhqD/+diFR5lRvH3PBnVpXomHlb/TxOFWA=
Message-ID: <43BBB7DC.2060303@gmail.com>
Date: Wed, 04 Jan 2006 12:56:12 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051210)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Jaroslav Kysela <perex@suse.cz>, "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
References: <4uzow-1g5-13@gated-at.bofh.it> <5r0aY-2If-41@gated-at.bofh.it> <5r3Ca-88G-81@gated-at.bofh.it> <5reGV-6YD-23@gated-at.bofh.it> <5reGV-6YD-21@gated-at.bofh.it> <5rf9X-7yf-25@gated-at.bofh.it>
In-Reply-To: <5rf9X-7yf-25@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaroslav Kysela ha scritto:
> On Wed, 4 Jan 2006, Pete Zaitcev wrote:
> 
> 
>>On Wed, 4 Jan 2006 09:37:55 +0000, Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
>>
>>
>>>>2) ALSA API is to complicated: most applications opens single sound
>>>>   stream.
>>>
>>>FUD and nonsense. []
>>>http://devzero.co.uk/~alistair/alsa/
>>
>>That's the kicker, isn't it? Once you get used to it, it's a workable
>>API, if kinky and verbose. I have a real life example, too:
>> http://people.redhat.com/zaitcev/linux/mpg123-0.59r-p3.diff
>>But arriving on the solution costed a lot of torn hair. Look at this
>>bald head here! And who is going to pay my medical bills when ALSA
>>causes me ulcers, Jaroslav?
> 
> 
> Well, the ALSA primary goal is to be the complete HAL not hidding the 
> extra hardware capabilities to applications. So API might look a bit 
> complicated for the first glance, but the ALSA interface code for simple 
> applications is not so big, isn't?
> 
> Also, note that app developers are not forced to use ALSA directly - there 
> is a lot of "portable" sound API libraries having an ALSA backend doing
> this job quite effectively. We can add a simple (like OSS) API layer 
> into alsa-lib, but I'm not sure, if it's worth to do it. Perhaps, adding
> some support functions for the easy PCM device initialization might be
> a good idea.
> 
> 						Jaroslav
> 

considering that alsa API and drivers is pretty stable i see no problem
in OSS removal.
When writing a program adding oss compatibility seems faster, but,
creates lots of problems.
check the skype example (yes i know it's closed-source). 99% of sound
problems users have is due to OSS driver usage.

that's a big problem. Needs a radical solution. Considering aoss works
in 50% of cases i suggest aoss improvement and not OSS keeping in kernel.

A good idea could be an OSS API layer over Alsa-lib...but i personally
don't know how much can that costs, considering you should link against
alsa-lib too.

This discussion seems a no-sense.
Kernel API continues to change every -rc and noone cares that.
OSS has been deprecated for a lot, and it's as old as moon.

	Patrizio

--
Patrizio Bassi
www.patriziobassi.it
