Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVAQKjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVAQKjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVAQKjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:39:55 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:58948 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262764AbVAQKjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:39:49 -0500
Date: Mon, 17 Jan 2005 11:39:28 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
cc: linux-atm-general@lists.sourceforge.net,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Kernel 2.6.10 Oops fore200e
Message-ID: <Pine.LNX.4.61L.0501171130330.8248@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (portraits.wsisiz.edu.pl [0.0.0.0]); Mon, 17 Jan 2005 11:39:42 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Lately we have problem with our router. For me it's look like driver 
fore200e problems. We know that's not a hardware problem.
Below is fragment from logs file. Unfortunately I don't know 
how to use ksymoops with 2.6.X kernels :/
System is Fedora Core 2, 2 x Pentium 3.00GHz, 1 GB RAM, 0,5 GB swap

[root@cosmos root]# atmarp -V
0.78


Jan  9 16:36:23 cosmos kernel: scheduling while atomic: swapper/0x00000200/0

ksymoops 2.4.11 on i686 2.6.10.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.6.10/ (default)
      -m /lib/modules/2.6.10/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan  9 16:36:23 cosmos kernel:  [<c02dffd8>] schedule+0x4d8/0x4e0
Jan  9 16:36:23 cosmos kernel:  [<c01173f4>] update_process_times+0x44/0x50
Jan  9 16:36:23 cosmos kernel:  [<e0855816>] fore200e_send+0x156/0x680 [fore_200e]
Jan  9 16:36:23 cosmos kernel:  [<c02dec0a>] clip_start_xmit+0x19a/0x220
Jan  9 16:36:23 cosmos kernel:  [<c024da05>] qdisc_restart+0x65/0x160
Jan  9 16:36:23 cosmos kernel:  [<c0241e7f>] dev_queue_xmit+0x18f/0x220
Jan  9 16:36:23 cosmos kernel:  [<c025eded>] ip_finish_output2+0xcd/0x1a0
Jan  9 16:36:23 cosmos kernel:  [<c025ed20>] ip_finish_output2+0x0/0x1a0
Jan  9 16:36:23 cosmos kernel:  [<c024cae9>] nf_hook_slow+0xf9/0x160
Jan  9 16:36:23 cosmos kernel:  [<c025ed20>] ip_finish_output2+0x0/0x1a0
Jan  9 16:36:23 cosmos kernel:  [<c025b240>] ip_forward_finish+0x0/0x50
Jan  9 16:36:23 cosmos kernel:  [<c025c7eb>] ip_finish_output+0x4b/0x50
Jan  9 16:36:23 cosmos kernel:  [<c025ed20>] ip_finish_output2+0x0/0x1a0
Jan  9 16:36:23 cosmos kernel:  [<c025b262>] ip_forward_finish+0x22/0x50
Jan  9 16:36:23 cosmos kernel:  [<c024cae9>] nf_hook_slow+0xf9/0x160
Jan  9 16:36:23 cosmos kernel:  [<c025b240>] ip_forward_finish+0x0/0x50
Jan  9 16:36:23 cosmos kernel:  [<c025b146>] ip_forward+0x176/0x270
Jan  9 16:36:23 cosmos kernel:  [<c025b240>] ip_forward_finish+0x0/0x50
Jan  9 16:36:24 cosmos kernel:  [<c025a109>] ip_rcv_finish+0x1e9/0x260
Jan  9 16:36:24 cosmos kernel:  [<c0259f20>] ip_rcv_finish+0x0/0x260
Jan  9 16:36:24 cosmos kernel:  [<c024cae9>] nf_hook_slow+0xf9/0x160
Jan  9 16:36:24 cosmos kernel:  [<c0259f20>] ip_rcv_finish+0x0/0x260
Jan  9 16:36:24 cosmos kernel:  [<c0259c9f>] ip_rcv+0x16f/0x220
Jan  9 16:36:24 cosmos kernel:  [<c0259f20>] ip_rcv_finish+0x0/0x260
Jan  9 16:36:24 cosmos kernel:  [<c02423c7>] netif_receive_skb+0x1b7/0x220
Jan  9 16:36:24 cosmos kernel:  [<c02424af>] process_backlog+0x7f/0x100
Jan  9 16:36:24 cosmos kernel:  [<c02425a4>] net_rx_action+0x74/0x100
Jan  9 16:36:24 cosmos kernel:  [<c01138ab>] __do_softirq+0x7b/0x90
Jan  9 16:36:24 cosmos kernel:  [<c01138e7>] do_softirq+0x27/0x30
Jan  9 16:36:24 cosmos kernel:  [<c0103d5e>] do_IRQ+0x1e/0x30
Jan  9 16:36:24 cosmos kernel:  [<c0102442>] common_interrupt+0x1a/0x20
Jan  9 16:36:24 cosmos kernel:  [<c0100463>] default_idle+0x23/0x30
Jan  9 16:36:24 cosmos kernel:  [<c01004e4>] cpu_idle+0x34/0x40
Jan  9 16:36:24 cosmos kernel:  [<c036496b>] start_kernel+0x13b/0x160
Jan  9 16:36:24 cosmos kernel:  [<c0364530>] unknown_bootoption+0x0/0x1e0
Jan  9 16:36:24 cosmos kernel:  [<c02dffd8>] schedule+0x4d8/0x4e0
Jan  9 16:36:24 cosmos kernel:  [<c010bdc2>] activate_task+0x62/0x80
Jan  9 16:36:24 cosmos kernel:  [<e0855816>] fore200e_send+0x156/0x680 [fore_200e]
Jan  9 16:36:25 cosmos kernel:  [<c02dec0a>] clip_start_xmit+0x19a/0x220
Jan  9 16:36:25 cosmos kernel:  [<c024da05>] qdisc_restart+0x65/0x160
Jan  9 16:36:25 cosmos kernel:  [<c0241e7f>] dev_queue_xmit+0x18f/0x220
Jan  9 16:36:25 cosmos kernel:  [<c025eded>] ip_finish_output2+0xcd/0x1a0
Jan  9 16:36:25 cosmos kernel:  [<c025ed20>] ip_finish_output2+0x0/0x1a0
Jan  9 16:36:25 cosmos kernel:  [<c024cae9>] nf_hook_slow+0xf9/0x160
Jan  9 16:36:25 cosmos kernel:  [<c025ed20>] ip_finish_output2+0x0/0x1a0
Jan  9 16:36:25 cosmos kernel:  [<c025b240>] ip_forward_finish+0x0/0x50
Jan  9 16:36:25 cosmos kernel:  [<c025c7eb>] ip_finish_output+0x4b/0x50
Jan  9 16:36:25 cosmos kernel:  [<c025ed20>] ip_finish_output2+0x0/0x1a0
Jan  9 16:36:25 cosmos kernel:  [<c025b262>] ip_forward_finish+0x22/0x50
Jan  9 16:36:25 cosmos kernel:  [<c024cae9>] nf_hook_slow+0xf9/0x160
Jan  9 16:36:25 cosmos kernel:  [<c025b240>] ip_forward_finish+0x0/0x50
Jan  9 16:36:25 cosmos kernel:  [<c025b146>] ip_forward+0x176/0x270
Jan  9 16:36:25 cosmos kernel:  [<c025b240>] ip_forward_finish+0x0/0x50
Jan  9 16:36:25 cosmos kernel:  [<c025a109>] ip_rcv_finish+0x1e9/0x260
Jan  9 16:36:25 cosmos kernel:  [<c0259f20>] ip_rcv_finish+0x0/0x260
Jan  9 16:36:25 cosmos kernel:  [<c024cae9>] nf_hook_slow+0xf9/0x160
Jan  9 16:36:25 cosmos kernel:  [<c0259f20>] ip_rcv_finish+0x0/0x260
Jan  9 16:36:26 cosmos kernel:  [<c0259c9f>] ip_rcv+0x16f/0x220
Jan  9 16:36:26 cosmos kernel:  [<c0259f20>] ip_rcv_finish+0x0/0x260
Jan  9 16:36:26 cosmos kernel:  [<c02423c7>] netif_receive_skb+0x1b7/0x220
Jan  9 16:36:26 cosmos kernel:  [<c02424af>] process_backlog+0x7f/0x100
Jan  9 16:36:26 cosmos kernel:  [<c02425a4>] net_rx_action+0x74/0x100
Jan  9 16:36:26 cosmos kernel:  [<c01138ab>] __do_softirq+0x7b/0x90
Jan  9 16:36:26 cosmos kernel:  [<c01138e7>] do_softirq+0x27/0x30
Jan  9 16:36:26 cosmos kernel:  [<c0103d5e>] do_IRQ+0x1e/0x30
Jan  9 16:36:26 cosmos kernel:  [<c0102442>] common_interrupt+0x1a/0x20
Jan  9 16:36:26 cosmos kernel:  [<c0100463>] default_idle+0x23/0x30
Jan  9 16:36:26 cosmos kernel:  [<c01004e4>] cpu_idle+0x34/0x40
Jan  9 16:36:26 cosmos kernel:  [<c036496b>] start_kernel+0x13b/0x160
Jan  9 16:36:26 cosmos kernel:  [<c0364530>] unknown_bootoption+0x0/0x1e0

1 error issued.  Results may not be reliable.


Aby idea

-- 
£T
