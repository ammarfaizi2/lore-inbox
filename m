Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbTDIXgi (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 19:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbTDIXgi (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 19:36:38 -0400
Received: from palrel13.hp.com ([156.153.255.238]:15270 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263867AbTDIXgh (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 19:36:37 -0400
Date: Wed, 9 Apr 2003 16:48:16 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304092348.h39NmGZU012306@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch] nuke unused smp_msg_data, smp_src_cpu & smp_msg_id
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to remove some declarations that are so dead it's not even funny
anymore.

I believe the MSG_* macros shouldn't be there either, but it looks
like some PPC{,64} and SPARC code may still rely on them.

	--david

diff -Nru a/include/linux/smp.h b/include/linux/smp.h
--- a/include/linux/smp.h	Wed Apr  9 14:49:49 2003
+++ b/include/linux/smp.h	Wed Apr  9 14:49:49 2003
@@ -74,10 +74,6 @@
  */
 extern int smp_threads_ready;
 
-extern volatile unsigned long smp_msg_data;
-extern volatile int smp_src_cpu;
-extern volatile int smp_msg_id;
-
 #define MSG_ALL_BUT_SELF	0x8000	/* Assume <32768 CPU's */
 #define MSG_ALL			0x8001
 
