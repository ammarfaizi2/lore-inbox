Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVGZVxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVGZVxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVGZVva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:51:30 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:17392 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262174AbVGZVvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:51:18 -0400
In-Reply-To: <20050726175014.GB1493@kroah.com>
References: <20050726175014.GB1493@kroah.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CD00B904-5FCE-42C9-9F83-81EE145E2F50@freescale.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: PCI: fix up errors after dma bursting patch and CONFIG_PCI=n -- bug?
Date: Tue, 26 Jul 2005 16:51:07 -0500
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 26, 2005, at 12:50 PM, Greg KH wrote:

> On Mon, Jul 25, 2005 at 11:52:43PM -0500, Kumar Gala wrote:
>
>> Andrew,
>>
>> In the patch from:
>>
>> http://www.uwsg.iu.edu/hypermail/linux/kernel/0506.3/0985.html
>>
>> Is the the following line suppose inside the if CONFIG_PCI=n
>>
>>   #define pci_dma_burst_advice(pdev, strat, strategy_parameter) do  
>> { }
>>
> while (0)
>
>>
>> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
>>
>
> Hm, how did that work?

I'm somewhat baffled by that as well.  I did a full build regression  
of the 50 PPC32 defconfigs and only one broke because of this.  I'm  
still a bit confused as to why.

> Bah, that pci.h file needs some major cleanups, I'll apply this patch
> and clean up the rest to make it more sane.

Cool, just want to make sure the minor fix makes it to linus before  
2.6.13.

- kumar
