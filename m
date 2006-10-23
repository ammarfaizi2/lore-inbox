Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWJWCaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWJWCaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 22:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWJWCaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 22:30:20 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:8500 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751198AbWJWCaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 22:30:18 -0400
Date: Sun, 22 Oct 2006 19:31:50 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: dwmw2@infradead.org
Subject: [PATCH] MTD: fix kernel-doc warnings
Message-Id: <20061022193150.aea33ea6.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix MTD kernel-doc warnings:
Warning(/var/linsrc/linux-2619-rc2g7//include/linux/mtd/nand.h:416): No description found for parameter 'write_page'
Warning(/var/linsrc/linux-2619-rc2g7//drivers/mtd/nand/nand_base.c:1485): No description found for parameter 'raw'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/mtd/nand/nand_base.c |    1 +
 include/linux/mtd/nand.h     |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2619-rc2g7.orig/drivers/mtd/nand/nand_base.c
+++ linux-2619-rc2g7/drivers/mtd/nand/nand_base.c
@@ -1479,6 +1479,7 @@ static void nand_write_page_syndrome(str
  * @buf:	the data to write
  * @page:	page number to write
  * @cached:	cached programming
+ * @raw:	use raw write mode
  */
 static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 			   const uint8_t *buf, int page, int cached, int raw)
--- linux-2619-rc2g7.orig/include/linux/mtd/nand.h
+++ linux-2619-rc2g7/include/linux/mtd/nand.h
@@ -355,7 +355,7 @@ struct nand_buffers {
  * @priv:		[OPTIONAL] pointer to private chip date
  * @errstat:		[OPTIONAL] hardware specific function to perform additional error status checks
  *			(determine if errors are correctable)
- * @write_page		[REPLACEABLE] High-level page write function
+ * @write_page:		[REPLACEABLE] High-level page write function
  */
 
 struct nand_chip {


---
