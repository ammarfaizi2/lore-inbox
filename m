Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274909AbTHFKfz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274929AbTHFKfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:35:55 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:10667 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S274909AbTHFKfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:35:52 -0400
Date: Wed, 6 Aug 2003 12:35:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Comment fixes
Message-ID: <20030806103537.GA690@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes typos/no-longer-right comments. (S4 no longer works as
described in the comment; AFAIK it never worked like that). Please
apply,

							Pavel
Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2003-07-22 12:53:27.000000000 +0200
@@ -69,10 +81,6 @@
  * First, we call to the device driver layer to save device state.
  * Once we have that, we save whatevery processor and kernel state we
  * need to memory.
- * If we're entering S4, we then write the memory image to disk.
- *
- * Only then is it safe for us to power down devices, since we may need
- * the disks and upstream buses to write to.
  */
 acpi_status
 acpi_system_save_state(
Index: linux/include/linux/reboot.h
===================================================================
--- linux.orig/include/linux/reboot.h	2003-07-22 13:39:42.000000000 +0200
+++ linux/include/linux/reboot.h	2003-07-17 22:22:58.000000000 +0200
@@ -21,7 +21,7 @@
  * CAD_OFF     Ctrl-Alt-Del sequence sends SIGINT to init task.
  * POWER_OFF   Stop OS and remove all power from system, if possible.
  * RESTART2    Restart system using given command string.
- * SW_SUSPEND  Suspend system using Software Suspend if compiled in
+ * SW_SUSPEND  Suspend system using software suspend if compiled in.
  */
 
 #define	LINUX_REBOOT_CMD_RESTART	0x01234567

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
