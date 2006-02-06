Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWBFJ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWBFJ3O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWBFJ3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:29:14 -0500
Received: from ns2.suse.de ([195.135.220.15]:47572 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750841AbWBFJ3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:29:13 -0500
Date: Mon, 6 Feb 2006 10:29:11 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] remove ipmi pm_power_off redefinition
Message-ID: <20060206092911.GA24133@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the global define of pm_power_off

Signed-off-by: Olaf Hering <olh@suse.de>
---
 drivers/char/ipmi/ipmi_poweroff.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.15/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.15.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.15/drivers/char/ipmi/ipmi_poweroff.c
@@ -37,15 +37,13 @@
 #include <linux/proc_fs.h>
 #include <linux/string.h>
 #include <linux/completion.h>
+#include <linux/pm.h>
 #include <linux/kdev_t.h>
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
 
 #define PFX "IPMI poweroff: "
 
-/* Where to we insert our poweroff function? */
-extern void (*pm_power_off)(void);
-
 /* Definitions for controlling power off (if the system supports it).  It
  * conveniently matches the IPMI chassis control values. */
 #define IPMI_CHASSIS_POWER_DOWN		0	/* power down, the default. */
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
