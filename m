Return-Path: <linux-kernel-owner+w=401wt.eu-S936553AbWLIKSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936553AbWLIKSe (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 05:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936782AbWLIKSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 05:18:33 -0500
Received: from hempcity.net ([81.171.100.190]:33998 "EHLO hempcity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936595AbWLIKSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 05:18:32 -0500
Message-ID: <13634.62.194.65.8.1165659510.squirrel@webmail.coolzero.info>
Date: Sat, 9 Dec 2006 11:18:30 +0100 (CET)
Subject: Ext3 Errors...
From: "Jim van Wel" <jim@coolzero.info>
To: linux-kernel@vger.kernel.org
Reply-To: jim@coolzero.info
User-Agent: SquirrelMail/1.4.8-2.el4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have something really strange while running kernel 2.6.19.

See the following lines:

Dec  5 23:50:49 kernel: do_get_write_access: OOM for frozen_buffer
Dec  5 23:50:49 kernel: ext3_free_blocks_sb: aborting transaction: Out of
memory in __ext3_journal_get_undo_access
Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in ext3_free_blocks_sb:
Out of memory
Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
ext3_reserve_inode_write: Readonly filesystem
Dec  5 23:50:50 kernel: EXT3-fs error (device md1) in ext3_truncate: Out
of memory
Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
ext3_reserve_inode_write: Readonly filesystem
Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in ext3_orphan_del:
Readonly filesystem
Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
ext3_reserve_inode_write: Readonly filesystem
Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in ext3_delete_inode:
Out of memory

And three days later the same:

Dec  8 08:24:29 kernel: do_get_write_access: OOM for frozen_buffer
Dec  8 08:24:29 kernel: ext3_reserve_inode_write: aborting transaction:
Out of memory in __ext3_journal_get_write_access
Dec  8 08:24:29 kernel: EXT3-fs error (device md1) in
ext3_reserve_inode_write: Out of memory
Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_dirty_inode:
Out of memory
Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_new_blocks:
Readonly filesystem
Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
ext3_reserve_inode_write: Readonly filesystem
Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_dirty_inode:
Out of memory
Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_prepare_write:
Out of memory

Now the funny thing is, with kernel 2.6.18.3 I did not had these errors.
Could it be my memory that is just going nuts, or something else? I have
seen some other topics about the EXT3 corruption problems. Maybe this is
also the same thing?

Thanks for reading.
