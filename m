Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263894AbTFJVPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTFJVCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:02:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:29858 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263894AbTFJShO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:14 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709673434@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270967446@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1349, 2003/06/09 15:59:43-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/pci/syscall.c


 drivers/pci/syscall.c |    2 --
 1 files changed, 2 deletions(-)


diff -Nru a/drivers/pci/syscall.c b/drivers/pci/syscall.c
--- a/drivers/pci/syscall.c	Tue Jun 10 11:19:57 2003
+++ b/drivers/pci/syscall.c	Tue Jun 10 11:19:57 2003
@@ -98,8 +98,6 @@
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
-	if (!pci_present())
-		return -ENOSYS;
 
 	dev = pci_find_slot(bus, dfn);
 	if (!dev)

