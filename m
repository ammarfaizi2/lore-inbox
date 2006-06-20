Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWFTQZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWFTQZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFTQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:25:09 -0400
Received: from rtr.ca ([64.26.128.89]:26012 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751385AbWFTQZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:25:08 -0400
Message-ID: <44982162.2020006@rtr.ca>
Date: Tue, 20 Jun 2006 12:25:06 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
References: <200606201815.54318.a1426z@gawab.com>
In-Reply-To: <200606201815.54318.a1426z@gawab.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> 
> I once sent a patch to -mm:
> 
..
>>> -#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
>>> +#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==((stat)&(good)))
>>>  #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
>>>  #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
>>>  #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
>> Assuming hdb is a CDROM/optical drive, then this change makes sense for
>> that. But I don't think it is a valid (good) change for regular ATA disks.
>>
>> A more complex patch is required, one which correctly handles each drive
>> type.

That patch was very ATAPI-specific, and would break other things.
It also would not correctly help anything in Justin's case.

-ml
