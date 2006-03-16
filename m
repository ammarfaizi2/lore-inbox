Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751551AbWCPMgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbWCPMgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 07:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbWCPMgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 07:36:39 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:20636 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750970AbWCPMgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 07:36:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=XTHbN9fR4GtGm4hdff6+vFOAwLdbl8i52EmLxBwcRiENdyJYfcj79hyR8T0NcckgKkdS2/ab3/KxgA3uNJ1/ho6eeyI+7+1Dqm82PHuRtgDVK4yTnNIvJLHHskssIhqPoCcyMjPaHTSG85Nrk8QvyRK+QxUz5yKtMCoWI80oiLI=
Message-ID: <44195BD0.2020506@gmail.com>
Date: Thu, 16 Mar 2006 13:36:32 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.5 (X11/20060224)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc6-git6 compilation fails (input system)
References: <441946AA.2070006@gmail.com> <20060316113206.GB3914@stusta.de> <44195429.8070809@gmail.com> <20060316122522.GC3914@stusta.de>
In-Reply-To: <20060316122522.GC3914@stusta.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk ha scritto:
> On Thu, Mar 16, 2006 at 01:03:53PM +0100, Patrizio Bassi wrote:
>   
>> Adrian Bunk ha scritto:
>>     
>>> On Thu, Mar 16, 2006 at 12:06:18PM +0100, Patrizio Bassi wrote:
>>>   
>>>       
>>>> i've a problem with gcc 4.1.0
>>>>
>>>>
>>>> LD drivers/ide/built-in.o
>>>> CC drivers/input/input.o
>>>> In file included from drivers/input/input.c:16:
>>>> include/linux/input.h:957: warning: ‘struct input_device_id’ declared
>>>> inside parameter list
>>>> include/linux/input.h:957: warning: its scope is only this definition or
>>>> declaration, which is probably not what you want
>>>> drivers/input/input.c: In function ‘input_register_device’:
>>>> drivers/input/input.c:842: warning: passing argument 3 of
>>>> ‘handler->connect’ from incompatible pointer type
>>>> drivers/input/input.c: In function ‘input_register_handler’:
>>>> drivers/input/input.c:898: warning: passing argument 3 of
>>>> ‘handler->connect’ from incompatible pointer type
>>>> ...
>>>>     
>>>>         
>>> Please send your .config .
>>>
>>> cu
>>> Adrian
>>>
>>>   
>>>       
>> remving joystick interface fixed it, but a nice warning still remains:
>>
>> In file included from drivers/input/serio/libps2.c:19:
>> include/linux/input.h:957: warning: ‘struct input_device_id’ declared
>> inside parameter list
>> include/linux/input.h:957: warning: its scope is only this definition or
>> declaration, which is probably not what you want
>>     
>
> Your .config compiles for me with neither errors nor warnings in the 
> input system.
>
> Well, with the exception that "make oldconfig" reveals that you have the 
> following options set that aren't present in 2.6.16-rc6-git6:
> CONFIG_NO_IDLE_HZ=y
> CONFIG_FB_SPLASH=y
>
>   
>> this should be the cause of the problem.
>>     
>
> It seems the cause of the problem is that you omitted the information 
> that what you call "2.6.16-rc6-git6" is in fact 2.6.16-rc6-git6 plus
> tons of patches, and one of these patches is causing your problem.
>
>   
>> Patrizio
>>     
>
> cu
> Adrian
>
>   
no i just have the Con Kolivas dynticks patch and the gentoo fbsplash one.

the whole kernel compiles good without the joystick interface,
the 2 patches don't touch the input.h file or related..

Patrizio.
