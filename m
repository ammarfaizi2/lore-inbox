Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbVLSUDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVLSUDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVLSUDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:03:46 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:5319 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964927AbVLSUDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:03:46 -0500
Message-ID: <43A7121E.1070709@ru.mvista.com>
Date: Mon, 19 Dec 2005 23:03:42 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] SPI core: turn transfers to be linked list
References: <43A480C0.9080201@ru.mvista.com> <200512181240.46841.david-b@pacbell.net> <43A665F7.7020404@ru.mvista.com> <20051219170005.GA1911@kroah.com>
In-Reply-To: <20051219170005.GA1911@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Mon, Dec 19, 2005 at 10:49:11AM +0300, Vitaly Wool wrote:
>  
>
>>The problem is: we're using real-time enhancements patch developed by 
>>Ingo/Sven/Daniel etc. You cannot call kmalloc from the interrupt 
>>context  if you're using this patch.
>>    
>>
>
>So you can't even call:
>	kmalloc(sizeof(foo), GFP_ATOMIC);
>in an interrupt anymore?
>If so, that's going to break mainline pretty bad...
>  
>
Don't think it will... Since most of the interrupts will work in threads 
pretty well... and it's np to alloc memory from threads.

Vitaly
