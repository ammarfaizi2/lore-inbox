Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269419AbUIIK4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269419AbUIIK4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269421AbUIIK4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:56:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:15291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269419AbUIIK4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:56:38 -0400
Date: Thu, 9 Sep 2004 03:54:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: hch@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Current BK breakage
Message-Id: <20040909035438.59d70176.akpm@osdl.org>
In-Reply-To: <20040909101847.GA11358@krispykreme>
References: <20040909101847.GA11358@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  Looks like a bug in the cleanup patch :)

oop.  Shows how many people are testing ext2.  Let's fix up that whitespace
also.

--- 25/fs/buffer.c~a	2004-09-09 03:53:03.625363720 -0700
+++ 25-akpm/fs/buffer.c	2004-09-09 03:53:17.022327072 -0700
@@ -895,9 +895,8 @@ void mark_buffer_dirty_inode(struct buff
 		spin_lock(&buffer_mapping->private_lock);
 		list_move_tail(&bh->b_assoc_buffers,
 				&mapping->private_list);
-		spin_lock(&buffer_mapping->private_lock);
-}
-
+		spin_unlock(&buffer_mapping->private_lock);
+	}
 }
 EXPORT_SYMBOL(mark_buffer_dirty_inode);
 
_



