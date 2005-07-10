Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVGJOF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVGJOF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 10:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVGJOF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 10:05:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:8610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261942AbVGJOF4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 10:05:56 -0400
X-Authenticated: #19095397
From: Bernd Schubert <bernd-schubert@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11.12: oops + panic
Date: Sun, 10 Jul 2005 16:05:53 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507101605.53205.bernd-schubert@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

below is an oops that happend on one of our servers last week. This oops was 
still logged by syslog, but its seems this oops immediately followed another 
oops which made the kernel to panick. The last oops could not logged anymore 
by the syslogd and unfortunately capturing using a serial cable was also 
disabled. But I guess the second oops is only the result of the first oops, 
so anyone knows were it comes from or how to further debug it? 

Thanks,
	Bernd

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c013f958
*pde = 00000000
Oops: 0002 [#1]
SMP
Modules linked in: quota_v2 drbd parport_pc lp parport ohci_hcd usbcore 
i2c_amd756 i2c_amd8111
dm_mod w83627hf eeprom lm85 i2c_sensor i2c_isa i2c_core sk98lin tg3 aic79xx
CPU:	0
EIP:	0060:[free_block+72/208]    Not tainted VLI
EFLAGS: 00010016   (2.6.11.12)
EIP is at free_block+0x48/0xd0
eax: 00000000	ebx: f027cd80	ecx: cc5be600	edx: 00580a78
esi: c2b93ac0	edi: 00000000	ebp: c2b93ae8	esp: c2991edc
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 6, threadinfo=c2990000 task=c2962a60)
Stack: c0407b60 c011440a c2b93af8 c2a0abd0 c2a0abc0 00000002 c2b93ac0 c014010a
       c2b93ac0 c2a0abd0 00000002 c2b93a38 c2b93ac0 00000005 c2b93a60 c01401d4
       c2b93ac0 c2a0abc0 00000000 c2b93a38 c2990000 c2b93b50 00000296 c2814ac0
Call Trace:
 [finish_task_switch+58/128] finish_task_switch+0x3a/0x80
 [drain_array_locked+122/192] drain_array_locked+0x7a/0xc0
 [cache_reap+132/496] cache_reap+0x84/0x1f0
 [worker_thread+441/592] worker_thread+0x1b9/0x250
 [cache_reap+0/496] cache_reap+0x0/0x1f0
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [worker_thread+0/592] worker_thread+0x0/0x250
 [kthread+183/192] kthread+0xb7/0xc0
 [kthread+0/192] kthread+0x0/0xc0
 [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Code: 46 38 8d 6e 28 89 44 24 08 8b 44 24 24 8b 15 50 ea 4e c0 8b 0c b8 8d 81 
00 00 00 40 c1 e8
 0c c1 e0 05 8b 5c 02 1c 8b 53 04 8b 03 <89> 50 04 89 02 c7 43 04 00 02 20 00 
2b 4b 0c c7 03 00 01 10 00


-- 
Bernd Schubert
PCI / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
