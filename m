Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTI1UpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 16:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTI1UpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 16:45:05 -0400
Received: from gprs147-229.eurotel.cz ([160.218.147.229]:50817 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262721AbTI1UpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 16:45:02 -0400
Date: Sun, 28 Sep 2003 22:44:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: -test6 include/asm-i386/mman.h bits
Message-ID: <20030928204431.GA9008@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This does not seem right, one copy should be enough.

diff -Nru a/include/asm-i386/mman.h b/include/asm-i386/mman.h
--- a/include/asm-i386/mman.h   Sat Sep 27 17:51:31 2003
+++ b/include/asm-i386/mman.h   Sat Sep 27 17:51:31 2003
@@ -6,6 +6,10 @@
 #define PROT_EXEC      0x4             /* page can be executed */
 #define PROT_SEM       0x8             /* page may be used for atomic ops */
 #define PROT_NONE      0x0             /* page can not be accessed */
+#define PROT_GROWSDOWN 0x01000000      /* mprotect flag: extend change to start of growsdown vma */
+#define PROT_GROWSUP   0x02000000      /* mprotect flag: extend change to end of growsup vma */
+#define PROT_GROWSDOWN 0x01000000      /* mprotect flag: extend change to start of growsdown vma */
+#define PROT_GROWSUP   0x02000000      /* mprotect flag: extend change to end of growsup vma */

 #define MAP_SHARED     0x01            /* Share changes */
 #define MAP_PRIVATE    0x02            /* Changes are private */

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
