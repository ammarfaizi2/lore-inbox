Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264101AbTEWRKx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbTEWRKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:10:53 -0400
Received: from smtp.terra.es ([213.4.129.129]:54148 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S264101AbTEWRKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:10:47 -0400
Date: Fri, 23 May 2003 19:23:42 +0200
From: Arador <grundig@teleline.es>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm8
Message-Id: <20030523192342.40214eba.grundig@teleline.es>
In-Reply-To: <20030522021652.6601ed2b.akpm@digeo.com>
References: <20030522021652.6601ed2b.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__23_May_2003_19:23:42_+0200_0832ca50"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__23_May_2003_19:23:42_+0200_0832ca50
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2003 02:16:52 -0700
Andrew Morton <akpm@digeo.com> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm8/

I still have some oopses (still compiling with gcc 3.3 btw)

It seems to happen randomly, always under X (not tested without it)
X dies after some seconds and i've to reboot (luckly the oops get
saved in the logs) using sysrq + B

May 23 18:10:48 estel kernel: Unable to handle kernel paging request at virtual address cc85c104
May 23 18:10:48 estel kernel:  printing eip:
May 23 18:10:48 estel kernel: c02beaf0
May 23 18:10:48 estel kernel: *pde = 00033067
May 23 18:10:48 estel kernel: *pte = 0c85c000
May 23 18:10:48 estel kernel: Oops: 0000 [#1]
May 23 18:10:48 estel kernel: CPU:    1
May 23 18:10:48 estel kernel: EIP:    0060:[tcp_v4_rcv+528/2464]    Not tainted VLI
May 23 18:10:48 estel kernel: EFLAGS: 00010286
May 23 18:10:48 estel kernel: EIP is at tcp_v4_rcv+0x210/0x9a0
May 23 18:10:48 estel kernel: eax: 00010000   ebx: cc85bf9c   ecx: cfde0000   edx: cfde7490
May 23 18:10:48 estel kernel: esi: 66f71950   edi: c833d364   ebp: cff4bd88   esp: cff4bd40
May 23 18:10:48 estel kernel: ds: 007b   es: 007b   ss: 0068
May 23 18:10:48 estel kernel: Process events/1 (pid: 7, threadinfo=cff4a000 task=cff4ecc0)
May 23 18:10:48 estel kernel: Stack: c833d364 00000001 00000020 cf9e408c 00000000 00000000 cff4bdd8 80000000 
May 23 18:10:48 estel kernel:        c03bd7a8 804d3612 00000004 0000804d 587899c1 c1672264 cf9e408c c0341520 
May 23 18:10:48 estel kernel:        00000000 c833d364 cff4bdac c02a0135 c833d364 c1672264 00000000 c02a0060 
May 23 18:10:48 estel kernel: Call Trace:
May 23 18:10:48 estel kernel:  [ip_local_deliver_finish+213/512] ip_local_deliver_finish+0xd5/0x200
May 23 18:10:48 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 23 18:10:48 estel kernel:  [nf_hook_slow+237/320] nf_hook_slow+0xed/0x140
May 23 18:10:48 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 23 18:10:48 estel kernel:  [ip_local_deliver+600/640] ip_local_deliver+0x258/0x280
May 23 18:10:48 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 23 18:10:48 estel kernel:  [ip_rcv+1005/1344] ip_rcv+0x3ed/0x540
May 23 18:10:48 estel kernel:  [netif_receive_skb+386/528] netif_receive_skb+0x182/0x210
May 23 18:10:48 estel kernel:  [process_backlog+143/304] process_backlog+0x8f/0x130
May 23 18:10:48 estel kernel:  [net_rx_action+165/352] net_rx_action+0xa5/0x160
May 23 18:10:48 estel kernel:  [do_softirq+216/224] do_softirq+0xd8/0xe0
May 23 18:10:48 estel kernel:  [local_bh_enable+101/160] local_bh_enable+0x65/0xa0
May 23 18:10:48 estel kernel:  [_end+340974994/1069786896] ppp_asynctty_receive+0x92/0x110 [ppp_async]
May 23 18:10:48 estel kernel:  [flush_to_ldisc+235/384] flush_to_ldisc+0xeb/0x180
May 23 18:10:48 estel kernel:  [console_callback+160/192] console_callback+0xa0/0xc0
May 23 18:10:48 estel kernel:  [worker_thread+566/992] worker_thread+0x236/0x3e0
May 23 18:10:48 estel kernel:  [flush_to_ldisc+0/384] flush_to_ldisc+0x0/0x180
May 23 18:10:48 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:10:48 estel kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 23 18:10:48 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:10:48 estel kernel:  [worker_thread+0/992] worker_thread+0x0/0x3e0
May 23 18:10:48 estel kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
May 23 18:10:48 estel kernel: 
May 23 18:10:48 estel kernel: Code: 00 0f 84 74 07 00 00 8b 5b 08 85 db 75 ed a1 0c 99 36 c0 c1 e0 04 8b 5c 02 08 85 db 74 20 8d 
b6 00 00 00 00 8d bc 27 00 00 00 00 <39> b3 68 01 00 00 0f 84 0a 07 00 00 8b 5b 08 85 db 75 ed f0 ff 
May 23 18:10:48 estel kernel:  <0>Kernel panic: Fatal exception in interrupt
May 23 18:10:48 estel kernel: In interrupt handler - not syncing



and another one; it seems to happen a few times  (2, 3, 4)
in a day.


Machine is SMP P3 2x800, connected through a ppp link
with a external serial modem. gzipped .config attached.

It never happened with 2.5.69 (no bk) or before.

May 23 18:34:02 estel kernel: Unable to handle kernel paging request at virtual address ca6c403c
May 23 18:34:02 estel kernel:  printing eip:
May 23 18:34:02 estel kernel: c02beaf0
May 23 18:34:02 estel kernel: *pde = 0002a067
May 23 18:34:02 estel kernel: *pte = 0a6c4000
May 23 18:34:02 estel kernel: Oops: 0000 [#1]
May 23 18:34:02 estel kernel: CPU:    0
May 23 18:34:02 estel kernel: EIP:    0060:[tcp_v4_rcv+528/2464]    Not tainted VLI
May 23 18:34:02 estel kernel: EFLAGS: 00010286
May 23 18:34:02 estel kernel: EIP is at tcp_v4_rcv+0x210/0x9a0
May 23 18:34:02 estel kernel: eax: 00010000   ebx: ca6c3ed4   ecx: cfde0000   edx: cfde2000
May 23 18:34:02 estel kernel: esi: 8ec52450   edi: cfe0c084   ebp: cff4dd88   esp: cff4dd40
May 23 18:34:02 estel kernel: ds: 007b   es: 007b   ss: 0068
May 23 18:34:02 estel kernel: Process events/0 (pid: 6, threadinfo=cff4c000 task=cff4f2f0)
May 23 18:34:02 estel kernel: Stack: cfe0c084 00000001 00000014 cfbdd2e4 00000000 00000000 cff4ddd8 80000000 
May 23 18:34:02 estel kernel:        c03bd7a8 1236140e 00000004 00001236 52e563d5 cf256e68 cfbdd2e4 c0341520 
May 23 18:34:02 estel kernel:        00000000 cfe0c084 cff4ddac c02a0135 cfe0c084 cf256e68 00000000 c02a0060 
May 23 18:34:02 estel kernel: Call Trace:
May 23 18:34:02 estel kernel:  [ip_local_deliver_finish+213/512] ip_local_deliver_finish+0xd5/0x200
May 23 18:34:02 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 23 18:34:02 estel kernel:  [nf_hook_slow+237/320] nf_hook_slow+0xed/0x140
May 23 18:34:02 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 23 18:34:02 estel kernel:  [ip_local_deliver+600/640] ip_local_deliver+0x258/0x280
May 23 18:34:02 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 23 18:34:02 estel kernel:  [ip_rcv+1005/1344] ip_rcv+0x3ed/0x540
May 23 18:34:02 estel kernel:  [netif_receive_skb+386/528] netif_receive_skb+0x182/0x210
May 23 18:34:02 estel kernel:  [process_backlog+143/304] process_backlog+0x8f/0x130
May 23 18:34:02 estel kernel:  [net_rx_action+165/352] net_rx_action+0xa5/0x160
May 23 18:34:02 estel kernel:  [do_softirq+216/224] do_softirq+0xd8/0xe0
May 23 18:34:02 estel kernel:  [local_bh_enable+101/160] local_bh_enable+0x65/0xa0
May 23 18:34:02 estel kernel:  [_end+340618642/1069786896] ppp_asynctty_receive+0x92/0x110 [ppp_async]
May 23 18:34:02 estel kernel:  [flush_to_ldisc+235/384] flush_to_ldisc+0xeb/0x180
May 23 18:34:02 estel kernel:  [worker_thread+566/992] worker_thread+0x236/0x3e0
May 23 18:34:02 estel kernel:  [flush_to_ldisc+0/384] flush_to_ldisc+0x0/0x180
May 23 18:34:02 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:34:02 estel kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 23 18:34:02 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:34:02 estel kernel:  [worker_thread+0/992] worker_thread+0x0/0x3e0
May 23 18:34:02 estel kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
May 23 18:34:02 estel kernel: 
May 23 18:34:02 estel kernel: Code: 00 0f 84 74 07 00 00 8b 5b 08 85 db 75 ed a1 0c 99 36 c0 c1 e0 04 8b 5c 02 08 85 db 74 20 8d 
b6 00 00 00 00 8d bc 27 00 00 00 00 <39> b3 68 01 00 00 0f 84 0a 07 00 00 8b 5b 08 85 db 75 ed f0 ff 
May 23 18:34:02 estel kernel:  <0>Kernel panic: Fatal exception in interrupt
May 23 18:34:02 estel kernel: In interrupt handler - not syncing
May 23 18:34:18 estel kernel:  Badness in local_bh_enable at kernel/softirq.c:108
May 23 18:34:18 estel kernel: Call Trace:
May 23 18:34:18 estel kernel:  [local_bh_enable+144/160] local_bh_enable+0x90/0xa0
May 23 18:34:18 estel kernel:  [_end+340620805/1069786896] ppp_async_push+0xf5/0x250 [ppp_async]
May 23 18:34:18 estel kernel:  [_end+340618814/1069786896] ppp_asynctty_wakeup+0x2e/0x60 [ppp_async]
May 23 18:34:18 estel kernel:  [uart_flush_buffer+170/240] uart_flush_buffer+0xaa/0xf0
May 23 18:34:18 estel kernel:  [do_tty_hangup+1313/1472] do_tty_hangup+0x521/0x5c0
May 23 18:34:18 estel kernel:  [worker_thread+566/992] worker_thread+0x236/0x3e0
May 23 18:34:18 estel kernel:  [do_tty_hangup+0/1472] do_tty_hangup+0x0/0x5c0
May 23 18:34:18 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:34:18 estel kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 23 18:34:18 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:34:18 estel kernel:  [worker_thread+0/992] worker_thread+0x0/0x3e0
May 23 18:34:18 estel kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
May 23 18:34:18 estel kernel: 
May 23 18:34:18 estel kernel: Badness in local_bh_enable at kernel/softirq.c:108
May 23 18:34:18 estel kernel: Call Trace:
May 23 18:34:18 estel kernel:  [local_bh_enable+144/160] local_bh_enable+0x90/0xa0
May 23 18:34:18 estel kernel:  [_end+340620805/1069786896] ppp_async_push+0xf5/0x250 [ppp_async]
May 23 18:34:18 estel kernel:  [uart_flush_buffer+170/240] uart_flush_buffer+0xaa/0xf0
May 23 18:34:18 estel kernel:  [_end+340618814/1069786896] ppp_asynctty_wakeup+0x2e/0x60 [ppp_async]
May 23 18:34:18 estel kernel:  [do_tty_hangup+1299/1472] do_tty_hangup+0x513/0x5c0
May 23 18:34:18 estel kernel:  [worker_thread+566/992] worker_thread+0x236/0x3e0
May 23 18:34:18 estel kernel:  [do_tty_hangup+0/1472] do_tty_hangup+0x0/0x5c0
May 23 18:34:18 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:34:18 estel kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 23 18:34:18 estel kernel:  [default_wake_function+0/48] default_wake_function+0x0/0x30
May 23 18:34:18 estel kernel:  [worker_thread+0/992] worker_thread+0x0/0x3e0
May 23 18:34:18 estel kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
May 23 18:34:18 estel kernel: 



I can't check if it has been repoted in bugzilla as bugme.osdl.org shows
Software error:

Bugzilla is currently broken. Please try again later. If the problem persists [...]

But that's another problem :)



-- 

--Multipart_Fri__23_May_2003_19:23:42_+0200_0832ca50
Content-Type: application/octet-stream;
 name=".config.gz"
Content-Disposition: attachment;
 filename=".config.gz"
Content-Transfer-Encoding: base64

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
/we6vBcoBFsAAA==

--Multipart_Fri__23_May_2003_19:23:42_+0200_0832ca50--
