Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264088AbTFJSix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTFJShy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:37:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:37550 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262918AbTFJSg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:36:57 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709643024@kroah.com>
Subject: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <20030610183334.GC18182@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1316, 2003/06/09 15:27:00-07:00, greg@kroah.com

PCI: remove pci_present() from arch/sparc/kernel/ebus.c


 arch/sparc/kernel/ebus.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/arch/sparc/kernel/ebus.c b/arch/sparc/kernel/ebus.c
--- a/arch/sparc/kernel/ebus.c	Tue Jun 10 11:22:41 2003
+++ b/arch/sparc/kernel/ebus.c	Tue Jun 10 11:22:41 2003
@@ -267,9 +267,6 @@
 	int reg, nreg;
 	int num_ebus = 0;
 
-	if (!pci_present())
-		return;
-
 	prom_getstring(prom_root_node, "name", lbuf, sizeof(lbuf));
 	for (sp = ebus_blacklist; sp->esname != NULL; sp++) {
 		if (strcmp(lbuf, sp->esname) == 0) {

