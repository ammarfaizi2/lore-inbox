Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVBFLtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVBFLtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBFLnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:43:19 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:37580 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261205AbVBFLlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:41:09 -0500
Message-ID: <4206024B.2030403@drzeus.cx>
Date: Sun, 06 Feb 2005 12:40:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Strange device init
References: <4204FDEA.3090306@drzeus.cx> <20050205215504.GA3621@neo.rr.com>
In-Reply-To: <20050205215504.GA3621@neo.rr.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Belay wrote:

>On Sat, Feb 05, 2005 at 06:10:02PM +0100, Pierre Ossman wrote:
>  
>
>>I'm having problem with a card reader on a laptop (Acer Aspire 1501). 
>>The device doesn't get its resources configured properly.
>>
>>The reader is connected to the LPC bus so there is no standardised way 
>>to configure the device. On other laptops the configuration is done via 
>>ACPI (_STA & co. in the DSDT). On this laptop these functions don't do a 
>>damn thing.
>>In Windows this device gets configured through some other means. It's 
>>not in the driver (I've disected it to confirm this). But under Linux 
>>the device is left unconfigured.
>>
>>So my question is if anyone has any ideas on how this device gets 
>>configured by Windows and possibly how we can get this to work on Linux.
>>
>>The reason this is an issue is that one cannot detect all the quirks of 
>>the hardware so a PNP solution is prefered. In those cases the 
>>manufacturer has chosen resources that work ok.
>>
>>For some context: I am the maintainer of the driver for this hardware. I 
>>have a laptop where the DSDT properly sets up the hardware. The Acer 
>>belongs to some of my users but they are not familiar with the kernel so 
>>I'm trying to fix this for them.
>>
>>Rgds
>>Pierre
>>    
>>
>
>So the device is not listed in the DSDT, or _SRS doesn't work?  Does _STA
>succeed?  Finally have you checked if PnPBIOS detects the device?  Any
>additional information you could provide would be appreciated.
>
>  
>
The device is listed in the DSDT but the functions are empty. E.g. _SRS:

Method (_SRS, 1, NotSerialized)
{
}

_PRS and _CRS at least returns the proper resources that should be used.

PNPBIOS cannot be compiled in. This is a x86_64 machine and PNPBIOS is 
dependent on ISA. Are there any user-space tools that can do the same 
thing? Just to do some testing.

Rgds
Pierre

