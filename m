Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbVKIIBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbVKIIBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbVKIIBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:01:48 -0500
Received: from mail.dvmed.net ([216.237.124.58]:15328 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965265AbVKIIBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:01:48 -0500
Message-ID: <4371ACE6.7010503@pobox.com>
Date: Wed, 09 Nov 2005 03:01:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Neil Brown <neilb@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: userspace block driver?
References: <4371A4ED.9020800@pobox.com> <17265.42782.188870.907784@cse.unsw.edu.au> <4371A944.6070302@pobox.com> <20051109075455.GN3699@suse.de>
In-Reply-To: <20051109075455.GN3699@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Nov 09 2005, Jeff Garzik wrote:
> 
>>Neil Brown wrote:
>>
>>>On Wednesday November 9, jgarzik@pobox.com wrote:
>>>
>>>
>>>>Has anybody put any thought towards how a userspace block driver
>>>>would work?
>>>
>>>
>>>Isn't this was enbd does? 
>>> http://www.it.uc3m.es/~ptb/nbd/
>>
>>Is there something there relevant for modern kernels?  I would sure hope 
>>I could come up with something more lightweight than that.
> 
> 
> I was going to say drbd, but then you did say more lightweight :-)
> 
> Is nbd completely screwed these days?

nbd does more than I want.

_All_ that is needed is flipping requests <somehow> to/from userspace. 
nbd messes directly with sockets and such, which I don't want.  It does 
way too much, hardcodes way too much.

loop is a closer model to a generic userspace block device than nbd, I 
think.

Though, answering your question directly, I do get the impression that 
in-kernel nbd has been left behind in favor of drbd and enbd, out in the 
few places where nbd-ish solutions are used.

	Jeff



