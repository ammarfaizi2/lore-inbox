Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264164AbUESNTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbUESNTK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 09:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUESNTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 09:19:10 -0400
Received: from mail.ccdaust.com.au ([203.29.88.42]:3899 "EHLO
	gateway.ccdaust.com.au") by vger.kernel.org with ESMTP
	id S264164AbUESNTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 09:19:05 -0400
Message-ID: <40AB5E81.4050301@wasp.net.au>
Date: Wed, 19 May 2004 17:17:53 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata Promise driver regression 2.6.5->2.6.6
References: <A6974D8E5F98D511BB910002A50A6647615FB7A9@hdsmsx403.hd.intel.com> <1084820518.12349.347.camel@dhcppc4> <40A90EE2.3040507@wasp.net.au> <40A91410.5040408@pobox.com> <40AA3844.9010403@wasp.net.au> <40AA4585.4060301@pobox.com>
In-Reply-To: <40AA4585.4060301@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against my better judgment I'm going to send this again as I have been having problems with a 
particularly faulty mail server randomly blackholing outgoing mail and I have not seen this in the 
archives after about 20 hours. Apologies if this arrives twice. I have temporarily subscribed to the 
list.

Jeff Garzik wrote:
> Interesting.
> 
> Well since it's not global behavior, but isolated to one port or card, I 
> still worry about non-libata things:
> 1) is a SATA cable bad, or not plugged in well?  I'm finding that it's 
> easier to screw up SATA cabling than PATA.  It's more-convenient design 
> is also less rugged.

Nup, all seated fine and working perfectly well (and I mean raid-5 across all 10 disks and spraying
data at maximum PCI speed for 8 hours at a time well) with 2.6.5, and they are Supermicro cables
SATA cables with a pair of 5 bay Supermicro Hotswap bays so the quality is pretty good.

> 2) is a PCI slot bad, or not busmastering like it should?  have you 
> tried moving the card to another PCI slot?

I hadn't, but I just gutted the system and did a heap of card shuffles.. it ain't that.

> 3) is it always the 9th port, regardless of the ordering of the PCI 
> cards in PCI slots?

Nup, but it's always appears to be on the 3rd card. Pull one of the cards and it's sweet.


> I apologize if you answered some of these in a previous message.

I hadn't, but I have now :p)

Under all these circumstances, 2.6.5 would boot fine. These tests were done with 2.6.5 and the patch
you supplied me.

I can even pull all the drives from boards 1&2 (drives 0-7) and it will lock hard on drive 8.

If I pull the 3rd card then it all behaves perfectly no matter what I do to it. I have relocated the
3rd card in other slots to change the detection order and it always *seems* to die on the 3rd
initialised card, no matter what slot.

Strange, No?

Brad
(I have knocked the other guys from the CC: as it does not appear to be ACPI related)

