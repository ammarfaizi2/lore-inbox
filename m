Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266851AbUHWTtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUHWTtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUHWTsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:48:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:50883 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266851AbUHWSgX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:23 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860832487@kroah.com>
Date: Mon, 23 Aug 2004 11:34:43 -0700
Message-Id: <1093286083974@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.12, 2004/08/02 15:37:32-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix build warnings due to msleep() patches.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpci_hotplug_core.c |    1 +
 drivers/pci/hotplug/ibmphp_hpc.c        |    1 +
 drivers/pci/hotplug/shpchp_hpc.c        |    1 +
 3 files changed, 3 insertions(+)


diff -Nru a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
--- a/drivers/pci/hotplug/cpci_hotplug_core.c	2004-08-23 11:07:48 -07:00
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c	2004-08-23 11:07:48 -07:00
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
+#include <linux/delay.h>
 #include "pci_hotplug.h"
 #include "cpci_hotplug.h"
 
diff -Nru a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
--- a/drivers/pci/hotplug/ibmphp_hpc.c	2004-08-23 11:07:48 -07:00
+++ b/drivers/pci/hotplug/ibmphp_hpc.c	2004-08-23 11:07:48 -07:00
@@ -29,6 +29,7 @@
 
 #include <linux/wait.h>
 #include <linux/time.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/smp_lock.h>
diff -Nru a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
--- a/drivers/pci/hotplug/shpchp_hpc.c	2004-08-23 11:07:48 -07:00
+++ b/drivers/pci/hotplug/shpchp_hpc.c	2004-08-23 11:07:48 -07:00
@@ -35,6 +35,7 @@
 #include <linux/vmalloc.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/delay.h>
 #include <linux/pci.h>
 #include <asm/system.h>
 #include "shpchp.h"

