Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbTFRF7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 01:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbTFRF7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 01:59:13 -0400
Received: from web40015.mail.yahoo.com ([66.218.78.55]:49497 "HELO
	web40015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265034AbTFRF7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 01:59:12 -0400
Message-ID: <20030618061307.84646.qmail@web40015.mail.yahoo.com>
Date: Tue, 17 Jun 2003 23:13:07 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: [PATCH] Symbol export needed by 3c509 module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

depmod gets snagged on 3c509.ko if netdev_boot_setup_check is not
in the kernel's export list.  On searching the kernel sources, I
found a few other modules that may require this symbol as well,
but 3c509 is the only one that affects me.  So here's the patch.

 -- Jeff Smith

========================================================================
--- a/net/netsyms.c	Tue Jun 17 16:23:00 2003
+++ b/net/netsyms.c	Tue Jun 17 16:58:52 2003
@@ -563,6 +563,7 @@
 EXPORT_SYMBOL(unregister_netdevice);
 EXPORT_SYMBOL(synchronize_net);
 EXPORT_SYMBOL(netdev_state_change);
+EXPORT_SYMBOL(netdev_boot_setup_check);
 EXPORT_SYMBOL(dev_new_index);
 EXPORT_SYMBOL(dev_get_by_flags);
 EXPORT_SYMBOL(__dev_get_by_flags);


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
