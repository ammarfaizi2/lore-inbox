Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWGYR5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWGYR5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWGYR5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 13:57:48 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:38533 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751401AbWGYR5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 13:57:47 -0400
Message-ID: <44C65B97.7010404@cmu.edu>
Date: Tue, 25 Jul 2006 13:57:43 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc2-git4: BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

I recently compiled a 2.6.18-rc2-git4 kernel and get this with cpu
hotplug enabled:
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
 [<c0138635>] lock_cpu_hotplug+0x74/0x7d
 [<c012f815>] __create_workqueue+0x44/0x13c
 [<c0340df6>] cpufreq_stat_notifier_policy+0x22/0x1d2
 [<c03418c0>] cpufreq_governor_dbs+0x2c7/0x31d
 [<c033f5ff>] __cpufreq_governor+0x1d/0x150
 [<c033f7f3>] __cpufreq_set_policy+0xc1/0xf7
 [<c03403a7>] store_scaling_governor+0xa2/0x180
 [<c033fbd6>] handle_update+0x0/0x5
 [<c0222800>] kobject_cleanup+0x59/0x60
 [<c0340305>] store_scaling_governor+0x0/0x180
 [<c033fe79>] store+0x2e/0x3e
 [<c018ed8d>] sysfs_write_file+0x8b/0xc7
 [<c015dd9b>] vfs_write+0x87/0xf5
 [<c018ed02>] sysfs_write_file+0x0/0xc7
 [<c015e350>] sys_write+0x41/0x6a
 [<c0102f15>] sysenter_past_esp+0x56/0x79
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
 [<c0138635>] lock_cpu_hotplug+0x74/0x7d
 [<c0341697>] cpufreq_governor_dbs+0x9e/0x31d
 [<c033f5ff>] __cpufreq_governor+0x1d/0x150
 [<c033f803>] __cpufreq_set_policy+0xd1/0xf7
 [<c03403a7>] store_scaling_governor+0xa2/0x180
 [<c033fbd6>] handle_update+0x0/0x5
 [<c0222800>] kobject_cleanup+0x59/0x60
 [<c0340305>] store_scaling_governor+0x0/0x180
 [<c033fe79>] store+0x2e/0x3e
 [<c018ed8d>] sysfs_write_file+0x8b/0xc7
 [<c015dd9b>] vfs_write+0x87/0xf5
 [<c018ed02>] sysfs_write_file+0x0/0xc7
 [<c015e350>] sys_write+0x41/0x6a
 [<c0102f15>] sysenter_past_esp+0x56/0x79

Just wanted to report this.

Thanks!
George
