Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTEENL3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTEENL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:11:29 -0400
Received: from tomts7.bellnexxia.net ([209.226.175.40]:22253 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262179AbTEENLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:11:23 -0400
Subject: 2.5.68-mmX: Drowning in irq 7: nobody cared!
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052141029.2527.27.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 May 2003 09:23:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting a lot of these in the logs. This is with the ALSA emu10k1
driver for a SB live card. This is a x86, UP, KT133 system with preempt
enabled. The system seems to be running fine.

handlers:
[<d8986540>] (gcc2_compiled.+0x0/0x390 [snd_emu10k1])
irq 7: nobody cared!
Call Trace:
 [<c010c5c2>] handle_IRQ_event+0xa2/0x110
 [<c010c7c0>] do_IRQ+0xa0/0x130
 [<c010b14c>] common_interrupt+0x18/0x20
 [<c012048c>] do_softirq+0x3c/0xa0
 [<c010c826>] do_IRQ+0x106/0x130
 [<c010b14c>] common_interrupt+0x18/0x20
 [<c0108884>] default_idle+0x24/0x30
 [<c0114e55>] apm_cpu_idle+0x125/0x170
 [<c0114d30>] apm_cpu_idle+0x0/0x170
 [<c0108860>] default_idle+0x0/0x30
 [<c0108902>] cpu_idle+0x32/0x50
 [<c0105000>] _stext+0x0/0x60
 [<c02c46be>] start_kernel+0x15e/0x170

handlers:
[<d8986540>] (gcc2_compiled.+0x0/0x390 [snd_emu10k1])
irq 7: nobody cared!
Call Trace:
 [<c010c5c2>] handle_IRQ_event+0xa2/0x110
 [<c010c7c0>] do_IRQ+0xa0/0x130
 [<c010b14c>] common_interrupt+0x18/0x20
 [<c012048c>] do_softirq+0x3c/0xa0
 [<c010c826>] do_IRQ+0x106/0x130
 [<c010b14c>] common_interrupt+0x18/0x20
 [<c01203dd>] current_kernel_time+0xd/0x40
 [<c015f4d5>] inode_update_time+0x15/0x90
 [<c01fd188>] memcpy_toiovec+0x68/0xb0
 [<c0132af0>] generic_file_aio_write_nolock+0x390/0x9c0
 [<c01fb9f7>] kfree_skbmem+0x17/0x20
 [<c011b0f0>] autoremove_wake_function+0x0/0x40
 [<c01f86dc>] sock_recvmsg+0x8c/0xb0
 [<c013318f>] generic_file_write_nolock+0x6f/0x90
 [<c0119cec>] __wake_up+0x1c/0x40
 [<c0134737>] __alloc_pages+0x97/0x3a0
 [<c0134a33>] __alloc_pages+0x393/0x3a0
 [<c01f97f2>] sys_recvfrom+0xa2/0x100
 [<c01f9836>] sys_recvfrom+0xe6/0x100
 [<c0134a5a>] __get_free_pages+0x1a/0x50
 [<c0134481>] free_hot_cold_page+0x21/0xf0
 [<c0133350>] generic_file_writev+0x30/0x50
 [<c014933d>] do_readv_writev+0x1bd/0x260
 [<c0148e30>] do_sync_write+0x0/0xb0
 [<c01f9ecf>] sys_socketcall+0x15f/0x1f0
 [<c0149474>] vfs_writev+0x44/0x50
 [<c01494e8>] sys_writev+0x28/0x40
 [<c010a7df>] syscall_call+0x7/0xb

           CPU0       
  0:   45130454          XT-PIC  timer
  1:       6730          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     278881          XT-PIC  uhci-hcd, uhci-hcd
  7:     128713          XT-PIC  EMU10K1
  8:          1          XT-PIC  rtc
 10:     983196          XT-PIC  ide2, ide3, bttv0
 11:    3031816          XT-PIC  eth0
 12:         60          XT-PIC  i8042, i8042, i8042, i8042
 14:      67179          XT-PIC  ide0
 15:        520          XT-PIC  ide1
NMI:          0 
LOC:   45131802 
ERR:        182
MIS:          0

BTW: What about the 4 i8042's on irq 12. Is this normal/OK?

Regards,

Shane

