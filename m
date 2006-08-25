Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWHYO4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWHYO4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWHYOzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:55:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:385 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030192AbWHYOtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:49:33 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/18] [PATCH] BLOCK: Remove duplicate declaration of exit_io_context() [try #3]
Date: Fri, 25 Aug 2006 15:49:21 +0100
To: axboe@kernel.dk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060825144921.30722.78255.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
References: <20060825144916.30722.90944.stgit@warthog.cambridge.redhat.com>
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
