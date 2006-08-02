Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWHBQvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWHBQvc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWHBQvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:51:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:34938 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750955AbWHBQvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:51:31 -0400
X-IronPort-AV: i="4.07,206,1151910000"; 
   d="scan'208"; a="109244361:sNHT32388167"
Message-ID: <44D0D7CA.2060001@intel.com>
Date: Wed, 02 Aug 2006 09:50:18 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Charlie Brady <charlieb@budge.apana.org.au>
CC: NetDev <netdev@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       molle.bestefich@gmail.com
Subject: Re: [bug] e100: checksum mismatch on 82551ER rev10
References: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com>
In-Reply-To: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2006 16:51:29.0336 (UTC) FILETIME=[E68FC380:01C6B653]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[cc-ing netdev]
[adding original thread authors back, please do not strip CC]

Charlie Brady wrote:
>> Molle Bestefich wrote:
>>> The NICs are working perfectly.
>> How can you tell? Do you know if jumbo frames work correctly? Is the
>> device properly checksumming? is flow control working properly? These
>> and many, many more settings are determined by the EEPROM. Seemingly it
>> may work correctly, but there is no guarantee whatsoever that it will 
>> work
>> correctly at all if the checksum is bad. Again, you can lose data, or
>> worse, you could corrupt memory in the system causing massive failure 
>> (DMA
>> timings, etc). Unlikely? sure, but not impossible.
> 
> Let's assume that these things are all true, and the NIC currently does 
> not work perfectly, just imperfectly, but acceptably. With the recent 
> driver change, it now does not work at all. That's surely a bug in the 
> driver.

There is no logic in that sentence at all. You're saying that the driver is 
broken because it doesn't fix an error in the EEPROM?

We're trying extremely hard to fix real errors here (especially when we find 
that hardware resellers send out hardware with EEPROM problems) and you are 
asking for a workaround that will (likely) introduce random errors and failure 
into your kernel. I do not want to accept responsability for that and I also 
do not think any other kernel developer would like me to release such a risk 
into the kernel. I'd probably get whistled back instantly :)

If you want to edit your own kernel then I am fine with it. If you want to 
recalculate the checksum yourself and put it in the EEPROM then I am also fine 
with that. As long as you never ask for support for that NIC. But we can't 
support an option that allows all users to willingly enable a piece of 
non-properly-working hardware. Because that is what it is: Not properly 
configured hardware.

The bottom line is that your problem is that a specific hardware vendor is/was 
selling badly configured hardware, and you buy it from them, even after it's 
End Of Lifed for that vendor. Even though that vendor did buy the units 
properly configured and had all the tools needed to configure them properly. I 
can maybe fix your problem by seeing if we can get you an eeprom update, but I 
can not break everyone elses kernel for that.

Auke



