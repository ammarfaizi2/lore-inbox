Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288498AbSATNPu>; Sun, 20 Jan 2002 08:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288521AbSATNPk>; Sun, 20 Jan 2002 08:15:40 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:38407 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S288498AbSATNP1>; Sun, 20 Jan 2002 08:15:27 -0500
Message-ID: <3C4AC2EA.85921F61@delusion.de>
Date: Sun, 20 Jan 2002 14:15:22 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.3-pre2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] APM Buglet
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The following patch against 2.5.3-pre2 fixes compile problems with apm.c


diff -Naur -X dontdiff linux-2.5.3-vanilla/arch/i386/kernel/apm.c linux-2.5.3/arch/i386/kernel/apm.c
--- linux-2.5.3-vanilla/arch/i386/kernel/apm.c  Sun Jan 20 14:12:06 2002
+++ linux-2.5.3/arch/i386/kernel/apm.c  Sun Jan 20 13:53:03 2002
@@ -1348,7 +1348,7 @@
  * decide if we should just power down.
  *
  */
-#define system_idle() (nr_running == 1)
+#define system_idle() (nr_running() == 1)

 static void apm_mainloop(void)
 {
