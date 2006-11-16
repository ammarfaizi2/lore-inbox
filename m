Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031070AbWKPDZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031070AbWKPDZW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031072AbWKPDZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:25:22 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:32167 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031071AbWKPDZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:25:21 -0500
Message-ID: <455BDA1D.5090409@garzik.org>
Date: Wed, 15 Nov 2006 22:25:17 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <455A938A.4060002@garzik.org>	 <20061114.201549.69019823.davem@davemloft.net> <455A9664.50404@garzik.org>	 <20061114.202814.70218466.davem@davemloft.net> <1163643937.5940.342.camel@localhost.localdomain>
In-Reply-To: <1163643937.5940.342.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Tue, 2006-11-14 at 20:28 -0800, David Miller wrote:
>> From: Jeff Garzik <jeff@garzik.org>
>> Date: Tue, 14 Nov 2006 23:24:04 -0500
>>
>>> I can't answer for the spec, but at least two independent device vendors 
>>> recommended to write an MSI driver that way (disable intx, enable msi).
>> Ok.
>>
>>> Completely independent of MSI though, a PCI 2.2 compliant driver should 
>>> be nice and disable intx on exit, just to avoid any potential interrupt 
>>> hassles after driver unload.  And of course be aware that it might need 
>>> to enable intx upon entry.
>> This also sounds like it should occur in the generic PCI layer when a
>> PCI driver is unregistered.
> 
> Is this disable_intx() thingy something x86 specific ? I mean, you can't
> just call disable_irq() for LSIs since you can be sharing it. If you
> aren't sharing, free_irq() will mask for you.

We are referring to the standard PCI 2.2 bit, PCI_COMMAND_INTX_DISABLE.

	Jeff


