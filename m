Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424349AbWKQRCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424349AbWKQRCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 12:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162420AbWKQRCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 12:02:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8978 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933740AbWKQRCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 12:02:11 -0500
Date: Fri, 17 Nov 2006 18:02:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Kylene Jo Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: [-mm patch] security/slim/slm_main.c: make 2 functions static
Message-ID: <20061117170210.GF31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 security/slim/slm_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.19-rc5-mm2/security/slim/slm_main.c.old	2006-11-17 16:42:58.000000000 +0100
+++ linux-2.6.19-rc5-mm2/security/slim/slm_main.c	2006-11-17 16:43:22.000000000 +0100
@@ -967,8 +967,8 @@
  * of the current process. This is especially important for objects
  * being promoted.
 */
-int slm_inode_setxattr(struct dentry *dentry, char *name, void *value,
-		       size_t size, int flags)
+static int slm_inode_setxattr(struct dentry *dentry, char *name, void *value,
+			      size_t size, int flags)
 {
 	struct slm_tsec_data *cur_tsec = current->security;
 	char *data = value;
@@ -1075,7 +1075,7 @@
 /*
  * Opening a socket demotes the integrity of a process to untrusted.
  */
-int slm_socket_create(int family, int type, int protocol, int kern)
+static int slm_socket_create(int family, int type, int protocol, int kern)
 {
 	struct task_struct *parent_tsk;
 	struct slm_tsec_data *cur_tsec = current->security, *parent_tsec;

