Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbVIFAo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbVIFAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 20:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbVIFAo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 20:44:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5316 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965009AbVIFAo0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 20:44:26 -0400
Date: Tue, 6 Sep 2005 01:44:23 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
Message-ID: <20050906004423.GO5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-mga/arch/ppc/syslib/ocp.c RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c
--- RC13-git5-mga/arch/ppc/syslib/ocp.c	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c	2005-09-05 16:41:17.000000000 -0400
@@ -165,7 +165,7 @@
 }
 
 static int
-ocp_device_suspend(struct device *dev, u32 state)
+ocp_device_suspend(struct device *dev, pm_message_t state)
 {
 	struct ocp_device *ocp_dev = to_ocp_dev(dev);
 	struct ocp_driver *ocp_drv = to_ocp_drv(dev->driver);
