Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbVJUSTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbVJUSTB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVJUSTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:19:01 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41654 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965065AbVJUSTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:19:00 -0400
Message-ID: <43593100.5040708@pobox.com>
Date: Fri, 21 Oct 2005 14:18:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com>
In-Reply-To: <435929FD.4070304@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 10/20/05 20:46, Jeff Garzik wrote:
> 
>>Consider what an ioctl is, overall:  a domain-specific "do this 
>>operation" interface.  Which, further, is nothing but a wrapping of a 
>>"send message" + "receive response" interface.  There are several ways 
>>to do this in Linux:
>>
>>* block driver.  a block driver is nothing but a message queue.  This is 
> 
> 
> Not quite.  This maybe the way it operates, but it is called "block"
> for a reason.

This illustrates you fundamentally don't understand a lot of Linux, and 
SCSI too.

Several non-blkdev device classes (Christoph listed them) use block 
layer request_queue for command transit, as does SG_IO and /dev/sg.


>>why James has suggested implementing SMP as a block driver.  People get 
>>stuck into thinking "block driver == block device", which is wrong.  The 
>>Linux block layer is nothing but a message queueing interface.
> 
> 
> Now, just because James suggested implementing the SMP service as a block
> device you think this is the right thing to do?

I very clearly said I don't know the best answer.  Perhaps you need to 
re-read the quoted email?


> How about this: Why not as a char device?

I covered that in the quoted email.


> At least MS isn't suffering from the "no to specs" syndrome which
> the Linux community seems to be suffering...

We have plenty of specs.  It's called source code.

You don't understand the Linux development process (think its more 
political than technical) and you don't understand even what a block 
driver is, and you wonder why you have difficulty getting code into the 
kernel?

	Jeff


