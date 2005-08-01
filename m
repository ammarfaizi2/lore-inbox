Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVHAUxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVHAUxq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVHAUvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:51:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52194 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261170AbVHAUtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:49:31 -0400
Message-ID: <42EE8AD5.6080100@pobox.com>
Date: Mon, 01 Aug 2005 16:49:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Daniel Drake <dsd@gentoo.org>, Otto Meier <gf435@gmx.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de> <20050801203228.GS22569@suse.de> <42EE87DF.1080508@pobox.com> <20050801204241.GU22569@suse.de>
In-Reply-To: <20050801204241.GU22569@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Aug 01 2005, Jeff Garzik wrote:
> 
>>Jens Axboe wrote:
>>
>>>Oh, and forget TCQ. It's a completely worthless technology inherited
>>
>>>from PATA,
>>
>>Agreed.
>>
>>There are a few controllers where we may -eventually- add TCQ support, 
>>controllers that do 100% of TCQ in hardware.  But that's so far down the 
>>priority list, it's below just about everything else.
>>
>>There may just be little motivation to -ever- support TCQ, even when 
>>libata is the 'main' IDE driver, sometime in the future.
> 
> 
> Host supported TCQ only removes the pain from the software side, it
> still doesn't make it a fast techology. The only reason you would want
> to support that would be "it's easy, why not...". From my POV, I would
> refuse to support it just from an ideological standpoint :-)
> 
> Legacy TCQ, hell no, not in a million years.

This is largely a confusion of terminology.  On the SATA page,

"host-based TCQ" == host controller has a hardware queue (DMA ring, or 
whatnot)

"legacy TCQ" == making use of READ/WRITE DMA QUEUED commands.

I would only consider accepting the -intersection- of these two feature 
sets, where host TCQ and legacy TCQ are -both- present.  As an extremely 
low, low priority.  :)

As a terminology side note, the SATA community refers to "everything 
that is not NCQ" as "legacy TCQ".  Legacy TCQ doesn't necessarily imply 
use of the standard PCI IDE interface, handling SERV interrupts and all 
that nastiness.

Patches to software-status.html to make this more clear are certainly 
welcome, as well :)

	Jeff


