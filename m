Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbVHIEXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVHIEXv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVHIEXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:23:51 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:13005 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932443AbVHIEXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:23:50 -0400
In-Reply-To: <20050808231714.GB7276@neo.rr.com>
References: <20050808231714.GB7276@neo.rr.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7A8D4849-AE31-4F22-BA00-6C2B66CC833D@freescale.com>
Cc: "Greg KH" <greg@kroah.com>, "Matthew Gilbert" <mgilbert@mvista.com>,
       <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] Custom IORESOURCE Class
Date: Mon, 8 Aug 2005 23:23:23 -0500
To: Adam Belay <ambx1@neo.rr.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 8, 2005, at 6:17 PM, Adam Belay wrote:

> On Mon, Aug 08, 2005 at 09:00:21AM -0700, Greg KH wrote:
>
>> On Mon, Aug 08, 2005 at 11:11:45AM -0700, Matthew Gilbert wrote:
>>
>>> Below is a patch that adds an additional resource class to the
>>>
> platform
>
>>> resource types. This is to support additional resources that need to
>>>
> be passed
>
>>> to drivers without overloading the existing specific types. In my
>>>
> case, I need
>
>>> to send clock information to the driver to enable power management.
>>>
>>> Signed-off-by: Matthew Gilbert <mgilbert@mvista.com>
>>>
>>
>> Hm, you do realize that Pat's no longer the driver core maintainer?
>>
> :)
>
>>
>> Anyway, Russell and Adam, any objections to this patch?
>>
>
> I'm not sure if I agree with this patch.  "struct resource" is used
> primarily for
> I/O resource assignment.  Although I agree we may need to add new
> IORESOURCE types,
> I'm not sure if clock data belongs here.  I don't think "start" and
> "end" would be
> useful for most platform data.  Could you provide more information  
> about
> this
> specific issue and resource type?  Maybe we could create a new sysfs
> attribute?

I would also like to understand more about what the need is here.  We  
have clock data and such but use platform_data for it.

- kumar
