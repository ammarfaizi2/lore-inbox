Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUJBNid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUJBNid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 09:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUJBNid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 09:38:33 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:24478 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S266128AbUJBNib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 09:38:31 -0400
From: Gavrila <gavrilao@spymac.com>
To: linux-kernel@vger.kernel.org
Subject: 2.8.6.1-CK kernel bug
Date: Sat, 2 Oct 2004 15:38:37 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410021538.37892.gavrilao@spymac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I was working on my desktop, computer hang and logged what reported 
below. Compiled with gcc 3.4.2 feel free to ask anything, since I don't 
really know how I should provide help :)

Regards

Oct  2 15:24:22 Kreuzberg ------------[ cut here ]------------
Oct  2 15:24:22 Kreuzberg kernel BUG at kernel/exit.c:845!
Oct  2 15:24:22 Kreuzberg invalid operand: 0000 [#1]
Oct  2 15:24:22 Kreuzberg PREEMPT
Oct  2 15:24:22 Kreuzberg Modules linked in: 8139cp snd_ymfpci snd_ac97_codec 
snd_opl3_lib snd_hwdep snd_mpu401_uart snd_rawmidi sis_agp a
gpgart sd_mod ide_cd cdrom nvidia pwc videodev
Oct  2 15:24:22 Kreuzberg CPU:    0
Oct  2 15:24:22 Kreuzberg EIP:    0060:[<c011cee4>]    Tainted: P
Oct  2 15:24:22 Kreuzberg EFLAGS: 00010282   (2.6.8.1-ck8)
Oct  2 15:24:22 Kreuzberg EIP is at do_exit+0x284/0x3f0
Oct  2 15:24:22 Kreuzberg eax: 00000004   ebx: dffee720   ecx: 00000001   edx: 
cb376000
Oct  2 15:24:22 Kreuzberg esi: d4483940   edi: c535d150   ebp: 00000002   esp: 
cb377ebc
Oct  2 15:24:22 Kreuzberg ds: 007b   es: 007b   ss: 0068
Oct  2 15:24:22 Kreuzberg Process as (pid: 25149, threadinfo=cb376000 
task=c535d150)
Oct  2 15:24:22 Kreuzberg Stack: c0123305 00000000 cb377f28 cb376000 dc9f84a0 
00000002 cb376000 cb376000
Oct  2 15:24:22 Kreuzberg c011d0ef 00000002 c535d150 00000009 c0124da7 
c535d150 cb376000 cb376000
Oct  2 15:24:22 Kreuzberg cb376000 cb376000 c535d684 cb377fc4 cb377f28 
cb377fc4 c535d684 cb376000
Oct  2 15:24:22 Kreuzberg Call Trace:
Oct  2 15:24:22 Kreuzberg [<c0123305>] __dequeue_signal+0xe5/0x150
Oct  2 15:24:22 Kreuzberg [<c011d0ef>] do_group_exit+0x2f/0xa0
Oct  2 15:24:22 Kreuzberg [<c0124da7>] get_signal_to_deliver+0x267/0x3c0
Oct  2 15:24:22 Kreuzberg [<c0105646>] do_signal+0x86/0x150
Oct  2 15:24:22 Kreuzberg [<c015c250>] pipe_read+0x20/0x30
Oct  2 15:24:22 Kreuzberg [<c0150134>] vfs_read+0xe4/0x120
Oct  2 15:24:22 Kreuzberg [<c01503b1>] sys_read+0x41/0x70
Oct  2 15:24:22 Kreuzberg [<c0105747>] do_notify_resume+0x37/0x3c
Oct  2 15:24:22 Kreuzberg [<c0105926>] work_notifysig+0x13/0x15
Oct  2 15:24:22 Kreuzberg Code: 0f 0b 4d 03 72 18 37 c0 eb fe b8 01 00 00 00 
e8 e8 09 11 00
Oct  2 15:24:22 Kreuzberg <6>note: as[25149] exited with preempt_count 1
