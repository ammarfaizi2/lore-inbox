Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVJOKk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVJOKk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 06:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVJOKk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 06:40:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25757 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751072AbVJOKkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 06:40:55 -0400
Message-ID: <4350DCB1.7010201@pobox.com>
Date: Sat, 15 Oct 2005 06:40:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: jgarzik@pobox.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] RNG rewrite...
References: <20051015043120.GA5946@plexity.net>
In-Reply-To: <20051015043120.GA5946@plexity.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:
> I want to add support for the RNG on Intel's IXP4xx NPU and 
> looking at the existing hw-random.c code, it is written with
> the assumption that the RNG is on the PCI bus. I can put a
> big #ifdef ARCH_IXP4XX in there but instead I would rather
> rewrite the damn thing to use the device model and have a rng
> device class with individual drivers for each RNG model, including
> IXP4xx. I'll keep the miscdev interface around but will add a
> new interface under /sys/class/rng that the userspace tools 
> can transition to. Is this OK with folks?

How does the hardware export RNG functionality?  CPU insn?  Magic memory 
address?  Can it be done 100% in userspace?


> One question I have is about the following comment:
> 
>  * This data only exists for exporting the supported
>  * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
>  * register a pci_driver, because someone else might one day
>  * want to register another driver on the same PCI id.
> 
> Why? Is there something else on those IDs that another driver might
> care about?

They are bridge ids, not device ids.

	Jeff



