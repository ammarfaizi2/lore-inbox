Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUDDXG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 19:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUDDXG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 19:06:58 -0400
Received: from linux-bt.org ([217.160.111.169]:28076 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262923AbUDDXG4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 19:06:56 -0400
Subject: Re: No interrupts for PCMCIA cards
From: Marcel Holtmann <marcel@holtmann.org>
To: daniel.ritz@gmx.ch
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404042338.47368.daniel.ritz@gmx.ch>
References: <200404042338.47368.daniel.ritz@gmx.ch>
Content-Type: text/plain
Message-Id: <1081120023.4635.3.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 01:07:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> you can try my TI interrupt routing patch:
> 	http://ritz.dnsalias.org/linux/pcmcia-ti-routing-9.patch
> also included in	2.6.5-rc3-mm1 and higher:
> 	http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc3/2.6.5-rc3-mm4/broken-out/yenta-TI-irq-routing-fix.patch
> 
> also the dmesg output with my patch applied would be nice to see...

thanks for the fast reply. This patch brings everything back in shape
and here is the Yenta part from dmesg:

Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:02:0e.0 (0000 -> 0002)
Yenta: CardBus bridge found at 0000:02:0e.0 [0000:0000]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:0e.0, mfunc 0x00000000, devctl 0x66
Yenta TI: socket 0000:02:0e.0 probing PCI interrupt failed, trying to fix
Yenta TI: socket 0000:02:0e.0 falling back to parallel PCI interrupts
Yenta TI: socket 0000:02:0e.0 parallel PCI interrupts ok
Yenta: ISA IRQ mask 0x0000, PCI irq 18
Socket status: 30000047
NET: Registered protocol family 23
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

Regards

Marcel


