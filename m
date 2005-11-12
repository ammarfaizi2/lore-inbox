Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVKLB5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVKLB5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 20:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVKLB5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 20:57:24 -0500
Received: from mail.dvmed.net ([216.237.124.58]:33421 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750998AbVKLB5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 20:57:23 -0500
Message-ID: <43754BF1.5050609@pobox.com>
Date: Fri, 11 Nov 2005 20:57:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Christoph Hellwig <hch@infradead.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] final pre -rc pieces of SCSI for 2.6.14
References: <1131745742.3505.47.camel@mulgrave> <20051111222341.GA20077@infradead.org> <Pine.LNX.4.64.0511111454140.3228@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511111454140.3228@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 11 Nov 2005, Christoph Hellwig wrote:
> 
>>On Fri, Nov 11, 2005 at 03:49:01PM -0600, James Bottomley wrote:
>>
>>>  o remove scsi_wait_req
>>
>>This requires '[PATCH] kill libata scsi_wait_req usage (make libata compile in
>>scsi-misc)' from Mike, because libata started to use this function in mainline
>>about the same time it was removed in scsi-misc.
> 
> 
> Yeah, I get
> 
> 	drivers/built-in.o(.text+0x12e68c): In function `.ata_cmd_ioctl':
> 	: undefined reference to `.scsi_wait_req'
> 	drivers/built-in.o(.text+0x12e85c): In function `.ata_task_ioctl':
> 	: undefined reference to `.scsi_wait_req'
> 
> right now. Can somebody forward that patch to me..

Given that that's the primary path for users issuing hdparm/SMART 
commands, I'm still hoping someone will give this patch even a simple 
"it works" test before pushing...  I requested this days ago, but 
haven't heard any results.

	Jeff



