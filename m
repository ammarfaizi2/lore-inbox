Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbWARVxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWARVxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWARVxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:53:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2996 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161021AbWARVxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:53:53 -0500
Date: Wed, 18 Jan 2006 13:53:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm1 usb hub problems
Message-Id: <20060118135336.58fee9b9.akpm@osdl.org>
In-Reply-To: <20060118205752.GA1520@elf.ucw.cz>
References: <20060118205752.GA1520@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> When I boot -mm1 in docking station, I get problems. First is ugly
> warning near yenta:
> 
> Yenta: CardBus bridge found at 0000:09:02.0 [1014:0148]
> Yenta: Using INTVAL to route CSC interrupts to PCI
> Yenta: Routing CardBus interrupts to PCI
> Yenta TI: socket 0000:09:02.0, mfunc 0x00001002, devctl 0x66
> irq 11: nobody cared (try booting with the "irqpoll" option)
> 
> ...
> and then I get problems with USB hub:
> 
> ...
> ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [LNKC] -> GSI 9 (level,
> low) -> IRQ 9
> PCI: Setting latency timer of device 0000:00:1d.2 to 64
> uhci_hcd 0000:00:1d.2: UHCI Host Controller
> uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
> uhci_hcd 0000:00:1d.2: irq 9, io base 0x00001840
> usb usb4: configuration #1 chosen from 1 choice
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> ehci_hcd 0000:00:1d.7: Unlink after no-IRQ?  Controller is probably
> using the wrong IRQ.
> 
>
> Any ideas?

I guess ACPI IRQ routing would be a suspect.  Can you generate the -rc1
dmesg and the -rc1-mm1 dmesg, diff them, look for ACPI differences?

