Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWGIFIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWGIFIT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 01:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWGIFIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 01:08:19 -0400
Received: from gw.goop.org ([64.81.55.164]:11493 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964983AbWGIFIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 01:08:18 -0400
Message-ID: <44B08F3F.1080704@goop.org>
Date: Sat, 08 Jul 2006 22:08:15 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: linux-acpi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kristen Accardi <kristen.c.accardi@intel.com>
Subject: 2.6.17-mm6: BUG: spinlock wrong CPU on CPU#1, kacpid_notify/7105
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Repost: got linux-acpi's address wrong. ]

I just got this while undocking my machine.  Thinkpad X60, Core Duo CPU.

ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4d74] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4d60] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4d4c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4d38] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4d24] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4d10] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4cfc] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4ce8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4cd4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4cc0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4cac] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4c98] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4c84] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec55b8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed0fa4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed0f90] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed0f7c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4c5c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4c48] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4c34] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec4c20] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec575c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec5748] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec5734] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec5720] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec570c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec56f8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec56e4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec56d0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec56bc] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec55a4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed0f68] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed0f54] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed0f40] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed0f2c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec56a8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec884c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ec8fe0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbb80] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbb6c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbb58] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbb44] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbb30] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbb1c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbb08] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbaf4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbae0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbacc] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbab8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecbaa4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecba90] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecf48c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed9658] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed9644] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed9630] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed961c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ed9608] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd504] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecf450] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd388] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecf43c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd93c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd928] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd914] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd900] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd8ec] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd8d8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd8c4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd8b0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd89c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd888] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd874] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd860] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd84c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd838] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd824] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd810] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd7fc] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd7e8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd7d4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd7c0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd7ac] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd798] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd784] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecd770] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdfe0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdfcc] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdfb8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdfa4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdf68] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdf54] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdf40] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdf2c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdf18] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdf04] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdef0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdedc] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdec8] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdeb4] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecdea0] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecde8c] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecde78] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecde64] [20060623]
ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object 
[f7ecde50] [20060623]
BUG: spinlock wrong CPU on CPU#1, kacpid_notify/7105
lock: f7e9ad9c, .magic: dead4ead, .owner: kacpid_notify/7105, .owner_cpu: 0
[<c01d6ee8>] _raw_spin_unlock+0x5d/0x70
[<c020d52a>] hotplug_dock_devices+0x8a/0x91
[<c01f302c>] acpi_os_execute_thread+0x0/0x1a
[<c020d638>] dock_notify+0xd2/0x15d
[<c020b2f5>] acpi_bus_notify+0x17/0x46
[<c01f85aa>] acpi_ev_notify_dispatch+0x4c/0x55
[<c01f3038>] acpi_os_execute_thread+0xc/0x1a
[<c01301bc>] kthread+0xc2/0xed
[<c01300fa>] kthread+0x0/0xed
[<c0101005>] kernel_thread_helper+0x5/0xb
ACPI: undocking

