Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWDBJPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWDBJPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDBJPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:15:50 -0400
Received: from ns2.74mail.ru ([212.57.187.242]:51939 "EHLO ns2.74mail.ru")
	by vger.kernel.org with ESMTP id S932302AbWDBJPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:15:48 -0400
X-AuthUser: roman@74mail.ru
Date: Sun, 2 Apr 2006 13:15:28 +0400
From: Roman Veretelnikov <roman@74mail.ru>
X-Mailer: The Bat! (v3.60.07) Professional
Reply-To: Roman Veretelnikov <roman@74mail.ru>
X-Priority: 3 (Normal)
Message-ID: <1589518899.20060402131528@74mail.ru>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.16.1 oops
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Server hung in few minutes after reboot.

I have the server with FC3 that hangs from time to time. Yesterday
I decided to reinstall kernel from 2.6.12-2.3.legacy_FC3smp to the
latest 2.6.16.1. It booted fine, but after few minutes I saw messages
from syslog at console. I had time to exec mc and dmesg. After that
console hung. I could ping it but tcp connections did not work;

OOPS:
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c015cfde
*pde = 2e380001
Oops: 0002 [#1]
SMP
Modules linked in: autofs4 ipt_LOG ipt_owner xt_state iptable_filter ipt_REDIRECT xt_tcpudp iptable_nat ip_nat ip_conntrack ip_tables x_tables dm_mod video button battery ac hw_random i2c_i801 i2c_core e1000 floppy ext3 jbd i2o_block i2o_core sd_mod scsi_mod
CPU:    1
EIP:    0060:[<c015cfde>]    Not tainted VLI
EFLAGS: 00010086   (2.6.16.1 #4)
EIP is at free_block+0x43/0xbf
eax: 00000000   ebx: f7db3000   ecx: f7db3290   edx: f7bbe000
esi: f7e19640   edi: f7f676c0   ebp: 00000000   esp: f7e3dee0
ds: 007b   es: 007b   ss: 0068
Process events/1 (pid: 11, threadinfo=f7e3c000 task=f7f45ab0)
Stack: <0>00000000 00000004 f7e1ba14 f7e1ba14 f7e1ba00 00000004 00000000 c015d7bf
       00000000 f7f676c0 f7e19640 c361d224 f7f676c0 f7f67788 c015d869 00000000
       00000000 f7e1966c 00000003 c361d220 c361d224 f7e116c0 00000000 c012f444
Call Trace:
 [<c015d7bf>] drain_array_locked+0x56/0x8c
 [<c015d869>] cache_reap+0x74/0x190
 [<c012f444>] run_workqueue+0x71/0xe5
 [<c015d7f5>] cache_reap+0x0/0x190
 [<c012f5d5>] worker_thread+0x11d/0x138
 [<c011c38e>] default_wake_function+0x0/0xc
 [<c011c38e>] default_wake_function+0x0/0xc
 [<c012f4b8>] worker_thread+0x0/0x138
 [<c01323b0>] kthread+0x8a/0xb2
 [<c0132326>] kthread+0x0/0xb2
 [<c0101db5>] kernel_thread_helper+0x5/0xb
Code: 44 24 08 8b 0c a8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 03 05 10 52 41 c0 8b 58 1c 8b 44 24 20 8b b4 87 90 00 00 00 8b 53 04 8b 03 <89> 50 04 89 02 c7 43 04 00 02 20 00 c7 03 00 01 10 00 89 da 8b

Disassembled call trace, cpuinfo, full dmesg, lspci and ver_linux in
the attachments.

-- 
 Roman                          mailto:roman@74mail.ru

