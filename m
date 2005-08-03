Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVHCJrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVHCJrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVHCJrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:47:10 -0400
Received: from ns1.axalto.com ([194.98.128.2]:48348 "EHLO
	cro-su-02.croissy.axalto.com") by vger.kernel.org with ESMTP
	id S262178AbVHCJrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:47:08 -0400
Date: Wed, 03 Aug 2005 11:47:07 +0200
From: bgerard <bgerard@axalto.com>
Subject: Re: hotplug problem
In-reply-to: <42F08247.1020405@anagramm.de>
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42F0929B.6040005@axalto.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
References: <42F078F3.4040808@axalto.com> <42F08247.1020405@anagramm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Koller wrote:

> Hi Ben!
>
> bgerard wrote:
>
>> I'm working on an embeded system with linux kernel 2.4.27 and busybox 
>> 1.00. Lately I've decided to add hotplug feature to my kernel in 
>> order to automaticaly mount usb keys.
>>
>> When I plug the usb key, I can see in the kernel debug that 
>> "/sbin/hotplug" is called but my script is not executed. I've tried 
>> to replace the hotplug script by a simple one but nothing appeared. 
>> Here is my script :
>> #!/bin/sh
>> echo "usb key un/plugged"
>
>
> I don't know much about hotplugging on 2.4.x and how you might need
> to enable it in /proc... it just works for me on 2.6. with
> CONFIG_HOTPLUG enabled and the latest hotplug-scripts.
>
>> The script is working when I run it myself (./sbin/hotplug )
>>
>> I've also noticed that when kmod try to call modprobe, it's not 
>> executed while the debug message says that everything went fine.
>
>
Hotplug is well enabled in /proc/sys/kernel/hotplug, I specified in it 
the path of /sbin/hotplug and according to the documentation that's all 
I need to do to configure hotplug.

> Try newer modutils?
>
I don't think modutils is responsible for that, I think the kernel can't 
call program in the user space and I don't kwnow why

Thank you for your quick answer
Regards
Ben.

> And you might have more luck asking on:
> linux-hotplug-devel@lists.sourceforge.net
> Greets,
>
> Clemens
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


