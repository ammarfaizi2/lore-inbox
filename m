Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbVBOTAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbVBOTAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 14:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBOTAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 14:00:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:9128 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261825AbVBOTAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 14:00:07 -0500
X-Authenticated: #1425685
Date: Tue, 15 Feb 2005 19:54:40 +0100
From: ostdeutschland <ostdeutschland@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: "sleeping function called from invalid context.." when resuming
 from S3
Message-Id: <20050215195440.763ccca1.ostdeutschland@gmx.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

after resuming from s3, i got the following oops:

hwsleep-0306 [10487] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
Warning: CPU frequency is 600000, cpufreq assumed 1400000 kHz.
Debug: sleeping function called from invalid context at mm/slab.c:2082
in_atomic():0, irqs_disabled():1
 [<c0114e96>] __might_sleep+0xa6/0xb0
 [<c013e03d>] kmem_cache_alloc+0x6d/0x70
 [<c02794e1>] acpi_pci_link_set+0x7d/0x269
 [<c0279b92>] acpi_pci_link_resume+0x48/0x86
 [<c0279c15>] irqrouter_resume+0x45/0x70
 [<c0279bd0>] irqrouter_resume+0x0/0x70
 [<c02c9e83>] sysdev_resume+0x103/0x108
 [<c02ce795>] device_power_up+0x5/0xa
 [<c01318b6>] suspend_enter+0x36/0x50
 [<c0131969>] enter_state+0x59/0xa0
 [<c0131af0>] state_store+0xa0/0xa8
 [<c018beea>] subsys_attr_store+0x3a/0x40
 [<c018c1ae>] flush_write_buffer+0x3e/0x50
 [<c018c253>] sysfs_write_file+0x93/0xb0
 [<c0154abe>] vfs_write+0xae/0x130
 [<c0154c11>] sys_write+0x51/0x80
 [<c010318f>] syscall_call+0x7/0xb

Please note the cpufreq-related warning, too.


thanks...
