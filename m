Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVLAWpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVLAWpz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVLAWpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:45:55 -0500
Received: from kirby.webscope.com ([204.141.84.57]:31632 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932533AbVLAWpy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:45:54 -0500
Message-ID: <438F7D09.6040007@m1k.net>
Date: Thu, 01 Dec 2005 17:45:29 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org, Perry Gilfillan <perrye@linuxmail.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Don Koch <aardvark@krl.com>
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com> <1133470859.23362.59.camel@localhost> <438F73E5.5020600@linuxmail.org> <200512011726.41299.gene.heskett@verizon.net>
In-Reply-To: <200512011726.41299.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>On Thursday 01 December 2005 17:06, Perry Gilfillan wrote:
>  
>
>>Mauro Carvalho Chehab wrote:
>>    
>>
>>>After checking the datasheets of Thompson tuner, and I have one
>>>guess:
>>>
>>>At board description, tda9887 is not there. This tuner needs to work
>>>properly.
>>>
>>>This small patch does enable it for your board.
>>>
>>>You should notice that you may need to use some parameters for
>>>tda0887 to work properly, like using port1=0 port2=0 qss=0 as insmod
>>>options for this module. (these are some on/off bits at the chip, to
>>>enable some special functions - if 0/0/0 doesn't work you may need to
>>>test 0/0/1, .. 1/1/1).
>>>      
>>>
>>This has fixed it for me!!  I compiled todays cvs, with out this patch,
>>to watch it fail, then added the line as noted, and reloaded the
>>modules without rebooting, and it worked.  I did a cold start to see
>>that it is repeatable, and it continues to work.  I used no extra
>>parameters, so the defaults are working fine.
>>    
>>
>
>I haven't built it yet, had to apply the patch by hand for some reason
>here, after doing a cvs up -D today.
>
>2.6.15-rc4 under construction to test it.
>
Gene, dont bother applying the patch to the cvs code -- It is obviously 
correct, so I have merged it into v4l-dvb cvs.

A simple cvs checkout will get you everything you need.

If you like, try to apply it against the kernel, without using cvs.

Anyhow, surely it will work.  Thank you Gene, Don and Perry for helping 
us to solve this bug......... Hopefully we'll be able to get the fix 
into 2.6.15.

Cheers,

Michael Krufky


