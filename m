Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVCJBKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVCJBKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 20:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVCJBIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 20:08:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:48543 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262616AbVCJAm1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:42:27 -0500
Cc: rmk+lkml@arm.linux.org.uk
Subject: [PATCH] driver core: Separate platform device name from platform device number
In-Reply-To: <1110414879646@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 9 Mar 2005 16:34:39 -0800
Message-Id: <11104148792069@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2038, 2005/03/09 09:32:19-08:00, rmk+lkml@arm.linux.org.uk

[PATCH] driver core: Separate platform device name from platform device number

Separate platform device name from platform device number such that
names ending with numbers aren't confusing.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/platform.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	2005-03-09 16:30:02 -08:00
+++ b/drivers/base/platform.c	2005-03-09 16:30:02 -08:00
@@ -131,7 +131,7 @@
 	pdev->dev.bus = &platform_bus_type;
 
 	if (pdev->id != -1)
-		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s%u", pdev->name, pdev->id);
+		snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s.%u", pdev->name, pdev->id);
 	else
 		strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);
 

