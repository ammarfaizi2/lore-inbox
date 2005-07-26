Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVGZRfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVGZRfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVGZRdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:33:37 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18823 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261984AbVGZRdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:33:15 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/23] Fix the arguments to machine_restart on cris
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
	<m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
	<m1ek9leb0h.fsf_-_@ebiederm.dsl.xmission.com>
	<m1ack9eaux.fsf_-_@ebiederm.dsl.xmission.com>
	<m164uxear0.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 26 Jul 2005 11:32:34 -0600
In-Reply-To: <m164uxear0.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 26 Jul 2005 11:29:55 -0600")
Message-ID: <m11x5leaml.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears machine_restart has been working cris just
by luck.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---

 arch/cris/kernel/process.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

bb30d3f0b58c6ecde77e7446b8bab12610fb5f97
diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
--- a/arch/cris/kernel/process.c
+++ b/arch/cris/kernel/process.c
@@ -113,6 +113,7 @@
 #include <linux/user.h>
 #include <linux/elfcore.h>
 #include <linux/mqueue.h>
+#include <linux/reboot.h>
 
 //#define DEBUG
 
@@ -208,7 +209,7 @@ void cpu_idle (void)
 
 void hard_reset_now (void);
 
-void machine_restart(void)
+void machine_restart(char *cmd)
 {
 	hard_reset_now();
 }
