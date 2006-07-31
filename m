Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWGaFYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWGaFYW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWGaFYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:24:22 -0400
Received: from [210.76.114.181] ([210.76.114.181]:42934 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751491AbWGaFYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:24:21 -0400
Message-ID: <44CD9408.1020405@ccoss.com.cn>
Date: Mon, 31 Jul 2006 13:24:25 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Peter <peter@maubp.freeserve.co.uk>,
       The Doctor <thedoctor@tardis.homelinux.org>
Subject: Re: [PATCH 1/3] usbhid: Driver for microsoft natural ergonomic keyboard
 4000
References: <44C74708.6090907@ccoss.com.cn> <20060728135428.GC4623@ucw.cz> <44CD536C.3050703@ccoss.com.cn> <200607302130.56881.dtor@insightbb.com>
In-Reply-To: <200607302130.56881.dtor@insightbb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Well, I think you are right.

    I reviewed the "Linux Device Driver", there are some follow words in
that book:

    "the role of a device driver is providing mechanism, not policy."

    It seem my hack break this rule obviously. I will "kcah" it back
soon.   

    Thanks.


Dmitry Torokhov wrote:
> On Sunday 30 July 2006 20:48, liyu wrote:
>   
>> Pavel Machek Wrote:
>>     
>>> Hi!
>>>
>>>   
>>>       
>>>>     This new version get some improvements:
>>>>
>>>>     2. Support left paren key "(", right paren key ")", equal key "=" on
>>>> right-top keypad. In fact, this keyboard generate KEYPAD_XXX usage code
>>>> for them, but I find many applications can not handle them on default
>>>> configuration, especially X.org. To get the most best usability, I use a
>>>> bit magic here: map them to "Shift+9" and "Shift+0".
>>>>     
>>>>         
>>> That is hardly 'improvement'. 'X is broken, so lets break input, too'.
>>>
>>>
>>>
>>>   
>>>       
>> Well, however, this can work truly. If we do not hack as this way.
>> Many applications can not get its input. I think the usability for
>> most people should be first, but not follow rules.
>>
>>     
>
> I do not quite understand why X would have issues with it. KEY_KPEQUAL,
> KEY_KPLEFTPAREN and KEY_KPRIGHTPAREN should work fine even with legacy
> X keyboard driver (one that is using PS/2 protocol instead of evdev).
> You might want to adjust your XKB map or use xmodmap, but kernel should
> report true keycodes.
>  
>   
>> I think we can add one module parameter like "shift_hack" to switch it ?!
>>
>>     
>
> No please don't.
>
>   


