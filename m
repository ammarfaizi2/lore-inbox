Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbTC3P7s>; Sun, 30 Mar 2003 10:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbTC3P7s>; Sun, 30 Mar 2003 10:59:48 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:260
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261407AbTC3P7p>; Sun, 30 Mar 2003 10:59:45 -0500
Message-ID: <000b01c2f6d6$f843eab0$030aa8c0@unknown>
From: "Shawn Starr" <spstarr@sh0n.net>
To: "Shawn Starr" <spstarr@sh0n.net>, "Andrew Morton" <akpm@digeo.com>
Cc: <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings - New OOPS w/ timer
Date: Sun, 30 Mar 2003 11:10:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function found was: delayed_work_timer_fn (kernel/workqueue.c)

free of pending timer at c7411150
function=c0138ba0
Call Trace:
 [<c014d4b4>] timer_hunt+0x84/0x90
 [<c0138ba0>] delayed_work_timer_fn+0x0/0x170
 [<c014fb08>] kfree+0x1c8/0x320
 [<c024f8a6>] release_dev+0x696/0x840
 [<c024f8a6>] release_dev+0x696/0x840
 [<c01566eb>] zap_pmd_range+0x4b/0x70
 [<c015675b>] unmap_page_range+0x4b/0x80
 [<c0250054>] tty_release+0x94/0x1b0
 [<c016db2c>] __fput+0xac/0x100
 [<c024ffc0>] tty_release+0x0/0x1b0
 [<c016db7b>] __fput+0xfb/0x100
 [<c016ba6c>] filp_close+0x15c/0x230
 [<c0125ebc>] put_files_struct+0x6c/0xe0
 [<c0127300>] do_exit+0x400/0xaa0
 [<c0255487>] read_chan+0x327/0x1010
 [<c0127bdb>] do_group_exit+0x1cb/0x210
 [<c01303e5>] dequeue_signal+0x35/0xa0
 [<c013319e>] get_signal_to_deliver+0x40e/0x920
 [<c010a08d>] do_signal+0xdd/0x110
 [<c024e22d>] tty_read+0x24d/0x2d0
 [<c0256170>] write_chan+0x0/0x240
 [<c016c641>] vfs_read+0xe1/0x1c0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c010a119>] do_notify_resume+0x59/0x5c
 [<c010a2f6>] work_notifysig+0x13/0x15

---- oops --
Unable to handle kernel paging request at virtual address 6b6b6b6f
 printing eip:
c012e9c7
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c012e9c7>]    Not tainted
EFLAGS: 00010002
EIP is at run_timer_softirq+0xe7/0x410
eax: c7411150   ebx: c7411154   ecx: 6b6b6b6b   edx: 6b6b6b6b
esi: 6b6b6b6b   edi: 6b6b6b6b   ebp: c7630000   esp: c7631c68
ds: 007b   es: 007b   ss: 0068
Process agetty (pid: 488, threadinfo=c7630000 task=c7626cc0)
Stack: 00000046 c010ac18 00000002 00000002 00000000 c04c9c40 fffffffd
c7630000
       00000040 0000007b 00000001 c04c9c48 fffffffd 00000046 c012964a
c04c9c48
       c7630000 c7630000 00000000 c04185e0 c010cd75 00000000 c7631cf0
c04185e0
Call Trace:
 [<c010ac18>] common_interrupt+0x18/0x20
 [<c012964a>] do_softirq+0x9a/0xa0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c010ac18>] common_interrupt+0x18/0x20
 [<c014007b>] sys_timer_delete+0xdb/0x210
 [<c014fb2c>] kfree+0x1ec/0x320
 [<c024f8a6>] release_dev+0x696/0x840
 [<c024f8a6>] release_dev+0x696/0x840
 [<c01566eb>] zap_pmd_range+0x4b/0x70
 [<c015675b>] unmap_page_range+0x4b/0x80
 [<c0250054>] tty_release+0x94/0x1b0
 [<c016db2c>] __fput+0xac/0x100
 [<c024ffc0>] tty_release+0x0/0x1b0
 [<c016db7b>] __fput+0xfb/0x100
 [<c016ba6c>] filp_close+0x15c/0x230
 [<c0125ebc>] put_files_struct+0x6c/0xe0
 [<c0127300>] do_exit+0x400/0xaa0
 [<c0255487>] read_chan+0x327/0x1010
 [<c0127bdb>] do_group_exit+0x1cb/0x210
 [<c01303e5>] dequeue_signal+0x35/0xa0
 [<c013319e>] get_signal_to_deliver+0x40e/0x920
 [<c010a08d>] do_signal+0xdd/0x110
 [<c024e22d>] tty_read+0x24d/0x2d0
 [<c0256170>] write_chan+0x0/0x240
 [<c016c641>] vfs_read+0xe1/0x1c0
 [<c010cd75>] do_IRQ+0x235/0x370
 [<c010a119>] do_notify_resume+0x59/0x5c
 [<c010a2f6>] work_notifysig+0x13/0x15

Code: 89 4a 04 89 11 c7 40 30 00 00 00 00 81 3d a0 9a 41 c0 3c 4b
 <0>Kernel panic: Aiee, killing interrupt handler!
kernel/timer.c:258: spin_lock(kernel/timer.c:c0419aa0) already locked by
kernel/timer.c/398
In interrupt handler - not syncing

ksymoops dump:

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 4a 04                  mov    %ecx,0x4(%edx)
Code;  00000003 Before first symbol
   3:   89 11                     mov    %edx,(%ecx)
Code;  00000005 Before first symbol
   5:   c7 40 30 00 00 00 00      movl   $0x0,0x30(%eax)
Code;  0000000c Before first symbol
   c:   81 3d a0 9a 41 c0 3c      cmpl   $0x4b3c,0xc0419aa0
Code;  00000013 Before first symbol
  13:   4b 00 00


