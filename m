Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWFZRy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWFZRy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWFZRy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:54:56 -0400
Received: from xenotime.net ([66.160.160.81]:43480 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751235AbWFZRy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:54:56 -0400
Date: Mon, 26 Jun 2006 10:57:42 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, viro@zeniv.linux.org.uk
Subject: [PATCH] fix kernel-doc in kernel/ dir.
Message-Id: <20060626105742.99e48bdd.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix kernel-doc parameters in kernel/

Warning(/var/linsrc/linux-2617-g9//kernel/auditsc.c:1376): No description found for parameter 'u_abs_timeout'
Warning(/var/linsrc/linux-2617-g9//kernel/auditsc.c:1420): No description found for parameter 'u_msg_prio'
Warning(/var/linsrc/linux-2617-g9//kernel/auditsc.c:1420): No description found for parameter 'u_abs_timeout'
Warning(/var/linsrc/linux-2617-g9//kernel/acct.c:526): No description found for parameter 'pacct'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 kernel/acct.c    |    1 +
 kernel/auditsc.c |    7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2617-g9.orig/kernel/acct.c
+++ linux-2617-g9/kernel/acct.c
@@ -521,6 +521,7 @@ static void do_acct_process(struct file 
 
 /**
  * acct_init_pacct - initialize a new pacct_struct
+ * @pacct: per-process accounting info struct to initialize
  */
 void acct_init_pacct(struct pacct_struct *pacct)
 {
--- linux-2617-g9.orig/kernel/auditsc.c
+++ linux-2617-g9/kernel/auditsc.c
@@ -1367,7 +1367,7 @@ int __audit_mq_open(int oflag, mode_t mo
  * @mqdes: MQ descriptor
  * @msg_len: Message length
  * @msg_prio: Message priority
- * @abs_timeout: Message timeout in absolute time
+ * @u_abs_timeout: Message timeout in absolute time
  *
  * Returns 0 for success or NULL context or < 0 on error.
  */
@@ -1409,8 +1409,8 @@ int __audit_mq_timedsend(mqd_t mqdes, si
  * __audit_mq_timedreceive - record audit data for a POSIX MQ timed receive
  * @mqdes: MQ descriptor
  * @msg_len: Message length
- * @msg_prio: Message priority
- * @abs_timeout: Message timeout in absolute time
+ * @u_msg_prio: Message priority
+ * @u_abs_timeout: Message timeout in absolute time
  *
  * Returns 0 for success or NULL context or < 0 on error.
  */
@@ -1558,7 +1558,6 @@ int __audit_ipc_obj(struct kern_ipc_perm
  * @uid: msgq user id
  * @gid: msgq group id
  * @mode: msgq mode (permissions)
- * @ipcp: in-kernel IPC permissions
  *
  * Returns 0 for success or NULL context or < 0 on error.
  */


---
