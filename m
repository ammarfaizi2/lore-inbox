Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWGFOUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWGFOUf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 10:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWGFOUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 10:20:35 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:5582 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030275AbWGFOUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 10:20:34 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060706142032.6D96582BC1@kleikamp.austin.ibm.com>
Date: Thu,  6 Jul 2006 09:20:32 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/jfs_txnmgr.c |    2 +-
 fs/jfs/namei.c      |   33 ++++++++++++++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

through these ChangeSets:

commit 48ce8b056c88920c8ac187781048f5dae33c81b9 
tree d03665af62302a252a5c60e7a920190ed93cbec8 
parent 672c6108a51bf559d19595d9f8193dfd81f0f752 
author Evgeniy Dushistov <dushistov@mail.ru> Mon, 05 Jun 2006 08:21:03 -0500 
committer Dave Kleikamp <shaggy@austin.ibm.com> Mon, 05 Jun 2006 08:21:03 -0500 

    JFS: commit_mutex cleanups
    
    I look at code, and see that
    1)locks wasn't release in the opposite order in which they were taken
    2)in jfs_rename we lock new_ip, and in "error path" we didn't unlock it
    3)I see strange expression: "! !"
    
    May be this worth to fix?
    
    Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

