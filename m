Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265375AbTLRWx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbTLRWx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:53:28 -0500
Received: from dyn-81-166-56-168.ppp.tiscali.fr ([81.166.56.168]:58116 "EHLO
	nsbm.kicks-ass.org") by vger.kernel.org with ESMTP id S265375AbTLRWxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:53:21 -0500
Date: Thu, 18 Dec 2003 23:52:43 +0100
From: Witukind <witukind@nsbm.kicks-ass.org>
To: linux-kernel@vger.kernel.org
Subject: Oops when trying to mount a CIFS filesystem with 2.6.0.
Message-Id: <20031218235243.77907bb8.witukind@nsbm.kicks-ass.org>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to get CIFS working and I found two of those in my syslog file:

--- begin oops ---

Unable to handle kernel NULL pointer dereference at virtual address 00000021
printing eip:
c0181b94
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0181b94>]    Not tainted
EFLAGS: 00010206
EIP is at unload_nls+0x4/0x30
eax: 00000009   ebx: c2fc05a0   ecx: 00000000   edx: ffffffea
esi: 00000000   edi: ffffffea   ebp: c36e1000   esp: c153feb8
ds: 007b   es: 007b   ss: 0068
Process mount (pid: 11723, threadinfo=c153e000 task=c2438700)
Stack: c4842077 00000009 c1d66400 00000000 c36e1000 c36e1000 c48423c6 c1d66400
       c3cff000 c36e1000 00000000 fffffff4 c3ff47e0 c4867680 c0146413 c4867680
       00000000 c36e1000 c3cff000 c1673000 c153ff54 c1673004 00000000 c0158628
Call Trace:
  [<c4842077>] cifs_read_super+0x77/0x130 [cifs]
  [<c48423c6>] cifs_get_sb+0x56/0xb0 [cifs]
  [<c0146413>] do_kern_mount+0x43/0xd0
  [<c0158628>] do_add_mount+0x58/0x130
  [<c015891c>] do_mount+0x13c/0x190
  [<c0158772>] copy_mount_options+0x72/0xe0
  [<c0158c5a>] sys_mount+0x8a/0xc0
  [<c0108d87>] syscall_call+0x7/0xb
Code: 8b 40 18 85 c0 74 0b ff 88 a0 00 00 00 83 38 02 74 01 c3 8b

--- end oops ---

If more info is needed I'll be glad to provide it just tell me what is needed.
Anyone got any luck getting CIFS to work?

-- 
Jabber: heimdal@jabber.org
