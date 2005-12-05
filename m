Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVLEOlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVLEOlk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVLEOlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:41:40 -0500
Received: from elmo.2sheds.de ([195.143.155.10]:26752 "EHLO elmo.2sheds.de")
	by vger.kernel.org with ESMTP id S932429AbVLEOlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:41:40 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
In-Reply-To: <6D6905B5-6DAF-47FC-A0AC-BDE089D3F103@2sheds.de>
References: <6D6905B5-6DAF-47FC-A0AC-BDE089D3F103@2sheds.de>
X-Gpgmail-State: !signed
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AF41465C-AE05-4077-A52F-CA08796B925A@2sheds.de>
Content-Transfer-Encoding: 7bit
From: Andrew Miehs <andrew@2sheds.de>
Subject: /proc/stat [Subject changed]
Date: Mon, 5 Dec 2005 15:41:38 +0100
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear List,

I have looked through all the archives, and have unfortunately not  
been able to
find any answers to my questions regarding using the /proc filesystem.

I would greatly appreciate it if anyone in the know, could spare the  
two minutes
to have a look at my question below, or tell me where I should look  
to get it
answered.

Thanks in advance for your help,

Andrew


On Dec 2, 2005, at 4:17 PM, Andrew Miehs wrote:
>
> Dear list,
>
> I had some questions regarding using /proc/stat (on the 2.6 kernel).
>
> Can I assume that reading /proc/stat is 'atomic'? Can I assume that  
> when I read
> the file, that nothing will change the data while I am reading it?
> IE:
>   cpu  15948315 4687107 3321012 122412279 659908 43304 144288
>   cpu0 15948315 4687107 3321012 122412279 659908 43304 144288
>
> can I assume that while I am reading the third value (system), that  
> the fourth value (idle)
> will not be changed underneath me? Can I assume that all the lines?  
> cpu, cpu0 will all be
> generated at once?
>
>
> My second question is regarding using these values to calculate  
> usage...
>
> Should I calculate usage by
> (where T1, T2 are time)
>
> A) read /proc/stat
>    Fill variables UserT1, NiceT1, SystemT1, IdleT1, IOWaitT1,  
> irqT1, irq2T1
>    wait a time
>    Fill variables UserT2, NiceT2, SystemT2, IdleT2, IOWaitT2,  
> irqT2, irq2T2
>    DeltaTotalTime=(UserT2-UserT1)+(NiceT2-NiceT1)+(SystemT2- 
> SystemT1)+(.........)
>
>    Then calculate the values I want as the delta  
> variableOfInterest / total delta
>    ie: (UserT2-UserT1)/DeltaTotalTime
>
>    Can I assume that all these values added together should add up  
> to 100%?
>
>
> or
>
>
> B) read /proc/stat
>    read variable of interest, ie: UserT1 and btimeT1 and number of  
> CPUs
>    wait a time
>    read variable of interest, ie: UserT2 and btimeT2 and number of  
> CPUs
>
>    Then calculate the values I want as
>      ((UserT2-UserT1)/NumCPU)/(btimeT2-btimeT1)*100 (Jiffies)
>

