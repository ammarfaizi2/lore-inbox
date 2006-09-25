Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751516AbWIYWOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbWIYWOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWIYWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:14:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23487 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751516AbWIYWOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:14:01 -0400
Subject: [PATCH] nomzomi: remove bogus cast
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 23:38:45 +0100
Message-Id: <1159223925.11049.160.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May as well go straight into the main tree

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/char/nozomi.c linux-2.6.18-mm1/drivers/char/nozomi.c
--- linux.vanilla-2.6.18-mm1/drivers/char/nozomi.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/char/nozomi.c	2006-09-25 12:17:53.000000000 +0100
@@ -1225,7 +1225,7 @@
     }
 
     if ( !(dc = get_dc_by_pdev(dev_id)) )  {
-        ERR("Could not find device context from pci_dev: %d", (u32) dev_id);
+        ERR("Could not find device context from pci_dev: %p", dev_id);
         return IRQ_NONE;
     }
 

