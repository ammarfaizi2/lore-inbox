Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVHSQMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVHSQMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbVHSQMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:12:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21748 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751224AbVHSQMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:12:17 -0400
Subject: Re: 2.6.13-rc6-mm1
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mark Fasheh <mark.fasheh@oracle.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050819043331.7bc1f9a9.akpm@osdl.org>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 19 Aug 2005 11:11:51 -0500
Message-Id: <1124467911.9329.11.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that git-ocfs2.patch duplicates the
update-filesystems-for-new-delete_inode-behavior.patch.  I noticed it
adds duplicate statements like:

diff -puN fs/ext2/inode.c~git-ocfs2 fs/ext2/inode.c
diff -puN fs/ext3/inode.c~git-ocfs2 fs/ext3/inode.c
--- devel/fs/ext3/inode.c~git-ocfs2     2005-08-18 22:00:35.000000000 -0700
+++ devel-akpm/fs/ext3/inode.c  2005-08-18 22:00:37.000000000 -0700
@@ -189,6 +189,8 @@ void ext3_delete_inode (struct inode * i

        truncate_inode_pages(&inode->i_data, 0);

+       truncate_inode_pages(&inode->i_data, 0);
+
        if (is_bad_inode(inode))
                goto no_delete;

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

