Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267232AbUH3GXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267232AbUH3GXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUH3GXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:23:25 -0400
Received: from mail2.uklinux.net ([80.84.72.32]:1930 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S267232AbUH3GXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:23:22 -0400
Date: Mon, 30 Aug 2004 06:57:12 +0100
To: linux-kernel@vger.kernel.org
Subject: [mark@hindley.uklinux.net: Oops]
Message-ID: <20040830055712.GA19157@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Got this OOPS last evening.

 AMD k6. 430TX.

 Seemed related to htdig running after closing ppp connection.
 
 Aug 29 22:13:36 titan kernel: PREEMPT 
Aug 29 22:13:36 titan kernel: Modules linked in: ppp_async ppp_generic slhc ipt_REJECT ipt_LOG ipt_limit ipt_MASQUERADE ipt_owner ipt_REDIRECT ipt_state iptable_filter iptable_nat ip_conntrack ip_tables ipv6 nfsd exportfs lockd sunrpc snd_als100 snd_opl3_lib snd_hwdep snd_sb16_dsp snd_sb_common snd_pcm snd_page_alloc snd_timer snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 3c59x dummy hangcheck_timer 8250_pnp 8250 serial_core
Aug 29 22:13:36 titan kernel: CPU:    0
Aug 29 22:13:36 titan kernel: EIP:    0060:[start_this_handle+202/972]    Not tainted
Aug 29 22:13:36 titan kernel: EFLAGS: 00010282   (2.6.7) 
Aug 29 22:13:36 titan kernel: EIP is at start_this_handle+0xca/0x3cc
Aug 29 22:13:36 titan kernel: eax: c212a000   ebx: c359012c   ecx: 00000000   edx: c3feae00
Aug 29 22:13:36 titan kernel: esi: c3fe1e00   edi: c212a000   ebp: c105a300   esp: c212bcec
Aug 29 22:13:36 titan kernel: ds: 007b   es: 007b   ss: 0068
Aug 29 22:13:36 titan kernel: Process htmerge (pid: 18153, threadinfo=c212a000 task=c3b278b0)
Aug 29 22:13:36 titan kernel: Stack: c3722144 c3fe1e00 c212a000 c105a300 00000000 00000000 0000000a 00002755 
Aug 29 22:13:36 titan kernel:        00000000 c013298b c02a34ac 00000046 c212a000 c02a3590 00000246 c02a34ac 
Aug 29 22:13:36 titan kernel:        c212a000 00000246 00000000 c0184766 c10ff560 00000050 c0184821 c3fe1e00 
Aug 29 22:13:36 titan kernel: Call Trace:
Aug 29 22:13:36 titan kernel:  [rmqueue_bulk+67/112] rmqueue_bulk+0x43/0x70
Aug 29 22:13:36 titan kernel:  [new_handle+14/68] new_handle+0xe/0x44
Aug 29 22:13:36 titan kernel:  [journal_start+133/180] journal_start+0x85/0xb4
Aug 29 22:13:36 titan kernel:  [ext3_journal_start+50/80] ext3_journal_start+0x32/0x50
Aug 29 22:13:36 titan kernel:  [ext3_prepare_write+48/272] ext3_prepare_write+0x30/0x110
Aug 29 22:13:36 titan kernel:  [generic_file_aio_write_nolock+1709/2624] generic_file_aio_write_nolock+0x6ad/0xa40
Aug 29 22:13:37 titan kernel:  [recalc_task_prio+361/376] recalc_task_prio+0x169/0x178
Aug 29 22:13:37 titan kernel:  [generic_file_aio_write+103/124] generic_file_aio_write+0x67/0x7c
Aug 29 22:13:37 titan kernel:  [ext3_file_write+43/172] ext3_file_write+0x2b/0xac
Aug 29 22:13:37 titan kernel:  [do_sync_write+129/176] do_sync_write+0x81/0xb0
Aug 29 22:13:37 titan kernel:  [update_atime+107/196] update_atime+0x6b/0xc4
Aug 29 22:13:37 titan kernel:  [update_atime+136/196] update_atime+0x88/0xc4
Aug 29 22:13:37 titan kernel:  [pipe_readv+615/632] pipe_readv+0x267/0x278
Aug 29 22:13:37 titan kernel:  [pipe_read+41/48] pipe_read+0x29/0x30
Aug 29 22:13:37 titan kernel:  [vfs_write+160/208] vfs_write+0xa0/0xd0
Aug 29 22:13:37 titan kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Aug 29 22:13:37 titan kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Aug 29 22:13:37 titan kernel: 
Aug 29 22:13:37 titan kernel: Code: 00 00 75 26 b8 00 e0 ff ff 21 e0 ff 48 14 8b 40 08 a9 08 00 

Let me know if you need more info.

Thanks

Mark
