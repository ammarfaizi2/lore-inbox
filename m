Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbVKCXB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbVKCXB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbVKCXB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:01:56 -0500
Received: from kirby.webscope.com ([204.141.84.57]:25228 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S1030370AbVKCXBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:01:53 -0500
Message-ID: <436A96A8.4080906@linuxtv.org>
Date: Thu, 03 Nov 2005 18:00:56 -0500
From: Mike Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [PATCH 26/37] dvb: add support for plls used by nxt200x
References: <4367241A.1060300@m1k.net> <20051103135910.3bf893d9.akpm@osdl.org>
In-Reply-To: <20051103135910.3bf893d9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>  
>
>>+struct dvb_pll_desc dvb_pll_tdhu2 = {
>> +	.name = "ALPS TDHU2",
>> +	.min = 54000000,
>> +	.max = 864000000,
>> +	.count = 4,
>> +	.entries = {
>> +		{ 162000000, 44000000, 62500, 0x85, 0x01 },
>> +		{ 426000000, 44000000, 62500, 0x85, 0x02 },
>> +		{ 782000000, 44000000, 62500, 0x85, 0x08 },
>> +		{ 999999999, 44000000, 62500, 0x85, 0x88 },
>> +	}
>> +};
>> +EXPORT_SYMBOL(dvb_pll_tdhu2);
>>    
>>
>
>The new driver is to have a GPL license, I assume?
>
>Generally, EXPORT_SYMBOL_GPL seems more appropriate for the DVB subsystem.
>
Yes, GPL'd of course.  But these pll definitions are not strictly tied 
to nxt200x -- they may very well be used by another frontend module in 
the future.

Actually, we keep pll info in a separate file (dvb-pll.c) so that the 
tuner programming can be used by any frontend module, depending on the 
design..... About EXPORT_SYMBOL, this is how it's done all over dvb-pll.c

If this needs to change, then it should apply to the entire dvb-pll.

I'll wait for Johannes' comments on this.

Michael Krufky


