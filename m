Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269404AbUIIKXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269404AbUIIKXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 06:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269409AbUIIKXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 06:23:19 -0400
Received: from ozlabs.org ([203.10.76.45]:63159 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269404AbUIIKXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 06:23:14 -0400
Date: Thu, 9 Sep 2004 20:18:47 +1000
From: Anton Blanchard <anton@samba.org>
To: hch@infradead.org, torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Current BK breakage
Message-ID: <20040909101847.GA11358@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Looks like a bug in the cleanup patch :)

Anton

Signed-off-by: Anton Blanchard <anton@samba.org>

===== buffer.c 1.256 vs edited =====
--- 1.256/fs/buffer.c	Wed Sep  8 16:33:15 2004
+++ edited/buffer.c	Thu Sep  9 20:03:41 2004
@@ -895,7 +895,7 @@
 		spin_lock(&buffer_mapping->private_lock);
 		list_move_tail(&bh->b_assoc_buffers,
 				&mapping->private_list);
-		spin_lock(&buffer_mapping->private_lock);
+		spin_unlock(&buffer_mapping->private_lock);
 }
 
 }
