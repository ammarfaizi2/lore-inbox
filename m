Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266858AbUHWTsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266858AbUHWTsA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUHWTqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:46:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:51907 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266858AbUHWSgY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:24 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286082458@kroah.com>
Date: Mon, 23 Aug 2004 11:34:42 -0700
Message-Id: <10932860824138@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.8, 2004/08/02 15:35:52-07:00, nacc@us.ibm.com

[PATCH] PCI Hotplug: ibmphp_core: replace long_delay() with msleep()

Replace long_delay() with msleep() to guarantee the task
delays as desired.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	2004-08-23 11:08:11 -07:00
+++ b/drivers/pci/hotplug/ibmphp_core.c	2004-08-23 11:08:11 -07:00
@@ -190,7 +190,7 @@
 		err ("command not completed successfully in power_on\n");
 		return -EIO;
 	}
-	long_delay (3 * HZ); /* For ServeRAID cards, and some 66 PCI */
+	msleep(3000);	/* For ServeRAID cards, and some 66 PCI */
 	return 0;
 }
 
@@ -913,7 +913,7 @@
 	}
 	/* This is for x440, once Brandon fixes the firmware, 
 	will not need this delay */
-	long_delay (1 * HZ);
+	msleep(1000);
 	debug ("%s -Exit\n", __FUNCTION__);
 	return 0;
 }

