Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbUBWBdr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 20:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbUBWBdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 20:33:47 -0500
Received: from imap.gmx.net ([213.165.64.20]:1220 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261782AbUBWBdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 20:33:44 -0500
X-Authenticated: #4512188
Message-ID: <40395872.2030007@gmx.de>
Date: Mon, 23 Feb 2004 02:33:38 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
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
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> On Saturday 14 February 2004 00:41, Ross Dickson wrote:
> 
>>On Friday 13 February 2004 21:17, Prakash K. Cheemplavam wrote:
>>
>>>Hi,
>>>
>>>I am just testing this patch with latest 2.6.3-rc2-mm1. It works in that 
>>>sense, that my machine doesn't lock up of APIC issue. (If it locks up - 
>>>hasn't done yet - then because of something else, I am currently 
>>>discssing it in another thread...)
>>>
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

Well, I hate to say it, but it seems, it doesn't work, or at least not 
so well, (running hot, but stability seems to be there) with 2.6.3-mm2. 
Like I had 52°C mostly idle with your patch and APIC just a few moments 
ago. Now back to PIC within a few minutes I am back to 45°C...7°C is too 
much of a difference for me.

To be honest, I can't remenber how it was with the older kernel and I 
haven't tested temp of apic_tack patch with 2.6.3-mm2, but for the 
moment I am back to PIC. (My CPU is running at 11x200MHz, 1,7vcore btw.)

Cheers,

Prakash
