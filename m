Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWKBPU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWKBPU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWKBPU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:20:56 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:13223 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751356AbWKBPUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:20:55 -0500
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 1/3] fsstack: Make fsstack_copy_attr_all copy inode size
Date: Wed, 01 Nov 2006 22:59:28 -0500
To: linux-kernel@vger.kernel.org
Message-Id: <20061102035930.679.85373.stgit@thor.fsl.cs.sunysb.edu>
In-Reply-To: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
References: <20061102035928.679.60601.stgit@thor.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Michael Halcrow <mhalcrow@us.ibm.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

fsstack_copy_attr_all should copy the inode size in addition to all the
other attributes.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
---

 fs/stack.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/stack.c b/fs/stack.c
index 03987f2..9d3ba4e 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -33,5 +33,7 @@ void fsstack_copy_attr_all(struct inode 
 	dest->i_ctime = src->i_ctime;
 	dest->i_blkbits = src->i_blkbits;
 	dest->i_flags = src->i_flags;
+
+	fsstack_copy_inode_size(dest, src);
 }
 EXPORT_SYMBOL_GPL(fsstack_copy_attr_all);

