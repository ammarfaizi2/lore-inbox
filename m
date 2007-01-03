Return-Path: <linux-kernel-owner+w=401wt.eu-S1754992AbXACHr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbXACHr3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754984AbXACHr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:47:29 -0500
Received: from www17.your-server.de ([213.133.104.17]:4669 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbXACHr2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:47:28 -0500
Message-ID: <459B5F50.8010703@m3y3r.de>
Date: Wed, 03 Jan 2007 08:46:24 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20061222)
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: ACPI: EC: evaluating _Q10
References: <45992109.9050009@m3y3r.de> <200701021205.07817.lenb@kernel.org> <459AC146.9020804@m3y3r.de> <200701022241.05303.lenb@kernel.org>
In-Reply-To: <200701022241.05303.lenb@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown schrieb:
>>> The bigger question is why you get "tons of these" --
>>> as EC  events are usually infrequent.
>>> Do you have a big number next to "acpi" in /proc/interrupts?
>>> If so, at what rate is it growing?
>>>       
>> maybe tons were a bit to overstated... After a fresh reboot, i count 110 
>> _q10 and one _q21messages now with 8 min. uptime and around 10300 acpi 
>> interrupts.
>>     
>
> 480 sec/110 ec events = 4 seconds/event.  This doesn't worry me.
> Could be battery updates, thermal updates etc.
>
> 480/10300 = an interrupt every 46 ms.
> This is certainly not right.
> Have you always seen runaway acpi interrupts on this box, no matter the kernel?
>   
To be honest i didn't care and knew about that this could be an problem 
until now. But the biggest part of the acpi interrupts seems to happen 
while the first minutes, maybe while booting because with 22 min. uptime 
i get these values:

           CPU0       CPU1
  0:     413784          0   IO-APIC-edge      timer
  9:      14544          0   IO-APIC-fasteoi   acpi

24 min. uptime:
           CPU0       CPU1
  0:     435875          0   IO-APIC-edge      timer
  9:      15247          0   IO-APIC-fasteoi   acpi

26 min. uptime:
  0:     470428          0   IO-APIC-edge      timer
  9:      16251          0   IO-APIC-fasteoi   acpi

So let's say approximatley 700 to 1000 acpi interrupts in 120 seconds. I 
guess this sounds better, doesn't it?

