Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUHSUzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUHSUzH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUHSUzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:55:07 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:7172 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S267442AbUHSUya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:54:30 -0400
Message-ID: <41251385.9040907@optonline.net>
Date: Thu, 19 Aug 2004 16:54:29 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: stefandoesinger@gmx.at
CC: acpi-devel@lists.sourceforge.net, len.brown@intel.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [ACPI] [PATCH][RFC] fix ACPI IRQ routing after S3 suspend
References: <41103F22.4090303@optonline.net> <200408192224.08271.stefandoesinger@gmx.at>
In-Reply-To: <200408192224.08271.stefandoesinger@gmx.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Dösinger wrote:
>>This patch should fix multiple user-visible problems with the ACPI IRQ
>>routing after S3 resume:
>>
>>"irq x: nobody cared"
>>"my interrupts are gone"
>>
>>It probably applies to multiple bugzilla entries and mailing list posts.
>>
>>Tested on my machine, which is experiencing similar problems. Seems to
>>work - although I get some non-fatal "nobody cared" messages that might
>>be caused by the i8042 driver.
>>
>>Comments?
>>Stefan, can you test this?
> 
> Sorry for the very late reply.
> 
> I tested with 2.6.8.1(I think your patch it included there) with strange 
> results.
> 
> *It works fine if I unload ipw2100 before suspend and load it later

I can't find anything named "ipw2100" in my kernel source tree...

> *In single user mode with ipw2100 loaded while S3, IRQ 11 is disabled on 
> resume, IRQ is not disabled

Huh? IRQ(what) is not disabled?

Please attach dmesg.

> *When the system is fully booted up, everything seems to work fine.

What do you mean by this? If you suspend when more drivers are loaded, 
things work fine, but don't work when less drivers are loaded?

> 
> I'll test a little bit more and report the results.

Thanks for testing.
Nathan

> 
> Cheers,
> Stefan
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
> 

