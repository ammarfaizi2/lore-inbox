Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWASNOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWASNOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 08:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbWASNOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 08:14:55 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52638 "EHLO
	out4.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1161194AbWASNOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 08:14:54 -0500
X-Sasl-enc: WsarF3jJnmjBqpqBgYuqIPubwK9hZknYuD02peB6Djor 1137676492
Message-ID: <43CF90C6.8050505@fastmail.co.uk>
Date: Thu, 19 Jan 2006 21:14:46 +0800
From: Max Waterman <davidmaxwaterman+kernel@fastmail.co.uk>
User-Agent: Thunderbird 1.6a1 (Macintosh/20060117)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: io performance...
References: <5vx8f-1Al-21@gated-at.bofh.it> <5wbRY-3cF-3@gated-at.bofh.it> <5wdKh-5wF-15@gated-at.bofh.it> <43CEF263.9060102@shaw.ca>
In-Reply-To: <43CEF263.9060102@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Jeff V. Merkey wrote:
>> Max Waterman wrote:
>>
>>> One further question. I get these messages 'in' dmesg :
>>>
>>> sda: asking for cache data failed
>>> sda: assuming drive cache: write through
>>>
>>> How can I force it to be 'write back'?
>>
>> Forcing write back is a very bad idea unless you have a battery backed 
>> up RAID controller.  
> 
> This is not what these messages are referring to. Those write through 
> vs. write back messages are referring to detecting the drive write cache 
> mode, not setting it. Whether or not the write cache is enabled is used 
> to determine whether the sd driver uses SYNCHRONIZE CACHE commands to 
> flush the write cache on the device. If the drive says its write cache 
> is off or doesn't support determining the cache status, the kernel will 
> not issue SYNCHRONIZE CACHE commands. This may be a bad thing if the 
> device is really using write caching..
>     

So, if I have my raid controller set to use write-back, it *is* caching 
the writes, and so this *is* a bad thing, right?

If so, how to fix?

Max.
