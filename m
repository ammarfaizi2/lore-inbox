Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbVKDAAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbVKDAAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVKDAAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:00:35 -0500
Received: from penta.pentaserver.com ([66.45.247.194]:19131 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S932688AbVKDAAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:00:33 -0500
Message-ID: <436AA148.8090705@linuxtv.org>
Date: Fri, 04 Nov 2005 03:46:16 +0400
From: Manu Abraham <manu@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mike Krufky <mkrufky@linuxtv.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [PATCH 26/37] dvb: add support for plls used by nxt200x
References: <4367241A.1060300@m1k.net> <20051103135910.3bf893d9.akpm@osdl.org> <436A96A8.4080906@linuxtv.org>
In-Reply-To: <436A96A8.4080906@linuxtv.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Krufky wrote:

> Andrew Morton wrote:
>
>> Michael Krufky <mkrufky@m1k.net> wrote:
>>  
>>
>>> +struct dvb_pll_desc dvb_pll_tdhu2 = {
>>> +    .name = "ALPS TDHU2",
>>> +    .min = 54000000,
>>> +    .max = 864000000,
>>> +    .count = 4,
>>> +    .entries = {
>>> +        { 162000000, 44000000, 62500, 0x85, 0x01 },
>>> +        { 426000000, 44000000, 62500, 0x85, 0x02 },
>>> +        { 782000000, 44000000, 62500, 0x85, 0x08 },
>>> +        { 999999999, 44000000, 62500, 0x85, 0x88 },
>>> +    }
>>> +};
>>> +EXPORT_SYMBOL(dvb_pll_tdhu2);
>>>   
>>
>>
>> The new driver is to have a GPL license, I assume?
>>
>> Generally, EXPORT_SYMBOL_GPL seems more appropriate for the DVB 
>> subsystem.
>>

Hello Andrew,

We have in the DVB subsystem most of the exported symbols as 
EXPORT_SYMBOL itself, rather than EXPORT_SYMBOL_GPL. I think if this 
needs to be changed, we would require a global change of all symbols to 
the same to maintain consistency. If you require that change we can have 
a change but i would think that the discussions be done with the 
relevant copyright holders too, eventhough probably most of the authors 
won't have any objection.

> Yes, GPL'd of course.  But these pll definitions are not strictly tied 
> to nxt200x -- they may very well be used by another frontend module in 
> the future.
>
> Actually, we keep pll info in a separate file (dvb-pll.c) so that the 
> tuner programming can be used by any frontend module, depending on the 
> design..... About EXPORT_SYMBOL, this is how it's done all over dvb-pll.c
>
> If this needs to change, then it should apply to the entire dvb-pll.
>

It is not necessary limited to dvb-pll, but the entire dvb-kernel.


Thanks,
Manu

