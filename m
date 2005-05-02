Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVEBByJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVEBByJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVEBByB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:54:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40976 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261673AbVEBBrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:16 -0400
Date: Mon, 2 May 2005 03:47:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy driver: make fd_routine static
Message-ID: <20050502014715.GC3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global fd_routine static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

 include/asm-i386/floppy.h   |    2 +-
 include/asm-parisc/floppy.h |    2 +-
 include/asm-sh/floppy.h     |    2 +-
 include/asm-x86_64/floppy.h |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.12-rc2-mm2-full/include/asm-i386/floppy.h.old	2005-04-10 01:51:37.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/include/asm-i386/floppy.h	2005-04-10 01:51:45.000000000 +0200
@@ -257,7 +257,7 @@
 	return 0;
 }
 
-struct fd_routine_l {
+static struct fd_routine_l {
 	int (*_request_dma)(unsigned int dmanr, const char * device_id);
 	void (*_free_dma)(unsigned int dmanr);
 	int (*_get_dma_residue)(unsigned int dummy);
--- linux-2.6.12-rc2-mm2-full/include/asm-x86_64/floppy.h.old	2005-04-10 01:51:53.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/include/asm-x86_64/floppy.h	2005-04-10 01:51:59.000000000 +0200
@@ -223,7 +223,7 @@
 	return 0;
 }
 
-struct fd_routine_l {
+static struct fd_routine_l {
 	int (*_request_dma)(unsigned int dmanr, const char * device_id);
 	void (*_free_dma)(unsigned int dmanr);
 	int (*_get_dma_residue)(unsigned int dummy);
--- linux-2.6.12-rc2-mm2-full/include/asm-parisc/floppy.h.old	2005-04-10 01:52:07.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/include/asm-parisc/floppy.h	2005-04-10 01:52:13.000000000 +0200
@@ -235,7 +235,7 @@
 	return 0;
 }
 
-struct fd_routine_l {
+static struct fd_routine_l {
 	int (*_request_dma)(unsigned int dmanr, const char * device_id);
 	void (*_free_dma)(unsigned int dmanr);
 	int (*_get_dma_residue)(unsigned int dummy);
--- linux-2.6.12-rc2-mm2-full/include/asm-sh/floppy.h.old	2005-04-10 01:52:25.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/include/asm-sh/floppy.h	2005-04-10 01:52:32.000000000 +0200
@@ -227,7 +227,7 @@
 	return 0;
 }
 
-struct fd_routine_l {
+static struct fd_routine_l {
 	int (*_request_dma)(unsigned int dmanr, const char * device_id);
 	void (*_free_dma)(unsigned int dmanr);
 	int (*_get_dma_residue)(unsigned int dummy);

