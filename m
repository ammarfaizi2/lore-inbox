Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVFANAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVFANAz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFANAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:00:54 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:45181 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261216AbVFANAD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:00:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CuxFJ/0xZaW+j0oHBfuOzSI/MA399m+ZxOUwuM+fWSj8j4AC/yOJE0J3Ub7k/wOXYNhFO1xUZQz2GX1fDpsYAtajIudTbKaY3lZ60njHTVt8LF/ITC4yCsW1lYKhaYEC1PQ1tbxwOYyo7cDbqfDGjkynY1ELDz9prjPpCRhnM6Q=
Message-ID: <4ccc54a905060106005fbe91b6@mail.gmail.com>
Date: Wed, 1 Jun 2005 14:00:00 +0100
From: Evgeniy Shapiro <shellinux@gmail.com>
Reply-To: Evgeniy Shapiro <shellinux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8 problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with 2.6.8 kernel (Suse 9.2 default) running on dual
opteron machine, The machine goes into hard lock 3-4 times a day with
the following message:

======================================================================
May 25 18:41:49 linux -- MARK --
May 25 18:45:46 linux kernel: Unable to handle kernel paging request
at 00000000000018f0 RIP:
May 25 18:45:46 linux kernel: {kmem_getpages+132}
May 25 18:45:46 linux kernel: PML4 140787067 PGD 13f40e067 PMD 0
May 25 18:45:46 linux kernel: Oops: 0000 [1] SMP
May 25 18:45:46 linux kernel: CPU 1
May 25 18:45:46 linux kernel: Modules linked in: usbserial floppy
parport_pc lp parport edd freq_table thermal processor fan button
battery ac ipv6 snd_pcm_oss snd_mixer_oss snd_ioctl32 snd_intel8x0
snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc
af_packet subfs joydev sg st sr_mod ehci_hcd uhci_hcd ohci1394
ieee1394 ohci_hcd hw_random evdev dm_mod usbcore e1000 reiserfs
sata_sil libata sd_mod scsi_mod
May 25 18:45:46 linux kernel: Pid: 7785, comm: a.out Not tainted
(2.6.8-24.10-smp SL92_BRANCH-200412221154270000)
May 25 18:45:46 linux kernel: RIP: 0010:[] {kmem_getpages+132}
May 25 18:45:46 linux kernel: RSP: 0018:000001013f925ad8 EFLAGS: 00010213
May 25 18:45:46 linux kernel: RAX: ffffffff7fffffff RBX:
000001017ffca880 RCX: 0000000000000000
May 25 18:45:46 linux kernel: RDX: 000001000000f780 RSI:
000001000000fb00 RDI: 000001000000f000
May 25 18:45:46 linux kernel: RBP: 0000010037ffd000 R08:
0000010139c0e000 R09: 0000000000000010
May 25 18:45:46 linux kernel: R10: 0000000000000006 R11:
0000000000000002 R12: 000001017ffca880
May 25 18:45:46 linux kernel: R13: 000001017ffca8c8 R14:
0000000000000000 R15: 0000000000000000
May 25 18:45:46 linux kernel: FS: 0000002a9782c160(0000)
GS:ffffffff804e2e80(005b) knlGS:00000000556f6080
May 25 18:45:46 linux kernel: CS: 0010 DS: 002b ES: 002b CR0: 0000000080050033
May 25 18:45:46 linux kernel: CR2: 00000000000018f0 CR3:
000000017ff98000 CR4: 00000000000006e0
May 25 18:45:46 linux kernel: Process a.out (pid: 7785, threadinfo
000001013f924000, task 000001017a2e3030)
May 25 18:45:46 linux kernel: Stack: 000000d23a5c5f34 00000100054a22d8
0000000000000010 ffffffff80162a49
May 25 18:45:46 linux kernel: 000001017ffca928 0000000000000001
0000005000000050 0000000000000000
May 25 18:45:46 linux kernel: 0000000000000000 0000000000001000
May 25 18:45:46 linux kernel: Call Trace:{cache_alloc_refill+665}
{kmem_cache_alloc+54}
May 25 18:45:46 linux kernel: {alloc_buffer_head+17} {create_buffers+42}
May 25 18:45:46 linux kernel: {create_empty_buffers+20}
{:reiserfs:reiserfs_prepare_file_region_for_write+277}
May 25 18:45:46 linux kernel: {:reiserfs:reiserfs_file_write+1459}
May 25 18:45:46 linux kernel: {:reiserfs:reiserfs_dirty_inode+147}
May 25 18:45:46 linux kernel: {inode_setattr+253}
{:reiserfs:reiserfs_setattr+577}
May 25 18:45:46 linux kernel: {__switch_to+314} {finish_task_switch+64}
May 25 18:45:46 linux kernel: {thread_return+41} {vfs_write+243}
May 25 18:45:46 linux kernel: {sys_write+83} {cstar_do_call+27}
May 25 18:45:46 linux kernel: May 25 18:45:46 linux kernel:
May 25 18:45:46 linux kernel: Code: 48 8b 91 f0 18 00 00 76 07 b8 00
00 00 80 eb 0a 48 b8 00 00
May 25 18:45:46 linux kernel: RIP {kmem_getpages+132} RSP
May 25 18:45:46 linux kernel: CR2: 00000000000018f0
May 25 18:45:47 linux kernel: Unable to handle kernel paging request
at 00000000000018f0 RIP:
May 25 18:45:47 linux kernel: {kmem_getpages+132}
May 25 18:45:47 linux kernel: PML4 16a44b067 PGD 16ac56067 PMD 0
May 25 18:45:47 linux kernel: Oops: 0000 [2] SMP
May 25 18:45:47 linux kernel: CPU 1
May 25 18:45:47 linux kernel: Modules linked in: usbserial floppy
parport_pc lp parport edd freq_table thermal processor fan button
battery ac ipv6 snd_pcm_oss snd_mixer_oss snd_ioctl32 snd_intel8x0
snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc
af_packet subfs joydev sg st sr_mod ehci_hcd uhci_hcd ohci1394
ieee1394 ohci_hcd hw_random evdev dm_mod usbcore e1000 reiserfs
sata_sil libata sd_mod scsi_mod
May 25 18:45:47 linux kernel: Pid: 54, comm: pdflush Not tainted
(2.6.8-24.10-smp SL92_BRANCH-200412221154270000)
May 25 18:45:47 linux kernel: RIP: 0010:[] {kmem_getpages+132}
May 25 18:45:47 linux kernel: RSP: 0000:000001017fcd3998 EFLAGS: 00010013
May 25 18:45:47 linux kernel: RAX: ffffffff7fffffff RBX:
000001007ffd98c0 RCX: 0000000000000000
May 25 18:45:47 linux kernel: RDX: 000001000000f780 RSI:
000001000000fb00 RDI: 000001000000f000
May 25 18:45:47 linux kernel: RBP: 000001017feba000 R08:
0000010139c0f000 R09: 0000000000000000
May 25 18:45:47 linux kernel: R10: 0000010140752a20 R11:
0000000000000001 R12: 000001007ffd98c0
May 25 18:45:47 linux kernel: R13: 000001007ffd9908 R14:
0000000000000000 R15: 0000000000000000
May 25 18:45:48 linux kernel: FS: 0000002a9958cf60(0000)
GS:ffffffff804e2e80(0000) knlGS:00000000556f6080
May 25 18:45:48 linux kernel: CS: 0010 DS: 0018 ES: 0018 CR0: 000000008005003b
May 25 18:45:48 linux kernel: CR2: 00000000000018f0 CR3:
000000017ff98000 CR4: 00000000000006e0
May 25 18:45:48 linux kernel: Process pdflush (pid: 54, threadinfo
000001017fcd2000, task 000001017fc50030)
May 25 18:45:48 linux kernel: Stack: 000001007fde0760 000001013adf1990
0000000000000000 ffffffff80162a49
May 25 18:45:48 linux kernel: 000001007ffd9968 0000000000000003
0000020000000200 000001017fcd3b78
May 25 18:45:48 linux kernel: 00000100070b9c00 0000000000000010
May 25 18:45:48 linux kernel: Call Trace:{cache_alloc_refill+665}
{kmem_cache_alloc+54}
May 25 18:45:48 linux kernel: {mempool_alloc+164} {autoremove_wake_function+0}
May 25 18:45:48 linux kernel: {autoremove_wake_function+0} {bio_alloc+47}
May 25 18:45:48 linux kernel: {submit_bh+175} {:reiserfs:write_ordered_chunk+0}
May 25 18:45:48 linux kernel: {:reiserfs:write_ordered_chunk+73}
May 25 18:45:48 linux kernel: {:reiserfs:add_to_chunk+105}
{:reiserfs:write_ordered_buffers+305}
May 25 18:45:48 linux kernel: {:reiserfs:flush_commit_list+483}
May 25 18:45:48 linux kernel: {:reiserfs:do_journal_end+3178}
{keventd_create_kthread+0}
May 25 18:45:48 linux kernel: {:reiserfs:reiserfs_write_super+103}
May 25 18:45:48 linux kernel: {__up_read+29} {sync_supers+125}
May 25 18:45:48 linux kernel: {wb_kupdate+42} {pdflush+323}
May 25 18:45:48 linux kernel: {wb_kupdate+0} {pdflush+0}
May 25 18:45:48 linux kernel: {kthread+217} {child_rip+8}
May 25 18:45:48 linux kernel: {keventd_create_kthread+0} {kthread+0}
May 25 18:45:48 linux kernel: {child_rip+0}
May 25 18:45:48 linux kernel:
May 25 18:45:48 linux kernel: Code: 48 8b 91 f0 18 00 00 76 07 b8 00
00 00 80 eb 0a 48 b8 00 00
May 25 18:45:48 linux kernel: RIP {kmem_getpages+132} RSP
May 25 18:45:48 linux kernel: CR2: 00000000000018f0
==================================================================================================

I thought this is a memory problem, we have changed memory and
memtest86 runs clean, but the problem is still there.

Can anyone help me with decoding the messages (I'm too lame to
understand them myself). Reiser's write is mentioned and the machine
loves to fall on huge rsyncs, Is it possible that this is a disk
problem?

Thank you

Evgeniy
