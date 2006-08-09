Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWHIJ1L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWHIJ1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbWHIJ1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:27:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12217 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030609AbWHIJ1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:27:10 -0400
Date: Wed, 9 Aug 2006 10:55:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       davej@codemonkey.org.uk
Subject: rc4: lukewarm irq warning during boot
Message-ID: <20060809085534.GA1694@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm getting this... I guess this is known and too hard to fix for
2.6.18... but perhaps warning should be disabled? (Or is that already
a plan for 2.6.18?)

								Pavel
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
 [<c0104343>] show_trace_log_lvl+0x163/0x190
 [<c01057af>] show_trace+0xf/0x20
 [<c01057d5>] dump_stack+0x15/0x20
 [<c01427fc>] lock_cpu_hotplug+0x7c/0x90
 [<c0138af7>] __create_workqueue+0x47/0x140
 [<c04bb58b>] cpufreq_governor_dbs+0x2cb/0x320
 [<c04b97d6>] __cpufreq_governor+0x46/0xf0
 [<c04b9a82>] __cpufreq_set_policy+0xf2/0x140
 [<c04b9d22>] store_scaling_governor+0xd2/0x1c0
 [<c04b95cd>] store+0x3d/0x60
 [<c01ab55f>] sysfs_write_file+0x8f/0xe0
 [<c016e056>] vfs_write+0xa6/0x160
 [<c016ea11>] sys_write+0x41/0x70
 [<c010303f>] syscall_call+0x7/0xb
 [<b7ec52ce>] 0xb7ec52ce
 [<c01427fc>] lock_cpu_hotplug+0x7c/0x90
 [<c0138af7>] __create_workqueue+0x47/0x140
 [<c04bb58b>] cpufreq_governor_dbs+0x2cb/0x320
 [<c013531b>] notifier_call_chain+0x2b/0x60
 [<c04b97d6>] __cpufreq_governor+0x46/0xf0
 [<c04b9a82>] __cpufreq_set_policy+0xf2/0x140
 [<c04b9d22>] store_scaling_governor+0xd2/0x1c0
 [<c04ba710>] handle_update+0x0/0x10
 [<c0269500>] kobject_set_name+0x20/0xb0
 [<c04b9c50>] store_scaling_governor+0x0/0x1c0
 [<c04b95cd>] store+0x3d/0x60
 [<c01ab55f>] sysfs_write_file+0x8f/0xe0
 [<c016e056>] vfs_write+0xa6/0x160
 [<c01ab4d0>] sysfs_write_file+0x0/0xe0
 [<c016ea11>] sys_write+0x41/0x70
 [<c010303f>] syscall_call+0x7/0xb


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
