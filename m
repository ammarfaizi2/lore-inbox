Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWEAQqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWEAQqQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 12:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWEAQqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 12:46:16 -0400
Received: from xenotime.net ([66.160.160.81]:9658 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932149AbWEAQqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 12:46:16 -0400
Date: Mon, 1 May 2006 09:48:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, dwmw2@infradead.org
Subject: [PATCH] Doc: add audit & acct to DocBook
Message-Id: <20060501094841.8054f115.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix one audit kernel-doc description (one parameter was missing).
Add audit*.c interfaces to DocBook.
Add BSD accounting interfaces to DocBook.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |   12 ++++++++++++
 kernel/auditsc.c                      |    1 +
 2 files changed, 13 insertions(+)

--- linux-2617-rc3.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2617-rc3/Documentation/DocBook/kernel-api.tmpl
@@ -331,6 +331,18 @@ X!Earch/i386/kernel/mca.c
 !Esecurity/security.c
   </chapter>
 
+  <chapter id="audit">
+     <title>Audit Interfaces</title>
+!Ekernel/audit.c
+!Ikernel/auditsc.c
+!Ikernel/auditfilter.c
+  </chapter>
+
+  <chapter id="accounting">
+     <title>Accounting Framework</title>
+!Ikernel/acct.c
+  </chapter>
+
   <chapter id="pmfuncs">
      <title>Power Management</title>
 !Ekernel/power/pm.c
--- linux-2617-rc3.orig/kernel/auditsc.c
+++ linux-2617-rc3/kernel/auditsc.c
@@ -1193,6 +1193,7 @@ ret:
  * @uid: msgq user id
  * @gid: msgq group id
  * @mode: msgq mode (permissions)
+ * @ipcp: in-kernel IPC permissions
  *
  * Returns 0 for success or NULL context or < 0 on error.
  */


---
