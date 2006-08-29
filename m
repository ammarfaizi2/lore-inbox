Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWH2QqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWH2QqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWH2Qp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:45:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965108AbWH2Qp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:45:57 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/19] BLOCK: Remove duplicate declaration of exit_io_context() [try #5]
Date: Tue, 29 Aug 2006 17:45:53 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060829164553.15723.94566.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
References: <20060829164549.15723.15017.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Remove the duplicate declaration of exit_io_context() from linux/sched.h.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/linux/sched.h |    1 -
 kernel/exit.c         |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6674fc1..c12c5f9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -709,7 +709,6 @@ #endif	/* CONFIG_SMP */
 
 
 struct io_context;			/* See blkdev.h */
-void exit_io_context(void);
 struct cpuset;
 
 #define NGROUPS_SMALL		32
diff --git a/kernel/exit.c b/kernel/exit.c
index dba194a..e0abd78 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -38,6 +38,7 @@ #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
 #include <linux/audit.h> /* for audit_free() */
 #include <linux/resource.h>
+#include <linux/blkdev.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
