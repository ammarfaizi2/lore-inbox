Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270102AbUJTGsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270102AbUJTGsW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270094AbUJSXKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:10:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:5258 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270106AbUJSWqZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:25 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257321259@kroah.com>
Date: Tue, 19 Oct 2004 15:42:12 -0700
Message-Id: <10982257321860@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.5, 2004/10/06 11:19:16-07:00, greg@kroah.com

[PATCH] PCI: make pci_find_class() warn if in interrupt like all other find/get functions do.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/search.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	2004-10-19 15:27:32 -07:00
+++ b/drivers/pci/search.c	2004-10-19 15:27:32 -07:00
@@ -332,6 +332,7 @@
 	struct list_head *n;
 	struct pci_dev *dev;
 
+	WARN_ON(in_interrupt());
 	spin_lock(&pci_bus_lock);
 	n = from ? from->global_list.next : pci_devices.next;
 

