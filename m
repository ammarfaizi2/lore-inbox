Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbUBNLQk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 06:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUBNLQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 06:16:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:53474 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261775AbUBNLQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 06:16:38 -0500
X-Authenticated: #4512188
Message-ID: <402E0386.5090004@gmx.de>
Date: Sat, 14 Feb 2004 12:16:22 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
CC: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround
 instead of apic ack delay.
References: <200402120122.06362.ross@datscreative.com.au> <402CB24E.3070105@gmx.de> <200402140041.17584.ross@datscreative.com.au> <200402141124.50880.ross@datscreative.com.au>
In-Reply-To: <200402141124.50880.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>But it doesn't work in the sense of cooling my machine down. Though 
>>>athcool reports disconnect is activated it behaves like it is not, ie, 
>>>turning disconnect off makes no difference in temperatures. Your old 
>>>tack patch in conjunction with 2.6.2-rc1 (linus) works like a charm, ie 
>>>no lock-ups and less temp.
>>>
>>
>>Thanks Prakash for testing it and spotting thermal problem.
>>
>>Here are some temperatures from my machine read from the bios on reboot.
>>I gave it minimal activity for the minutes prior to reboot.
>>
>>Win98, 47C
>>XPHome, 42C
>>Patched Linux 2.4.24 (1000Hz), 40C
>>Patched Linux 2.6.3-rc1-mm1, 53C  OUCH!
>>
>>Sorry, I will have to go through my latest patch and see why the temp differs
>>so much between 2.4 and 2.6. I currently use patched 2.4.24 with Suse 8.2 for
>>convenience. When it stopped the lockups on 2.6 I thought the 2.6 was
>>working the same way. 
>>
> 
> 
> Found the problem for 2.6
> 
> After fixing it the 2.6 temperature is
> Patched Linux 2.6.3-rc1-mm1, 38C
> Ambient today is 1C cooler also.

Yes, I am just trying your new patch, and it works! Furthermore it seems 
to have less ipact on system performance than the tack one, as now 
hdparm reports the same figures as without using APIC. Well done!

Have you read the post  from Mathieu about his finding of APIC and 8254 
timer not being sync, which causes lock-ups? Maybe there should be the 
correct way of fixing it. Furthermore I saw this in latest ACPI update:
[ACPI] nforce2 timer lockup from Maciej W. Rozycki

Is this the fix or something else?

Cheers,

Prakash
