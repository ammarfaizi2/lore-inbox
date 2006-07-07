Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWGGLsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWGGLsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWGGLs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:48:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932072AbWGGLr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:47:56 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/8] FDPIC: Move roundup() into linux/kernel.h [try #4]
Date: Fri, 07 Jul 2006 12:47:51 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060707114751.948.50969.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
References: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Move the roundup() macro from binfmt_elf.c into linux/kernel.h as it's
generally useful.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/binfmt_elf.c        |    2 --
 include/linux/kernel.h |    1 +
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f42e642..672a3b9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1185,8 +1185,6 @@ static int maydump(struct vm_area_struct
 	return 1;
 }
 
-#define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
-
 /* An ELF note in memory */
 struct memelfnote
 {
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5c1ec1f..181c69c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -33,6 +33,7 @@ #define STACK_MAGIC	0xdeadbeef
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
 #define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
+#define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 
 #define	KERN_EMERG	"<0>"	/* system is unusable			*/
 #define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/
