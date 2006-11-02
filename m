Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWKBRjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWKBRjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWKBRjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:39:42 -0500
Received: from smtpauth03.prod.mesa1.secureserver.net ([64.202.165.183]:2516
	"HELO smtpauth03.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1751045AbWKBRjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:39:41 -0500
Message-ID: <454A2D54.4060901@seclark.us>
Date: Thu, 02 Nov 2006 12:39:32 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
CC: Dave Jones <davej@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
References: <4548DDF4.2030903@seclark.us>	 <20061101201218.GA4899@martell.zuzino.mipt.ru>	 <45490EFE.1060608@seclark.us> <20061101235546.GB10577@redhat.com>	 <4549450F.3080207@seclark.us>  <20061102030353.GA2797@redhat.com>	 <1162441409.7677.23.camel@monteirov>  <454A0352.8010207@seclark.us> <1162478860.12936.6.camel@localhost.localdomain>
In-Reply-To: <1162478860.12936.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergio Monteiro Basto wrote:

>On Thu, 2006-11-02 at 09:40 -0500, Stephen Clark wrote:
>  
>
>>Sergio Monteiro Basto wrote:
>>
>>    
>>
>>>On Wed, 2006-11-01 at 22:03 -0500, Dave Jones wrote:
>>> 
>>>
>>>      
>>>
>>>>On Wed, Nov 01, 2006 at 08:08:31PM -0500, Stephen Clark wrote:
>>>>
>>>>        
>>>>
>>>>>booting without lapic allowed it to boot but now I get
>>>>>...
>>>>>Local APIC disabled by BIOS -- you can enable it with "lapic"
>>>>>...
>>>>>Local APIC not detected. Using dummy APIC emulation.
>>>>>  which means more processor overhead - right?
>>>>>
>>>>>also cpuspeed doesn't work anymore - I don't have a cpufreq dir
>>>>>          
>>>>>
>>>>The Duron had powernow ?
>>>>   
>>>>
>>>>        
>>>>
>>>This story of trying enable lapic when BIOS don't, has been triggered on
>>>kernel2.6.18, but in my opinion is not a bug if lapic on those computers
>>>don't work.
>>>
>>>If you boot without enable lapic, you will see cat /proc/interrupts with
>>>interrupts in XT-PIC.
>>>if you try enable lapic, somehow IRQ routing should change 
>>>and if /proc/interrupts still the same, with IRQs in XT-PIC.
>>>I think, lapic still not enabled and the most you can get it's problems.
>>>Unless you know that lapic works (it is programmed and BIOS wrongly
>>>disable it), you shouldn't try enable lapic because it is probable that
>>>just give problems, to you. 
>>>Historically: In 2002/3 was a very common bug, when kernel was compiled
>>>to support lapic and try enable lapic (even when BIOS don't) and
>>>computer hangs on boot. 
>>> 
>>>
>>>      
>>>
>>Loading the correct kernel arch 686 - fixes my powernow problems - this 
>>is a mobile duron.
>>
>>Booting with lapic worked fine on  fc5 kernel-2.6.18-2200 but it causes 
>>fc6 kernel-2.6.18-2798
>>to hang.
>>    
>>
>
>With lapic boot option enabled, have you a different /proc/interrupts ? 
>have you lapic working ? 
>
>
>
>  
>
No interrupt assignments are the same - but what about the hi-res timer 
the lapic is
supposed to have and linux is suppose to use?

Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



