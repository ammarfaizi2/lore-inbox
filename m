Return-Path: <linux-kernel-owner+w=401wt.eu-S1751438AbXAFR0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbXAFR0z (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 12:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXAFR0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 12:26:55 -0500
Received: from ironport-out.pppoe.ca ([206.248.154.62]:24619 "EHLO
	ironport-out.pppoe.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbXAFR0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 12:26:54 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 12:26:54 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAJZon0VBJ8Tuh2dsb2JhbACNPQEJDio
X-IronPort-AV: i="4.13,157,1167627600"; 
   d="scan'208"; a="64936241:sNHT17021076"
Message-ID: <459FD993.3070909@xandros.com>
Date: Sat, 06 Jan 2007 12:17:07 -0500
From: Woody Suwalski <woodys@xandros.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Alessandro Zummo <alessandro.zummo@towertech.it>,
       rtc-linux@googlegroups.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 2.6.20-rc3 1/3] rtc-cmos driver
References: <200701051001.58472.david-b@pacbell.net> <20070105214509.12190340@inspiron> <200701051910.02975.david-b@pacbell.net> <200701051933.26368.david-b@pacbell.net>
In-Reply-To: <200701051933.26368.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> On Friday 05 January 2007 7:10 pm, David Brownell wrote:
>   
>> On Friday 05 January 2007 12:45 pm, Alessandro Zummo wrote:
>>     
>
>   
>>>  I'd appreciate if someone (Woody?) can test
>>>  this code on ARM.
>>>       
>> There are PPC, M68K, SPARC, and other boards that could also
>> use this; ARMs tend to integrate some other RTC on-chip.  But
>> on whatever non-PC platform is involved in such sanity testing,
>> that involves adding a platform_device to board setup code.
>>     
>
> Let me put that differently.  That should be done as a separate
> patch, adding (a) that platform_device, and maybe platform_data
> if it's got additional alarm registers, and (b) Kconfig support
> to let that work.  I'd call it a "patch #4 of 3".  ;)
>
> The current Kconfig uses:
>
>   
>> +config RTC_DRV_CMOS
>> +       tristate "CMOS real time clock"
>> +       depends on RTC_CLASS && (X86_PC || ACPI)
>>     
>
> Eventually maybe the PC-or-ACPI stuff should vanish, but IMO
> not until this code has been used on a few other platforms.
>
> - Dave
>   
I will try to play with the new code on Monday on ARM...

Thanks, Woody
