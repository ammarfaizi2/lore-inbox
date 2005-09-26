Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVIZTbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVIZTbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVIZTbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:31:04 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:57995 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751383AbVIZTbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:31:01 -0400
Subject: Add IPMI poweroff control to sysfs
From: Corey Minyard <minyard@acm.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>
Content-Type: multipart/mixed; boundary="=-61ogP39K9nsHwLBVtDWD"
Date: Mon, 26 Sep 2005 14:30:44 -0500
Message-Id: <1127763044.19641.1.camel@i2.minyard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-61ogP39K9nsHwLBVtDWD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Is it possible to get this into 2.6.14?  It's a fairly simple change.

--=-61ogP39K9nsHwLBVtDWD
Content-Disposition: attachment; filename=ipmi-poweroff-parm-in-sysfs.patch
Content-Type: text/x-patch; name=ipmi-poweroff-parm-in-sysfs.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Put the IPMI poweroff_powercycle parameter into sysfs.  This
field is dynamically settable and is valuable to have in sysfs.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.14-rc2/drivers/char/ipmi/ipmi_poweroff.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/ipmi/ipmi_poweroff.c
+++ linux-2.6.14-rc2/drivers/char/ipmi/ipmi_poweroff.c
@@ -55,7 +55,7 @@ extern void (*pm_power_off)(void);
 static int poweroff_powercycle;
 
 /* parameter definition to allow user to flag power cycle */
-module_param(poweroff_powercycle, int, 0);
+module_param(poweroff_powercycle, int, 0644);
 MODULE_PARM_DESC(poweroff_powercycles, " Set to non-zero to enable power cycle instead of power down. Power cycle is contingent on hardware support, otherwise it defaults back to power down.");
 
 /* Stuff from the get device id command. */

--=-61ogP39K9nsHwLBVtDWD--

