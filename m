Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTEFW4Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTEFWyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:54:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57515 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262057AbTEFWwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:45 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624131038@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624132138@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.392.2, 2003/03/19 14:39:42-08:00, hannal@us.ibm.com

[PATCH] patch: remove unnecessary proc stuff from controller struct


 drivers/hotplug/cpqphp.h |    4 ----
 1 files changed, 4 deletions(-)


diff -Nru a/drivers/hotplug/cpqphp.h b/drivers/hotplug/cpqphp.h
--- a/drivers/hotplug/cpqphp.h	Tue May  6 15:56:15 2003
+++ b/drivers/hotplug/cpqphp.h	Tue May  6 15:56:15 2003
@@ -299,8 +299,6 @@
 	struct pci_resource *bus_head;
 	struct pci_dev *pci_dev;
 	struct pci_bus *pci_bus;
-	struct proc_dir_entry* proc_entry;
-	struct proc_dir_entry* proc_entry2;
 	struct event_info event_queue[10];
 	struct slot *slot;
 	u8 next_event;
@@ -322,8 +320,6 @@
 	u8 pcix_speed_capability;	/* PCI-X */
 	u8 pcix_support;		/* PCI-X */
 	u16 vendor_id;
-	char proc_name[20];
-	char proc_name2[20];
 	struct work_struct int_task_event;
 	wait_queue_head_t queue;	/* sleep & wake process */
 };

