Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265055AbUG2OL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbUG2OL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUG2OKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:10:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:31126 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265053AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 45/47] Re-add PC Speaker support for PPC
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101962613@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110196560@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1840.1.90, 2004-07-27 14:46:36+02:00, olh@suse.de
  input: Re-add PC Speaker support for PPC
  
  Signed-off-by: Olaf Hering <olh@suse.de>
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 drivers/input/misc/Kconfig  |    2 +-
 include/asm-ppc/8253pit.h   |   10 ++++++++++
 include/asm-ppc64/8253pit.h |   10 ++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
--- a/drivers/input/misc/Kconfig	Thu Jul 29 14:38:33 2004
+++ b/drivers/input/misc/Kconfig	Thu Jul 29 14:38:33 2004
@@ -14,7 +14,7 @@
 
 config INPUT_PCSPKR
 	tristate "PC Speaker support"
-	depends on (ALPHA || X86 || X86_64 || MIPS) && INPUT && INPUT_MISC
+	depends on (ALPHA || X86 || X86_64 || MIPS || PPC_PREP || PPC_CHRP || PPC_PSERIES) && INPUT && INPUT_MISC
 	help
 	  Say Y here if you want the standard PC Speaker to be used for
 	  bells and whistles.
diff -Nru a/include/asm-ppc/8253pit.h b/include/asm-ppc/8253pit.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc/8253pit.h	Thu Jul 29 14:38:33 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif
diff -Nru a/include/asm-ppc64/8253pit.h b/include/asm-ppc64/8253pit.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc64/8253pit.h	Thu Jul 29 14:38:33 2004
@@ -0,0 +1,10 @@
+/*
+ * 8253/8254 Programmable Interval Timer
+ */
+
+#ifndef _8253PIT_H
+#define _8253PIT_H
+
+#define PIT_TICK_RATE 	1193182UL
+
+#endif

