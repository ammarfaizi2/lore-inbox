Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266353AbUG1W1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUG1W1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUG1W1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:27:13 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:2176 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266353AbUG1WY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:24:59 -0400
Date: Thu, 29 Jul 2004 00:24:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: -mm swsusp: do not default to platform/firmware
Message-ID: <20040728222445.GA18210@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

-mm swsusp now defaults to platform/firmware suspend... That's
certainly unexpected, changes behaviour from previous version, and
only works on one of three machines I have here. I'd like the default
to be changed back. Please apply,
								Pavel

--- clean-mm/drivers/acpi/sleep/main.c	2004-07-28 23:39:47.000000000 +0200
+++ linux-mm/drivers/acpi/sleep/main.c	2004-07-28 22:54:43.000000000 +0200
@@ -216,9 +216,7 @@
 			if (acpi_gbl_FACS->S4bios_f) {
 				sleep_states[i] = 1;
 				printk(" S4bios");
-				acpi_pm_ops.pm_disk_mode = PM_DISK_FIRMWARE;
-			} else if (sleep_states[i])
-				acpi_pm_ops.pm_disk_mode = PM_DISK_PLATFORM;
+			}
 		}
 	}
 	printk(")\n");
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
