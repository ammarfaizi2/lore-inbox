Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVACR0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVACR0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVACR0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:26:01 -0500
Received: from holomorphy.com ([207.189.100.168]:34204 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261514AbVACRXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:23:05 -0500
Date: Mon, 3 Jan 2005 09:23:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [1/8] there is no generic_file_(get|set)_policy()
Message-ID: <20050103172303.GB29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103172013.GA29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no generic_file_set_policy() or generic_file_get_policy.
This patch removes the dangling references to them.

Without this patch, the kernel fails to build from source with
CONFIG_NUMA=y

Signed-off-by: William Irwin <wli@holomorphy.com>


Index: mm1-2.6.10/mm/filemap.c
===================================================================
--- mm1-2.6.10.orig/mm/filemap.c	2005-01-03 06:46:04.000000000 -0800
+++ mm1-2.6.10/mm/filemap.c	2005-01-03 07:50:55.000000000 -0800
@@ -1542,10 +1542,6 @@
 	.nopage		= filemap_nopage,
 	.populate	= filemap_populate,
 	.page_mkwrite	= filemap_page_mkwrite,
-#ifdef CONFIG_NUMA
-	.set_policy     = generic_file_set_policy,
-	.get_policy     = generic_file_get_policy,
-#endif
 };
 
 /* This is used for a general mmap of a disk file */
