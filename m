Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUJPR46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUJPR46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268452AbUJPR46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 13:56:58 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:13654 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S268315AbUJPR44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 13:56:56 -0400
Date: Sat, 16 Oct 2004 11:53:35 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Tasklet usage?
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <003201c4b3a9$0f0a6180$6601a8c0@northbrook>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
Content-type: text/plain; reply-type=response; charset=iso-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <fa.hf0cjfr.n3qt2d@ifi.uio.no> <fa.doac9ep.1ckig8r@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you want an exact size, int32_t, uint32_t, etc. are what you'd need to 
use.. Typically "long" is the biggest that can be handled in single machine 
instructions, though there is no guarantee of this (I think the language 
standard only guarantees that long is as least as big as int and at least 32 
bits).


----- Original Message ----- 
From: "Pierre Ossman" <drzeus-list@drzeus.cx>
Newsgroups: fa.linux.kernel
To: "Roland Dreier" <roland@topspin.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
Sent: Saturday, October 16, 2004 10:37 AM
Subject: Re: Tasklet usage?


> Roland Dreier wrote:
>
>>unsigned long will be 64 bits on a 64-bit system.  There are many
>>places in the Linux kernel where we assume that void * and long are
>>the same size.
>>
>> - Roland
>>
> Just out of curiosity, how do you declare a 32-bit int then? I thought 
> longlong would be the 64-bit int under gcc and long stay as it is.
>
> Rgds
> Pierre
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/ 

