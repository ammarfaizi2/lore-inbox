Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUCQNvk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 08:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbUCQNvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 08:51:40 -0500
Received: from uh02.cern.ch ([137.138.53.31]:40064 "EHLO four09.here.local")
	by vger.kernel.org with ESMTP id S261455AbUCQNvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 08:51:38 -0500
To: linux-kernel@vger.kernel.org
Subject: USB oops on Thinkpad
Message-Id: <E1B3bSL-0000iE-00@four09.here.local>
From: Anton Empl <empl@cern.ch>
Date: Wed, 17 Mar 2004 14:51:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


this is not to complain but rather to report and try to sort out a problem
experienced with the 2.6.x kernel for quite a long time. I am not a kernel
expert so please forgive any not helpful statements here. Also, the hardware
used is a Thinkpad T30 (2366-96U) laptop and all might just be specific to
that system.


Since this system only has USB1 available internally I purchased a PCMCIA
USB2 hub (ATEN USB 2.0 2 Port Host Control Card: PU-212). Inserting this
card into a running kernel about every other time locks up the system. The
lockup is more likely if the card is inserted longer after system start.
Here's a transcript (by hand) of the oops:


  *pde=    00000000
  Oops:    0002 [#1]
  CPU:     0
  EIP:     0060: [<f8a079e9>] Not tainted
  EFLAGS:  00010296

  EIP is at end_unlink_async+0x1a/0xf6 [ehci_hcd]

  Process usb.agent

  Call trace:    ehci_work
                 ehci_irq
                 usb_hcd_irq
                 handle_IRQ_event
                 do_IRQ
                 common_interrupt

  kernel panic: fatal exception in interrupt
  In interrupt handler - not syncing

I can certainly provide more information but the problems described above
are rather independent of the actual details of building the kernel and
rather stable. Please cc since I am not subscribed to the list.

thanks,


Anton.Empl@cern.ch

