Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264344AbUFKUFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUFKUFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUFKUFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 16:05:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:39105 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264344AbUFKUFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 16:05:10 -0400
Date: Fri, 11 Jun 2004 13:04:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Mika Kukkonen <mika@osdl.org>
Subject: [PATCH] sparse fix for void return in selinux/hooks.c
Message-ID: <20040611130456.R21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CHECK   security/selinux/hooks.c
security/selinux/hooks.c:1383:34: warning: return expression in void function
security/selinux/hooks.c:3548:30: warning: return expression in void function
  CC      security/selinux/hooks.o

From: Mika Kukkonen <mika@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

===== security/selinux/hooks.c 1.40 vs edited =====
--- 1.40/security/selinux/hooks.c	2004-05-10 04:25:52 -07:00
+++ edited/security/selinux/hooks.c	2004-06-11 12:54:44 -07:00
@@ -1380,7 +1380,7 @@
 	if (error)
 		return;
 
-	return secondary_ops->capset_set(target, effective, inheritable, permitted);
+	secondary_ops->capset_set(target, effective, inheritable, permitted);
 }
 
 static int selinux_capable(struct task_struct *tsk, int cap)
@@ -3545,7 +3545,7 @@
 
 static void selinux_msg_msg_free_security(struct msg_msg *msg)
 {
-	return msg_msg_free_security(msg);
+	msg_msg_free_security(msg);
 }
 
 /* message queue security operations */

