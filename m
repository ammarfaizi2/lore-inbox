Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262946AbVDBAIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbVDBAIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVDBAHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:07:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:38876 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262946AbVDAXsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:17 -0500
Cc: gregkh@suse.de
Subject: PCI: increase the size of the pci.ids strings
In-Reply-To: <20050401234550.GA15046@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:48 -0800
Message-Id: <11123992681543@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.1, 2005/03/16 23:55:56-08:00, gregkh@suse.de

PCI: increase the size of the pci.ids strings

If we are going to waste memory, might as well do it right...

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/gen-devlist.c |    2 +-
 include/linux/pci.h       |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/gen-devlist.c b/drivers/pci/gen-devlist.c
--- a/drivers/pci/gen-devlist.c	2005-04-01 15:38:43 -08:00
+++ b/drivers/pci/gen-devlist.c	2005-04-01 15:38:43 -08:00
@@ -7,7 +7,7 @@
 #include <stdio.h>
 #include <string.h>
 
-#define MAX_NAME_SIZE 89
+#define MAX_NAME_SIZE 200
 
 static void
 pq(FILE *f, const char *c, int len)
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2005-04-01 15:38:43 -08:00
+++ b/include/linux/pci.h	2005-04-01 15:38:43 -08:00
@@ -561,7 +561,7 @@
 	int rom_attr_enabled;		/* has display of the rom attribute been enabled? */
 	struct bin_attribute *res_attr[DEVICE_COUNT_RESOURCE]; /* sysfs file for resources */
 #ifdef CONFIG_PCI_NAMES
-#define PCI_NAME_SIZE	96
+#define PCI_NAME_SIZE	255
 #define PCI_NAME_HALF	__stringify(43)	/* less than half to handle slop */
 	char		pretty_name[PCI_NAME_SIZE];	/* pretty name for users to see */
 #endif

