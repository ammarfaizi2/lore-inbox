Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbVAWVhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVAWVhr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 16:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVAWVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 16:37:47 -0500
Received: from imap.gmx.net ([213.165.64.20]:24769 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261360AbVAWVhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 16:37:41 -0500
X-Authenticated: #1425685
Date: Sun, 23 Jan 2005 23:37:51 +0100
From: Ostdeutschland <Ostdeutschland@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: sleeping function called from invalid context at mm/slab.c:2085
Message-Id: <20050123233752.1a8d7e86.Ostdeutschland@gmx.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while suspending and resuming 2.6.11-rc2 i see the follwing:

   1467 Jan 23 23:15:59  Debug: sleeping function called from invalid context at mm/slab.c:2085
   1468 Jan 23 23:15:59  in_atomic():0, irqs_disabled():1
   1469 Jan 23 23:15:59  [<c0114e86>] __might_sleep+0xa6/0xb0
   1470 Jan 23 23:15:59  [<c013dead>] kmem_cache_alloc+0x6d/0x70
   1471 Jan 23 23:15:59  [<c0278c79>] acpi_pci_link_set+0x7d/0x269
   1472 Jan 23 23:15:59  [<c027932a>] acpi_pci_link_resume+0x48/0x86
   1473 Jan 23 23:15:59  [<c02793ad>] irqrouter_resume+0x45/0x70
   1474 Jan 23 23:15:59  [<c0279368>] irqrouter_resume+0x0/0x70
   1475 Jan 23 23:15:59  [<c02cd693>] sysdev_resume+0x103/0x108
   1476 Jan 23 23:15:59  [<c02d16e5>] device_power_up+0x5/0xa
   1477 Jan 23 23:15:59  [<c01317a6>] suspend_enter+0x36/0x50
   1478 Jan 23 23:15:59  [<c0131859>] enter_state+0x59/0xa0
   1479 Jan 23 23:15:59  [<c01319e0>] state_store+0xa0/0xa8
   1480 Jan 23 23:15:59  [<c018b8da>] subsys_attr_store+0x3a/0x40
   1481 Jan 23 23:15:59  [<c018bb9e>] flush_write_buffer+0x3e/0x50
   1482 Jan 23 23:15:59  [<c018bc43>] sysfs_write_file+0x93/0xb0
   1483 Jan 23 23:15:59  [<c01547e8>] vfs_write+0xc8/0x170
   1484 Jan 23 23:15:59  [<c0153ce9>] filp_close+0x59/0x90
   1485 Jan 23 23:15:59  [<c0154961>] sys_write+0x51/0x80
   1486 Jan 23 23:15:59  [<c0103197>] syscall_call+0x7/0xb


Regards-- 

mfg
