Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbUCSXhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbUCSXgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:36:44 -0500
Received: from mail.kroah.org ([65.200.24.183]:41935 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263152AbUCSXcf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:32:35 -0500
Subject: Re: [PATCH] PCI and PCI Hotplug fixes for 2.6.5-rc1
In-Reply-To: <10797391322846@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 19 Mar 2004 15:32:12 -0800
Message-Id: <10797391323331@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.97.7, 2004/03/19 14:08:42-08:00, willy@debian.org

[PATCH] PCI: claim PCI resources on ia64

Call pci_claim_resources() so we can see what PCI resources are being used.


 arch/ia64/pci/pci.c |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
--- a/arch/ia64/pci/pci.c	Fri Mar 19 15:21:06 2004
+++ b/arch/ia64/pci/pci.c	Fri Mar 19 15:21:06 2004
@@ -320,6 +320,7 @@
 				dev->resource[i].end   += window->offset;
 			}
 		}
+		pci_claim_resource(dev, i);
 	}
 }
 

