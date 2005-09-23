Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVIWVUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVIWVUq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVIWVUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:20:46 -0400
Received: from dyn50.sunlabs.com ([204.153.12.50]:60934 "EHLO
	mail-mta.sunlabs.com") by vger.kernel.org with ESMTP
	id S1751304AbVIWVUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:20:44 -0400
Date: Fri, 23 Sep 2005 14:21:45 -0700
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: [PATCH] updated version of Jens' SATA suspend-to-ram patch
In-reply-to: <433469DF.1060900@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jens Axboe <axboe@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Message-id: <433471E9.2040307@triplehelix.org>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.92.0.0
References: <20050923163334.GA13567@triplehelix.org>
 <20050923180711.GH22655@suse.de> <433469DF.1060900@pobox.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Very strange.  I cannot find this patch at all in my email folders.
> 
> Can someone resend it to me?

The original is at
http://seclists.org/lists/linux-kernel/2005/May/0447.html, as indicated
by the footnote in my original message.

That said, it's identical in content to the one I've just sent (attached
as a text/plain MIME attachment.)

> Worried now!
> 
> If this patch is needed, something VERY VERY WRONG is going on.  This
> patch indicates that the queueing state machine has been violated, and
> something is trying to IGNORE the command synchronization :(
> 
> Further, you cannot always assume that msleep() is valid in that
> context.  It should be the caller that waits (libata suspend code), not
> ata_do_simple_cmd() itself.
> 
> Does anyone have a link to James Bottomley's proposed patch?  That one
> seemed to do what was necessary -- send a SYNCHRONIZE_CACHE command then
> turn it over to the LLD for further suspend.

I don't think James sent any patch in the original thread with Jens'
patch. But that sounds somewhat cleaner than msleep().

At any rate, the current patch (with or without Jens' new addition)
works for me on Thinkpad T43. So the net result is better anyway, IMO.

>> Ok. Can we have this in -mm for a few days just to shake out anything
>> interesting, and then merge it into mainline?
> 
> Once we get a decent patch, I can merge it into my libata-dev.git
> repository, which is automatically propagated to -mm.

Is the kludginess of Jens' addition the only problem you have with the
current patch? (If it is, then fixing this is out of the range of my
current ability...)

Thanks for responding.

-- 
Joshua Kwan
