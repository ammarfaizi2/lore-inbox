Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWHISsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWHISsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWHISsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:48:42 -0400
Received: from igw1.zrnko.cz ([81.31.45.161]:7878 "EHLO anubis.fi.muni.cz")
	by vger.kernel.org with ESMTP id S1751318AbWHISsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:48:41 -0400
Date: Wed, 9 Aug 2006 20:48:42 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: CPU HOTPLUG BUG 2.6.18-rc4
Message-ID: <20060809184842.GF2959@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

just tested CPU HOTPLUG using 2.6.18-rc4 kernel on Intel Core 2 Duo on DP965LT
Intel board. I'm running in X86_64 mode, SMP, kernel preemtion, bkl preemt.

After booting I got this (non fatal) dump:
Lukewarm IQ detected in hotplug locking
BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()

Call Trace:
 [<ffffffff802a0708>] lock_cpu_hotplug+0x51/0x76
 [<ffffffff80298917>] __create_workqueue+0x57/0x157
 [<ffffffff803fc52b>] cpufreq_governor_dbs+0xbb/0x330
 [<ffffffff803f9f98>] __cpufreq_governor+0x98/0x19f
 [<ffffffff803fa72d>] __cpufreq_set_policy+0xfd/0x142
 [<ffffffff803faf43>] store_scaling_governor+0x183/0x1e2
 [<ffffffff803faabc>] handle_update+0x0/0x14
 [<ffffffff8020f086>] __alloc_pages+0x76/0x2d0
 [<ffffffff8027bef2>] store+0x44/0x5b
 [<ffffffff802e0673>] sysfs_write_file+0xb8/0xe3
 [<ffffffff8021674d>] vfs_write+0xad/0x159
 [<ffffffff80216fe7>] sys_write+0x45/0x7e
 [<ffffffff802617ce>] system_call+0x7e/0x83


-- 
Luká¹ Hejtmánek
