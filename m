Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265729AbUFXVeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUFXVeM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 17:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbUFXVdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 17:33:38 -0400
Received: from mproxy.gmail.com ([216.239.56.242]:54924 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S265696AbUFXVbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:31:07 -0400
Message-ID: <bca9c54204062414315317659d@mail.gmail.com>
Date: Thu, 24 Jun 2004 17:31:03 -0400
From: Steev Klimaszewski <threeway@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.7-mm2 i82365 (pcmcia) complaint
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with i82365 compatible bridge support, the kernel
complains as such when booting.

Device 'i823650' does not have a release() function, it is broken and
must be fixed.
Badness in device_release at drivers/base/core.c:85
 [<c024e4de>] kobject_cleanup+0x98/0x9a
 [<c02a30b8>] platform_device_unregister+0x1b/0x59
 [<c05295cb>] init_i82365+0x1c0/0x1d6
 [<c025baeb>] pci_register_driver+0x6a/0x84
 [<c05146e1>] do_initcalls+0x27/0xb3
 [<c012527e>] init_workqueues+0x17/0x31
 [<c01003e1>] init+0x0/0x150
 [<c0100419>] init+0x38/0x150
 [<c0102258>] kernel_thread_helper+0x0/0xb
 [<c010225d>] kernel_thread_helper+0x5/0xb

I don't actually have an i82365 bridge, so that might be why, but I
thought I would post it in case someone else who does have one would
know more.
