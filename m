Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVBSGxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVBSGxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 01:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVBSGxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 01:53:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63170 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261645AbVBSGxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 01:53:15 -0500
Message-ID: <4216E248.5070603@pobox.com>
Date: Sat, 19 Feb 2005 01:52:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Should kirqd work on HT?
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi all.
> 
> I've noticed this problem for a while, but only now decided to ask.
> Interrupt balancing doesn't do anything on my system.
> 
>            CPU0       CPU1
>   0:   31931808          0    IO-APIC-edge  timer
>   1:      76595          0    IO-APIC-edge  i8042
>   8:          1          0    IO-APIC-edge  rtc
>   9:          1          0   IO-APIC-level  acpi
>  14:        122          1    IO-APIC-edge  ide0
>  16:    4074456          0   IO-APIC-level  uhci_hcd, uhci_hcd, radeon@PCI:1:0:0
>  17:    4295132          0   IO-APIC-level  Intel ICH5
>  18:    2070933          0   IO-APIC-level  libata, uhci_hcd, eth0
>  19:     887311          0   IO-APIC-level  uhci_hcd
>  22:     572530          0   IO-APIC-level  ath0
> NMI:   31931749   31931636 (I've since disabled the nmi_watchdog)
> LOC:   31931252   31931251
> ERR:          0
> MIS:          0
> 
> I enabled the debugging and found that it doesn't think it's worth the
> effort. Is that correct? Not a complaint, just curious!

What are the results of running irqbalanced?

	Jeff



