Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbTIUSly (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTIUSly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:41:54 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:8685 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S262508AbTIUSlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:41:52 -0400
Date: Sun, 21 Sep 2003 14:41:49 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@onerussian.com
Subject: USB problem. 'irq 9: nobody cared!'
Message-ID: <20030921184149.GA12274@washoe.rutgers.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Gurus,

Since one of the bk versions in -test4- USB problem persist. On boot I'm
getting next dump. More information about my system and configuration is at

http://www.onerussian.com/Linux/bug.USB/

Please help to get rid of the problem cause USB doesn't work now for me :-(

drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface
driver v2.1
uhci-hcd 0000:00:1f.2: UHCI Host Controller
irq 9: nobody cared!
Call Trace:
 [<c010b70a>] __report_bad_irq+0x2a/0x90
 [<c010b800>] note_interrupt+0x70/0xb0
 [<c010bad0>] do_IRQ+0x120/0x130
 [<c0109d88>] common_interrupt+0x18/0x20
 [<c0124b6e>] do_softirq+0x3e/0xa0
 [<c010baab>] do_IRQ+0xfb/0x130
 [<c0109d88>] common_interrupt+0x18/0x20
 [<c01f3c60>] pci_bus_write_config_word+0x60/0x90
 [<c02f6331>] uhci_reset+0x41/0x60
 [<c02e5b44>] usb_hcd_pci_probe+0x194/0x4a0
 [<c016b3a1>] dput+0x31/0x220
 [<c01f7bc2>] pci_device_probe_static+0x52/0x70
 [<c01f7c1c>] __pci_device_probe+0x3c/0x50
 [<c01f7c5c>] pci_device_probe+0x2c/0x50
 [<c025accf>] bus_match+0x3f/0x70
 [<c025ae1f>] driver_attach+0x6f/0xb0
 [<c025b0e3>] bus_add_driver+0x93/0xb0
 [<c025b51f>] driver_register+0x2f/0x40
 [<c01f7e50>] pci_register_driver+0x60/0x90
 [<c053207d>] uhci_hcd_init+0xbd/0x150
 [<c05167ab>] do_initcalls+0x2b/0xa0
 [<c01305bf>] init_workqueues+0xf/0x30
 [<c01050a4>] init+0x34/0x1d0
 [<c0105070>] init+0x0/0x1d0
 [<c01072a5>] kernel_thread_helper+0x5/0x10

handlers:
[<c02015cf>] (acpi_irq+0x0/0x16)
[<c02bb040>] (ohci_irq_handler+0x0/0x7e0)
[<c02d9240>] (yenta_interrupt+0x0/0x40)
Disabling IRQ #9

Sincerely
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
