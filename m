Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422962AbWJQAE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422962AbWJQAE2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422957AbWJQAE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:04:28 -0400
Received: from rtr.ca ([64.26.128.89]:40465 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1422954AbWJQAE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:04:27 -0400
Message-ID: <45341E08.9040100@rtr.ca>
Date: Mon, 16 Oct 2006 20:04:24 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Jens Axboe <jens.axboe@oracle.com>,
       Allen Martin <AMartin@nvidia.com>, Jeff Garzik <jeff@garzik.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       prakash@punnoor.de
Subject: Re: [RFC PATCH] nForce4 ADMA with NCQ: It's aliiiive..
References: <DBFABB80F7FD3143A911F9E6CFD477B018E8171B@hqemmail02.nvidia.com> <452C7C1D.3040704@shaw.ca> <20061011103038.GK6515@kernel.dk> <452F053B.2000906@shaw.ca> <4533B0B3.8070205@rtr.ca> <4534185C.9060401@shaw.ca>
In-Reply-To: <4534185C.9060401@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Mark Lord wrote:
>> Robert Hancock wrote:
..
>> Be careful of that.  The original PDC hardware for ADMA still had
>> the "don't cross a 64KB boundary" requirement.
..
> That is part of the ADMA spec - but in that case, how come the 
> pdc_adma.c driver sets the dma_boundary in the SCSI host template to 
> 4GB? That seems wrong.

Ah, you are correct.  My memory is fading of such things.
The PDC parts are good for 2^34 transfer sizes (bytes).

Cheers
