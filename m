Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWBXQOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWBXQOX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 11:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWBXQOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 11:14:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5249 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750835AbWBXQOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 11:14:22 -0500
Message-ID: <43FF30D1.8060708@osdl.org>
Date: Fri, 24 Feb 2006 08:14:09 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: woho@woho.de
CC: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [git patches] net driver fixes
References: <20060224052214.GA14586@havoc.gtf.org> <200602240859.23062.woho@woho.de>
In-Reply-To: <200602240859.23062.woho@woho.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Hoffmann wrote:
> On Friday 24 February 2006 06:22, Jeff Garzik wrote:
>   
>> Please pull from 'upstream-fixes' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
>>
>> [...]
>> Stephen Hemminger:
>>       sky2: yukon-ec-u chipset initialization
>>       sky2: limit coalescing values to ring size
>>       sky2: poke coalescing timer to fix hang
>>       sky2: force early transmit status
>>       sky2: use device iomem to access PCI config
>>       sky2: close race on IRQ mask update.
>> [...]
>>     
>
> Thanks for the update.
>
> Still I'm seeing reproducable hangs with this version of sky2 (as reported in 
> bugzilla 6084 and discussed on netdev).
>
> Stephen, if there is anything I can do to narrow down my hangs a bit more 
> systematically, please let me know, I'd be happy to help.
>
> Wolfgang
>   
There is an outstanding bug where the sky2 will hang if it receives a 
packet larger than the
MTU.  At this point, there isn't enough information on chip behavior to fix.

You could try using a larger mut or patching the driver so that the 
rx_buffer_size is always big (like 4k).
