Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTEQVyt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTEQVyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 17:54:49 -0400
Received: from smtp.terra.es ([213.4.129.129]:62613 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S261858AbTEQVyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 17:54:45 -0400
Date: Sun, 18 May 2003 00:06:44 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm6
Message-Id: <20030518000644.74e8e3e8.diegocg@teleline.es>
In-Reply-To: <20030516015407.2768b570.akpm@digeo.com>
References: <20030516015407.2768b570.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__18_May_2003_00:06:44_+0200_08e56930"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sun__18_May_2003_00:06:44_+0200_08e56930
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 May 2003 01:54:07 -0700
Andrew Morton <akpm@digeo.com> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm6/


I had this oops don't know how it happened (not reproduceable):

May 17 23:11:22 estel kernel: Unable to handle kernel paging request at virtual address c1bb103c
May 17 23:11:22 estel kernel:  printing eip:
May 17 23:11:22 estel kernel: c02bcbb0
May 17 23:11:22 estel kernel: *pde = 00007067
May 17 23:11:22 estel kernel: *pte = 01bb1000
May 17 23:11:22 estel kernel: Oops: 0000 [#1]
May 17 23:11:22 estel kernel: CPU:    0
May 17 23:11:22 estel kernel: EIP:    0060:[tcp_v4_rcv+528/2464]    Not tainted VLI
May 17 23:11:22 estel kernel: EFLAGS: 00010286
May 17 23:11:22 estel kernel: EIP is at tcp_v4_rcv+0x210/0x9a0
May 17 23:11:22 estel kernel: eax: 00010000   ebx: c1bb0ed4   ecx: cfd00000   edx: cfd055c0
May 17 23:11:22 estel kernel: esi: ad272450   edi: c5659b14   ebp: cff67d88   esp: cff67d40
May 17 23:11:22 estel kernel: ds: 007b   es: 007b   ss: 0068
May 17 23:11:22 estel kernel: Process events/0 (pid: 6, threadinfo=cff66000 task=cff6d2f0)
May 17 23:11:22 estel kernel: Stack: c5659b14 00000001 00000020 c065d8d0 00000000 00000000 cff67dd8 80000000
May 17 23:11:22 estel kernel:        c03bb488 805a3612 00000004 0000805a deda99c1 cd5c0044 c065d8d0 c033eba0
May 17 23:11:22 estel kernel:        00000000 c5659b14 cff67dac c029e215 c5659b14 cd5c0044 00000000 c029e140
May 17 23:11:22 estel kernel: Call Trace:
May 17 23:11:22 estel kernel:  [ip_local_deliver_finish+213/512] ip_local_deliver_finish+0xd5/0x200
May 17 23:11:22 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 17 23:11:22 estel kernel:  [nf_hook_slow+237/320] nf_hook_slow+0xed/0x140
May 17 23:11:22 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 17 23:11:22 estel kernel:  [ip_local_deliver+600/640] ip_local_deliver+0x258/0x280
May 17 23:11:22 estel kernel:  [ip_local_deliver_finish+0/512] ip_local_deliver_finish+0x0/0x200
May 17 23:11:22 estel kernel:  [ip_rcv+1005/1344] ip_rcv+0x3ed/0x540
May 17 23:11:22 estel kernel:  [netif_receive_skb+386/528] netif_receive_skb+0x182/0x210
May 17 23:11:22 estel kernel:  [process_backlog+143/320] process_backlog+0x8f/0x140
May 17 23:11:22 estel kernel:  [net_rx_action+149/352] net_rx_action+0x95/0x160
May 17 23:11:22 estel kernel:  [do_softirq+216/224] do_softirq+0xd8/0xe0
May 17 23:11:22 estel kernel:  [local_bh_enable+101/160] local_bh_enable+0x65/0xa0
May 17 23:11:22 estel kernel:  [_end+273436850/1069795888] ppp_asynctty_receive+0x92/0x110 [ppp_async]
May 17 23:11:22 estel kernel:  [flush_to_ldisc+235/384] flush_to_ldisc+0xeb/0x180
May 17 23:11:22 estel kernel:  [console_callback+160/192] console_callback+0xa0/0xc0
May 17 23:11:22 estel kernel:  [worker_thread+566/992] worker_thread+0x236/0x3e0
May 17 23:11:22 estel kernel:  [flush_to_ldisc+0/384] flush_to_ldisc+0x0/0x180
May 17 23:11:22 estel kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 17 23:11:22 estel kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
May 17 23:11:22 estel kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
May 17 23:11:22 estel kernel:  [worker_thread+0/992] worker_thread+0x0/0x3e0
May 17 23:11:22 estel kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
May 17 23:11:22 estel kernel:
May 17 23:11:22 estel kernel: Code: 00 0f 84 74 07 00 00 8b 5b 08 85 db 75 ed a1 2c 68 36 c0 c1 e0 04 8b 5c 02 08 85 db 74 20 8d b6 00 00 00 00 8d bc 27 00 00 00 00 <39> b3 68 01 00 00 0f 84 0a 07 00 00 8b 5b 08 85 db 75 ed f0 ff
May 17 23:11:22 estel kernel:  <0>Kernel panic: Fatal exception in interrupt
May 17 23:11:22 estel kernel: In interrupt handler - not syncing


Machine (dual p3) was connected to internet via a typical external 56k modem.

.config.gz attached





(also when i start my ppp link, which loads one of those modules:
ppp_async              10368  1 [unsafe]
ppp_generic            28176  5 ppp_deflate,bsd_comp,ppp_async
slhc                    5888  1 ppp_generic
bsd_comp                5120  0
ppp_deflate             4608  0 
zlib_deflate           21912  1 ppp_deflate
zlib_inflate           21280  1 ppp_deflate
i see lots of times;
May 17 19:57:23 estel kernel: Unable to handle kernel paging request at virtual address c03390e8
May 17 19:57:23 estel kernel:  printing eip:
May 17 19:57:23 estel kernel: c01109d9
May 17 19:57:23 estel kernel: *pde = 00102027
May 17 19:57:23 estel kernel: *pte = 00339000
May 17 19:57:23 estel kernel: Oops: 0000 [#1]
May 17 19:57:23 estel kernel: CPU:    1
May 17 19:57:23 estel kernel: EIP:    0060:[apply_alternatives+201/272]    Not tainted VLI
May 17 19:57:23 estel kernel: EFLAGS: 00010202
May 17 19:57:23 estel kernel: EIP is at apply_alternatives+0xc9/0x110
May 17 19:57:23 estel kernel: eax: 00000001   ebx: d0870a20   ecx: 00000000   edx: 00000001
May 17 19:57:23 estel kernel: esi: c03390e8   edi: d086a94b   ebp: cda1deec   esp: cda1ded8
May 17 19:57:23 estel kernel: ds: 007b   es: 007b   ss: 0068
May 17 19:57:23 estel kernel: Process modprobe (pid: 387, threadinfo=cda1c000 task=cefbaca0)
May 17 19:57:23 estel kernel: Stack: c02f7fc0 00000003 d0883738 0000008f d088346d cda1df0c c011a4b6 d0870a20
May 17 19:57:23 estel kernel:        d0870aaf d08833ba d087c000 d0872980 00000460 cda1df94 c013cabb d087c000
May 17 19:57:23 estel kernel:        d08834b8 d0872980 00000016 d0872980 00000000 00000000 00000000 00000488
May 17 19:57:23 estel kernel: Call Trace:
May 17 19:57:23 estel kernel:  [module_finalize+150/160] module_finalize+0x96/0xa0
May 17 19:57:23 estel kernel:  [load_module+1515/2160] load_module+0x5eb/0x870
May 17 19:57:23 estel kernel:  [sys_init_module+134/784] sys_init_module+0x86/0x310
May 17 19:57:23 estel kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 17 19:57:23 estel kernel:
May 17 19:57:23 estel kernel: Code: 00 00 8b 0b 83 fa 09 b8 08 00 00 00 0f 4c c2 8b 7d f0 01 cf 8b 4d ec 8b 34 81 89 c1 c1 e9 02  f3 a5 a8 02 74 02 66 a5 a8 01 74 01 <a4> 01 45 f0 29 c2 85 d2 7f cd 83 c3 0c 3b 5d 0c 0f 82 71 ff ff


and internet doesn't works; also i'm unable to load any module after this)


--Multipart_Sun__18_May_2003_00:06:44_+0200_08e56930
Content-Type: application/octet-stream;
 name=".config.gz"
Content-Disposition: attachment;
 filename=".config.gz"
Content-Transfer-Encoding: base64

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
uYr+nf8Deb8MiSNbAAA=

--Multipart_Sun__18_May_2003_00:06:44_+0200_08e56930--
