Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265508AbUFCFd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265508AbUFCFd5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUFCFd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 01:33:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47258 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265508AbUFCFdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 01:33:54 -0400
X-Authenticated: #4512188
Message-ID: <40BEB840.8060305@gmx.de>
Date: Thu, 03 Jun 2004 07:33:52 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040525)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-rc1-mm1: libata flooding my log
References: <40B8E8D4.1010905@gmx.de> <40B8EB07.6000700@pobox.com> <40B8F601.2000600@gmx.de> <40BD8B7A.2010901@gmx.de>
In-Reply-To: <40BD8B7A.2010901@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Prakash K. Cheemplavam wrote:
> 
>> Jeff Garzik wrote:
>>
>>> Prakash K. Cheemplavam wrote:
>>>
>> [snip]
>>
>>>> FAILED
>>>>   status = 1, message = 00, host = 0, driver = 08
>>>>   Current sd: sense = 70  5
>>>> ASC=20 ASCQ= 0
>>>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 
>>>> 0x00 0x00 0x20 0x00
>>>> FAILED
>>>>   status = 1, message = 00, host = 0, driver = 08
>>>>   Current sd: sense = 70  5
>>>> ASC=20 ASCQ= 0
>>>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 
>>>> 0x00 0x00 0x20 0x00
>>>> FAILED
>>>>   status = 1, message = 00, host = 0, driver = 08
>>>>   Current sd: sense = 70  5
>>>> ASC=20 ASCQ= 0
>>>> Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x06 0x00 0x00 
>>>> 0x00 0x00 0x20 0x00
>>>>
>>>>
>>>
> 
>>
>>
>>>
>>> I wonder if you have a bad SATA cable, initially, though.
>>
>>
>>
>> I don't think so, because previous mm kernels didn't show anything 
>> like this.
>>

So I tried something new. I enabled the SCSI error reporting and now get 
this:

FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense key Illegal Request
Additional sense: Invalid command operation code
FAILED
   status = 1, message = 00, host = 0, driver = 08
   Current sd: sense key Illegal Request
Additional sense: Invalid command operation code


I found another interesting thing: It seems those errors only appear 
when I use mozilla thunderbird! Any idea what tb is trying to do to the 
hd? As I said earlier kernels didn't report such errors. (Are those 
actually errors?)

Prakash
