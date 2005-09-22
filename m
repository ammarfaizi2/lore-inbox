Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbVIVHta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbVIVHta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVIVHtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:49:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:61362 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751434AbVIVHsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:51 -0400
Date: Thu, 22 Sep 2005 00:48:24 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       lxiep@us.ibm.com
Subject: [patch 08/18] PCI Hotplug: Fix buffer overrun in rpadlpar_sysfs.c
Message-ID: <20050922074823.GI15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pci-buffer-overrun-rpaldpar.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linda Xie <lxiep@us.ibm.com>

Signed-off-by: Linda Xie <lxie@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 drivers/pci/hotplug/rpadlpar_sysfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- scsi-2.6.orig/drivers/pci/hotplug/rpadlpar_sysfs.c	2005-09-20 05:59:55.000000000 -0700
+++ scsi-2.6/drivers/pci/hotplug/rpadlpar_sysfs.c	2005-09-21 17:29:34.000000000 -0700
@@ -62,7 +62,7 @@
 	char drc_name[MAX_DRC_NAME_LEN];
 	char *end;
 
-	if (nbytes > MAX_DRC_NAME_LEN)
+	if (nbytes >= MAX_DRC_NAME_LEN)
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);
@@ -83,7 +83,7 @@
 	char drc_name[MAX_DRC_NAME_LEN];
 	char *end;
 
-	if (nbytes > MAX_DRC_NAME_LEN)
+	if (nbytes >= MAX_DRC_NAME_LEN)
 		return 0;
 
 	memcpy(drc_name, buf, nbytes);

--
