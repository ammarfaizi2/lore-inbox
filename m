Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992985AbWJULpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992985AbWJULpp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 07:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992986AbWJULpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 07:45:45 -0400
Received: from [203.26.40.81] ([203.26.40.81]:15263 "EHLO boo.knobbits.org")
	by vger.kernel.org with ESMTP id S2992985AbWJULpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 07:45:44 -0400
Message-ID: <453A0868.307@knobbits.org>
Date: Sat, 21 Oct 2006 21:45:44 +1000
From: "Michael (Micksa) Slade" <micksa@knobbits.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Inspiron 6000 and CPU power saving
References: <EB12A50964762B4D8111D55B764A8454C1A3F3@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454C1A3F3@scsmsx413.amr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:

> 
>
>  
>
>>-----Original Message-----
>>From: linux-kernel-owner@vger.kernel.org 
>>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>>Michael (Micksa) Slade
>>Sent: Sunday, October 15, 2006 7:18 PM
>>To: linux-kernel@vger.kernel.org
>>Subject: Inspiron 6000 and CPU power saving
>>
>>I recently discovered that my Inspiron 6000 uses about 50% more power 
>>idling in linux than in windows XP.  This means its battery life is 
>>about 2/3 of what it could/should be.
>>
>>I guessed it might be the CPU, and did some tests.  The 
>>results strongly 
>>suggest as much.  These are the results I got for power consumption in 
>>various situations.
>>
>>linux idle at 800MHz: 27W        
>>linux idle at 1600MHz: 36W        
>>linux raytracing at 800: 30W
>>linux raytracing at 1600: 42W 
>>
>>windows idle (presumably 800MHz): 16W
>>windows raytracing (presumably 1600MHz): 36W
>>
>>I've tried ubuntu dapper and ubuntu edgy, and RIP 10 (rescue disk) and 
>>BBC 2.1 (rescue disk), and they all appear to have the same 
>>issue.  The 
>>machine's BIOS has no APM so I can't try it for comparison.
>>
>>I've tried noapic and "echo n > 
>>/sys/module/processor/parameters/max_cstate", where n is 1 thru 4.  
>>Neither appear to have any affect.
>>
>>I need help digging deeper.  I guess /proc/acpi/processor/CPU0/power 
>>could give some insight but I'm not sure how to read the 
>>numbers.  That 
>>and "learn about ACPI" is all I can figure out so far.
>>
>>So where to from here?  I am prepared to spend a significant amount of 
>>time researching and resolving the issue, so feel free to suggest 
>>reading the ACPI spec or whatever if that's what it's going to take.
>>
>>Mick.
>>
>>    
>>
>
>Output of 
>#cat /proc/acpi/processor/CPU0/power/*
>And
>#cat /sys/devices/system/cpu/cpu0/cpufreq/*
>Will be a good starting point.
>
>Also, open a issue at bugme.osdl.org. It makes tracking the issues
>easier that way.
>
>Thanks,
>Venki
>  
>
Done.

http://bugzilla.kernel.org/show_bug.cgi?id=7393

As part of this I've also tried vanilla 2.6.19-rc2 and done another 
small test. See the report.

Mick.

