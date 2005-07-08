Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262840AbVGHUet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262840AbVGHUet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262835AbVGHUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:33:44 -0400
Received: from relay02.pair.com ([209.68.5.16]:65039 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S262852AbVGHU1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:27:51 -0400
X-pair-Authenticated: 209.68.2.107
Message-ID: <42CEE1C6.8050500@cybsft.com>
Date: Fri, 08 Jul 2005 15:27:50 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Maxey <dwm@maxeymade.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption -RT-V0.7.51-17 - Keyboard Problems
References: <200507081935.j68JZSqr003200@falcon30.maxeymade.com>
In-Reply-To: <200507081935.j68JZSqr003200@falcon30.maxeymade.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Maxey wrote:
> On Fri, 08 Jul 2005 21:13:26 +0200, Ingo Molnar wrote:
> 
>>* K.R. Foley <kr@cybsft.com> wrote:
>>
>>
>>>Ingo,
>>>
>>>I have an issue with keys VERY SPORADICALLY repeating, SOMETIMES, when 
>>>running the RT patches. The problem manifests itself as if the key 
>>>were stuck but happens far too quickly for that to be the case. I 
>>>realize that the statements above are far from scientific, but I can't 
>>>seem to narrow it down further. 2.6.12 doesn't seem to have the 
>>>problem at all, only when running the RT patches. It SEEMS to have 
>>>gotten worse lately. I am attaching my config as well as the output 
>>>from lspci.
>>>
>>>Adjusting the delay in the keyboard repeat seems to help. Any ideas?
> 
> 
> Is the keyboard standard (PS2) or USB?  Did not see the detail.

Sorry. It is PS2.

> 
> 
>>hm. Would be nice to somehow find a condition that triggers it. One 
>>possibility is that something else is starving the keyboard handling 
>>path. Right now it's handled via workqueues, which live in keventd. Do 
>>things improve if you chrt keventd up to prio 99? Also i'd chrt the 
>>keyboard IRQ thread up to prio 99 too.
>>
>>the other possibility is some IRQ handling bug - those are usually 
>>specific to the IRQ controller, so try turning off (or on) the IO-APIC 
>>[if the box has an IO-APIC], does that change anything?
> 
> 
> FWIW, I have seen this issue under USB, off and on since about 2.6.9.
> Never have dug into it, was always simpler to just unplug and re-plug
> the keyboard.  Of course, this predates RT.
> 
> ++doug
> 
> 


-- 
    kr
