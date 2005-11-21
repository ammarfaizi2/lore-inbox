Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbVKUQoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVKUQoh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVKUQoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:44:37 -0500
Received: from mout1.freenet.de ([194.97.50.132]:1514 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1751034AbVKUQof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:44:35 -0500
From: Sascha Sommer <saschasommer@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: sleeping function called from invaled context at mm/slab.c:2472
Date: Mon, 21 Nov 2005 17:44:25 +0100
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211744.25859.saschasommer@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm not sure if this is the right place to report but
suspend to disk in 2.6.15-rc2 triggers the following:

Debug: sleeping function called from invalid context at mm/slab.c:2472
in_atomic():0, irqs_disabled():1
 [<c014d53a>] kmem_cache_alloc+0x9a/0xc0
 [<c02fcdc2>] acpi_pci_link_set+0x48/0x18a
 [<c02fd313>] acpi_pci_link_resume+0x21/0x27
 [<c02fd336>] irqrouter_resume+0x1d/0x3c
 [<c03507e9>] __sysdev_resume+0x19/0x90
 [<c0350b18>] sysdev_resume+0x48/0x67
 [<c0356315>] device_power_up+0x5/0xa
 [<c013cdac>] swsusp_suspend+0x6c/0xa0
 [<c013d7df>] pm_suspend_disk+0x4f/0xb0
 [<c013bc98>] enter_state+0x68/0xa0
 [<c013be38>] state_store+0xa8/0xc3
 [<c01a7567>] flush_write_buffer+0x37/0x40
 [<c01a75e3>] sysfs_write_file+0x73/0xa0
 [<c0165366>] vfs_write+0xd6/0x1b0
 [<c016550b>] sys_write+0x4b/0x80
 [<c01033a7>] sysenter_past_esp+0x54/0x75

Tell me if you need more info.

Thanks

Sascha
