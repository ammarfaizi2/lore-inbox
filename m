Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270087AbUJSXbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270087AbUJSXbe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270152AbUJSXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:25:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:18058 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270161AbUJSWqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:40 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <109822573337@kroah.com>
Date: Tue, 19 Oct 2004 15:42:13 -0700
Message-Id: <10982257332302@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.11, 2004/10/06 11:33:28-07:00, greg@kroah.com

[PATCH] PCI: fix improper pr_debug() statement

Thanks to Joe Perches for pointing this out.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/quirks.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-10-19 15:27:00 -07:00
+++ b/drivers/pci/quirks.c	2004-10-19 15:27:00 -07:00
@@ -992,7 +992,7 @@
 	while (f < end) {
 		if ((f->vendor == dev->vendor || f->vendor == (u16) PCI_ANY_ID) &&
  		    (f->device == dev->device || f->device == (u16) PCI_ANY_ID)) {
-			pr_debug(KERN_INFO "PCI: Calling quirk %p for %s\n", f->hook, pci_name(dev));
+			pr_debug("PCI: Calling quirk %p for %s\n", f->hook, pci_name(dev));
 			f->hook(dev);
 		}
 		f++;

