Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUHJFrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUHJFrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 01:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267439AbUHJFrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 01:47:48 -0400
Received: from mail2.uklinux.net ([80.84.72.32]:16030 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S267438AbUHJFrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 01:47:46 -0400
Date: Mon, 9 Aug 2004 13:14:54 +0100
To: linux-kernel@vger.kernel.org
Subject: Oops while idle: 2.6.7
Message-ID: <20040809121454.GA1024@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Got ths oops today whils the box was idle. Needed Sysrq reboot.
Have been having a few freezes with nothing in the logs. Maybe this has
been the cause.

Kernel 2.6.7
AMD K6
TX MB

Let me know if you need any more info.

Thanks.

Mark



Aug  9 11:56:17 titan kernel: PREEMPT 
Aug  9 11:56:17 titan kernel: Modules linked in: snd_pcm_oss snd_mixer_oss nfs ipv6 af_packet nfsd exportfs lockd sunrpc snd_als100 snd_opl3_lib snd_hwdep snd_sb16_dsp snd_sb_common snd_pcm snd_page_alloc snd_timer snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c59x dummy ipt_REJECT ipt_LOG ipt_limit ipt_MASQUERADE ipt_owner ipt_REDIRECT iptable_nat ipt_state iptable_filter ip_conntrack ip_tables 8250_pnp 8250 serial_core
Aug  9 11:56:17 titan kernel: CPU:    0
Aug  9 11:56:17 titan kernel: EIP:    0060:[ext3_do_update_inode+212/940]    Not tainted
Aug  9 11:56:17 titan kernel: EFLAGS: 00010293   (2.6.7) 
Aug  9 11:56:17 titan kernel: EIP is at ext3_do_update_inode+0xd4/0x3ac
Aug  9 11:56:17 titan kernel: eax: c10a3c40   ebx: c0047d8c   ecx: c3ebef80   edx: c117ca94
Aug  9 11:56:17 titan kernel: esi: c117ca00   edi: c117ca94   ebp: 00000000   esp: c0047d40
Aug  9 11:56:17 titan kernel: ds: 007b   es: 007b   ss: 0068
Aug  9 11:56:17 titan kernel: Process sh (pid: 4392, threadinfo=c0046000 task=c1ebe740)
Aug  9 11:56:17 titan kernel: Stack: c0047d8c c117ca94 c0ac6294 c3fe2e00 c3ebef80 c117ca00 c3eeef2c c017c39e 
Aug  9 11:56:17 titan kernel:        c0ac6294 c117ca94 c0047d8c c0047d8c c017c469 c0ac6294 c117ca94 c0047d8c 
Aug  9 11:56:17 titan kernel:        c0ac6294 00000000 c117ca94 c3eeef2c 00000380 0000000c c017c4c7 c0ac6294 
Aug  9 11:56:17 titan kernel: Call Trace:
Aug  9 11:56:17 titan kernel:  [ext3_mark_iloc_dirty+26/40] ext3_mark_iloc_dirty+0x1a/0x28
Aug  9 11:56:17 titan kernel:  [ext3_mark_inode_dirty+41/52] ext3_mark_inode_dirty+0x29/0x34
Aug  9 11:56:17 titan kernel:  [ext3_dirty_inode+83/104] ext3_dirty_inode+0x53/0x68
Aug  9 11:56:17 titan kernel:  [__mark_inode_dirty+43/360] __mark_inode_dirty+0x2b/0x168
Aug  9 11:56:17 titan kernel:  [update_atime+107/196] update_atime+0x6b/0xc4
Aug  9 11:56:17 titan kernel:  [update_atime+136/196] update_atime+0x88/0xc4
Aug  9 11:56:17 titan kernel:  [do_generic_mapping_read+889/904] do_generic_mapping_read+0x379/0x388
Aug  9 11:56:17 titan kernel:  [__generic_file_aio_read+465/500] __generic_file_aio_read+0x1d1/0x1f4
Aug  9 11:56:17 titan kernel:  [file_read_actor+0/212] file_read_actor+0x0/0xd4
Aug  9 11:56:17 titan kernel:  [generic_file_aio_read+69/80] generic_file_aio_read+0x45/0x50
Aug  9 11:56:17 titan kernel:  [do_sync_read+129/180] do_sync_read+0x81/0xb4
Aug  9 11:56:17 titan kernel:  [permission+55/68] permission+0x37/0x44
Aug  9 11:56:17 titan kernel:  [open_namei+678/960] open_namei+0x2a6/0x3c0
Aug  9 11:56:17 titan kernel:  [dentry_open+296/500] dentry_open+0x128/0x1f4
Aug  9 11:56:17 titan kernel:  [filp_open+74/84] filp_open+0x4a/0x54
Aug  9 11:56:17 titan kernel:  [vfs_read+160/208] vfs_read+0xa0/0xd0
Aug  9 11:56:17 titan kernel:  [sys_read+49/76] sys_read+0x31/0x4c
Aug  9 11:56:17 titan kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug  9 11:56:17 titan kernel: 
Aug  9 11:56:17 titan kernel: Code: 8b 54 24 24 66 8b 42 28 8b 4c 24 10 66 89 41 02 8b 74 24 24 

