Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbVHXElH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbVHXElH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 00:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVHXElH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 00:41:07 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:7281 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751448AbVHXElG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 00:41:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uiED/NVB7o7RVp8NQTr6vMAVbfGVaDMG+VCKDM46DjrZ2nYXFzulAQ9dBJED7yCJLQlha4EnCNq2SHwALZb1CaqWHgk1Zwzi/WdNgDUPKE/NAOfbkGEg/vw1F5UbtzD3mGwMWuNPdtrWUY9zIYpVHMtk45giiEmmyb4n2pDO+ZE=
Message-ID: <430BFA58.6090609@gmail.com>
Date: Wed, 24 Aug 2005 10:10:56 +0530
From: Rajesh <rvarada@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: debug a high load average
References: <430B03B4.8040205@gmail.com> <20050823133050.GC29062@harddisk-recovery.com>
In-Reply-To: <20050823133050.GC29062@harddisk-recovery.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:

>On Tue, Aug 23, 2005 at 04:38:36PM +0530, Rajesh wrote:
>  
>
>>I have a case occasionally when I copy data from a usb storage (ipod) to 
>>my hard drive the load average goes up from 0.4 to about 15.0, and the 
>>system becomes very unusable till I kill the cp command. I have checked 
>>the CPU usage, bytes read from usb device, byte written to hard drive 
>>etc, and all these values are low like CPU usage is at a maximum of 30%, 
>>disk read bytes is at an average of 1.5 MiB/s, disk write bytes is at 
>>1.5 MiB/s, number of processes is at 110, etc, during this high load.
>>    
>>
>
>1.5 MB/s suggests you're using an IDE drive in PIO mode. Switch to DMA
>mode (hdparm -d 1 /dev/hda) and see if it gets any better.
>
>  
>

It seems to have helped a little. Now the rate at which load average 
goes up has decreased ( I can copy up to about 700-800 MiB compared to a 
high of 200MiB earlier), but it is still going up to 15 gradually at 
which point I am still killing the cp process to make the system usable.

I know I am not giving much information. But if I know what factors 
cause the loadavg to keep on going up I will gladly provide it.

I am running  2.6.12 kernel on a laptop. I have an ipod attached to my 
USB 1.1 as a drive on which I am saving and retreiving large 
files(2-4GiB files). The transfer speed is slow, but I am fine with it, 
as long as the load average stays within bounds so that the machine is 
usable. (If I dual boot to windows and do the same operation, I am able 
to get the files copied over in a few minutes.). Can vfat be a factor?

Thanks
Rajesh

>Erik
>
>  
>

