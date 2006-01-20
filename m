Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422696AbWATAUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422696AbWATAUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161428AbWATAUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 19:20:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:46856 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161422AbWATAUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 19:20:03 -0500
Date: Fri, 20 Jan 2006 01:20:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] help text: SOFTWARE_SUSPEND doesn't need ACPI
Message-ID: <20060120002002.GH19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The note that SOFTWARE_SUSPEND doesn't need APM is helpful, but nowadays 
the information that it doesn't need ACPI, too, is even more helpful.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm1-full/kernel/power/Kconfig.old	2006-01-20 01:14:09.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/kernel/power/Kconfig	2006-01-20 01:14:19.000000000 +0100
@@ -39,11 +39,11 @@
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
 	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
-	  It doesn't need APM.
+	  It doesn't need ACPI or APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
 	  (patch for sysvinit needed). 
 
 	  It creates an image which is saved in your active swap. Upon next
 	  boot, pass the 'resume=/dev/swappartition' argument to the kernel to

