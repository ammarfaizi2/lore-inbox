Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTLMJvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 04:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264545AbTLMJvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 04:51:39 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:62470 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S264540AbTLMJvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 04:51:37 -0500
Message-ID: <3FDAE10D.1090309@nishanet.com>
Date: Sat, 13 Dec 2003 04:51:09 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic,
 io-apic, udma133 covered
References: <200312131920.57880.ross@datscreative.com.au>
In-Reply-To: <200312131920.57880.ross@datscreative.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:

>>>So the fix was absolutely a BIOS fix. 
>>>
>>>      
>>>
><snip>
>
>==That's why I'm trying to contact shuttle.
>Jesse
>  
>
R> Good Work Jesse, I hope shuttle give up some info - especially as I have
pheonix bioses and they are doing ?? about it? -Ross

B> I was expecting to hear that.

I have an Award bios on MSI nforce2 mboard. Their bios flash
file begins with
"w" for Award  w6570nms.760(W6570 v760 bios flash file)
"p" phoenix
"a" ami
also appears at boot but goes by in a flash
and appears on first cmos setup page

So Award bios has a fix for the nforce2.

How about Jesse's bios that can fix the
problem without a kernel patch, as my
Award bios is doing? What kind of bios
is that you have, Jesse?

My Award bios does not make any way for
me to have ioapic edge timer turn on,
though. I need a patch to get that on.

Also I don't have a cpu disconnect choice in
setup and by running temp range 41C to 48C
I guess cpu disconnect is not on. 48C once in
a while does not hurt anything though.  -Bob

>>...but we're stuck looking at smoke and mirrors, 
>>when the kernel might be able to work around 
>>bioses that have not been "updated". Or to put 
>>it another way, "voodoo" may be done by 
>>kernel if not done by bios. Whatever is being 
>>tweaked may be accessible to kernel code. 
>>    
>>
><snip>
>Bob
>
>Please ignore the following if you are already up to speed on SMM. Some
>readers may not know why we cannot do all that the bios can do aside from
>a lack of information.
> 
>Agreed but the keywords are might and may. I remember doing dos based data acquisition 
>with 486SX laptops and then Intel brought out the 486Sl and our pulse counting 
>went bad because of the power saving core. I got the data book from Intel and
>was very dismayed to see that bios code was being executed when I thought our code
>was running and there was not a darn thing I could do about it and keep the
>laptop warranty intact. 
>
>Its offspring as you may already know is SMM. It is a priviledged mode that we can
>do pretty much squat about. It can pop up anywhere in the middle of our code 
>and the only thing we will know about it aside from missing time is when it has
>stuffed something up - like setting registers back to the wrong values. Think of
>it like a kernel within our kernel with permissions set so it can hack us but we
>cannot hack it.
>
>Maciej recently writes of its continuing effect on NMI debug here.
>
>http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2940.html
>
>Regards
>Ross
>
>  
>
Thanks for explaining. We got some new functionality
just by turning nmi_watchdog on but I don't know if
anybody has learned anything from the extra debug
have they, as far as this nforce2 timing thing?     -Bob
