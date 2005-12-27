Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVL0Tsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVL0Tsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 14:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVL0Tsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 14:48:45 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:5875 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751137AbVL0Tsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 14:48:45 -0500
Date: Tue, 27 Dec 2005 14:48:42 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Sensors errors with 15-rc6, 15-rc5 was normal
In-reply-to: <20051223112127.2bb67a07.khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizononline.net
Message-id: <200512271448.42177.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200512201505.43199.gene.heskett@verizon.net>
 <200512211835.34309.gene.heskett@verizon.net>
 <20051223112127.2bb67a07.khali@linux-fr.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 December 2005 05:21, Jean Delvare wrote:
>Hi Gene,
>
>> [root@coyote root]# i2cdump 1 0x4e b
>> WARNING! This program can confuse your I2C bus, cause data loss and
>> worse!
>> I will probe file /dev/i2c-1, address 0x4e, mode byte
>> Continue? [Y/n] y
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f   
>> 0123456789abcdef 00: 00 08 33 33 03 80 01 00 00 00 ff 00 00 00 00
>> 00    .?33???......... 10: 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00    ................ 20: 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00    ................ 30: 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00    ................ 40: 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00    ................ 50: 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00    ................ 60: 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00    ................ 70: 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   
>> ................ 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00    ................ a0: 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00    ................ b0: 00 00 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00    ................ c0: 00 00 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00    ................ d0: 00 00 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00    ................ e0: 00 00 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00    ................ f0: 00 00 00
>> 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
>
>Don't know what it is, but most certainly not a temperature sensor.
>
>> THRM at default, and temp2, both result in only one reading, of
>> about 156F in gkrellm, I guess I better truck this thing out to an
>> air hose & give it a litteral blow job.
>
>If ACPI gets the temperature value from the W83627HF chip as the
>w83627hf driver does, I would expect concurrent access issues. If you
>are having temperature readings trouble again, try only using either
> of the (ACPI) thermal or w83627hf drivers, not both, and see if
> things improve.
>
>I have no idea how such conflicts can be prevented in the big
> picture.

Put it in the snilmerg category Jean.

I had first built the -rc6 kernel with the compiler optimizations 
turned on as that was the default when my script ran the make 
oldconfig.  No squawks, but subtle things like this didn't work.  So I 
built it with that optimization turned off.  Got lots of squawks, 
something about the timer I think, and ntpd didn't work.  Built it 
with the size optimization turned on again.  It worked. And -rc7 is 
now working, built from the same .config, after a make oldconfig.

And this is from the full dl of -rc7, I was asleep when I did it last 
night & didn't get the patch, but the whole thing.

Thats what 4 days away does, away at a nieces dairy farm in NY, 430 
miles one way, for the Christmas days.  And weather turned sour coming 
back, not enough to bother me much, but at one point my wife turned to 
me and said "if and when you sell this truck, you'll have to explain 
to the new owner that those cuts and gouges in the passenger grab rail 
above the glovebox were made by your wifes fingernails".  I darned 
near lost it laughing at her.  Obviously, we went to different driving 
schools, she to drivers ed, and me to Glare Ice University the year I 
turned 16.  55 years ago now, but those lessons stick to you really 
well.  But they also allow one to safely go 10-40 mph faster than the 
drivers ed rules.  And kept me alive many times when idiots are 
indestinguishable from common loose nuts behind the wheel.

I hope you had a merry Christmas too.

Whatever it was that got the tummy ache seems to have found the 
pepto-bismol and is ok now. :-)

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
