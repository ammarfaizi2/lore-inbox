Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275086AbTHMNov (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275092AbTHMNou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:44:50 -0400
Received: from [66.212.224.118] ([66.212.224.118]:5386 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275086AbTHMNor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:44:47 -0400
Date: Wed, 13 Aug 2003 09:32:55 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6-mm] ipmi_kcs_intf.c compile warning
Message-ID: <Pine.LNX.4.53.0308130931490.4078@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/ipmi/ipmi_kcs_intf.c: In function `acpi_find_bmc':
drivers/char/ipmi/ipmi_kcs_intf.c:1088: warning: long unsigned int format, 
different type arg (arg 2)
drivers/char/ipmi/ipmi_kcs_intf.c:1088: warning: long unsigned int format, 
different type arg (arg 2)

Index: linux-2.6.0-test3-mm2-x86_64/drivers/char/ipmi/ipmi_kcs_intf.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/drivers/char/ipmi/ipmi_kcs_intf.c,v
retrieving revision 1.1.1.2
diff -u -p -B -r1.1.1.2 ipmi_kcs_intf.c
--- linux-2.6.0-test3-mm2-x86_64/drivers/char/ipmi/ipmi_kcs_intf.c	13 Aug 2003 13:15:20 -0000	1.1.1.2
+++ linux-2.6.0-test3-mm2-x86_64/drivers/char/ipmi/ipmi_kcs_intf.c	13 Aug 2003 13:15:31 -0000
@@ -1085,7 +1085,7 @@ static int acpi_find_bmc(unsigned long *
 		*port = spmi->addr.address;
 		printk("ipmi_kcs_intf: Found ACPI-specified state machine"
 		       " at I/O address 0x%lx\n",
-		       (int) spmi->addr.address);
+		       (unsigned long) spmi->addr.address);
 	} else
 		goto not_found; /* Not an address type we recognise. */
 
