Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUJSVKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUJSVKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269903AbUJSVBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:01:11 -0400
Received: from pop1.oxfordnetworks.net ([66.231.220.66]:63165 "EHLO
	pop1.oxfordnetworks.net") by vger.kernel.org with ESMTP
	id S267760AbUJSUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:50:19 -0400
Message-ID: <016501c4b61d$3ae50190$6601a8c0@calcutta>
From: "Jim Greene" <jwgreene@megalink.net>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with kernel crash
Date: Tue, 19 Oct 2004 16:50:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am getting a kernel crash on 4 identical PE 2650's running RH AS 3,0 
and Kernel 2.6.8.1. Each server has  a Perc4/Dc.  Can someone tell me what 
exactly the problem is?  Thanks

Oct 19 15:17:11 pop1 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Oct 19 15:17:11 pop1 kernel:  printing eip:
Oct 19 15:17:11 pop1 kernel: c2825292
Oct 19 15:17:11 pop1 kernel: *pde = 00003001
Oct 19 15:17:11 pop1 kernel: Oops: 0002 [#1]
Oct 19 15:17:11 pop1 kernel: SMP
Oct 19 15:17:11 pop1 kernel: Modules linked in: md5 ipv6 autofs4 e1000 
microcode ext3 jbd dm_mod megaraid qla2300 qla2xxx scsi_transport_fc sd_mod 
scsi_mod
Oct 19 15:17:11 pop1 kernel: CPU:    2
Oct 19 15:17:11 pop1 kernel: EIP:    0060:[<c2825292>]    Not tainted
Oct 19 15:17:11 pop1 kernel: EFLAGS: 00010202   (2.6.8-1.524smp)
Oct 19 15:17:11 pop1 kernel: EIP is at 
journal_commit_transaction+0x60f/0x1228 [jbd]
Oct 19 15:17:11 pop1 kernel: eax: 76ad132c   ebx: 00000000   ecx: c1165780 
edx: bf1c42fc
Oct 19 15:17:11 pop1 kernel: esi: c1faac00   edi: 76ad132c   ebp: be1b8300 
esp: c10e6da0
Oct 19 15:17:11 pop1 kernel: ds: 007b   es: 007b   ss: 0068
Oct 19 15:17:11 pop1 kernel: Process kjournald (pid: 223, 
threadinfo=c10e6000 task=39ee9170)
Oct 19 15:17:11 pop1 kernel: Stack: 00000000 00000000 00000000 00000000 
00000000 00000000 3d3cc3bc 0208c50c
Oct 19 15:17:11 pop1 kernel:        000004bf 0000009c 00000000 00000001 
00000100 00000083 00008f80 0000009c
Oct 19 15:17:11 pop1 kernel:        0000009c 02405004 02404ff8 c10e6e1c 
00000003 04841060 00000000 39ee9170
Oct 19 15:17:11 pop1 kernel: Call Trace:
Oct 19 15:17:11 pop1 kernel:  [<0211f0bf>] autoremove_wake_function+0x0/0x2d
Oct 19 15:17:11 pop1 kernel:  [<0211cd90>] load_balance+0x4b/0x1f9
Oct 19 15:17:11 pop1 kernel:  [<0211f0bf>] autoremove_wake_function+0x0/0x2d
Oct 19 15:17:11 pop1 kernel:  [<0211d5c0>] scheduler_tick+0x3b9/0x3c1
Oct 19 15:17:11 pop1 kernel:  [<c2827f33>] kjournald+0x10d/0x329 [jbd]
Oct 19 15:17:11 pop1 kernel:  [<0211f0bf>] autoremove_wake_function+0x0/0x2d
Oct 19 15:17:11 pop1 kernel:  [<0211f0bf>] autoremove_wake_function+0x0/0x2d
Oct 19 15:17:11 pop1 kernel:  [<0211bfe9>] finish_task_switch+0x6c/0x8c
Oct 19 15:17:11 pop1 kernel:  [<c2827e20>] commit_timeout+0x0/0x5 [jbd]
Oct 19 15:17:11 pop1 kernel:  [<c2827e26>] kjournald+0x0/0x329 [jbd]
Oct 19 15:17:11 pop1 kernel:  [<021041f1>] kernel_thread_helper+0x5/0xb
Oct 19 15:17:11 pop1 kernel: Code: f0 ff 43 04 8b 03 a8 04 0f 84 9d 00 00 00 
81 be e8 00 00 00 


