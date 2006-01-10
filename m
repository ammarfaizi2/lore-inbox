Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWAJWMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWAJWMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 17:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWAJWMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 17:12:30 -0500
Received: from dvhart.com ([64.146.134.43]:14209 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932566AbWAJWM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 17:12:29 -0500
Message-ID: <43C4314C.4030800@mbligh.org>
Date: Tue, 10 Jan 2006 14:12:28 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Although CONFIG_IRQBALANCE is enabled IRQ's don't seem to be
 balanced very well
References: <9a8748490601100314u26d4a566uc41a1912e410ea46@mail.gmail.com>	 <20060110203115.GB5479@filer.fsl.cs.sunysb.edu>	 <43C42708.4020108@mbligh.org> <9a8748490601101410i31a8447ev2bf8fafe570fc407@mail.gmail.com>
In-Reply-To: <9a8748490601101410i31a8447ev2bf8fafe570fc407@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 1/10/06, Martin Bligh <mbligh@mbligh.org> wrote:
> 
>>Josef Sipek wrote:
>>
>>>On Tue, Jan 10, 2006 at 12:14:42PM +0100, Jesper Juhl wrote:
>>>
>>>
>>>>Do I need any userspace tools in addition to CONFIG_IRQBALANCE?
>>>
>>>
>>>Last I checked, yes you do need "irqbalance" (at least that's what
>>>the package is called in debian.
>>
>>Nope - you need the kernel option turned on OR the userspace daemon,
>>not both.
>>
> 
> Ok, good to know.
> 
> 
>>If you're not generating interrupts at a high enough rate, it won't
>>rotate. That's deliberate.
>>
> 
> 
> Hmm, and what would count as "a high enough rate"?
> 
> I just did a small test with thousands of  ping -f's through my NIC
> while at the same time giving the disk a good workout with tons of
> find's, sync's & updatedb's - that sure did drive up the number of
> interrupts and my load average went sky high (amazingly the box was
> still fairly responsive):
> 
> root@dragon:/home/juhl# uptime
>  22:59:58 up 12:43,  1 user,  load average: 1015.48, 715.93, 429.07
> 
> but, not a single interrupt was handled by CPU1, they all went to CPU0.
> 
> Do you have a good way to drive up the nr of interrupts above the
> treshhold for balancing?

Is it HT? ISTR it was intelligent enough to ignore that. But you'd
have to look at the code to be sure.

M.
