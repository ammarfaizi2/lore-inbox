Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVBTOpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVBTOpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 09:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVBTOpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 09:45:34 -0500
Received: from jade.aracnet.com ([216.99.193.136]:10429 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S261839AbVBTOpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 09:45:16 -0500
Date: Sun, 20 Feb 2005 06:45:08 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: ncunningham@cyclades.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Should kirqd work on HT?
Message-ID: <320610000.1108910707@[10.10.2.4]>
In-Reply-To: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

I think it's nothing to do with HT, just the rate you're sending intterrupts
at isn't high enough to bother rotating.

M.

