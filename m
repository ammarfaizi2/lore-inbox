Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263650AbTJOQ7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 12:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263654AbTJOQ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 12:59:00 -0400
Received: from mail-2.tiscali.it ([195.130.225.148]:32951 "EHLO
	mail-2.tiscali.it") by vger.kernel.org with ESMTP id S263650AbTJOQ6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 12:58:52 -0400
From: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Organization: -ENOENT
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.6.0-test7-bk7 CONFIG_PREEMPT=y
Date: Wed, 15 Oct 2003 18:58:34 +0000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310151858.34475.l.allegrucci@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could not reproduce on a plain 2.6.0-test7-bk7
(CONFIG_PREEMPT=n)


Oct 15 18:46:57 odyssey kernel: ------------[ cut here ]------------
Oct 15 18:46:57 odyssey kernel: kernel BUG at kernel/exit.c:758!
Oct 15 18:46:57 odyssey kernel: invalid operand: 0000 [#1]
Oct 15 18:46:57 odyssey kernel: CPU:    0
Oct 15 18:46:57 odyssey kernel: EIP:    0060:[do_exit+529/1040]    Not tainted
Oct 15 18:46:57 odyssey kernel: EFLAGS: 00010286
Oct 15 18:46:57 odyssey kernel: EIP is at do_exit+0x211/0x410
Oct 15 18:46:57 odyssey kernel: eax: 00000004   ebx: dffeeaa0   ecx: db4d32a0   edx: da99c000
Oct 15 18:46:57 odyssey kernel: esi: 00000000   edi: db006cc0   ebp: da99ded0   esp: da99deb4
Oct 15 18:46:57 odyssey kernel: ds: 007b   es: 007b   ss: 0068
Oct 15 18:46:57 odyssey kernel: Process bomb.sh (pid: 9670, threadinfo=da99c000 task=db006cc0)
Oct 15 18:46:57 odyssey kernel: Stack: db006cc0 dc9cefc0 da99df24 db007284 da99c000 00000009 00000009 da99dee4
Oct 15 18:46:57 odyssey kernel:        c011ee0a 00000009 da99c000 db006cc0 da99df0c c0127be1 00000009 db007284
Oct 15 18:46:57 odyssey kernel:        da99df24 da99c000 db007284 da99dfc4 db007284 da99c000 da99dfb0 c0109196
Oct 15 18:46:57 odyssey kernel: Call Trace:
Oct 15 18:46:57 odyssey kernel:  [do_group_exit+58/176] do_group_exit+0x3a/0xb0
Oct 15 18:46:57 odyssey kernel:  [get_signal_to_deliver+593/864] get_signal_to_deliver+0x251/0x360
Oct 15 18:46:57 odyssey kernel:  [do_signal+102/224] do_signal+0x66/0xe0
Oct 15 18:46:57 odyssey kernel:  [exit_notify+553/1920] exit_notify+0x229/0x780
Oct 15 18:46:57 odyssey kernel:  [do_exit+529/1040] do_exit+0x211/0x410
Oct 15 18:46:57 odyssey kernel:  [sys_sigreturn+184/208] sys_sigreturn+0xb8/0xd0
Oct 15 18:46:57 odyssey kernel:  [do_notify_resume+59/64] do_notify_resume+0x3b/0x40
Oct 15 18:46:57 odyssey kernel:  [work_notifysig+19/21] work_notifysig+0x13/0x15
Oct 15 18:46:57 odyssey kernel:
Oct 15 18:46:57 odyssey kernel: Code: 0f 0b f6 02 3d 9d 34 c0 8d b4 26 00 00 00 00 eb fe 8b 77 10
Oct 15 18:46:57 odyssey kernel:  <6>note: bomb.sh[9670] exited with preempt_count 1

