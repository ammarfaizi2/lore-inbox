Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318728AbSHAMGR>; Thu, 1 Aug 2002 08:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318724AbSHAMFZ>; Thu, 1 Aug 2002 08:05:25 -0400
Received: from [195.39.17.254] ([195.39.17.254]:15232 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318728AbSHAMFG>;
	Thu, 1 Aug 2002 08:05:06 -0400
Date: Thu, 1 Aug 2002 12:40:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI: compilation fixes
Message-ID: <20020801104053.GA137@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.5.29 will not compile for me without these, please apply.

								Pavel
--- clean/drivers/acpi/system.c	Mon Jul 29 20:02:23 2002
+++ linux-swsusp/drivers/acpi/system.c	Mon Jul 29 20:14:27 2002
@@ -256,7 +256,8 @@
 	acpi_status		status = AE_ERROR;
 	unsigned long		flags = 0;
 
-	save_flags(flags);
+	local_irq_save(flags);
+	local_irq_disable();
 	
 	switch (state)
 	{
@@ -270,7 +271,7 @@
 		do_suspend_lowlevel(0);
 		break;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return status;
 }

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
