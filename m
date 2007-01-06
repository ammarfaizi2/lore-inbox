Return-Path: <linux-kernel-owner+w=401wt.eu-S1751318AbXAFJCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbXAFJCY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 04:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbXAFJCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 04:02:24 -0500
Received: from mga06.intel.com ([134.134.136.21]:48902 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751318AbXAFJCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 04:02:23 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2007 04:02:22 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,156,1167638400"; 
   d="scan'208"; a="182103295:sNHT36892198"
Message-ID: <459F6366.5080609@linux.intel.com>
Date: Sat, 06 Jan 2007 11:52:54 +0300
From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Berthold Cogel <cogel@rrz.uni-koeln.de>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Regression in kernel linux-2.6.20-rc1/2: Problems with poweroff
References: <459069AA.20809@rrz.uni-koeln.de> <20061228221616.GI20714@stusta.de> <45999C47.40204@rrz.uni-koeln.de> <459D5079.70605@linux.intel.com> <459EE89F.1010505@rrz.uni-koeln.de>
In-Reply-To: <459EE89F.1010505@rrz.uni-koeln.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berthold Cogel wrote:
> Alexey Starikovskiy schrieb:
>   
>> Berthold Cogel wrote:
>>     
>>> Adrian Bunk schrieb:
>>>  
>>>       
>>>> On Tue, Dec 26, 2006 at 01:15:38AM +0100, Berthold Cogel wrote:
>>>>
>>>>    
>>>>         
>>>>> Hello!
>>>>>       
>>>>>           
>>>> Hi Berthold!
>>>>
>>>>    
>>>>         
>>>>> 'shutdown -h now' doesn't work for my system (Acer Extensa 3002 WLMi)
>>>>> with linux-2.6.20-rc kernels. The system reboots instead.
>>>>> I've checked linux-2.6.19.1 with an almost identical .config file
>>>>> (differences because of new or changed options). For pre 2.6.20 kernels
>>>>> shutdown works for my computer.
>>>>> ...
>>>>>       
>>>>>           
>>>> Thanks for your report.
>>>>
>>>> Please send:
>>>> - the .config for 2.6.20-rc2
>>>> - the output of "dmesg -s 1000000" with 2.6.20-rc2
>>>> - the output of "dmesg -s 1000000" with 2.6.19
>>>>
>>>>    
>>>>         
>>>>> Regards,
>>>>>
>>>>> Berthold Cogel
>>>>>       
>>>>>           
>>>> cu
>>>> Adrian
>>>>
>>>>     
>>>>         
>>> Hello Adrian,
>>>
>>> I've attached the informations you requested.
>>>
>>> In additon to the poweroff problem I see a lot of messages with
>>> linux-2.6.20-rc2 that I do not see with linux-2.6.20-rc1:
>>>
>>> kernel: ACPI: EC: evaluating _Q80
>>> kernel: ACPI: EC: evaluating _Q81
>>> kernel: ACPI: EC: evaluating _Q09
>>> kernel: ACPI: EC: evaluating _Q20
>>>
>>> I'm running Debian testing/unstable with 'homemade' kernels. The laptop
>>> is one of those using the Smart Battery System.
>>>
>>>
>>> Berthold
>>>   
>>>       
>> Well, I see a lot of differences not related to ACPI...
>> 20c3
>> Processor caps differ...
>> < CPU: After all inits, caps: afe9f9bf 00000000 00000000 00000040
>> 00000180 00000000 00000000
>> ---
>>     
>>> CPU: After all inits, caps: afe9f9bf 00000000 00000000 00002040
>>>       
>> 00000180 00000000 00000000
>>
>> Prefetch for PCMCIA differ
>> 68,69c52,53
>> <   PREFETCH window: 50000000-51ffffff
>> <   MEM window: 54000000-55ffffff
>> ---
>>     
>>>   PREFETCH window: 50000000-53ffffff
>>>   MEM window: 58000000-5bffffff
>>>       
>> 73c57
>> <   PREFETCH window: 50000000-52ffffff
>> ---
>>     
>>>   PREFETCH window: 50000000-55ffffff
>>>       
>> This one is new as well...
>> 168a156
>>     
>>> Yenta: Raising subordinate bus# of parent bus (#02) from #02 to #06
>>>       
>> Berthold,
>> Could you please check if disabling PCMCIA changes situation?
>>
>> Regards,
>>    Alex.
>>
>>
>>
>>     
>
> Hello Alex,
>
> I still get the same diffs. Except the yenta part of course. And the
> system is still rebooting.
>
> Berthold
>   
Good, yenta is cleared :) Could you replace /drivers/acpi/ec.c with the 
version from 2.6.19.x and try again?

Regards,
    Alex.
