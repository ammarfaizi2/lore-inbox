Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTJALdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 07:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbTJALdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 07:33:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:39559 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261969AbTJALdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 07:33:33 -0400
X-Authenticated: #12859812
Date: Wed, 1 Oct 2003 13:33:49 +0200
From: "[ATR]Dj-Death" <djdeath@gmx.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 Digital camera usb crash
Message-ID: <20031001113349.GA10787@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have a digital camera and using 2.6.0-test6 I had got
a kernel crash.
I was reading some photos on the camera, then I remove
the digital camera and I came back to the camera's mount
point using an image browser (gqview). I had got that error :

Sep 29 21:54:20 traktopel kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000006d
Sep 29 21:54:20 traktopel kernel:  printing eip:
Sep 29 21:54:20 traktopel kernel: f18643af
Sep 29 21:54:20 traktopel kernel: *pde = 00000000
Sep 29 21:54:20 traktopel kernel: Oops: 0000 [#1]
Sep 29 21:54:20 traktopel kernel: CPU:    0
Sep 29 21:54:20 traktopel kernel: EIP:    0060:[<f18643af>]    Tainted: P  
Sep 29 21:54:20 traktopel kernel: EFLAGS: 00010046
Sep 29 21:54:20 traktopel kernel: EIP is at scsi_prep_fn+0x7f/0x180 [scsi_mod]
Sep 29 21:54:20 traktopel kernel: eax: 00000001   ebx: d9e51118   ecx: da54bd00   edx: 00000001
Sep 29 21:54:20 traktopel kernel: esi: ef455d00   edi: d9e51118   ebp: e4247800   esp: dc2e9c10
Sep 29 21:54:20 traktopel kernel: ds: 007b   es: 007b   ss: 0068
Sep 29 21:54:20 traktopel kernel: Process gqview (pid: 28011, threadinfo=dc2e8000 task=e1c2ed40)
Sep 29 21:54:20 traktopel kernel: Stack: ef455d00 00000020 dc2e9c5c 00000000 d9e51118 d37f5e00 dc2e9c5c 00000000 
Sep 29 21:54:20 traktopel kernel:        c01fe33e d37f5e00 d9e51118 d9e51118 d37f5e00 d37f5e00 c01ffd68 d37f5e00 
Sep 29 21:54:20 traktopel kernel:        dc2e8000 c01ffeea d37f5e00 dc2e9c5c dc2e9c5c de273b70 c037c028 dc2e9c9c 
Sep 29 21:54:20 traktopel kernel: Call Trace:
Sep 29 21:54:20 traktopel kernel:  [<c01fe33e>] elv_next_request+0x4e/0x100
Sep 29 21:54:20 traktopel kernel:  [<c01ffd68>] generic_unplug_device+0x68/0x80
Sep 29 21:54:20 traktopel kernel:  [<c01ffeea>] blk_run_queues+0x7a/0xb0
Sep 29 21:54:20 traktopel kernel:  [<c0152c9f>] __wait_on_buffer+0xbf/0xd0
Sep 29 21:54:20 traktopel kernel:  [<c01542e5>] __find_get_block+0x65/0xe0
Sep 29 21:54:20 traktopel kernel:  [<c011c0d0>] autoremove_wake_function+0x0/0x50
Sep 29 21:54:20 traktopel kernel:  [<c015696b>] bio_alloc+0xcb/0x1a0
Sep 29 21:54:20 traktopel kernel:  [<c011c0d0>] autoremove_wake_function+0x0/0x50
Sep 29 21:54:20 traktopel kernel:  [<c015413d>] __bread_slow+0x4d/0xb0
Sep 29 21:54:20 traktopel kernel:  [<c0154455>] __bread+0x35/0x40
Sep 29 21:54:20 traktopel kernel:  [<f1b0b5e2>] fat__get_entry+0xa2/0x18d [fat]
Sep 29 21:54:20 traktopel kernel:  [<c0163d24>] filldir64+0xc4/0x110
Sep 29 21:54:20 traktopel kernel:  [<f1b07444>] fat_readdirx+0xd64/0xe60 [fat]
Sep 29 21:54:20 traktopel kernel:  [<c0119a5e>] recalc_task_prio+0x8e/0x1b0
Sep 29 21:54:20 traktopel kernel:  [<c019c8d1>] __journal_file_buffer+0x181/0x270
Sep 29 21:54:20 traktopel kernel:  [<c019afd6>] do_get_write_access+0x2c6/0x5f0
Sep 29 21:54:20 traktopel kernel:  [<f18b207b>] autofs_update_usage+0x1b/0x40 [autofs]
Sep 29 21:54:20 traktopel kernel:  [<f18b207b>] autofs_update_usage+0x1b/0x40 [autofs]
Sep 29 21:54:20 traktopel kernel:  [<c0168122>] dput+0x22/0x210
Sep 29 21:54:20 traktopel kernel:  [<c0168122>] dput+0x22/0x210
Sep 29 21:54:20 traktopel kernel:  [<c015f5d0>] link_path_walk+0x5f0/0x8f0
Sep 29 21:54:20 traktopel kernel:  [<c0168122>] dput+0x22/0x210
Sep 29 21:54:20 traktopel kernel:  [<c012bd05>] in_group_p+0x25/0x30
Sep 29 21:54:20 traktopel kernel:  [<c015ea0c>] vfs_permission+0x7c/0x110
Sep 29 21:54:20 traktopel kernel:  [<c015b5d4>] cp_new_stat64+0x114/0x130
Sep 29 21:54:20 traktopel kernel:  [<f1b07579>] fat_readdir+0x39/0x40 [fat]
Sep 29 21:54:20 traktopel kernel:  [<c0163c60>] filldir64+0x0/0x110
Sep 29 21:54:20 traktopel kernel:  [<c016397c>] vfs_readdir+0x7c/0x80
Sep 29 21:54:20 traktopel kernel:  [<c0163c60>] filldir64+0x0/0x110
Sep 29 21:54:20 traktopel kernel:  [<c0163ddf>] sys_getdents64+0x6f/0xa9
Sep 29 21:54:20 traktopel kernel:  [<c0163c60>] filldir64+0x0/0x110
Sep 29 21:54:20 traktopel kernel:  [<c01091db>] syscall_call+0x7/0xb
Sep 29 21:54:20 traktopel kernel: 
Sep 29 21:54:20 traktopel kernel: Code: ff 50 6c 85 c0 74 05 8b 47 08 eb c2 89 34 24 e8 3d f9 ff ff 
Sep 29 21:54:20 traktopel kernel:  <6>note: gqview[28011] exited with preempt_count 2

The kernel crashed without panic.
I just had to reboot the box.

I'm using autofs to automaticly umount the camera.
But as you probably know, autofs doesn't umount umount any
devices even after the default timeout. It seems to be a
bug too.

If you need more informations please ask me, I can reproduce that error.

Thx.
