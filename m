Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWERNSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWERNSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 09:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWERNSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 09:18:47 -0400
Received: from rtr.ca ([64.26.128.89]:51100 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751360AbWERNSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 09:18:47 -0400
Message-ID: <446C7435.2040809@rtr.ca>
Date: Thu, 18 May 2006 09:18:45 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Cc: Jan Wagner <jwagner@kurp.hut.fi>, linux-kernel@vger.kernel.org
Subject: Re: support for sata7 Streaming Feature Set?
References: <Pine.LNX.4.58.0605051547410.7359@kurp.hut.fi> <4466D6FB.1040603@gmail.com> <Pine.LNX.4.58.0605162126520.31191@kurp.hut.fi> <446BD8F2.10509@gmail.com>
In-Reply-To: <446BD8F2.10509@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jan Wagner wrote:
>> Hi and thanks for your response,
>>
>> On Sun, 14 May 2006, Tejun Heo wrote:
>>>> anyone know if the now already somewhat old Streaming Feature Set of
>>>> ATA/ATAPI 7 is going to be implemented in the kernel ata functions?
>>>>
>>>> According to one web site that contains hdreg.h
>>>> http://www.koders.com/c/fidCD7293464D782E48F93EEF8A71192F1BF28FC205.aspx 
...
That link just gives me a search page.  Got a better link?


> No, it's not a horrible hack.  Again, no one thinks smartd is a horrible 
> hack.  Even core things like irqbalancing and CPU speeding down are 
> controlled from userland.  Being in the userland is a good thing - it's 
> much safer & more convenient/flexible out there.
> 
>>> What are you gonna use it for?
>>
>> To record or play back real-time continuous streamed data that is not
>> error-critical but delay critical, from/to a bidirectional data
>> aquisition card at ~1Gbit/s over longer time spans.
..
Other uses include tons of embedded systems using Linux,
primarily those that handle any kind of A/V record/playback
(think "Tivo", MP3 player, video players, ...).
These are about as rare as a fileserver, when counting the installed base.

I think that the ATA streaming feature set cannot be done
efficiently (which is the whole point of it!) without some kernel support.

The device driver has to know about it, at a minimum so that it can
select a different EH protocol for the streams.  Which in turn means
that the streaming commands should be known to the driver as well.

But how to handle it all nicely is the real question.
A new block driver, if libata cannot handle it?

Cheers
