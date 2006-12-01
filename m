Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162262AbWLAXfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162262AbWLAXfI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162254AbWLAXe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:34:26 -0500
Received: from ns.suse.de ([195.135.220.2]:33165 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162262AbWLAXXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:31 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 23/36] Driver core: change mem class_devices to be real devices
Date: Fri,  1 Dec 2006 15:21:53 -0800
Message-Id: <11650154001320-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153961479-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/mem.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 5547337..e67eef4 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -980,10 +980,10 @@ static int __init chr_dev_init(void)
 
 	mem_class = class_create(THIS_MODULE, "mem");
 	for (i = 0; i < ARRAY_SIZE(devlist); i++)
-		class_device_create(mem_class, NULL,
-					MKDEV(MEM_MAJOR, devlist[i].minor),
-					NULL, devlist[i].name);
-	
+		device_create(mem_class, NULL,
+			      MKDEV(MEM_MAJOR, devlist[i].minor),
+			      devlist[i].name);
+
 	return 0;
 }
 
-- 
1.4.4.1

