Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269319AbUIAAlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269319AbUIAAlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269336AbUIAAk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:40:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:55530 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269054AbUIAAiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:38:19 -0400
Message-ID: <413519F7.3000004@acm.org>
Date: Tue, 31 Aug 2004 19:38:15 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPMI driver updates for 2.4
References: <411EB8F1.5040209@acm.org> <20040823132820.GB2157@logos.cnet> <4132A17A.8060607@acm.org> <20040831111621.GE4615@logos.cnet>
In-Reply-To: <20040831111621.GE4615@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There actually aren't any bug fixes.  These are all new feature 
additions.  It is a big driver revamp, but it has been around for a while

I guess it is not critical now, but it would be nicer for the users of 
the driver.

-Corey

Marcelo Tosatti wrote:

>Hi Corey, 
>
>You wrote a nice changelog entry - thanks for that.
>
>I'm not sure if we should apply all of this in v2.4. It looks like a
>big driver revamp to me. 
>
>Is is all this critical for being merged in v2.4.x now? 
>
>Would it be very painful/unwanted to maintain only the bugfixes 
>and not only new features? What you think about that?
>
>On Sun, Aug 29, 2004 at 10:39:38PM -0500, Corey Minyard wrote:
>  
>
>>Marcelo Tosatti wrote:
>>
>>    
>>
>>>Corey,
>>>
>>>Care to write a detailed changelog so we can apply this?
>>>
>>>Thanks
>>>
>>>
>>>
>>>      
>>>
>>I'm sorry this took so long, I have been dealing with disasters at work.
>>
>>Ok, a detailed changelog:
>>
>>* Add a new "system interface" driver that supports all the standard
>> IPMI system interfaces (SMIC, BT, and KCS, see the IPMI spec for
>> more details if you care).  This driver will auto-detect the interface
>> type and parameters via SMBIOS or ACPI tables.
>>* Deprecate the old KCS-only interface.
>>* Support non-contiguous registers for system interfaces.
>>* Add support for IPMI LAN bridging so messages can be received
>> from and sent to system software connected to a LAN interface.
>>* Add support for powering off the system on a halt via the IPMI
>> interface.
>>* Add support for storing panic logs in the IPMI event log.
>>* Allow control of message parameters (resends, timeouts)
>>
>>I've also re-attached the patch.
>>
>>Thanks,
>>    
>>

