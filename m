Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWHEWeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWHEWeu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 18:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWHEWeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 18:34:50 -0400
Received: from www.polish-dvd.com ([69.222.0.225]:56709 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1751191AbWHEWeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 18:34:50 -0400
Message-ID: <20060805221410.22397.qmail@mail.webhostingstar.com>
From: "art" <art@usfltd.com>
To: linux-kernel@vger.kernel.org
Cc: davej@redhat.com, michal.k.k.piotrowski@gmail.com
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at
  /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Date: Sat, 05 Aug 2006 17:14:10 -0500
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same for 2.6.18.rc3-git7 on smp amd64 x2 (dualcore)
after
# echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 

dmesg 

....
SELinux: initialized (dev sdb1, type vfat), uses genfs_contexts
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug() 

Call Trace:
 [<ffffffff802a0e72>] lock_cpu_hotplug+0x50/0x73
 [<ffffffff80299a36>] __create_workqueue+0x5d/0x146
 [<ffffffff803f437d>] cpufreq_governor_dbs+0xa8/0x2f4
 [<ffffffff803f22ac>] __cpufreq_governor+0xa4/0x194
 [<ffffffff803f2516>] __cpufreq_set_policy+0x17a/0x1f4
 [<ffffffff803f2792>] store_scaling_governor+0x17c/0x1d8
 [<ffffffff803f35f8>] handle_update+0x0/0x28
 [<ffffffff8026650b>] _spin_unlock_irqrestore+0x15/0x30
 [<ffffffff803f1a00>] cpufreq_cpu_get+0xb5/0x143
 [<ffffffff80272dbf>] store+0x44/0x5b
 [<ffffffff802f1ddc>] sysfs_write_file+0xc5/0xf4
 [<ffffffff80215e1b>] vfs_write+0xce/0x174
 [<ffffffff802166a9>] sys_write+0x45/0x6e
 [<ffffffff8025fa8e>] system_call+0x7e/0x83 

 ------------------------------------------------------
my old message from 2006/08/03 


2.6.18-rc3-git1-smp-amd64 - Lukewarm IQ detected in hotplug
what i have in dmesg
Linux version 2.6.18-rc3-git1 (xxx@xxx.xxx) (gcc version 4.1.1 20060525)) #1 
SMP PREEMPT Tue Aug 1 09:46:44 CDT 2006
...
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
...
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses 
genfs_contexts
ip_tables: (C) 2000-2006 Netfilter Core Team
BUG: warning at kernel/cpu.c:51/unlock_cpu_hotplug()
Call Trace:
[<ffffffff802a0e51>] unlock_cpu_hotplug+0x3f/0x6c
[<ffffffff803f3937>] store_speed+0xc2/0xd1
[<ffffffff80272d3f>] store+0x44/0x5b
[<ffffffff802f1c8a>] sysfs_write_file+0xc5/0xf4
[<ffffffff80215e14>] vfs_write+0xce/0x174
[<ffffffff802166a2>] sys_write+0x45/0x6e
[<ffffffff8025fa0e>] system_call+0x7e/0x83
Netfilter messages via NETLINK v0.30.
...
...
SELinux: initialized (dev sdb1, type vfat), uses genfs_contexts
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
Call Trace:
[<ffffffff802a0def>] lock_cpu_hotplug+0x50/0x73
[<ffffffff802999ab>] __create_workqueue+0x5d/0x146
[<ffffffff803f4108>] cpufreq_governor_dbs+0xa8/0x2f4
[<ffffffff803f2006>] __cpufreq_governor+0xa4/0x194
[<ffffffff803f225f>] __cpufreq_set_policy+0x169/0x1d9
[<ffffffff803f24a8>] store_scaling_governor+0x153/0x18d
[<ffffffff803f32ed>] handle_update+0x0/0x28
[<ffffffff8026648b>] _spin_unlock_irqrestore+0x15/0x30
[<ffffffff803f1800>] cpufreq_cpu_get+0xb4/0x143
[<ffffffff80272d3f>] store+0x44/0x5b
[<ffffffff802f1c8a>] sysfs_write_file+0xc5/0xf4
[<ffffffff80215e14>] vfs_write+0xce/0x174
[<ffffffff802166a2>] sys_write+0x45/0x6e
[<ffffffff8025fa0e>] system_call+0x7e/0x83
hdc: CHECK for good STATUS
...
the same in 2.6.18-rc3-git3 any clue ?
 ------------------------------------------------- 

xboom 

art@usfltd.com
