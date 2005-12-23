Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbVLWIhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbVLWIhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 03:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVLWIhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 03:37:23 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:12212 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1030462AbVLWIhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 03:37:23 -0500
Message-ID: <43ABB76B.8000301@ru.mvista.com>
Date: Fri, 23 Dec 2005 11:38:03 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
References: <20051222180449.4335a8e6.vwool@ru.mvista.com> <200512221637.07895.david-b@pacbell.net> <43ABA27C.6020309@ru.mvista.com> <200512230028.03682.david-b@pacbell.net>
In-Reply-To: <200512230028.03682.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>>How exactly that's done is system-specific.  Many controllers
>>>just have a register per chipselect, listing stuff like SPI mode,
>>>clock divisor, and word size.  So switching to that chipselect
>>>kicks those in automatically ... devices ignore the clock unless
>>>they've been selected.
>>>      
>>>
>>Hmm, usually clocks are configured for the bus not device.
>>    
>>
>
>Not a chance.  The clock is activated to talk to a given device;
>and there's no requirement that all devices on the bus use the
>same clock rate.  (If one chipselect gives access to a linked series
>of devices, clearly they'll all need to be clocked alike.  But
>that's not a bus, it's just a compound device ... like a big shift
>register.)
>
>I did my homework when putting that API together, and looked at
>quite a few SPI controllers.  **Not one** of them forces all
>their chipselets to use the same clock rate.
>  
>
I admit that thw word 'usually' is incorrect here, but still we have two 
Philips ARM boards where the SPI clock is configured _only_ on the bus, 
by setting the bus clock divisor on per-message basis. I was also 
keeping in mind PXA, so it wasn't just bare words...

Vitaly
