Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUBXS42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbUBXS42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:56:28 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:56258 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262400AbUBXS4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:56:19 -0500
Date: Tue, 24 Feb 2004 18:55:10 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: fritz@isdn4linux.de
Subject: 2.6.3-bk5 isdn oops
Message-ID: <20040224185510.GN11203@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, fritz@isdn4linux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More modprobe/rmmod fun..  (no card present).

		Dave

ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/1.1.2.2/1.1.2.2 loaded
ICN-ISDN-driver Rev 1.65.6.8 mem=0x000d0000
icn: (line0) ICN-2B, port 0x320 added
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43in_atomic():0, irqs_disabled():1
Call Trace:
 [<c0123214>] __might_sleep+0x80/0x8a
 [<c011df07>] do_page_fault+0x71/0x46c
 [<c7b0ffd7>] isdn_status_callback+0x8e0/0x968 [isdn]
 [<c0121447>] schedule+0x5a6/0x631
 [<c01213c8>] schedule+0x527/0x631
 [<c011de96>] do_page_fault+0x0/0x46c
 [<c010c165>] error_code+0x2d/0x38
 [<c79aba66>] icn_exit+0xb4/0x155 [icn]
 [<c01214d2>] default_wake_function+0x0/0xc
 [<c0138926>] kthread_stop+0x83/0xa0
 [<c013ab6f>] try_stop_module+0x94/0x9c
 [<c013ad14>] sys_delete_module+0x11b/0x13d
 [<c015063c>] unmap_vma_list+0xe/0x17
 [<c0150aea>] do_munmap+0x17e/0x18a
 [<c010b663>] syscall_call+0x7/0xb
 
Unable to handle kernel paging request at virtual address 0000297c
 printing eip:
c79aba66
*pde = 00000000
Oops: 0000 [#1]
SMP
CPU:    0
EIP:    0060:[<c79aba66>]    Not tainted
EFLAGS: 00010046
EIP is at icn_exit+0xb4/0x155 [icn]
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000001
esi: 00000000   edi: 00000292   ebp: c0320298   esp: c2323ee4
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 1327, threadinfo=c2322000 task=c4ae87d0)
Stack: c111acc0 c2323f20 00000000 0000010a c01214d2 00100100 00200200 00000000
       00000007 00000286 00000000 00000246 c21e1270 c032010c c2323f58 c79ad900
       c0138926 c21e1270 c2323f44 c013ab6f c2323f6c c79ad900 00000880 c2323f6c
Call Trace:
 [<c01214d2>] default_wake_function+0x0/0xc
 [<c0138926>] kthread_stop+0x83/0xa0
 [<c013ab6f>] try_stop_module+0x94/0x9c
 [<c013ad14>] sys_delete_module+0x11b/0x13d
 [<c015063c>] unmap_vma_list+0xe/0x17
 [<c0150aea>] do_munmap+0x17e/0x18a
 [<c010b663>] syscall_call+0x7/0xb
 
Code: 81 bb 7c 29 00 00 ad 4e ad de 74 08 0f 0b 5d 00 b3 bb 9a c7
  

