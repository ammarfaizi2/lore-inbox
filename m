Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVI2MUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVI2MUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVI2MUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:20:40 -0400
Received: from moutvdom.kundenserver.de ([212.227.126.249]:63697 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750727AbVI2MUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:20:39 -0400
Message-ID: <433BDC11.7070407@anagramm.de>
Date: Thu, 29 Sep 2005 14:20:33 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.2 crash on shutdown on SMP machine
References: <433A747E.3070705@anagramm.de> <Pine.LNX.4.61.0509280812250.1684@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0509280812250.1684@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Zwane!


Zwane Mwaikambo wrote:
> On Wed, 28 Sep 2005, Clemens Koller wrote:
> 
>>Last night, right before thinking about going to bed, my newly
>>installed old SMP machine crashed after a #shutdown -h now
>>as shown below:
>>
>>linux-2.6.13.2
>>old Tyan Tomcat Board, Dual Processor, 2xPentium MMX 200MHz
>>SMP enabled, preemption enabled..
>>
>>[...]
>>Shutdown: hda
>>Power down.
>>Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
>>c010fdd5    send_IPI_mask_bitmask+0x65/0x70
>>c0110236    smp_send_reschedule+0x16/0x20
> 
> We've seen this one before, how reproducible is it for you? Could you also 
> please test a 2.6.14-rc -mm kernel?

It's reproducable... I got the same thing with a slightly different configured
2.6.13.2-npe (no preemtion, no acpi, no apm) but beside that, I got other
very strange crashes (page table something thingys?) as well during a CRUX pkgmk
tool to build i.e. samba. So I wasn't able to get the system stable enough for
more serious testing yet.
I am about to grab the latest linus' git tree and try that...

This system was running for a long time with linux without any problems
in the past. But I had to change the hdd (old one was broken) and installed
a new (CRUX) system from scratch... I migrated to 2.6.13.2 and switched over
to udev... I was running memtest86 for about half a day. It didn't show any
problems. Are there good torture tests to check if a system's hw is stable?

Thanks,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
