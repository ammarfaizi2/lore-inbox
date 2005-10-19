Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbVJSFC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbVJSFC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 01:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbVJSFCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 01:02:25 -0400
Received: from xenotime.net ([66.160.160.81]:38863 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751501AbVJSFCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 01:02:25 -0400
Date: Tue, 18 Oct 2005 22:02:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] Doc/hpet.txt: change to < 80 columns
Message-Id: <20051018220223.3536f2d0.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Put text into < 80 columns.  No other changes.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/hpet.txt |   34 ++++++++++++++++++----------------
 1 files changed, 18 insertions(+), 16 deletions(-)

diff -Naurp linux-2614-rc4/Documentation/hpet.txt~doc_hpet linux-2614-rc4/Documentation/hpet.txt
--- linux-2614-rc4/Documentation/hpet.txt~doc_hpet	2005-08-28 16:41:01.000000000 -0700
+++ linux-2614-rc4/Documentation/hpet.txt	2005-10-17 20:54:01.000000000 -0700
@@ -1,18 +1,21 @@
 		High Precision Event Timer Driver for Linux
 
-The High Precision Event Timer (HPET) hardware is the future replacement for the 8254 and Real
-Time Clock (RTC) periodic timer functionality.  Each HPET can have up two 32 timers.  It is possible
-to configure the first two timers as legacy replacements for 8254 and RTC periodic.  A specification
-done by INTEL and Microsoft can be found at http://www.intel.com/labs/platcomp/hpet/hpetspec.htm.
-
-The driver supports detection of HPET driver allocation and initialization of the HPET before the
-driver module_init routine is called.  This enables platform code which uses timer 0 or 1 as the
-main timer to intercept HPET initialization.  An example of this initialization can be found in
+The High Precision Event Timer (HPET) hardware is the future replacement
+for the 8254 and Real Time Clock (RTC) periodic timer functionality.
+Each HPET can have up two 32 timers.  It is possible to configure the
+first two timers as legacy replacements for 8254 and RTC periodic timers.
+A specification done by Intel and Microsoft can be found at
+<http://www.intel.com/hardwaredesign/hpetspec.htm>.
+
+The driver supports detection of HPET driver allocation and initialization
+of the HPET before the driver module_init routine is called.  This enables
+platform code which uses timer 0 or 1 as the main timer to intercept HPET
+initialization.  An example of this initialization can be found in
 arch/i386/kernel/time_hpet.c.
 
-The driver provides two APIs which are very similar to the API found in the rtc.c driver.
-There is a user space API and a kernel space API.  An example user space program is provided
-below.
+The driver provides two APIs which are very similar to the API found in
+the rtc.c driver.  There is a user space API and a kernel space API.
+An example user space program is provided below.
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -290,9 +293,8 @@ The kernel API has three interfaces expo
 	hpet_unregister(struct hpet_task *tp)
 	hpet_control(struct hpet_task *tp, unsigned int cmd, unsigned long arg)
 
-The kernel module using this interface fills in the ht_func and ht_data members of the
-hpet_task structure before calling hpet_register.  hpet_control simply vectors to the hpet_ioctl
-routine and has the same commands and respective arguments as the user API.  hpet_unregister
+The kernel module using this interface fills in the ht_func and ht_data
+members of the hpet_task structure before calling hpet_register.
+hpet_control simply vectors to the hpet_ioctl routine and has the same
+commands and respective arguments as the user API.  hpet_unregister
 is used to terminate usage of the HPET timer reserved by hpet_register.
-
-

---
