Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVLMPfY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVLMPfY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 10:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVLMPfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 10:35:24 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:41145 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932141AbVLMPfY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 10:35:24 -0500
Date: Tue, 13 Dec 2005 10:35:23 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "J.A. Magallon" <jamagallon@able.es>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: 2.6.15-rc5-mm1
In-Reply-To: <20051213145112.46301af0@werewolf.auna.net>
Message-ID: <Pine.LNX.4.44L0.0512131032200.4831-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, J.A. Magallon wrote:

> Bingo! This corrected the problem. I applied it to rc5-mm2 and booted nicely.
> One less bug.
> 
> A side question. Are this messages dangerous ?
> 
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> PCI: cache line size of 128 is not supported by device 0000:00:1d.7
>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I don't think that matters.  It's more informational than a warning.

> ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
> ehci_hcd 0000:00:1d.7: irq 19, io mem 0xed200000
> ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> usb 1-1: unable to read config index 0 descriptor/all
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> usb 1-1: can't read configurations, error -71
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These messages indicate a real problem.  The device plugged into your 
first USB port didn't respond to a request.  It might not matter though, 
because the system will retry.  If the device works then you don't need to 
worry about it.

Alan Stern

