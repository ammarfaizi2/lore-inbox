Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUIUVLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUIUVLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 17:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUIUVLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 17:11:16 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:54732 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267945AbUIUVKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 17:10:47 -0400
Message-ID: <249a3f9e0409211410422e1ab1@mail.gmail.com>
Date: Tue, 21 Sep 2004 16:10:44 -0500
From: Tim Savannah <kata198@gmail.com>
Reply-To: Tim Savannah <kata198@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S2
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reports in my dmesg from using voluntary-preempt-2.6.9-rc2-mm1-S2

This doesn't include a bunch of reports from nvidia.

using smp_processor_id() in preemptible code: rmmod/3329
 [<c011d200>] smp_processor_id+0x84/0x8a
 [<c013b527>] __stop_machine_run+0xc3/0xc7
 [<c01376a3>] __try_stop_module+0x0/0x42
 [<c013b530>] stop_machine_run+0x5/0x18
 [<c013769f>] try_stop_module+0x1f/0x23
 [<c0137854>] sys_delete_module+0xef/0x171
 [<c014d87f>] unmap_vma_list+0xe/0x17
 [<c014dbe9>] do_munmap+0x11a/0x176
 [<c0104049>] sysenter_past_esp+0x52/0x71

using smp_processor_id() in preemptible code: gkrellm/3542
 [<c011d200>] smp_processor_id+0x84/0x8a
 [<c02dc66a>] disk_round_stats+0x23/0x8d
 [<c02df0cf>] diskstats_show+0x17/0x312
 [<c0243de6>] inode_has_perm+0x53/0x87
 [<c024668f>] selinux_file_mmap+0x27/0x135
 [<c0275834>] __copy_to_user_ll+0x52/0x61
 [<c02758e3>] copy_to_user+0x40/0x53
 [<c0161bba>] cp_new_stat64+0xf0/0x102
 [<c0246280>] selinux_file_permission+0x111/0x166
 [<c01750cb>] seq_read+0xc3/0x273
 [<c0158a3a>] vfs_read+0xcd/0x126
 [<c0158d00>] sys_read+0x41/0x6a
 [<c0104049>] sysenter_past_esp+0x52/0x71

using smp_processor_id() in preemptible code: gkrellm/3542
 [<c011d200>] smp_processor_id+0x84/0x8a
 [<c02dc66a>] disk_round_stats+0x23/0x8d
 [<c02df0cf>] diskstats_show+0x17/0x312
 [<c01751db>] seq_read+0x1d3/0x273
 [<c0158a3a>] vfs_read+0xcd/0x126
 [<c0158d00>] sys_read+0x41/0x6a
 [<c0104049>] sysenter_past_esp+0x52/0x71
