Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVHLDLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVHLDLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVHLDLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:11:52 -0400
Received: from lig.net ([66.95.121.230]:58038 "EHLO mail.lig.net")
	by vger.kernel.org with ESMTP id S1750768AbVHLDLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:11:52 -0400
Message-ID: <42FC1356.7080708@lig.net>
Date: Thu, 11 Aug 2005 23:11:18 -0400
From: "Stephen D. Williams" <sdw@lig.net>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Soft lockup in e100 driver ?
References: <20050809133647.GK22165@mea-ext.zmailer.org> <1123604182.15991.40.camel@c-67-188-6-232.hsd1.ca.comcast.net> <20050809163632.GQ22165@mea-ext.zmailer.org> <42FA9C02.3030406@lig.net> <42FA9CAD.7030607@lig.net> <20050811073946.GT22165@mea-ext.zmailer.org>
In-Reply-To: <20050811073946.GT22165@mea-ext.zmailer.org>
Content-Type: multipart/mixed;
 boundary="------------050102070000060202040603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050102070000060202040603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

"noapic" didn't work, nor did "noacpi", etc.
Going to 2.6.13-rc6.2 solved the problem (once I integrated udev, etc.).

The chipset is an Intel 8x0 something.  Unfortunately, there is a 
heatsink semi-permanently installed over everything.  Is there a /proc 
pseudofile that will give me good identifying chipset info to report here?

If there is a FAQ for this, we should post a message about it once in a 
while.
Nothing here indicates chipset:
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html

The CPU is an Intel Celeron CPU 2.00GHz running at 1495.772 MHz, 128MB 
cache.

sdw

Matti Aarnio wrote:

>On Wed, Aug 10, 2005 at 08:32:45PM -0400, Stephen D. Williams wrote:
>  
>
>>I just noticed that the Ubuntu setup says "GSI 20(level,low) -> IRQ 20" 
>>whereas I remember my built kernels saying "No GSI......  IRQ 11".  I'll 
>>investigate what that means and how to enable it.  Pointers appreciated.
>>    
>>
>
>That is most likely unrelated, but I had similar experiences
>at times.  It turned out that something done recently in APIC
>management code did break things, but lattest version is again
>working.   For a while to have network card working I had to boot
>with  "noapic"  option in my home SMP box.
>
>In an UP box it is about same to boot as "noapic", but in SMP it
>does result in "one CPU does all interrupts" thingie.  (In some
>rare cases it could be desirable, even.)
>
>   /Matti Aarnio
>
>
>  
>
>>sdw
>>
>>Stephen D. Williams wrote:
>>
>>    
>>
>>>I have been working for days to get a recent kernel to work with these 
>>>small-format UP Celeron 2Ghz (running at 1.33Ghz) motherboards that I 
>>>am planning to use as thin clients.  I'm doing a PXE boot, loading 
>>>kernels, and trying to get networking to come up.
>>>
>>>I eventually realized that the problem is that the e100 driver loads 
>>>but does not allow any packet traffic.  The system isn't crashed, but 
>>>I do get transmit timeouts.
>>>
>>>I've used kernels: 2.6.10, 2.6.11, and 2.6.12.4, stock with only the 
>>>"squashfs" patch applied and compiled as 586/....
>>>
>>>The interesting thing is that Ubuntu 5.04, booted "Live" on the box, 
>>>works just fine with the e100 driver with a kernel shown as: 
>>>"2.6.10-5-386".  I'm going to work on pulling this kernel and its 
>>>modules off to use.
>>>
>>>Any help urgently appreciated.
>>>
>>>sdw
>>>      
>>>
>
>  
>


--------------050102070000060202040603
Content-Type: text/x-vcard; charset=utf-8;
 name="sdw.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sdw.vcf"

begin:vcard
fn:Stephen Williams
n:Williams;Stephen
email;internet:sdw@lig.net
tel;work:703-724-0118
tel;fax:703-995-0407
tel;pager:sdwpage@lig.net
tel;home:703-729-5405
tel;cell:703-371-9362
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------050102070000060202040603--
