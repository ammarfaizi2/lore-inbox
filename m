Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVAABKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVAABKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 20:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVAABKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 20:10:23 -0500
Received: from mail.tmr.com ([216.238.38.203]:6600 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S262168AbVAABKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 20:10:09 -0500
Message-ID: <41D5FB14.8090704@tmr.com>
Date: Fri, 31 Dec 2004 20:21:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fryderyk Mazurek <dedyk@go2.pl>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: Problems with 2.6.10
References: <41D3646A.9020806@tmr.com><20041228145600.6A9FC193D36@r10.go2.pl> <20041230164546.987845674D@rekin12.go2.pl>
In-Reply-To: <20041230164546.987845674D@rekin12.go2.pl>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fryderyk Mazurek wrote:
> Hello!
> 
> I'm sorry, but acpi=routeirq doesn't work. But to my head came other
> thing. I noticed that I on 2.6.9 (which correct works) I have this
> part of dmesg:

Not surprised, that should be pci=routeirq, as in the original post. Do 
you have preempt on?
> 
> hdb: Host Protected Area detected.
> 	current capacity is 66055248 sectors (33820 MB)
> 	native  capacity is 78165360 sectors (40020 MB)
> hdb: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63,
> UDMA(33)
> 
> and on 2.6.10 I have:
> 
> hdb: Host Protected Area detected.
> 	current capacity is 66055248 sectors (33820 MB)
> 	native  capacity is 78165360 sectors (40020 MB)
> hdb: Host Protected Area disabled.
> hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63,
> UDMA(33)
> 
> How see, first is 32GB (33820 MB), and second is 40GB (40020MB).
> Correct value should be 32GB, in spite that my disk is 40GB. I want
> to say, that I have a little old BIOS and my BIOS detect only 32GB,
> therefore I have limited size of my disk. And maybe kernel 2.6.10
> influence on my BIOS and force to detect 40GB, which is not
> operable, because my BIOS is too old. I think that maybe to fix it I
> should force my kernel to detect only 32GB, how on kernel 2.6.9.
> Maybe this is a BUG of new kernel?
> 
> Fryderyk.
> 
> ---- Wiadomo¶æ Oryginalna ----
> Od: Bill Davidsen <davidsen@tmr.com>
> Do: Fryderyk Mazurek <dedyk@go2.pl>
> Kopia do: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
> Data: Wed, 29 Dec 2004 21:14:02 -0500
> Temat: Re: Problems with 2.6.10
> 
> 
>>Fryderyk Mazurek wrote:
>>
>>>Hello.
>>>
>>>My kernel 2.6.10 I compiled two times. First with ACPI and second
>>>fully without ACPI. And the same situation.
>>>For me this situation is strange, because usually reset should help,
>>>but not this time. I thought that maybe my BIOS is too old. But with
>>>2.6.9 works. Therefore I don't know. Now I use 2.6.9.
>>>
>>>Fryderyk.
>>>
>>>---- Wiadomo¶æ Oryginalna ----
>>>Od: Len Brown <len.brown@intel.com>
>>>Do: Fryderyk Mazurek <dedyk@go2.pl>
>>>Kopia do: linux-kernel@vger.kernel.org
>>>Data: 27 Dec 2004 21:44:11 -0500
>>>Temat: Re: Problems with 2.6.10
>>>
>>>
>>>
>>>>On Mon, 2004-12-27 at 12:11, Fryderyk Mazurek wrote:
>>>>
>>>>
>>>>
>>>>>problem starts when I do reboot. On boot screen my bios can't
> 
> detect
> 
>>>>>my disk. Bios stops and nothing.
>>>>
>>>>Does reboot work if the initial boot is with acpi=off?
>>
>>With that system, perhaps acpi=ht would be better if he uses the
> 
> HT. And 
> 
>>pci=routeirq may help as well, although it told me it was disabling 
>>IRQ18 and didn't!


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
