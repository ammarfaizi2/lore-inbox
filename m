Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWFSM2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWFSM2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWFSMZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932392AbWFSMZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:13 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 10/15] frv: initrd is grossly broken on frv (never built)
Date: Mon, 19 Jun 2006 13:25:05 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122505.10060.98900.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The FRV arch doesn't currently support initrd, so it should be disabled
automatically for the moment.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 drivers/block/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index ae0949b..93d9474 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -402,6 +402,7 @@ config BLK_DEV_RAM_SIZE
 
 config BLK_DEV_INITRD
 	bool "Initial RAM filesystem and RAM disk (initramfs/initrd) support"
+	depends on BROKEN || !FRV
 	help
 	  The initial RAM filesystem is a ramfs which is loaded by the
 	  boot loader (loadlin or lilo) and that is mounted as root

