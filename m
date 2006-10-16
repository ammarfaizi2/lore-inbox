Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422939AbWJPXlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422939AbWJPXlI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422942AbWJPXlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:41:08 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24338 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1422939AbWJPXlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:41:05 -0400
Date: Mon, 16 Oct 2006 17:40:12 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
In-reply-to: <4533B0B3.8070205@rtr.ca>
To: Mark Lord <liml@rtr.ca>
Cc: Jens Axboe <jens.axboe@oracle.com>, Allen Martin <AMartin@nvidia.com>,
       Jeff Garzik <jeff@garzik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Message-id: <4534185C.9060401@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com>
 <452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk>
 <452F053B.2000906@shaw.ca> <4533B0B3.8070205@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Robert Hancock wrote:
>>
>> I also noticed that I'm still using the default 64KB libata 
>> dma_boundary value, this should be 4GB for ADMA mode (but fixed up 
>> back to the default if an ATAPI device is connected, same as with the 
>> DMA mask).
> 
> Be careful of that.  The original PDC hardware for ADMA still had
> the "don't cross a 64KB boundary" requirement.
> 
> Cheers

That is part of the ADMA spec - but in that case, how come the 
pdc_adma.c driver sets the dma_boundary in the SCSI host template to 
4GB? That seems wrong.

In any case, however, I really doubt the NVIDIA ADMA controller shares 
this limitation - they provide 32 bits for the region length (standard 
ADMA only has 16 bits), which wouldn't be very useful if you couldn't 
cross a 64KB boundary..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

