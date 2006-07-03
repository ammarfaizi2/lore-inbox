Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWGCBAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWGCBAX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 21:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWGCBAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 21:00:23 -0400
Received: from thunk.org ([69.25.196.29]:1476 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750831AbWGCBAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 21:00:22 -0400
Message-Id: <20060703005333.706556000@candygram.thunk.org>
Date: Sun, 02 Jul 2006 20:53:33 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch 0/8] Inode slimming patches, part 1
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are against 2.6.17-mm5, and reduce the size of
the VFS inode structure by 28 bytes on a UP x86.  (It would be more on
an x86_64 system).  This is a 10% reduction in the inode size on a UP
kernel that is configured in a production mode (i.e., with no spinlock
or other debugging functions enabled; if you want to save memory taken
up by in-core inodes, the first thing you should do is disable the
debugging options; they are responsible for a huge amount of bloat in
the VFS inode structure).

							- Ted
