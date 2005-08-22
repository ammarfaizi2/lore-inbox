Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVHVW4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVHVW4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVHVW4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:56:40 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:15502 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751432AbVHVW4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:56:36 -0400
Message-ID: <430957F8.9070507@pobox.com>
Date: Mon, 22 Aug 2005 00:43:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Escombe <lists@dresco.co.uk>
CC: linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [patch] libata passthrough - return register data from HDIO_*
 commands
References: <42FE2FBA.3000605@dresco.co.uk> <430112F6.3090906@dresco.co.uk>
In-Reply-To: <430112F6.3090906@dresco.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Escombe wrote:
> 
>> Here is a first attempt at a patch to return register data from the 
>> libata passthrough HDIO ioctl handlers, I needed this as the ATA 
>> 'unload immediate' command returns the success in the lbal register. 
>> This patch applies on top of 2.6.12 and Jeffs 
>> 2.6.12-git4-passthru1.patch. (Apologies, but Thunderbird appears to 
>> have replaced the tabs with spaces).
>>
>> One oddity is that the sr_result field is correctly being set in 
>> ata_gen_ata_desc_sense(), however the high word is different when 
>> we're back in the ioctl hander. I've coded round this for now by only 
>> checking the low word, but this needs more investigation.
>>
>> Jeff, could this functionality be incorporated into the pasthrough 
>> patch when complete?
> 
> 
> 
> I'd failed to realise that scsi_finish_command() sets the high byte of 
> the result field to DRIVER_SENSE when there is sense data. Patch updated 
> to reflect this...
> 
> Haven't had any feedback on the patch itself - but this now does what I 
> wanted it do to.  (I can't find a way to make Thunderbird retain tabs in 
> the message body, so sending as an attachment).

Patch seems sane at first glance.  I'll look over it in depth this week.

	Jeff


