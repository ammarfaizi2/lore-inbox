Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbVHaBww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVHaBww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 21:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVHaBww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 21:52:52 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41676 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932330AbVHaBwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 21:52:51 -0400
Message-ID: <43150D64.1060208@pobox.com>
Date: Tue, 30 Aug 2005 21:52:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libata: add ATAPI module option
References: <20050830215234.GA6991@havoc.gtf.org> <4314F1C8.8040706@rtr.ca>
In-Reply-To: <4314F1C8.8040706@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> -#ifndef ATA_ENABLE_ATAPI
>> -    if (unlikely(dev->class == ATA_DEV_ATAPI))
>> -        return NULL;
>> -#endif
>> +    if (atapi_enabled) {
>> +        if (unlikely(dev->class == ATA_DEV_ATAPI))
>> +            return NULL;
>> +    }
> 
> ..
> 
> Is that if-stmt the right way around?
> At first glance, I'd expect it to read:
> 
>      if (!atapi_enabled) {
>      ...
> 
> Cheers!

Indeed, thanks, fixed.

	Jeff



