Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269895AbUJSXb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269895AbUJSXb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269516AbUJSX1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:27:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:16266 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270158AbUJSWqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:38 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <1098225731207@kroah.com>
Date: Tue, 19 Oct 2004 15:42:11 -0700
Message-Id: <10982257313321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.2.121, 2004/10/06 17:20:53-07:00, akpm@osdl.org

[PATCH] PCI: pci_dev_put() build fix

With CONFIG_PCI=n:

arch/i386/kernel/cpu/mtrr/main.c: In function `have_wrcomb':
arch/i386/kernel/cpu/mtrr/main.c:86: warning: implicit declaration of function `pci_dev_put

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:21:19 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:21:19 -07:00
@@ -896,6 +896,7 @@
 { return NULL; }
 
 #define pci_dev_present(ids)	(0)
+#define pci_dev_put(dev)	do { } while (0)
 
 static inline void pci_set_master(struct pci_dev *dev) { }
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }

