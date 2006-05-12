Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWELVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWELVGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWELVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:06:50 -0400
Received: from heisenberg.zen.co.uk ([212.23.3.141]:12947 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S932243AbWELVGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:06:49 -0400
Message-ID: <4464F8D9.7020600@cantab.net>
Date: Fri, 12 May 2006 22:06:33 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [patch 5/9] Add Geode HW RNG driver
References: <20060512103522.898597000@bu3sch.de> <20060512103648.229129000@bu3sch.de> <44646C08.9000800@cantab.net> <200605122246.58961.mb@bu3sch.de>
In-Reply-To: <200605122246.58961.mb@bu3sch.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Heisenberg-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> On Friday 12 May 2006 13:05, you wrote:
>> mb@bu3sch.de wrote:
>>> Signed-off-by: Michael Buesch <mb@bu3sch.de>
>>> Index: hwrng/drivers/char/hw_random/Kconfig
>>> ===================================================================
>>> --- hwrng.orig/drivers/char/hw_random/Kconfig	2006-05-08 00:11:59.000000000 +0200
>>> +++ hwrng/drivers/char/hw_random/Kconfig	2006-05-08 00:12:08.000000000 +0200
>>> @@ -35,3 +35,16 @@
>>>  	  module will be called amd-rng.
>>>  
>>>  	  If unsure, say Y.
>>> +
>>> +config HW_RANDOM_GEODE
>>> +	tristate "AMD Geode HW Random Number Generator support"
>>> +	depends on HW_RANDOM && (X86 || IA64) && PCI
>>                                      ^^^^^^^
>> IA64?
> 
> I have no idea. I neither wrote the driver, nor do I have the device.
> So, drop IA64?

Yes, the AMD Geode CPUs are all x86.

>>> +	default y
>>> +	---help---
>>> +	  This driver provides kernel-side support for the Random Number
>>> +	  Generator hardware found on AMD Geode based motherboards.
>>> +
>>> +	  To compile this driver as a module, choose M here: the
>>> +	  module will be called geode-rng.
>> You need to state which members of the Geode family have this hardware.
>>  e.g., Is it only the Geode LX CPUs?
> 
> Well, no idea. It was not stated in the existing old help text either.

I checked the datasheets for the Geode GX, Geode LX and Geode NX and 
only the Geode LX has an on-chip random number generator.  So this 
driver must be for the Geode LX only.

David Vrabel

