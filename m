Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTFJUiF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTFJUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:32:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:19840 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262543AbTFJShU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:20 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709643700@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <10552709643024@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1317, 2003/06/09 15:29:23-07:00, greg@kroah.com

PCI: remove pci_present() from arch/sparc64/kernel/ebus.c


 arch/sparc64/kernel/ebus.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
--- a/arch/sparc64/kernel/ebus.c	Tue Jun 10 11:22:37 2003
+++ b/arch/sparc64/kernel/ebus.c	Tue Jun 10 11:22:37 2003
@@ -525,9 +525,6 @@
 	int nd, ebusnd, is_rio;
 	int num_ebus = 0;
 
-	if (!pci_present())
-		return;
-
 	pdev = find_next_ebus(NULL, &is_rio);
 	if (!pdev) {
 		printk("ebus: No EBus's found.\n");

