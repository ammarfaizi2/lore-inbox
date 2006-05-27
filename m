Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWE0UMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWE0UMd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 16:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWE0UMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 16:12:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:5776 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964956AbWE0UMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 16:12:31 -0400
Message-ID: <4478B2AC.4090508@garzik.org>
Date: Sat, 27 May 2006 16:12:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata resume improvements
References: <20060527055533.GA5159@havoc.gtf.org> <4478B236.7000007@rtr.ca>
In-Reply-To: <4478B236.7000007@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
>> This is an example of how one might make sure the ATA bus reaches
>> bus-idle, before attempting to talk to it.
>>
>> It compiles, but is completely untested...
>>
>> Other resume improvements should work at the pci_driver::resume level as
>> this does, _not_ the SCSI->ATA->resume device level.
>>
>>
>> diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
> ...
> 
> Sorry to say, but no user-visible difference from previous attempts.
> Still fails the same way, after a 30-ish second timeout on resume.

Thanks again for testing, though I think more recent of the flurry of 
patches invalidated this patch :/  Nonetheless, its useful as a data point.

	Jeff



