Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269742AbUJMQMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269742AbUJMQMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269744AbUJMQMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:12:38 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21387 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S269742AbUJMQMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:12:32 -0400
Message-ID: <416D0007.1000108@comcast.net>
Date: Wed, 13 Oct 2004 10:14:31 +0000
From: "D. Stimits" <stimits@comcast.net>
Reply-To: stimits@comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS 2.6.8 SMP
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a crash OOPS that was non-fatal, and resulted in respawn of X. 
440 BX chipset, dual cpu. I am not on this list if possible someone 
might be able to CC me. This kernel has all debug information compiled in.

D. Stimits, stimits AT comcast DOT net

Oct 13 09:44:14 localhost kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000134
Oct 13 09:44:14 localhost kernel:  printing eip:
Oct 13 09:44:14 localhost kernel: c01066db
Oct 13 09:44:14 localhost kernel: *pde = 00000000
Oct 13 09:44:14 localhost kernel: Oops: 0000 [#1]
Oct 13 09:44:14 localhost kernel: SMP DEBUG_PAGEALLOC
Oct 13 09:44:14 localhost kernel: Modules linked in: snd_pcm_oss snd_pcm 
snd_page_alloc snd_timer snd_mixer_oss snd soundcore md5 ipv6 parport_pc 
lp parport sunrpc tulip crc32 e100 mii ipt_REJECT ipt_LOG iptable_filter 
ip_tables sg microcode dm_mod uhci_hcd ext3 jbd aic7xxx
Oct 13 09:44:14 localhost kernel: CPU:    0
Oct 13 09:44:14 localhost kernel: EIP:    0060:[<c01066db>]    Not tainted
Oct 13 09:44:14 localhost kernel: EFLAGS: 00013206   (2.6.8-2smp-dbg)
Oct 13 09:44:14 localhost kernel: EIP is at setup_sigcontext+0x1b/0x130
Oct 13 09:44:14 localhost kernel: eax: bffff048   ebx: bffff040   ecx: 
00000114   edx: 00000000
Oct 13 09:44:14 localhost kernel: esi: 00000000   edi: bffff048   ebp: 
c6e2fed0   esp: c6e2fec0
Oct 13 09:44:14 localhost kernel: ds: 007b   es: 007b   ss: 0068
Oct 13 09:44:15 localhost kernel: Process X (pid: 2988, 
threadinfo=c6e2e000 task=c6f4c8c0)
Oct 13 09:44:15 localhost kernel: Stack: bffff0a0 bffff040 c6e2ffc4 
c6ed8b88 c6e2fef0 c01068c6 00000000 c6f4cdf4
Oct 13 09:44:15 localhost gdm[2979]: gdm_slave_xioerror_handler: Fatal X 
error - Restarting :0
Oct 13 09:44:15 localhost kernel:        0000000e c6ed8b88 c6e2ffc4 
c6e2ff24 c6e2ff14 c0106dab c6e2ffc4 0000000e
Oct 13 09:44:15 localhost gdm(pam_unix)[2979]: session closed for user 
stimits
Oct 13 09:44:15 localhost kernel:        00000000 00400000 c6e2ffc4 
c6f4cdf4 c6e2e000 c6e2ffb0 c0106e73 c6e2ffc4
Oct 13 09:44:15 localhost kernel: Call Trace:
Oct 13 09:44:15 localhost kernel:  [<c01085b5>] show_stack+0x75/0x90
Oct 13 09:44:15 localhost kernel:  [<c0108713>] show_registers+0x123/0x180
Oct 13 09:44:15 localhost kernel:  [<c0108895>] die+0x95/0x140
Oct 13 09:44:15 localhost kernel:  [<c0117f63>] do_page_fault+0x283/0x58c
Oct 13 09:44:15 localhost kernel:  [<c010821d>] error_code+0x2d/0x40
Oct 13 09:44:15 localhost kernel:  [<c01068c6>] setup_frame+0xd6/0x1d0
Oct 13 09:44:15 localhost kernel:  [<c0106dab>] handle_signal+0x15b/0x1a0
Oct 13 09:44:15 localhost kernel:  [<c0106e73>] do_signal+0x83/0x100
Oct 13 09:44:15 localhost kernel:  [<c0106f2d>] do_notify_resume+0x3d/0x3f
Oct 13 09:44:15 localhost kernel:  [<c010715e>] work_notifysig+0x13/0x15
Oct 13 09:44:15 localhost kernel: Code: 8b 51 20 09 c6 31 c0 89 57 08 8b 
51 1c 09 c6 31 c0 89 57 0c
