Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbULHXMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbULHXMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 18:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbULHXMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 18:12:40 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:18904 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261401AbULHXMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 18:12:34 -0500
References: <cp7iqj$57n$1@gatekeeper.tmr.com> <41B767CC.8000109@dif.dk>
Message-ID: <cone.1102547540.298881.4626.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Limiting program swap
Date: Thu, 09 Dec 2004 10:12:20 +1100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl writes:

> Bill Davidsen wrote:
>> I have several machine of various memory sizes which suffer from really 
>> poor performance when doing backups. This appears to be because all the 
>> programs other than the backup quickly get swapped to make room for i/o 
>> buffers.
>> 
>> Is there some standard portable way to prevent this, either by reserving 
>> some memory for programs which will not get swapped regardless of i/o 
>> pressure, or alternatively limiting the total memory used for i/o 
>> buffers, dcache, and similar things?
>> 
> 
> I'm wondering if turning the /proc/sys/vm/swappiness knob would help, 
> but I'll honestly admit that I don't know.

No, there comes a point where the vm pressure overrides the value of 
swappiness and we start swapping. It is better in 2.6.7 and before with 
issues yet to be resolved in the latest mainline trees. My tree (-ck) has a 
slightly different tuning and a hard maplimit option for just such a reason 
but are unlikely to be of interest to the mainline maintainers so I've never 
promoted them.

Cheers,
Con

