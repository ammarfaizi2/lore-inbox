Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265761AbUFVWB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265761AbUFVWB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUFVWAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:00:08 -0400
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:18910 "EHLO
	mail.asahi-net.or.jp") by vger.kernel.org with ESMTP
	id S266016AbUFVV5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:57:52 -0400
Message-ID: <40D8AB57.5040206@ThinRope.net>
Date: Wed, 23 Jun 2004 06:57:43 +0900
From: Kalin KOZHUHAROV <kalin@ThinRope.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: bg, en, ja, ru, de
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.7 and rfcomm Oops (BlueTooth)
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just managed to start using my phone for ppp via BlueTooth with 2.6.7 (stock + kmsgdump patch).

Sometimes I get the foolowing Oops though:

Bluetooth: RFCOMM ver 1.3
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: rfcomm l2cap hci_usb bluetooth usbhid 3c59x nvidia ehci_hcd ohci_hcd usbcore ipv6
CPU:    0
EIP:    0060:[<00000000>]    Tainted: P  
EFLAGS: 00210202   (2.6.7-KK1_sata) 
EIP is at 0x0
eax: 00000000   ebx: d5500000   ecx: e0c7f5c0   edx: 00000000
esi: da66cf58   edi: c0000000   ebp: 00000000   esp: d5501eb4
ds: 007b   es: 007b   ss: 0068
Process rfcomm (pid: 9368, threadinfo=d5500000 task=dd5f6830)
Stack: e0c7654e da66cf58 00000000 d5500000 e0c7f5c0 e0c76617 da66cf58 00000000 
       da66c3d8 d210b000 cfdac7e0 e0c7ade7 da66cf58 00000000 d210b000 00000000 
       c0259dcb d210b000 cfdac7e0 00000000 00200286 00000000 026524f0 026524f0 
Call Trace:
 [<e0c7654e>] __rfcomm_dlc_close+0x4e/0xd0 [rfcomm]
 [<e0c76617>] rfcomm_dlc_close+0x47/0x70 [rfcomm]
 [<e0c7ade7>] rfcomm_tty_close+0x67/0xb0 [rfcomm]
 [<c0259dcb>] release_dev+0x60b/0x620
 [<c016552f>] do_pollfd+0x4f/0x90
 [<c01655da>] do_poll+0x6a/0xd0
 [<c025a140>] tty_release+0x0/0x60
 [<c025a16a>] tty_release+0x2a/0x60
 [<c0152d64>] __fput+0x114/0x130
 [<c0151429>] filp_close+0x59/0x90
 [<c01514c1>] sys_close+0x61/0xa0
 [<c0106087>] syscall_call+0x7/0xb

Code:  Bad EIP value.
 <6>note: rfcomm[9368] exited with preempt_count 2

-- 
||///_ o  *****************************
||//'_/>     WWW: http://ThinRope.net/
