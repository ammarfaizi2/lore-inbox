Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262378AbVESGUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbVESGUC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 02:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbVESGUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 02:20:02 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:21697 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262378AbVESGTz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 02:19:55 -0400
Subject: Re: Scheduling while atomic lockups, Reiser4, DAC960
From: Vladimir Saveliev <vs@namesys.com>
To: "Berck E. Nash" <flyboy@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <428A68BC.1020303@namesys.com>
References: <428A40EC.8050206@gmail.com>  <428A68BC.1020303@namesys.com>
Content-Type: text/plain
Message-Id: <1116483531.13501.276.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 19 May 2005 10:18:52 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Wed, 2005-05-18 at 01:57, Hans Reiser wrote:
> vs will look at it.
> 
> Hans
> 
> Berck E. Nash wrote:
> 
> >Linux luna 2.6.12-rc4-mm1 i686

Please try to patch -R the patch 
ftp://ftp.ru.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/broken-out/reiser4-sb_sync_inodes-cleanup.patch
or use 2.6.12-rc4-mm2

> >Debian unstable, AMD Athlon
> >
> >The error seems to occur with my reiser4 partition.   The physical
> >device is  an 8-disk RAID-0 array on a Mylex Extreme RAID 1100 using the
> >DAC960 driver.  The error is sometimes followed by a lockup, but not always.
> >
> >Not sure if it's a hardware problem or kernel problem.
> >
> >There's pages and pages of errors that look like this.  If there's
> >anything I can do to provide more information, I will gladly do so.
> >
> >Just a user, not a hacker.  I'm not subscribed to the list, so cc's on
> >reply would be appreciated.
> >
> >Thanks,
> >Berck
> >
> > scheduling while atomic: pdflush/0xffffffff/92
> >May 16 03:36:43 luna kernel:  [<c02f6ac4>] schedule+0x604/0x610
> >May 16 03:36:43 luna kernel:  [<c02f6265>] __down+0x85/0x120
> >May 16 03:36:43 luna kernel:  [<c0115020>] default_wake_function+0x0/0x10
> >May 16 03:36:43 luna kernel:  [<c02f645f>] __down_failed+0x7/0xc
> >May 16 03:36:43 luna kernel:  [<c024b420>] blk_backing_dev_unplug+0x0/0x10
> >May 16 03:36:43 luna kernel:  [<c01c5ca3>] .text.lock.flush_queue+0x8/0x25
> >May 16 03:36:43 luna kernel:  [<c01c5524>] finish_fq+0x14/0x40
> >May 16 03:36:43 luna kernel:  [<c01c55ae>] finish_all_fq+0x5e/0xa0
> >May 16 03:36:43 luna kernel:  [<c01c560e>]
> >current_atom_finish_all_fq+0x1e/0x70
> >May 16 03:36:43 luna kernel:  [<c01c167c>] reiser4_write_logs+0x20c/0x2b0
> >May 16 03:36:43 luna kernel:  [<c01ba599>] commit_current_atom+0x109/0x1e0
> >May 16 03:36:43 luna kernel:  [<c01c5957>] release_prepped_list+0xf7/0x130
> >May 16 03:36:43 luna kernel:  [<c01bae23>] try_commit_txnh+0x113/0x190
> >May 16 03:36:43 luna kernel:  [<c01baec8>] commit_txnh+0x28/0xa0
> >May 16 03:36:43 luna kernel:  [<c01b9d7c>] txn_end+0x2c/0x30
> >May 16 03:36:43 luna kernel:  [<c01bab2b>] flush_some_atom+0x1fb/0x290
> >May 16 03:36:43 luna kernel:  [<c01c9368>] writeout+0x68/0xb0
> >May 16 03:36:43 luna kernel:  [<c01c940b>] reiser4_sync_inodes+0x5b/0xa0
> >May 16 03:36:43 luna kernel:  [<c01c93b0>] reiser4_sync_inodes+0x0/0xa0
> >May 16 03:36:43 luna kernel:  [<c0174a59>] sync_sb_inodes+0x19/0x20
> >May 16 03:36:43 luna kernel:  [<c0174b1e>] writeback_inodes+0xbe/0xd0
> >May 16 03:36:43 luna kernel:  [<c013be15>] background_writeout+0x65/0xa0
> >May 16 03:36:43 luna kernel:  [<c013c748>] __pdflush+0xc8/0x1c0
> >May 16 03:36:43 luna kernel:  [<c013c840>] pdflush+0x0/0x20
> >May 16 03:36:43 luna kernel:  [<c013c85a>] pdflush+0x1a/0x20
> >May 16 03:36:43 luna kernel:  [<c013bdb0>] background_writeout+0x0/0xa0
> >May 16 03:36:43 luna kernel:  [<c013c840>] pdflush+0x0/0x20
> >May 16 03:36:43 luna kernel:  [<c012bb44>] kthread+0x94/0xa0
> >May 16 03:36:43 luna kernel:  [<c012bab0>] kthread+0x0/0xa0
> >May 16 03:36:43 luna kernel:  [<c0100f1d>] kernel_thread_helper+0x5/0x18
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >  
> >
> 
> 

