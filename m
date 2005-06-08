Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVFHPgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVFHPgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFHPgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:36:45 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3765 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261277AbVFHPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:36:18 -0400
Date: Wed, 8 Jun 2005 17:36:15 +0200
From: Jan Kara <jack@suse.cz>
To: Frank Elsner <frank@moltke28.B.Shuttle.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11:   kernel BUG at fs/jbd/checkpoint.c:247!
Message-ID: <20050608153615.GA27540@atrey.karlin.mff.cuni.cz>
References: <E1DeJTR-00026k-5j@moltke28.B.Shuttle.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DeJTR-00026k-5j@moltke28.B.Shuttle.DE>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not a kernel hacker. Maybe some of you knows what happened :-)
  Looks like a bug in the kernel :). Can you please try 2.6.12-rc5 or
newer? It should contain several fixes in this area.

						Thanks for report
								Honza

> Jun  3 04:04:54 seymour kernel: kernel BUG at fs/jbd/checkpoint.c:247!
> Jun  3 04:04:54 seymour kernel: invalid operand: 0000 [#1]
> Jun  3 04:04:54 seymour kernel: PREEMPT SMP 
> Jun  3 04:04:54 seymour kernel: Modules linked in: radeon nfsd exportfs lockd pa
> rport_pc lp parport tun autofs4 sunrpc ipt_REJECT ipt_LOG ipt_state iptable_filt
> er iptable_nat ip_conntrack ip_tables vfat fat video button battery ac uhci_hcd 
> ehci_hcd snd_emu10k1 snd_rawmidi snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pc
> m snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore natsemi sym53c8x
> x scsi_transport_spi
> Jun  3 04:04:54 seymour kernel: CPU:    1
> Jun  3 04:04:54 seymour kernel: EIP:    0060:[<c019c730>]    Not tainted VLI
> Jun  3 04:04:54 seymour kernel: EFLAGS: 00010296   (2.6.11) 
> Jun  3 04:04:54 seymour kernel: EIP is at __flush_buffer+0xfa/0x157
> Jun  3 04:04:54 seymour kernel: eax: 0000005a   ebx: d0d968cc   ecx: c0331714   
> edx: 00000206
> Jun  3 04:04:54 seymour kernel: esi: e8fbdd30   edi: 00000000   ebp: e8fbdd34   
> esp: e8fbdcd8
> Jun  3 04:04:54 seymour kernel: ds: 007b   es: 007b   ss: 0068
> Jun  3 04:04:54 seymour kernel: Process updatedb (pid: 18466, threadinfo=e8fbc00
> 0 task=f7496550)
> Jun  3 04:04:54 seymour kernel: Stack: c02f6ad4 c02e16a3 c02f56ce 000000f7 c02f5
> 6e2 f7cdc000 ed7876ec d0d968cc 
> Jun  3 04:04:54 seymour kernel:        ed78771c f7cdc000 c019c832 e8fbdd2c e8fbd
> d30 c1808060 c011a74b c1808060 
> Jun  3 04:04:54 seymour kernel:        f7cdc0e4 e8fbc000 0006c901 f0a4de9c f6d9d
> b80 0000003c 00000001 d0d968cc 
> Jun  3 04:04:54 seymour kernel: Call Trace:
> Jun  3 04:04:54 seymour kernel:  [<c019c832>] log_do_checkpoint+0xa5/0x1be
> Jun  3 04:04:54 seymour kernel:  [<c011a74b>] finish_task_switch+0x30/0x6d
> Jun  3 04:04:54 seymour kernel:  [<c019c334>] __log_wait_for_space+0x90/0xaa
> Jun  3 04:04:54 seymour kernel:  [<c0197c44>] start_this_handle+0xec/0x371
> Jun  3 04:04:54 seymour kernel:  [<c01b8284>] copy_to_user+0x2b/0x3d
> Jun  3 04:04:54 seymour kernel:  [<c018a9c2>] call_filldir+0x6c/0xaf
> Jun  3 04:04:54 seymour kernel:  [<c016893e>] filldir64+0x0/0xd0
> Jun  3 04:04:54 seymour kernel:  [<c018ab0e>] ext3_dx_readdir+0x109/0x1b5
> Jun  3 04:04:54 seymour kernel:  [<c016893e>] filldir64+0x0/0xd0
> Jun  3 04:04:54 seymour kernel:  [<c0197f8b>] journal_start+0x8f/0xb1
> Jun  3 04:04:54 seymour kernel:  [<c0160893>] cp_new_stat64+0xf0/0x102
> Jun  3 04:04:54 seymour kernel:  [<c018f572>] ext3_dirty_inode+0x27/0x82
> Jun  3 04:04:54 seymour kernel:  [<c01765cf>] __mark_inode_dirty+0xaf/0x1c3
> Jun  3 04:04:54 seymour kernel:  [<c0124086>] current_fs_time+0x50/0x5a
> Jun  3 04:04:54 seymour kernel:  [<c016f666>] update_atime+0x57/0x97
> Jun  3 04:04:54 seymour kernel:  [<c016870e>] vfs_readdir+0x66/0x68
> Jun  3 04:04:54 seymour kernel:  [<c0168a7a>] sys_getdents64+0x6c/0xbe
> Jun  3 04:04:54 seymour kernel:  [<c0103dc5>] sysenter_past_esp+0x52/0x75
> Jun  3 04:04:54 seymour kernel: Code: 44 24 10 e2 56 2f c0 c7 44 24 0c f7 00 00 
> 00 c7 44 24 08 ce 56 2f c0 c7 44 24 04 a3 16 2e c0 c7 04 24 d4 6a 2f c0 e8 d7 35
>  f8 ff <0f> 0b f7 00 ce 56 2f c0 e9 3b ff ff ff c7 44 24 10 4c 8f 2f c0 
> Jun  3 04:04:54 seymour kernel:  <6>note: updatedb[18466] exited with preempt_co
> unt 2
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
