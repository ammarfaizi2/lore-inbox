Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVCUNsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVCUNsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVCUNsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:48:54 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:38108 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261789AbVCUNsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:48:52 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321132046.17292.95433.98870@clementine.local>
Subject: [PATCH] gadget/ether: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 14:48:47 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "dev_addr"/"iProduct" parameter description duplication/mixup.
Error detected with section2text.rb, see autoparam patch. 

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc1/drivers/usb/gadget/ether.c	2005-03-20 18:20:17.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/usb/gadget/ether.c	2005-03-21 14:01:56.000000000 +0100
@@ -199,7 +199,7 @@
 /* initial value, changed by "ifconfig usb0 hw ether xx:xx:xx:xx:xx:xx" */
 static char *__initdata dev_addr;
 module_param(dev_addr, charp, S_IRUGO);
-MODULE_PARM_DESC(iProduct, "Device Ethernet Address");
+MODULE_PARM_DESC(dev_addr, "Device Ethernet Address");
 
 /* this address is invisible to ifconfig */
 static char *__initdata host_addr;
