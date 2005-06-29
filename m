Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVF2O6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVF2O6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVF2O6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:58:14 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40965 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261252AbVF2O6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:58:05 -0400
Date: Wed, 29 Jun 2005 16:58:06 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13-rc1
Message-ID: <20050629145806.GA5803@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4kEoS-Am-3@gated-at.bofh.it> <m37jgd9r8w.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37jgd9r8w.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 04:23:11PM +0200, Ronny V. Vindenes wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > ARM, x86[-64], ppc, sparc updates, networking, sound, infiniband, input
> > layer, ISDN, MD, DVB, V4L, network drivers, pcmcia, isofs, jfs, nfs,
> > xfs, knfsd.. You name it.
> > 
> > Git trees and traditional patches/tar-balls are out there, or at least 
> > slowly mirroring out. Go wild,
> > 
> > 		Linus
> 
> On x86_64 with reiserfs and ext3 on dm (using cfq scheduler) the log
> is full of this:
> 
> Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424

 Also on x86, Reiserfs on LVM2, cfq, on sata_sil; Preemption set to
Voluntary.

Badness in blk_remove_plug at drivers/block/ll_rw_blk.c:1424
 [<c027adf1>] blk_remove_plug+0x61/0x70
 [<c027ae14>] __generic_unplug_device+0x14/0x30
 [<c027b6d5>] get_request_wait+0xd5/0x100
 [<c01322f0>] autoremove_wake_function+0x0/0x50
 [<c01322f0>] autoremove_wake_function+0x0/0x50
 [<c02837f0>] cfq_merge+0x0/0xc0
 [<c027bf03>] __make_request+0x93/0x470
 [<c027c617>] generic_make_request+0x107/0x1f0
 [<c027b61b>] get_request_wait+0x1b/0x100
 [<c01322f0>] autoremove_wake_function+0x0/0x50
 [<c01322f0>] autoremove_wake_function+0x0/0x50
 [<c01615bc>] bio_clone+0xcc/0xe0
 [<c02ca72c>] __map_bio+0x3c/0x100
 [<c02cab0b>] __clone_and_map+0x22b/0x240
 [<c02cabb7>] __split_bio+0x97/0x100
 [<c02cac7f>] dm_request+0x5f/0x90
 [<c027c617>] generic_make_request+0x107/0x1f0
 [<c01322f0>] autoremove_wake_function+0x0/0x50
 [<c01322f0>] autoremove_wake_function+0x0/0x50
 [<c027c74b>] submit_bio+0x4b/0xe0
 [<c01612c1>] bio_alloc_bioset+0x181/0x200
 [<c0160bba>] submit_bh+0xda/0x130
 [<c01b0369>] write_ordered_chunk+0x29/0x50
 [<c01b03cb>] add_to_chunk+0x3b/0x40
 [<c01b0673>] write_ordered_buffers+0xb3/0x1a0
 [<c01b0340>] write_ordered_chunk+0x0/0x50
 [<c01b0c2c>] flush_commit_list+0x37c/0x460
 [<c01b5469>] do_journal_end+0x8d9/0x930
 [<c01477c0>] pdflush+0x0/0x20
 [<c01b425c>] journal_end_sync+0x4c/0xb0
 [<c01a2e55>] reiserfs_sync_fs+0x45/0x60
 [<c01629cb>] sync_supers+0xbb/0xd0
 [<c0146e85>] wb_kupdate+0x25/0x120
 [<c0387eea>] schedule+0x2fa/0x5d0
 [<c01477c0>] pdflush+0x0/0x20
 [<c01476e6>] __pdflush+0x96/0x170
 [<c01477da>] pdflush+0x1a/0x20
 [<c0146e60>] wb_kupdate+0x0/0x120
 [<c01477c0>] pdflush+0x0/0x20
 [<c0131f05>] kthread+0x95/0xd0
 [<c0131e70>] kthread+0x0/0xd0
 [<c010134d>] kernel_thread_helper+0x5/0x18

-- 
Tomasz Torcz                "Funeral in the morning, IDE hacking
zdzichu@irc.-nie.spam-.pl    in the afternoon and evening." - Alan Cox

