Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUGLXnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUGLXnd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUGLXnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:43:33 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:34558 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S264255AbUGLXn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:43:26 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Preempt Threshold Measurements
Date: Mon, 12 Jul 2004 19:43:25 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121943.25196.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping in mind that I'm using the nvidia-kernel drivers, here are my preempt 
threshold violations.

6ms non-preemptible critical section violated 4 ms preempt threshold starting 
at kernel_fpu_begin+0xd/0x50 and ending at _mmx_memcpy+0x127/0x170
 [<c0241987>] _mmx_memcpy+0x127/0x170
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c0241987>] _mmx_memcpy+0x127/0x170
 [<c012d3b5>] load_module+0x835/0x900
 [<c013c84e>] unmap_vmas+0x10e/0x1f0
 [<c012d4fb>] sys_init_module+0x7b/0x230
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6106  Wed Jun 23 
08:14:01 PDT 2004
NTFS volume version 3.1.
14ms non-preemptible critical section violated 4 ms preempt threshold starting 
at sys_ioctl+0x42/0x290 and ending at sys_ioctl+0xbd/0x290
 [<c0158ded>] sys_ioctl+0xbd/0x290
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c0158ded>] sys_ioctl+0xbd/0x290
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
nfs warning: mount version older than kernel
6ms non-preemptible critical section violated 4 ms preempt threshold starting 
at pte_alloc_map+0x3d/0xb0 and ending at copy_mm+0x33b/0x3c0
 [<c0116ecb>] copy_mm+0x33b/0x3c0
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c0116ecb>] copy_mm+0x33b/0x3c0
 [<c01177c2>] copy_process+0x3b2/0xa90
 [<c0117edd>] do_fork+0x3d/0x188
 [<c012280f>] sigprocmask+0x4f/0xd0
 [<c0242000>] copy_to_user+0x40/0x60
 [<c0102b15>] sys_clone+0x35/0x40
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
hdd: DMA disabled
41ms non-preemptible critical section violated 4 ms preempt threshold starting 
at chrdev_open+0xd9/0x210 and ending at schedule+0x237/0x480
 [<c03873f7>] schedule+0x237/0x480
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c03873f7>] schedule+0x237/0x480
 [<c0126261>] worker_thread+0x1d1/0x240
 [<c01262b2>] worker_thread+0x222/0x240
 [<c0114d78>] activate_task+0x68/0x80
 [<c0383fb0>] do_cache_clean+0x0/0x40
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c03873f7>] schedule+0x237/0x480
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c0126090>] worker_thread+0x0/0x240
 [<c01298c4>] kthread+0x94/0xa0
 [<c0129830>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
248ms non-preemptible critical section violated 4 ms preempt threshold 
starting at schedule+0x57/0x480 and ending at schedule+0x237/0x480
 [<c03873f7>] schedule+0x237/0x480
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c03873f7>] schedule+0x237/0x480
 [<c0126261>] worker_thread+0x1d1/0x240
 [<c01262b2>] worker_thread+0x222/0x240
 [<c0114d78>] activate_task+0x68/0x80
 [<c02d0740>] fb_flashcursor+0x0/0x80
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c03873f7>] schedule+0x237/0x480
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c0126090>] worker_thread+0x0/0x240
 [<c01298c4>] kthread+0x94/0xa0
 [<c0129830>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18
228ms non-preemptible critical section violated 4 ms preempt threshold 
starting at schedule+0x57/0x480 and ending at schedule+0x237/0x480
 [<c03873f7>] schedule+0x237/0x480
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c03873f7>] schedule+0x237/0x480
 [<c0126261>] worker_thread+0x1d1/0x240
 [<c01262b2>] worker_thread+0x222/0x240
 [<c0114d78>] activate_task+0x68/0x80
 [<c02d0740>] fb_flashcursor+0x0/0x80
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c03873f7>] schedule+0x237/0x480
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c0126090>] worker_thread+0x0/0x240
 [<c01298c4>] kthread+0x94/0xa0
 [<c0129830>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18
36ms non-preemptible critical section violated 4 ms preempt threshold starting 
at schedule+0x57/0x480 and ending at schedule+0x237/0x480
 [<c03873f7>] schedule+0x237/0x480
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c03873f7>] schedule+0x237/0x480
 [<c0387b60>] schedule_timeout+0x60/0xc0
 [<c01162f0>] dec_preempt_count+0x50/0x120
 [<c0120110>] process_timeout+0x0/0x10
 [<c01201fe>] sys_nanosleep+0xce/0x150
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
41ms non-preemptible critical section violated 4 ms preempt threshold starting 
at chrdev_open+0xd9/0x210 and ending at schedule+0x237/0x480
 [<c03873f7>] schedule+0x237/0x480
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c03873f7>] schedule+0x237/0x480
 [<c0387b60>] schedule_timeout+0x60/0xc0
 [<c01162f0>] dec_preempt_count+0x50/0x120
 [<c0120110>] process_timeout+0x0/0x10
 [<c01201fe>] sys_nanosleep+0xce/0x150
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
250ms non-preemptible critical section violated 4 ms preempt threshold 
starting at schedule+0x57/0x480 and ending at schedule+0x237/0x480
 [<c03873f7>] schedule+0x237/0x480
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c03873f7>] schedule+0x237/0x480
 [<c0126261>] worker_thread+0x1d1/0x240
 [<c01262b2>] worker_thread+0x222/0x240
 [<c0114d78>] activate_task+0x68/0x80
 [<c02677b0>] batch_entropy_process+0x0/0x130
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c03873f7>] schedule+0x237/0x480
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c0126090>] worker_thread+0x0/0x240
 [<c01298c4>] kthread+0x94/0xa0
 [<c0129830>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18
228ms non-preemptible critical section violated 4 ms preempt threshold 
starting at schedule+0x57/0x480 and ending at schedule+0x237/0x480
 [<c03873f7>] schedule+0x237/0x480
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c03873f7>] schedule+0x237/0x480
 [<c0126261>] worker_thread+0x1d1/0x240
 [<c01262b2>] worker_thread+0x222/0x240
 [<c0114d78>] activate_task+0x68/0x80
 [<c02d0740>] fb_flashcursor+0x0/0x80
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c03873f7>] schedule+0x237/0x480
 [<c01153e0>] default_wake_function+0x0/0x10
 [<c0126090>] worker_thread+0x0/0x240
 [<c01298c4>] kthread+0x94/0xa0
 [<c0129830>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18
36ms non-preemptible critical section violated 4 ms preempt threshold starting 
at schedule+0x57/0x480 and ending at chrdev_open+0x105/0x210
 [<c0150695>] chrdev_open+0x105/0x210
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c0150695>] chrdev_open+0x105/0x210
 [<c0147254>] dentry_open+0x134/0x210
 [<c014711c>] filp_open+0x4c/0x50
 [<c01162f0>] dec_preempt_count+0x50/0x120
 [<c01162f0>] dec_preempt_count+0x50/0x120
 [<c0147396>] get_unused_fd+0x66/0xd0
 [<c014752d>] sys_open+0x4d/0x80
 [<c0103ee1>] sysenter_past_esp+0x52/0x71
6ms non-preemptible critical section violated 4 ms preempt threshold starting 
at ksoftirqd+0x59/0xc0 and ending at ksoftirqd+0x63/0xc0
 [<c011c653>] ksoftirqd+0x63/0xc0
 [<c01163b0>] dec_preempt_count+0x110/0x120
 [<c011c5f0>] ksoftirqd+0x0/0xc0
 [<c011c653>] ksoftirqd+0x63/0xc0
 [<c01298c4>] kthread+0x94/0xa0
 [<c0129830>] kthread+0x0/0xa0
 [<c010227d>] kernel_thread_helper+0x5/0x18
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86, might be 
trying access hardware directly.


-- 
Gabriel Devenyi
devenyga@mcmaster.ca
