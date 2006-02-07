Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWBGJWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWBGJWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 04:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWBGJWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 04:22:30 -0500
Received: from smtp802.mail.ukl.yahoo.com ([217.12.12.139]:56677 "HELO
	smtp802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932281AbWBGJWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 04:22:30 -0500
Message-ID: <43E866D2.4050103@btinternet.com>
Date: Tue, 07 Feb 2006 09:22:26 +0000
From: Matt Keenan <matt.keenan@btinternet.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
References: <43DEA195.1080609@tmr.com> <20060202203503.GH4215@suse.de>
In-Reply-To: <20060202203503.GH4215@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Mon, Jan 30 2006, Bill Davidsen wrote:
>  
>
>>Please take this as a question to elicit information, not an invitation 
>>for argument.
>>
>>In Linux currently:
>> SCSI - liiks like SCSI
>> USB - looks like SCSI
>> Firewaire - looks like SCSI
>> SATA - looks like SCSI
>>    
>>
>
>SATA will _not_ look like SCSI in the future.
>
>  
>
>> Compact flash and similar - looks like SCSI
>>    
>>
>
>? CF adapters are usually IDE, so looks like ATA.
>
>  
>
>> ATAPI - looks different unless ide-scsi used
>>    
>>
>
>But it's all besides the point, it doesn't matter what the device
>special file looks like (if it's SCSI or not). What matters is that you
>talk to the device the same way - and that way is currently SG_IO.
>
>That a device hangs off the SCSI stack because that is the way the
>author wrote eg usb-storage is irrelevant. What matters is that you open
>the device in question and use SG_IO to talk to it.
>
>Talking about the SCSI stack and ide-scsi completely misses the point.
>
>  
>
Jens,

Is there a document that clearly lists how these components (SCSI, 
SG_IO, ATA/PI etc et al) connect together and what protocol / transports 
they use? I suspect the problem with all these current arguments is that 
very few people understand how this all works / connects. I think alot 
of people equate kconfig options with how the stuff works under the hood 
(even though a number of these config options are badly named to say the 
least).

Matt

