Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269187AbUISIOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269187AbUISIOV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 04:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269190AbUISIOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 04:14:20 -0400
Received: from webmail.sub.ru ([213.247.139.22]:25355 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S269187AbUISIOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 04:14:17 -0400
Subject: 2.6.8.1 fails to recognize hotplugged USB device
From: Mikhail Ramendik <mr@ramendik.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1095581643.2662.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Sun, 19 Sep 2004 12:14:04 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use 2.6.8.1. On 2.6.7 things were OK. My motherboard is an Asus
P4P800, with the Intel i865PE chipset. USB stuff is compiled into the
kernel (not as modules).

When I plug in a USB device it is not recognized. It does not even
appear in lsusb. 

The system works OK with USB devices that were plugged in at boot time.
But when I unplug one, wait some seconds and plug it in again, the
system does npt see it anymore.

On the first plugging-in of any USB device, the following appears in
/var/log/messages : 

===

Sep 19 11:49:07 localhost kernel: irq 11: nobody cared!
Sep 19 11:49:07 localhost kernel:  [<c010784c>]
__report_bad_irq+0x2a/0x8b
Sep 19 11:49:07 localhost kernel:  [<c0107936>] note_interrupt+0x6f/0x9f
Sep 19 11:49:07 localhost kernel:  [<c0107b2c>] do_IRQ+0xe3/0xe5
Sep 19 11:49:07 localhost kernel:  [<c0106104>]
common_interrupt+0x18/0x20
Sep 19 11:49:07 localhost kernel:  [<c01077e2>]
handle_IRQ_event+0x24/0x64
Sep 19 11:49:07 localhost kernel:  [<c0107abb>] do_IRQ+0x72/0xe5
Sep 19 11:49:07 localhost kernel:  [<c0106104>]
common_interrupt+0x18/0x20
Sep 19 11:49:07 localhost kernel:  [<c011d47f>] __do_softirq+0x2f/0x83
Sep 19 11:49:07 localhost kernel:  [<c011d4f9>] do_softirq+0x26/0x28
Sep 19 11:49:07 localhost kernel:  [<c0107b13>] do_IRQ+0xca/0xe5
Sep 19 11:49:07 localhost kernel:  [<c010401e>] default_idle+0x0/0x27
Sep 19 11:49:07 localhost kernel:  [<c0106104>]
common_interrupt+0x18/0x20
Sep 19 11:49:07 localhost kernel:  [<c010401e>] default_idle+0x0/0x27
Sep 19 11:49:07 localhost kernel:  [<c0104042>] default_idle+0x24/0x27
Sep 19 11:49:07 localhost kernel:  [<c01040a9>] cpu_idle+0x2e/0x37
Sep 19 11:49:07 localhost kernel:  [<c03e26ca>] start_kernel+0x17e/0x1bd
Sep 19 11:49:07 localhost kernel:  [<c03e22e4>]
unknown_bootoption+0x0/0x16f
Sep 19 11:49:07 localhost kernel: handlers:
Sep 19 11:49:07 localhost kernel: [<d099d725>]
(ohci_irq_handler+0x0/0x78d [ohci1394])
Sep 19 11:49:07 localhost kernel: [<d0aa06a5>] (SkGeIsrOnePort+0x0/0x146
[sk98lin])
Sep 19 11:49:07 localhost kernel: [<d0b07796>]
(snd_intel8x0_interrupt+0x0/0x1ef [snd_intel8x0])
Sep 19 11:49:07 localhost kernel: Disabling IRQ #11
Sep 19 11:49:47 localhost kernel: drivers/usb/input/hid-core.c: input
irq status -84 received
Sep 19 11:49:48 localhost last message repeated 2 times
Sep 19 11:49:48 localhost kernel: usb 2-1: USB disconnect, address 2
Sep 19 11:49:48 localhost /etc/hotplug/usb.agent: Bad USB agent
invocation
Sep 19 11:49:53 localhost /etc/hotplug/usb.agent: Bad USB agent
invocation
Sep 19 11:49:57 localhost gpm[1972]: imps2: Auto-detected intellimouse
PS/2

===

Is there anything one can do about this?

Yours, Mikhail Ramendik



