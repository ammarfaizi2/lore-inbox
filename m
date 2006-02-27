Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWB0W0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWB0W0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWB0W0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:26:04 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:50507 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751253AbWB0W0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:26:03 -0500
In-Reply-To: <20060224014251.GC25787@kroah.com>
References: <8B3A62DF-6991-4C46-A294-6DF314D24AF4@kernel.crashing.org> <Pine.LNX.4.44.0602231324110.12559-100000@gate.crashing.org> <20060224014251.GC25787@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8F53A5C-A186-478E-A2A9-4797FE56EBE4@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: what's a platform device?
Date: Mon, 27 Feb 2006 16:25:52 -0600
To: Russell King <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> This makes sense, but you seem to be talking about hierarchy more  
>>> the
>>> functionality.  I agree in your description of hierarchy.
>>>
>>> I was looking at it from a functional point of view, maybe more from
>>> the device view then from the bus.  I need a struct device type that
>>> contains resources, a name, an id.  I'll do matching based on name.
>>>  From a functional point of view platform does all this.
>>>
>>> Based on your description would you say that a platform_device's
>>> parent device should always be platform_bus? [I'm getting at the  
>>> fact
>>> that we allow pdev->dev.parent to be set by the caller of
>>> platform_device_add].
>>>
>>> Hmm, as I think about this further, I think that its more  
>>> coincidence
>>> that the functionality for the "kumar" bus is equivalent to that of
>>> the "platform" bus.
>>>
>>
>> What about a new bus_type that uses all the sematics of the  
>> platform_bus.
>> Doing someting like the following which would allow the caller to  
>> specify
>> their own bus_type.
>>
>> I'm just trying to avoid duplicating alot of code that already  
>> exists in
>> base/platform.c
>
> I'm ok with this patch, Russell?

http://marc.theaimsgroup.com/?l=linux-kernel&m=114072367307531&w=2

Russell, comments?

- kumar
