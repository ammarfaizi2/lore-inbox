Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVKDPHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVKDPHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVKDPHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:07:49 -0500
Received: from [85.8.13.51] ([85.8.13.51]:48790 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751459AbVKDPHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:07:48 -0500
Message-ID: <436B793F.3040808@drzeus.cx>
Date: Fri, 04 Nov 2005 16:07:43 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: Vojtech Pavlik <vojtech@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: keyboard dies during failed suspend attempt
References: <4369D04C.70509@drzeus.cx> <200511040011.18393.dtor_core@ameritech.net>
In-Reply-To: <200511040011.18393.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On Thursday 03 November 2005 03:54, Pierre Ossman wrote:
>   
>> I discovered a problem with my laptop keyboard when the machine failed 
>> to suspend. Pavel Machek pointed me in your direction for guidance. :)
>>
>> The original issue (swsusp failing) is in this thread:
>>
>> http://marc.theaimsgroup.com/?t=113093802700002&r=1&w=2
>>
>> The side issue is that the keyboard goes completely dead when the 
>> suspend fails like this. Not even hardware buttons that control the 
>> intensity of the TFT backlight work.
>>
>>     
>
> Are these controlled by ACPI?
>
>   

Haven't the slightest. There is nothing to control the backlight in 
/proc/acpi at least (all brightness say '<not supported>').

>> The problem doesn't happen every time, but it seems to be often enough 
>> to do some decent testing.
>>
>> The problem seems to have appeared after 2.6.14 was released. Since the 
>>   problem is intermittent I can't be 100% sure of this, but it's fairly 
>> likely since none of the tests before 2.6.14 failed.
>>
>>     
>
> It feels like device_resume is not called somewhere when swsusp fails.
>
> Could you try activating debug mode for i8042:
>
> 	echo 1 > /sys/modules/i8042/parameters/debug
>
> ...and then making it fail. Then we'll see if i8042 resume methods are
> called and whether they succeed.
>
>   

I've been suspending the machine all day now and I have yet to get it to 
fail. There must have been something different yesterday but I can't 
figure out what... I'll do some more testing during the weekend and see 
if I can provoke it again. Otherwise I suppose we can write it off as 
something temporary.

Rgds
Pierre

