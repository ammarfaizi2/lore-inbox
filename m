Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbTIKTD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 15:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIKTD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 15:03:27 -0400
Received: from mail-4.tiscali.it ([195.130.225.150]:44517 "EHLO
	mail-4.tiscali.it") by vger.kernel.org with ESMTP id S261465AbTIKTDZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 15:03:25 -0400
From: Lorenzo Allegrucci <l.allegrucci@tiscali.it>
Organization: -ENOENT
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.6.0-test5 with CONFIG_PREEMPT
Date: Thu, 11 Sep 2003 21:07:39 +0000
User-Agent: KMail/1.5.1
Cc: Andrew Morton <akpm@osdl.org>, Robert Love <rml@tech9.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309112107.39062.l.allegrucci@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This time captured by "console=lp0" :)

------------[ cut here ]------------
kernel BUG at kernel/exit.c:731!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c011e1ce>]    Not tainted
EFLAGS: 00010296
EIP is at do_exit+0x20e/0x400
eax: 00000000   ebx: dffeeaa0   ecx: dc865940   edx: dcb5e000
esi: 00000000   edi: dd7026d0   ebp: dcb5fed0   esp: dcb5feb4
ds: 007b   es: 007b   ss: 0068
Process bomb.sh (pid: 11259, threadinfo=dcb5e000 task=dd7026d0)
Stack: dd7026d0 dcb44580 dcb5ff24 dd702c84 dcb5e000 00000009 00000009 dcb5fee4
       c011e46a 00000009 dcb5e000 dd7026d0 dcb5ff0c c0127124 00000009 dd702c84
       dcb5ff24 dcb5e000 dd702c84 dcb5ffc4 dd702c84 dcb5e000 dcb5ffb0 c0109156
Call Trace:
 [<c011e46a>] do_group_exit+0x3a/0xb0
 [<c0127124>] get_signal_to_deliver+0x244/0x350
 [<c0109156>] do_signal0+0x66/0xe0
 [<c010920b>] do_notify_resume+0x3b/0x40
 [<c01093ea>] work_notifysig+0x13/0x15

Code: 0f 0b 02 4c 4f 32 c0 eb fe 8b 77 10 85 f6 75 ea 89 3c 24
 <6>note: bomb.sh[11259] exited with preempt_count 1


It's not that easy to trigger, but it's 100% reproducible.

