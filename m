Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTFJT4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbTFJTzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:55:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:32384 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263990AbTFJShZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:25 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709693294@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270969809@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1370, 2003/06/09 16:13:31-07:00, greg@kroah.com

PCI: remove pci_present() from include/asm-sparc64/parport.h


 include/asm-sparc64/parport.h |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/include/asm-sparc64/parport.h b/include/asm-sparc64/parport.h
--- a/include/asm-sparc64/parport.h	Tue Jun 10 11:18:10 2003
+++ b/include/asm-sparc64/parport.h	Tue Jun 10 11:18:10 2003
@@ -121,9 +121,6 @@
 	struct linux_ebus_device *edev;
 	int count = 0;
 
-	if (!pci_present())
-		return 0;
-
 	for_each_ebus(ebus) {
 		for_each_ebusdev(edev, ebus) {
 			if (ebus_ecpp_p(edev)) {

