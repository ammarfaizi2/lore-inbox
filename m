Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVLWHIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVLWHIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 02:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbVLWHIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 02:08:10 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:9626 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S1030413AbVLWHIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 02:08:09 -0500
Message-ID: <43ABA27C.6020309@ru.mvista.com>
Date: Fri, 23 Dec 2005 10:08:44 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
References: <20051222180449.4335a8e6.vwool@ru.mvista.com> <200512221337.39305.david-b@pacbell.net> <43AB1DB7.3080505@ru.mvista.com> <200512221637.07895.david-b@pacbell.net>
In-Reply-To: <200512221637.07895.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>No, suppose there're two devices behind the same SPI bus that have 
>>different clock constraints. As active SPI device change may well happen 
>>when each new message is processed, we'll need to set up clocks again 
>>for each message. Right?
>>    
>>
>
>Clock is coupled to chipselect/device.  When the bus controller
>switches to the other device, it updates the clock accordingly.
>  
>
Yeah, but chipselect is called on per-transfer basis what is likely to 
be redundant for clock setting.
Per-message clock configuration is enough AFAIS.

>How exactly that's done is system-specific.  Many controllers
>just have a register per chipselect, listing stuff like SPI mode,
>clock divisor, and word size.  So switching to that chipselect
>kicks those in automatically ... devices ignore the clock unless
>they've been selected.
>  
>
Hmm, usually clocks are configured for the bus not device.
So, summarizing, you haven't convinced me yet. :)

Vitaly
