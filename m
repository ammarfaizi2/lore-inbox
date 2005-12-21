Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbVLUNVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVLUNVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLUNVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:21:49 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:7600 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S932405AbVLUNVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:21:48 -0500
Message-ID: <43A95713.6020405@ru.mvista.com>
Date: Wed, 21 Dec 2005 16:22:27 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
References: <43A480C0.9080201@ru.mvista.com> <200512181240.46841.david-b@pacbell.net> <43A665F7.7020404@ru.mvista.com> <200512200011.57052.david-b@pacbell.net>
In-Reply-To: <200512200011.57052.david-b@pacbell.net>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>>The list setting commands are pretty essential and will not add a lot to 
>>the assembly code.
>>    
>>
>
>I'm not totally averse to such changes, but you don't seem to be making
>the best arguments.  Example:  they're clearly not "essential" because
>transfer queues work today with the lists at the spi_message level.
>  
>
One more reason for that that came out only recently: suppore we're 
adding transfers to an already configured message (i. e. with some 
transfers set up already). This 'chaning' may happen for some kinds of 
devices. And in case transfers is an array, we should either be apriory 
aware of whether the chaining will take place or allocate an array large 
enough to hold additional transfers. Neither of these look good to me, 
and having a linked list of transfers will definitely solve this problem.

Vitaly

