Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbULLVYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbULLVYG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 16:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbULLVYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 16:24:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12039 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262129AbULLVUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 16:20:35 -0500
Date: Sun, 12 Dec 2004 22:20:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/unix/: make some code static
Message-ID: <20041212212022.GA22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 net/unix/af_unix.c         |    2 +-
 net/unix/sysctl_net_unix.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/net/unix/af_unix.c.old	2004-12-12 19:36:21.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/unix/af_unix.c	2004-12-12 19:36:32.000000000 +0100
@@ -121,7 +121,7 @@
 
 int sysctl_unix_max_dgram_qlen = 10;
 
-kmem_cache_t *unix_sk_cachep;
+static kmem_cache_t *unix_sk_cachep;
 
 struct hlist_head unix_socket_table[UNIX_HASH_SIZE + 1];
 rwlock_t unix_table_lock = RW_LOCK_UNLOCKED;
--- linux-2.6.10-rc2-mm4-full/net/unix/sysctl_net_unix.c.old	2004-12-12 19:37:08.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/net/unix/sysctl_net_unix.c	2004-12-12 19:37:17.000000000 +0100
@@ -14,7 +14,7 @@
 
 extern int sysctl_unix_max_dgram_qlen;
 
-ctl_table unix_table[] = {
+static ctl_table unix_table[] = {
 	{
 		.ctl_name	= NET_UNIX_MAX_DGRAM_QLEN,
 		.procname	= "max_dgram_qlen",

