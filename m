Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWCBH0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWCBH0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 02:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWCBH0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 02:26:53 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:41605 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751414AbWCBH0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 02:26:53 -0500
Message-ID: <44069E3A.4000907@drzeus.cx>
Date: Thu, 02 Mar 2006 08:26:50 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060119)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <20060127202646.GC2767@flint.arm.linux.org.uk> <43DA84B2.8010501@drzeus.cx> <43DA97A3.4080408@drzeus.cx> <20060127225428.GD2767@flint.arm.linux.org.uk> <20060128191759.GC9750@suse.de> <43DBC6E2.4000305@drzeus.cx> <20060129152228.GF13831@suse.de> <43DDC6F9.6070007@drzeus.cx> <20060130080930.GB4209@suse.de> <43DFAEC6.3090205@drzeus.cx> <20060301232913.GC4024@flint.arm.linux.org.uk>
In-Reply-To: <20060301232913.GC4024@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Jan 31, 2006 at 07:39:02PM +0100, Pierre Ossman wrote:
>   
>> Jens Axboe wrote:
>>     
>>> On Mon, Jan 30 2006, Pierre Ossman wrote:
>>>   
>>>       
>>>> Jens Axboe wrote:
>>>>     
>>>>         
>>>>> Ah, you need to disable clustering to prevent that from happening! I was
>>>>> confused there for a while.
>>>>>
>>>>>   
>>>>>       
>>>>>           
>>>> And which is the lesser evil, highmem bounce buffers or disabling
>>>> clustering? I'd probably vote for the former since the MMC overhead can
>>>> be quite large.
>>>>     
>>>>         
>>> Disabling clustering is by far the least expensive way to accomplish it.
>>>
>>>   
>>>       
>> Russell, what's your view on this? And how should we handle it with
>> regard to MMC drivers?
>>     
>
> Okay, I've hit this same problem (but in a slightly different way) with
> mmci.c.  The way I'm proposing to fix this for mmci is to introduce a
> new capability which says "clustering is supported by this driver."
>
>   

This will decrease performance more than necessary for drivers that can
do clustering, just not in highmem. So what about another flag that says
"highmem is supported by this driver"?

Rgds
Pierre

