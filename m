Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVJNPuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVJNPuX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVJNPuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 11:50:23 -0400
Received: from pat.uio.no ([129.240.130.16]:54729 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750765AbVJNPuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 11:50:23 -0400
Subject: Re: [OOPS] nfsv4 in linux 2.6.13 (-ck7)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Gabriel A. Devenyi" <ace@staticwave.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510121903.04485.ace@staticwave.ca>
References: <200510121903.04485.ace@staticwave.ca>
Content-Type: multipart/mixed; boundary="=-V4dGyjXYLko1J2Q2lENn"
Date: Fri, 14 Oct 2005 11:49:55 -0400
Message-Id: <1129304995.8571.43.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.732, required 12,
	autolearn=disabled, AWL 2.08, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V4dGyjXYLko1J2Q2lENn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

on den 12.10.2005 Klokka 19:03 (-0400) skreiv Gabriel A. Devenyi:
> This oops seems to occur during heavy i/o load over nfsv4.
> 
> nfs-utils version 1.0.7
> 
> OOps follows, what other information is needed?
> 
>  [kernel] Unable to handle kernel paging request at 0000000000100108 RIP:
>  [kernel] <ffffffff80185e98>{generic_drop_inode+56}
>  [kernel] PGD 34e3b067 PUD 34e68067 PMD 0
>  [kernel] CPU 0
>  [kernel] Modules linked in: nvidia snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss snd_mixer_oss snd_seq_oss snd_seq_midi_event sn
> d_seq snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd
>  [kernel] Pid: 179, comm: kswapd0 Tainted: P      2.6.13-ck7
>  [kernel] RIP: 0010:[<ffffffff80185e98>] <ffffffff80185e98>{generic_drop_inode+56}
>  [kernel] RSP: 0018:ffff81003fcd7b68  EFLAGS: 00010246
>  [kernel] RAX: 0000000000100100 RBX: ffff81001a58c950 RCX: 0000000000200200
>  [kernel] RDX: ffff81001a58c960 RSI: ffff81003eb84000 RDI: ffff81001a58c950
>  [kernel] RBP: ffff81001a58c950 R08: 00000000fffffffa R09: ffff81001a58ca68
>  [kernel] R10: 0000000000000001 R11: ffffffff80185e60 R12: 0000000000000000
>  [kernel] R13: ffff81001a58c7d0 R14: ffff81001a58c860 R15: ffff81003f1f5200
>  [kernel] FS:  0000000040800960(0000) GS:ffffffff80494800(0000) knlGS:0000000056160040
>  [kernel] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
>  [kernel] CR2: 0000000000100108 CR3: 0000000034de7000 CR4: 00000000000006e0
>  [kernel] Process kswapd0 (pid: 179, threadinfo ffff81003fcd6000, task ffff81003fcb2760)
>  [kernel] Stack: ffff81003f1f5c00 ffffffff801d7a25 00000001803e8238 ffff81003fcd7c18
>  [kernel]        ffffffffffffffff ffff81003fcd7c18 ffff81003fcd7c00 ffff81001a58c938
>  [kernel]        0000000000000000 0000000000000000
>  [kernel] Call Trace:<ffffffff801d7a25>{__nfs_revalidate_inode+261} <ffffffff8014e5df>{find_get_pages_tag+31}
>  [kernel]        <ffffffff8015781a>{pagevec_lookup_tag+26} <ffffffff8014e00e>{wait_on_page_writeback_range+206}
>  [kernel]        <ffffffff801f11ba>{nfs_do_return_delegation+42} <ffffffff801f12e5>{nfs_inode_return_delegation+197}
>  [kernel]        <ffffffff801d8a10>{nfs4_clear_inode+32} <ffffffff80184cfe>{clear_inode+158}
>  [kernel]        <ffffffff8018594e>{dispose_list+94} <ffffffff80185b82>{shrink_icache_memory+434}
>  [kernel]        <ffffffff8015806b>{shrink_slab+219} <ffffffff80159517>{balance_pgdat+695}
>  [kernel]        <ffffffff801597a8>{kswapd+312} <ffffffff80143b30>{autoremove_wake_function+0}
>  [kernel]        <ffffffff80143b30>{autoremove_wake_function+0} <ffffffff8010f30e>{child_rip+8}
>  [kernel]        <ffffffff80159670>{kswapd+0} <ffffffff8010f306>{child_rip+0}
>  [kernel]
>  [kernel] Code: 48 89 48 08 48 89 01 48 8b 05 aa 43 26 00 48 89 50 08 48 89
>  [kernel] RIP <ffffffff80185e98>{generic_drop_inode+56} RSP <ffff81003fcd7b68>

Does the attached patch fix it for you?

Cheers,
  Trond


--=-V4dGyjXYLko1J2Q2lENn
Content-Disposition: inline; filename=linux-2.6.14-00-fix_iput.dif
Content-Type: text/plain; name=linux-2.6.14-00-fix_iput.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

NFS: Fix Oopsable/unnecessary i_count manipulations in nfs_wait_on_inode()

 Oopsable since nfs_wait_on_inode() can get called as part of iput_final().

 Unnecessary since the caller had better be damned sure that the inode won't
 disappear from underneath it anyway.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---
 inode.c |    2 --
 1 files changed, 2 deletions(-)

Index: linux-2.6.14-rc4/fs/nfs/inode.c
===================================================================
--- linux-2.6.14-rc4.orig/fs/nfs/inode.c
+++ linux-2.6.14-rc4/fs/nfs/inode.c
@@ -877,12 +877,10 @@ static int nfs_wait_on_inode(struct inod
 	sigset_t oldmask;
 	int error;
 
-	atomic_inc(&inode->i_count);
 	rpc_clnt_sigmask(clnt, &oldmask);
 	error = wait_on_bit_lock(&nfsi->flags, NFS_INO_REVALIDATING,
 					nfs_wait_schedule, TASK_INTERRUPTIBLE);
 	rpc_clnt_sigunmask(clnt, &oldmask);
-	iput(inode);
 
 	return error;
 }

--=-V4dGyjXYLko1J2Q2lENn--

