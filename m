Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVA0OS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVA0OS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 09:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVA0OS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 09:18:58 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:13440 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262632AbVA0OSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 09:18:55 -0500
Message-ID: <41F91470.6040204@tiscali.de>
Date: Thu, 27 Jan 2005 16:18:56 +0000
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Preempt & Xfs Question
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I have a question: Why do I get such debug messages:

BUG: using smp_processor_id() in preemptible [00000001] code: khelper/892
caller is _pagebuf_lookup_pages+0x11b/0x362
 [<c03119c7>] smp_processor_id+0xa3/0xb4
 [<c02ef802>] _pagebuf_lookup_pages+0x11b/0x362
 [<c02ef802>] _pagebuf_lookup_pages+0x11b/0x362
 [<c02efe31>] xfs_buf_get_flags+0x106/0x141
 [<c02efeaa>] xfs_buf_read_flags+0x3e/0xae
 [<c02e0fd5>] xfs_trans_read_buf+0x18b/0x389
 [<c02ada32>] xfs_da_do_buf+0x735/0x88c
 [<c0127f46>] run_timer_softirq+0x12d/0x1c7
 [<c02adc1b>] xfs_da_read_buf+0x47/0x4b
 [<c02b1b22>] xfs_dir2_block_lookup_int+0x52/0x1b4
 [<c02b1b22>] xfs_dir2_block_lookup_int+0x52/0x1b4
 [<c011f189>] vprintk+0x133/0x16a
 [<c0101319>] kernel_thread_helper+0x5/0xb
 [<c0130253>] __kernel_text_address+0x28/0x36
 [<c02b1a10>] xfs_dir2_block_lookup+0x2f/0xef
 [<c02b0967>] xfs_dir2_isblock+0x2c/0x74
 [<c02aff4e>] xfs_dir2_lookup+0x176/0x186
 [<c01389d9>] __print_symbol+0x86/0xef
 [<c02e214e>] xfs_dir_lookup_int+0x4c/0x144
 [<c04cf6aa>] _spin_lock+0x16/0x7c
 [<c02e7cc8>] xfs_lookup+0x55/0x8a
 [<c02f4736>] linvfs_lookup+0x52/0x99
 [<c01698a2>] real_lookup+0xc2/0xe3
 [<c0169b2c>] do_lookup+0x96/0xa1
 [<c0169cd0>] link_path_walk+0x199/0xe3a
 [<c012a2f1>] do_notify_parent+0x108/0x214
 [<c016ac39>] path_lookup+0x97/0x15f
 [<c0166612>] open_exec+0x2f/0x102
 [<c011834b>] task_rq_lock+0x36/0x66
 [<c01676ed>] do_execve+0x42/0x201
 [<c0101cc1>] sys_execve+0x46/0x9c
 [<c010318b>] syscall_call+0x7/0xb
 [<c012e60e>] ____call_usermodehelper+0xa1/0xc0
 [<c012e56d>] ____call_usermodehelper+0x0/0xc0
 [<c0101319>] kernel_thread_helper+0x5/0xb

Does the XFS Module avoid preemption rules? If so, why?

Thanks
Matthias-Christian Ott

-- 
http://unixforge.org/~matthias-christian-ott/

