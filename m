Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265998AbTBYCcD>; Mon, 24 Feb 2003 21:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266020AbTBYCcD>; Mon, 24 Feb 2003 21:32:03 -0500
Received: from services.cam.org ([198.73.180.252]:51211 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S265998AbTBYCcB>;
	Mon, 24 Feb 2003 21:32:01 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [OOPS] uart_block_til_ready 2.5.63
Date: Mon, 24 Feb 2003 21:42:25 -0500
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200302242142.26124.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this in my log a couple of hours after booting .63

Feb 24 21:14:44 oscar kernel:  printing eip:
Feb 24 21:14:44 oscar kernel: c01aed4a
Feb 24 21:14:44 oscar kernel: Oops: 0000
Feb 24 21:14:44 oscar kernel: CPU:    0
Feb 24 21:14:44 oscar kernel: EIP:    0060:[uart_block_til_ready+362/428]    Not tainted
Feb 24 21:14:44 oscar kernel: EFLAGS: 00010246
Feb 24 21:14:44 oscar kernel: EIP is at uart_block_til_ready+0x16a/0x1ac
Feb 24 21:14:44 oscar kernel: eax: 00000000   ebx: da504000   ecx: dfd54818   edx: dfd4e3c0
Feb 24 21:14:44 oscar kernel: esi: da505e68   edi: 00000202   ebp: da505e7c   esp: da505e40
Feb 24 21:14:44 oscar kernel: ds: 007b   es: 007b   ss: 0068
Feb 24 21:14:44 oscar kernel: Process bkupsd (pid: 956, threadinfo=da504000 task=da72a700)
Feb 24 21:14:44 oscar kernel: Stack: c02d4100 00000001 00000000 c032f234 dfd54818 00000000 da72a700 c0113718
Feb 24 21:14:44 oscar kernel:        00000000 00000000 00000000 da72a700 c0113718 dfd4e410 dfd4e410 da505eb8
Feb 24 21:14:44 oscar kernel:        c01af0a4 da747320 dfd4e3c0 00000000 00000100 00000000 00000001 dfd4e3c0
Feb 24 21:14:44 oscar kernel: Call Trace:
Feb 24 21:14:44 oscar kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
Feb 24 21:14:44 oscar kernel:  [default_wake_function+0/24] default_wake_function+0x0/0x18
Feb 24 21:14:44 oscar kernel:  [uart_open+544/664] uart_open+0x220/0x298
Feb 24 21:14:44 oscar kernel:  [tty_open+479/908] tty_open+0x1df/0x38c
Feb 24 21:14:44 oscar kernel:  [tty_open+525/908] tty_open+0x20d/0x38c
Feb 24 21:14:44 oscar kernel:  [link_path_walk+1626/2008] link_path_walk+0x65a/0x7d8
Feb 24 21:14:44 oscar kernel:  [get_chrfops+216/488] get_chrfops+0xd8/0x1e8
Feb 24 21:14:44 oscar kernel:  [chrdev_open+94/156] chrdev_open+0x5e/0x9c
Feb 24 21:14:44 oscar kernel:  [dentry_open+252/480] dentry_open+0xfc/0x1e0
Feb 24 21:14:44 oscar kernel:  [filp_open+64/72] filp_open+0x40/0x48
Feb 24 21:14:44 oscar kernel:  [sys_open+52/112] sys_open+0x34/0x70
Feb 24 21:14:44 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 24 21:14:44 oscar kernel:
Feb 24 21:14:44 oscar kernel: Code: f6 80 1c 01 00 00 02 75 2d 8b 4d 08 51 e8 10 6e 00 00 85 c0
Feb 24 21:15:26 oscar kernel:  <6>

Ideas?
Ed Tomlinson
