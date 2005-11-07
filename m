Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVKGIgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVKGIgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 03:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKGIgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 03:36:47 -0500
Received: from [85.8.13.51] ([85.8.13.51]:52631 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932453AbVKGIgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 03:36:46 -0500
Message-ID: <436F1214.6000307@drzeus.cx>
Date: Mon, 07 Nov 2005 09:36:36 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: cpufreq@lists.linux.org.uk, davej@codemonkey.org.uk
Subject: sleeping function called from cpufreq
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of lately I've been getting tonnes of these:

[  610.185635] Debug: sleeping function called from invalid context at 
include/linux/rwsem.h:43
[  610.185647] in_atomic():1, irqs_disabled():0
[  610.185653]  [<c01041be>] dump_stack+0x1e/0x20
[  610.185667]  [<c0119b62>] __might_sleep+0xa2/0xc0
[  610.185678]  [<c029de86>] cpufreq_notify_transition+0x46/0x220
[  610.185690]  [<e09d08fc>] centrino_target+0xfc/0x130 [speedstep_centrino]
[  610.185708]  [<c029f17f>] __cpufreq_driver_target+0x5f/0x70
[  610.185718]  [<c02a029d>] cpufreq_set+0x7d/0xa0
[  610.185728]  [<c02a0339>] store_speed+0x49/0x50
[  610.185737]  [<c029e6c6>] store+0x46/0x60
[  610.185745]  [<c01a5f27>] flush_write_buffer+0x37/0x40
[  610.185754]  [<c01a5f98>] sysfs_write_file+0x68/0x90
[  610.185763]  [<c01639b8>] vfs_write+0xa8/0x190
[  610.185773]  [<c0163b57>] sys_write+0x47/0x70
[  610.185781]  [<c01032bb>] sysenter_past_esp+0x54/0x75

Ideas on solving it?

Rgds
Pierre
