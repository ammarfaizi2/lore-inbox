Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267385AbUHWTRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267385AbUHWTRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUHWTQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:16:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:5060 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267263AbUHWSgw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:52 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286082562@kroah.com>
Date: Mon, 23 Aug 2004 11:34:42 -0700
Message-Id: <1093286082835@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1790.2.6, 2004/08/02 15:34:59-07:00, nacc@us.ibm.com

[PATCH] PCI Hotplug: ibmphp: remove long_delay

Remove unused function long_delay().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp.h |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp.h b/drivers/pci/hotplug/ibmphp.h
--- a/drivers/pci/hotplug/ibmphp.h	2004-08-23 11:08:22 -07:00
+++ b/drivers/pci/hotplug/ibmphp.h	2004-08-23 11:08:22 -07:00
@@ -759,11 +759,5 @@
 extern int ibmphp_unconfigure_card (struct slot **, int);
 extern struct hotplug_slot_ops ibmphp_hotplug_slot_ops;
 
-static inline void long_delay (int delay)
-{
-	set_current_state (TASK_INTERRUPTIBLE);
-	schedule_timeout (delay);
-}
-
 #endif				//__IBMPHP_H
 

