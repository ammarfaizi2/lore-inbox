Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVKWG46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVKWG46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 01:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVKWG45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 01:56:57 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:39879 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1030343AbVKWG45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 01:56:57 -0500
In-Reply-To: <20051117154925.GA26032@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0511151727170.32393-100000@gate.crashing.org> <20051116064123.GA31824@kroah.com> <18C975E2-BA90-4595-8C50-63E5CFB9C0A1@kernel.crashing.org> <20051117154925.GA26032@flint.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <322E3172-BDF9-40BC-A5EC-444C8C33C450@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: overlapping resources for platform devices?
Date: Wed, 23 Nov 2005 00:57:40 -0600
To: Russell King <rmk+lkml@arm.linux.org.uk>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 17, 2005, at 9:49 AM, Russell King wrote:

> On Thu, Nov 17, 2005 at 09:36:38AM -0600, Kumar Gala wrote:
>>
>> On Nov 16, 2005, at 12:41 AM, Greg KH wrote:
>>
>>> On Tue, Nov 15, 2005 at 05:31:57PM -0600, Kumar Gala wrote:
>>>> Guys,
>>>>
>>>> I was wondering if there was any issue in changing
>>>> platform_device_add to
>>>> use insert_resource instead of request_resource.  The reason for  
>>>> this
>>>> change is to handle several cases where we have device registers  
>>>> that
>>>> overlap that two different drivers are handling.
>>>>
>>>> The biggest case of this is with ethernet on a number of PowerPC
>>>> based
>>>> systems where a subset of the ethernet controllers registers are
>>>> used for
>>>> MDIO/PHY bus control.  We currently hack around the limitation by
>>>> having
>>>> the MDIO/PHY bus not actually register an memory resource region.
>>>>
>>>> If the following looks good I'll send a more formal patch.
>>>
>>> Looks good to me, but Russell knows this code much better than I.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Russell, any issues?
>
> Haven't managed to look at this yet - busy catching up after illness.

Any update?

- kumar
