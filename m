Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVGGCfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGGCfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 22:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVGFT6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:58:32 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:34573 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262273AbVGFQMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 12:12:48 -0400
Date: Wed, 6 Jul 2005 09:12:43 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix 2.6.13rc2 compilation without CONFIG_HOTPLUG
Message-ID: <20050706161243.GB13518@suse.de>
References: <20050706112354.GE21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706112354.GE21330@wotan.suse.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 01:23:54PM +0200, Andi Kleen wrote:
> 
> Otherwise PCI won't compile.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>

No, I like this patch better, it's cleaner and is what I intended the
code to be.  I've already sent it to Linus and the list.

thanks,

greg k-h


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pci/pci-driver.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/pci/pci-driver.c	2005-07-06 01:03:26.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci-driver.c	2005-07-06 09:07:09.000000000 -0700
@@ -17,13 +17,13 @@
  * Dynamic device IDs are disabled for !CONFIG_HOTPLUG
  */
 
-#ifdef CONFIG_HOTPLUG
-
 struct pci_dynid {
 	struct list_head node;
 	struct pci_device_id id;
 };
 
+#ifdef CONFIG_HOTPLUG
+
 /**
  * store_new_id
  *
