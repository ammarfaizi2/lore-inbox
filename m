Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266223AbSKLG0U>; Tue, 12 Nov 2002 01:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266236AbSKLG0U>; Tue, 12 Nov 2002 01:26:20 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:10642 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S266223AbSKLG0U>;
	Tue, 12 Nov 2002 01:26:20 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [0/4]: Ext2/3 updates: Introduction
From: tytso@mit.edu
Message-Id: <E18BUbi-0005iv-00@snap.thunk.org>
Date: Tue, 12 Nov 2002 01:33:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following four patches are further cleanups to the ext2/3
filesystem.  Please apply, or pull them from:

	     bk://extfs.bkbits.net/extfs-2.5-update

Of note is patch #3, which I've also pushed to Marcelo.  Apparently the
Index/Btree flag compatibility code which was in the ext2 code base of
2.2.19 somehow disappeared before 2.4 shipped.  Fortunatelly, it was
retained in the ext3-2.4 codebase.  The upshot of all of this is that
mounting an HTREE-enabled filesystems under ext2 will cause subtle
filesystem corruptions will cause e2fsck and ext3-htree to complain
bitterly.

						- Ted
