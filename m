Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933083AbWF2XRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933083AbWF2XRy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbWF2XRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:17:53 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:8037 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S933083AbWF2XRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:17:52 -0400
Date: Thu, 29 Jun 2006 17:17:38 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from Longhaul
 by rw semaphores
In-reply-to: <fa.lpmuYQxc6OV7Bh11JMM/FzqVWyY@ifi.uio.no>
To: =?ISO-8859-2?Q?Rafa=B3_Bilski?= <rafalbilski@interia.pl>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Message-id: <44A45F92.8000904@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-2; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.lpmuYQxc6OV7Bh11JMM/FzqVWyY@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafa³ Bilski wrote:
>> It needs there to be no bus mastering occuring at the time
>> of a CPU speed transition. Though I'm unable to find the part that me
> ntions
>> this in the specs I have right now.
> 
>> Dave
> 
> "Once this is set, the processor will switch to the
> value in [26:23] on the next AUTOHALT transition. The duration of the A
> UTOHALT
> should be >=1ms to ensure the CPU's internal PLL is resynchronized. F
> or AUTOHALT, this means interrupts must be disabled except for the time ti
> ck, which should be reset to >=1ms. Care must be taken to avoid other sys
> tem events that could interfere with this operation. A few examples are 
> snooping, NMI, INIT, SMI and FLUSH."
> 
> For CPU's with Longhaul MSR this time is equal to 200us.

That really is a rather horrible design on their part. Who the hell at 
VIA thought this was a good idea?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

