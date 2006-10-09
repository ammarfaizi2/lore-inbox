Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWJIIo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWJIIo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 04:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWJIIo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 04:44:56 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:52776 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932402AbWJIIoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 04:44:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=p8mK502SsgVaD+LrwFsANv5UuhQd5MI0HGNZP8/rPQPVF7cwKg4CVwrZJhTYghP8aYNFU6GMBedUUhdpEjDySeIQziHFuWHpgkF10ga4gfjD7u6L74wNrfzjJyUQOIJPOH8aYIw4KdcnHpCK0OHfBcxQNbJmXXr1XJv6zyrP8KU=
Message-ID: <452A0C02.90700@gmail.com>
Date: Mon, 09 Oct 2006 12:44:50 +0400
From: Manu Abraham <abraham.manu@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: Amit Choudhary <amit2030@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.19-rc1] drivers/media/dvb/bt8xx/dvb-bt8xx.c: check
 kmalloc() return value.
References: <20061008231034.e50118df.amit2030@gmail.com> <20061009083723.GA27728@aepfle.de>
In-Reply-To: <20061009083723.GA27728@aepfle.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:
> On Sun, Oct 08, Amit Choudhary wrote:
> 
>> Description: Check the return value of kmalloc() in function frontend_init(), in file drivers/media/dvb/bt8xx/dvb-bt8xx.c.
>>
>> Signed-off-by: Amit Choudhary <amit2030@gmail.com>
>>
>> diff --git a/drivers/media/dvb/bt8xx/dvb-bt8xx.c b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
>> index fb6c4cc..14e69a7 100644
>> --- a/drivers/media/dvb/bt8xx/dvb-bt8xx.c
>> +++ b/drivers/media/dvb/bt8xx/dvb-bt8xx.c
>> @@ -665,6 +665,10 @@ static void frontend_init(struct dvb_bt8
>>  	case BTTV_BOARD_TWINHAN_DST:
>>  		/*	DST is not a frontend driver !!!		*/
>>  		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
>> +		if (!state) {
>> +			printk("dvb_bt8xx: No memory\n");
> 
> KERN_FOO loglevel is missing.

It shouldn't matter though.


Manu


