Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbTGDCAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbTGDB7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:59:09 -0400
Received: from granite.he.net ([216.218.226.66]:25870 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265656AbTGDByy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:54 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845524168@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845523317@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:12 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1364, 2003/07/03 15:50:59-07:00, willy@debian.org

[PATCH] PCI: arch/i386/pci/direct.c can use __init, not __devinit
pci_sanity_check() is only called from functions marked __init, so it
can be __init too.


 arch/i386/pci/direct.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/pci/direct.c b/arch/i386/pci/direct.c
--- a/arch/i386/pci/direct.c	Thu Jul  3 18:17:06 2003
+++ b/arch/i386/pci/direct.c	Thu Jul  3 18:17:06 2003
@@ -177,7 +177,7 @@
  * This should be close to trivial, but it isn't, because there are buggy
  * chipsets (yes, you guessed it, by Intel and Compaq) that have no class ID.
  */
-static int __devinit pci_sanity_check(struct pci_raw_ops *o)
+static int __init pci_sanity_check(struct pci_raw_ops *o)
 {
 	u32 x = 0;
 	int devfn;

