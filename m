Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270142AbUJSXb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbUJSXb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270154AbUJSX2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:28:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:14218 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270153AbUJSWqg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:36 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257363931@kroah.com>
Date: Tue, 19 Oct 2004 15:42:16 -0700
Message-Id: <1098225736472@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.36, 2004/10/06 12:56:27-07:00, hannal@us.ibm.com

[PATCH] PCI: Fix one missed pci_find_device

Just noticed this in my update to the latest mm kernel...


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/cpu/cyrix.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/arch/i386/kernel/cpu/cyrix.c b/arch/i386/kernel/cpu/cyrix.c
--- a/arch/i386/kernel/cpu/cyrix.c	2004-10-19 15:24:27 -07:00
+++ b/arch/i386/kernel/cpu/cyrix.c	2004-10-19 15:24:27 -07:00
@@ -280,7 +280,7 @@
 			pci_dev_put(dev);
 			pit_latch_buggy = 1;
 		}
-		dev =  pci_find_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
+		dev =  pci_get_device(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, NULL);
 		if (dev) {
 			pci_dev_put(dev);
 			pit_latch_buggy = 1;

