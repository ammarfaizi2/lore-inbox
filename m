Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbVKQPgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbVKQPgM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVKQPgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:36:11 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:52230 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750786AbVKQPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:36:11 -0500
In-Reply-To: <20051116064123.GA31824@kroah.com>
References: <Pine.LNX.4.44.0511151727170.32393-100000@gate.crashing.org> <20051116064123.GA31824@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <18C975E2-BA90-4595-8C50-63E5CFB9C0A1@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: overlapping resources for platform devices?
Date: Thu, 17 Nov 2005 09:36:38 -0600
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


On Nov 16, 2005, at 12:41 AM, Greg KH wrote:

> On Tue, Nov 15, 2005 at 05:31:57PM -0600, Kumar Gala wrote:
>> Guys,
>>
>> I was wondering if there was any issue in changing  
>> platform_device_add to
>> use insert_resource instead of request_resource.  The reason for this
>> change is to handle several cases where we have device registers that
>> overlap that two different drivers are handling.
>>
>> The biggest case of this is with ethernet on a number of PowerPC  
>> based
>> systems where a subset of the ethernet controllers registers are  
>> used for
>> MDIO/PHY bus control.  We currently hack around the limitation by  
>> having
>> the MDIO/PHY bus not actually register an memory resource region.
>>
>> If the following looks good I'll send a more formal patch.
>
> Looks good to me, but Russell knows this code much better than I.
>
> thanks,
>
> greg k-h

Russell, any issues?

- kumar

