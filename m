Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWHHGvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWHHGvm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 02:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWHHGvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 02:51:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:24488 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932298AbWHHGvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 02:51:41 -0400
X-Authenticated: #14349625
Subject: 2.6.18-rc4: Lukewarm IQ
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 08:59:06 +0000
Message-Id: <1155027546.6152.5.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably already known, but just in case...

CLASS: registering class device: ID = 'audio'
class_uevent - name = audio
class_device_create_uevent called for audio
<snip * zillion>

Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
 [<b1004150>] show_trace_log_lvl+0x16e/0x191
 [<b1004837>] show_trace+0x12/0x14
 [<b1004958>] dump_stack+0x19/0x1b
 [<b103b7bc>] lock_cpu_hotplug+0x79/0x82
 [<b10324e1>] __create_workqueue+0x50/0x171
 [<b13001e7>] cpufreq_governor_dbs+0x2b9/0x30f
 [<b12fdb2e>] __cpufreq_governor+0x22/0x166
 [<b12fdd58>] __cpufreq_set_policy+0xe6/0x133
 [<b12fea3e>] store_scaling_governor+0xa8/0x1e2
 [<b12fe2d9>] store+0x34/0x47
 [<b10aa7b5>] sysfs_write_file+0x83/0xc1
 [<b106cee8>] vfs_write+0xa6/0x170
 [<b106d590>] sys_write+0x3d/0x64
 [<b10030e7>] syscall_call+0x7/0xb
 [<a7c2a3ce>] 0xa7c2a3ce
 [<b1004837>] show_trace+0x12/0x14
 [<b1004958>] dump_stack+0x19/0x1b
 [<b103b7bc>] lock_cpu_hotplug+0x79/0x82
 [<b10324e1>] __create_workqueue+0x50/0x171
 [<b13001e7>] cpufreq_governor_dbs+0x2b9/0x30f
 [<b12fdb2e>] __cpufreq_governor+0x22/0x166
 [<b12fdd58>] __cpufreq_set_policy+0xe6/0x133
 [<b12fea3e>] store_scaling_governor+0xa8/0x1e2
 [<b12fe2d9>] store+0x34/0x47
 [<b10aa7b5>] sysfs_write_file+0x83/0xc1
 [<b106cee8>] vfs_write+0xa6/0x170
 [<b106d590>] sys_write+0x3d/0x64
 [<b10030e7>] syscall_call+0x7/0xb


