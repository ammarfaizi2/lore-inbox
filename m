Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUHDPHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUHDPHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUHDPHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:07:49 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:58832 "EHLO
	mail.electro-mechanical.com") by vger.kernel.org with ESMTP
	id S266245AbUHDPHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:07:46 -0400
Date: Wed, 4 Aug 2004 11:07:36 -0400
From: William Thompson <wt@electro-mechanical.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB quits working on 2.6.7
Message-ID: <20040804150736.GA24181@electro-mechanical.com>
References: <20040802194542.GA11965@electro-mechanical.com> <20040803002537.GA26323@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803002537.GA26323@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have USB host controllers and HID compiled in due to the keyboard.
> 
> Can you test 2.6.8-rc2 to see if this is fixed there or not?

Nope doesn't work:

irq 10: nobody cared!
 [<c010671a>] __report_bad_irq+0x2a/0x90
 [<c0106810>] note_interrupt+0x70/0xb0
 [<c0106ac1>] do_IRQ+0x111/0x120
 [<c0104c3c>] common_interrupt+0x18/0x20
 [<c0102190>] default_idle+0x0/0x40
 [<c01021bc>] default_idle+0x2c/0x40
 [<c010224b>] cpu_idle+0x3b/0x50
 [<c011b123>] printk+0x153/0x190
handlers:
[<c02124e0>] (usb_hcd_irq+0x0/0x70)
[<c02124e0>] (usb_hcd_irq+0x0/0x70)
[<c02124e0>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #10
# uname -a
Linux potato 2.6.8-rc2 #2 SMP Wed Aug 4 08:54:01 EDT 2004 i686 GNU/Linux
# cat /proc/interrupts
           CPU0       CPU1
  0:    7605564         72    IO-APIC-edge  timer
  1:         10          1    IO-APIC-edge  i8042
  9:          0          0   IO-APIC-level  acpi
 10:     186654     113347   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd
 12:        144          1    IO-APIC-edge  i8042
 14:      11946          0    IO-APIC-edge  ide0
 15:         44          0    IO-APIC-edge  ide1
 16:        140          0   IO-APIC-level  aic7xxx
 17:          0          0   IO-APIC-level  es1371
 18:      25568          2   IO-APIC-level  ide2, ide3, eth1
 19:     955149     717889   IO-APIC-level  aic7xxx, eth0
NMI:          0          0
LOC:    7531043    7531389
ERR:          0
MIS:        131
