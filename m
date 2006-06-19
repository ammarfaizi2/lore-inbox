Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWFSM2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWFSM2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWFSMZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6590 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932421AbWFSMZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:19 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/15] ext2 XIP won't build without MMU
Date: Mon, 19 Jun 2006 13:25:03 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122503.10060.98112.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Disable Ext2 XIP if the kernel is configured in no-MMU mode as the former won't
build.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index f9b5842..ab69a1e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -53,7 +53,7 @@ config EXT2_FS_SECURITY
 
 config EXT2_FS_XIP
 	bool "Ext2 execute in place support"
-	depends on EXT2_FS
+	depends on EXT2_FS && MMU
 	help
 	  Execute in place can be used on memory-backed block devices. If you
 	  enable this option, you can select to mount block devices which are

