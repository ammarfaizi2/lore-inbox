Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTFJS5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTFJSnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:43:21 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:33711 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264030AbTFJSha convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:30 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <105527096525@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709651073@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:25 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1331, 2003/06/09 15:37:53-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/ide/ide.c


 drivers/ide/ide.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	Tue Jun 10 11:21:31 2003
+++ b/drivers/ide/ide.c	Tue Jun 10 11:21:31 2003
@@ -2115,10 +2115,7 @@
 static void __init probe_for_hwifs (void)
 {
 #ifdef CONFIG_BLK_DEV_IDEPCI
-	if (pci_present())
-	{
-		ide_scan_pcibus(ide_scan_direction);
-	}
+	ide_scan_pcibus(ide_scan_direction);
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 
 #ifdef CONFIG_ETRAX_IDE

