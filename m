Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbUJXNUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUJXNUS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUJXNSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:18:37 -0400
Received: from verein.lst.de ([213.95.11.210]:9126 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261474AbUJXNR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:17:29 -0400
Date: Sun, 24 Oct 2004 15:17:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: a.gruenbacher@computer.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove ext2 xatts exports
Message-ID: <20041024131718.GB19658@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think Andreas exported them to allow modular xattr handlers, but with
James rework these aren't possible anymore, and we never had them
anyway.

--- 1.24/fs/ext2/xattr.c	2004-10-19 11:40:30 +02:00
+++ edited/fs/ext2/xattr.c	2004-10-23 14:35:56 +02:00
@@ -64,11 +64,6 @@
 #include "xattr.h"
 #include "acl.h"
 
-/* These symbols may be needed by a module. */
-EXPORT_SYMBOL(ext2_xattr_get);
-EXPORT_SYMBOL(ext2_xattr_list);
-EXPORT_SYMBOL(ext2_xattr_set);
-
 #define HDR(bh) ((struct ext2_xattr_header *)((bh)->b_data))
 #define ENTRY(ptr) ((struct ext2_xattr_entry *)(ptr))
 #define FIRST_ENTRY(bh) ENTRY(HDR(bh)+1)
