Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265502AbUGMSrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUGMSrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUGMSrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 14:47:47 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:22183 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S265502AbUGMSrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 14:47:40 -0400
Message-ID: <40F42C44.5010603@am.sony.com>
Date: Tue, 13 Jul 2004 11:39:00 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
CC: trivial@rustcorp.com.au, Adam Kropelin <akropel1@rochester.rr.com>
Subject: [PATCH] - trivial comment fixups in init/main.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has some trivial comment fixups for init/main.c, to bring
the comments into consistency with the coding style of the kernel.

These modifications were originally made by Adam Kropelin
These came to our attention while working on a patch to
calibrate_delay(), and I thought we should separate these
changes from that patch.

The patch applies silently against 2.6.7 and cleanly but
with hunk offsets to 2.6.7-bk20.

main.c |   21 +++++++++++++--------
  1 files changed, 13 insertions(+), 8 deletions(-)

Please apply.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================

Signed-off-by: Tim Bird <tim.bird@am.sony.com>
--


diff -u -X /home/tbird/dontdiff -ruN linux-2.6.7.orig/init/main.c patch5/init/main.c
--- linux-2.6.7.orig/init/main.c	2004-06-15 22:19:01.000000000 -0700
+++ patch5/init/main.c	2004-07-12 12:34:55.000000000 -0700
@@ -238,8 +264,10 @@
  __setup("debug", debug_kernel);
  __setup("quiet", quiet_kernel);

-/* Unknown boot options get handed to init, unless they look like
-   failed parameters */
+/*
+ * Unknown boot options get handed to init, unless they look like
+ * failed parameters
+ */
  static int __init unknown_bootoption(char *param, char *val)
  {
  	/* Change NUL term back to "=", to make "param" the whole string. */
@@ -250,8 +278,10 @@
  	if (obsolete_checksetup(param))
  		return 0;

-	/* Preemptive maintenance for "why didn't my mispelled command
-           line work?" */
+	/*
+	 * Preemptive maintenance for "why didn't my mispelled command
+	 * line work?"
+	 */
  	if (strchr(param, '.') && (!val || strchr(param, '.') < val)) {
  		printk(KERN_ERR "Unknown boot option `%s': ignoring\n", param);
  		return 0;
@@ -289,7 +319,8 @@
  	unsigned int i;

  	execute_command = str;
-	/* In case LILO is going to boot us with default command line,
+	/*
+	 * In case LILO is going to boot us with default command line,
  	 * it prepends "auto" before the whole cmdline which makes
  	 * the shell think it should execute a script with such name.
  	 * So we ignore all arguments entered _before_ init=... [MJ]
@@ -483,9 +514,9 @@
  	check_bugs();

  	/*
-	 *	We count on the initial thread going ok
-	 *	Like idlers init is an unlocked kernel thread, which will
-	 *	make syscalls (and thus be locked).
+	 * We count on the initial thread going ok
+	 * Like idlers init is an unlocked kernel thread, which will
+	 * make syscalls (and thus be locked).
  	 */
  	init_idle(current, smp_processor_id());

